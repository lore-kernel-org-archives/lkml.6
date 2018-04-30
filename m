Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrYnHYOlDL1Gkvov9JHQDHqqZgE0ctlPt5N6aMJqpVqA6ksS0HdV1TcR4ZGkSyg1Up6yZSL
ARC-Seal: i=1; a=rsa-sha256; t=1525116438; cv=none;
        d=google.com; s=arc-20160816;
        b=GfaJzHVXoHv0dLiJv7mklKBJtnXEk1quhU/Lr1pbz3yRQpJIIUwO9Tj33YZccW2SV5
         QW5rhXiAsfFIh/BPGFqf2f30dvsyZa6fLPzBmowZkOfJkxKToDEf3OqP3ZtH0VI6jPwR
         nishjBy4UBCuDJdt4K8Ye2BHiW4BUBC25Efr0Ud6x9mu8usK3hymvZYjZlz596Gi3q9w
         4DTvn20oULn5oc/bg0qxGDwi+vZobOruw8EPKZ2IAg0negF0KFNINdxSsn91EVSsb++u
         tJzRj7Ta4KrYI4DXTnT/nr4gHJhkYqAFguKJFqx/OYrTlemBYhwwej6TwYl1V9wZbOrJ
         VFiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=DMrY/p/S+Xx52MZ2G0aUTOwanXobs1Qc7c0E76uf9E4=;
        b=UYLtWqTQ7WbkYa0rfVjB+x9WMF3Oir9GSdl66fNutPjg9Aut/RgAxGdyeyWTzhUpnJ
         GeQijoJ3chuRv65VDxip/uSuTtk0lICg7eOWKvUQdaYRiDdhUsIn7o2Em5T0rSdfEUO2
         jtA/o27xO37teXd46zfFpAXfPKe6RJBn/cFPTzgEOzxzKaXjy3KhtdLL/6qel2PCxPCr
         oigCS1PvEmzGVALIRfxOuofhlUJ2IlL5VOXtx0bBq2j/0CyjTq7gwFoRHqofc+yYUeMX
         qR/S51g6ESfOVH6qUoA5Ej92CT2D5np9M6r8HOYg3cGtUmKjTIaqH54jdVS1feT2Soi2
         e1ZA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C00122DC1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 46/91] ALSA: hda: Hardening for potential Spectre v1
Date: Mon, 30 Apr 2018 12:24:28 -0700
Message-Id: <20180430184006.585130167@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200409700898059?=
X-GMAIL-MSGID: =?utf-8?q?1599200494849293810?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 69fa6f19b95597618ab30438a27b67ad93daa7c7 upstream.

As recently Smatch suggested, one place in HD-audio hwdep ioctl codes
may expand the array directly from the user-space value with
speculation:
  sound/pci/hda/hda_local.h:467 get_wcaps() warn: potential spectre issue 'codec->wcaps'

As get_wcaps() itself is a fairly frequently called inline function,
and there is only one single call with a user-space value, we replace
only the latter one to open-code locally with array_index_nospec()
hardening in this patch.

BugLink: https://marc.info/?l=linux-kernel&m=152411496503418&w=2
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/hda_hwdep.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/sound/pci/hda/hda_hwdep.c
+++ b/sound/pci/hda/hda_hwdep.c
@@ -21,6 +21,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/compat.h>
+#include <linux/nospec.h>
 #include <sound/core.h>
 #include "hda_codec.h"
 #include "hda_local.h"
@@ -51,7 +52,16 @@ static int get_wcap_ioctl(struct hda_cod
 	
 	if (get_user(verb, &arg->verb))
 		return -EFAULT;
-	res = get_wcaps(codec, verb >> 24);
+	/* open-code get_wcaps(verb>>24) with nospec */
+	verb >>= 24;
+	if (verb < codec->core.start_nid ||
+	    verb >= codec->core.start_nid + codec->core.num_nodes) {
+		res = 0;
+	} else {
+		verb -= codec->core.start_nid;
+		verb = array_index_nospec(verb, codec->core.num_nodes);
+		res = codec->wcaps[verb];
+	}
 	if (put_user(res, &arg->res))
 		return -EFAULT;
 	return 0;
