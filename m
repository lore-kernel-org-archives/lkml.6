Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqLZxJWjt+TEhJVaCgnpiqDqlwn4MS44iXZPkoNY2E5nDeCZjQyMUvPbbOjArghUVKa+tiP
ARC-Seal: i=1; a=rsa-sha256; t=1525116498; cv=none;
        d=google.com; s=arc-20160816;
        b=s8tYEiBMl2F54CM7tpRppH1/p+vc0doj/q5Obl8/ZF0mmBb6XsWKqC/2N+sugABkv0
         kejxIhltOJznRm/5pkT/OuCOhnONjlgWB3M2LBwU/waRhOnTakF1ZcHSQNvzrMSkhvhz
         PjC2+R3BTLtoVQKQDDuAeBgQpuHwaQA5ks1OjkxZx2P2fhsoGdPHlCNfhL1Aj84ucfnL
         gYPiW0/lLCOycJwGnz1zUhSfC/F/80XOTqMmYh1W+q5x2lsL8S0KtOQLrd1gZsPcEZnC
         TgIVq7ZlkgiLq9KXcRLKYkxGa0exVlV0/bsk3QugF/+N9bLBVMlJ5ac0Gzd/t21zcL8E
         piNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=TdzXt4zBeFPCie1Gcxvc3H6OpJzKcMsuGOPQMAlZFkk=;
        b=XOENJynm3ngtHhgXbEWj4Z4YPilJVOoKREszVFtM83dEpw4ddgGtyiTnS4QBJiG1Ni
         9cfQgHFS5ch6Gy5Hr9TKblRSiHJzv40cNP3YrfMT5b2I3yGeLnaaxM6c3cypcwkG0e9u
         Bs38TlaWxuKUukpnmAiWc/dIpMltDd9u9JaNlmE8l5wE+6RJqmdl7Yt8l/PSRahDmPYb
         2+5St4srLJGeaabtIvnO9xo6BnwAS4rxFKbnOcVJxnVAf7+t0N239MbWEJL5G5nL3yGo
         62meFkwS0yz8K/EnEwszA75fi+DWhrybL/6yGYN0ktX82z0G05Iz68ZFz2cO/UzYud+V
         cgUw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C66C922DAC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.16 050/113] ALSA: hda: Hardening for potential Spectre v1
Date: Mon, 30 Apr 2018 12:24:21 -0700
Message-Id: <20180430184017.174230376@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200409700898059?=
X-GMAIL-MSGID: =?utf-8?q?1599200557267361323?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
