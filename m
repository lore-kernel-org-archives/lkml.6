Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqY69Hxr9ZEz7iZWzt0cV8Ju2vaQrIQyDY1t90FyFHgB2fMZSlH1RHjSNLNPbetlCoJbhIh
ARC-Seal: i=1; a=rsa-sha256; t=1525116357; cv=none;
        d=google.com; s=arc-20160816;
        b=WGvxJqXwhfH27qYXjHAsClvE7/Nn07SC6M3jBtieMI38EHnGMrvuCp/WYd0SEDyj5O
         Tsi8gD1iIOHjwygJfvchGWGOS5cJ00OIeJ98yB7OURbFAseyV2q4k+kiUMYbXIP+BbGC
         AkGvKmfGhOeAzVav0Ud/o9CJtCQQcHVrb3zYZRcpmCV547e5bSZ7JxuHDUx/HY4riSNK
         EtQFF1PA9i7O1VwO1UHt2ZzvsmsBE0hLH8iPC7M2n/6FZ635UL5uEckL1h6oiXe5330l
         w4nOZfERYMi0PCIzHHDEfAaRTZS2EFGrCWQ4Gxo0Sw//xwjqiJ6vPT4oki/jAkXoGSKi
         vwFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=/vobJAh7mvKmU/zDNRKLf/JdETdnIpzQLuI07Txzz7c=;
        b=kmqWlEGFIhHLZgk87tuaJfDiJyejj+kPW8LbVLcspJL+UQJP3gezKKh+9v3QeF5r07
         kmveq1DxAqwcoeU/uweTNtllNJIfkxniqvEwmKELO7+6zbgQC8egwz0beQE4BxpOiUyf
         59cuuWFIqehdiJurHs3t73ChWEhFSNojnYHVJg1bbydtbl3nMu+9hbW27IsoaRlPREqX
         hk2h6ugHrJqfCtDm5binznAII2MfJPdOuJHXCf53jt00/3rBlBsoXmibJGyZQuU+2KOR
         XP6QVZs7BOrZ8d0YzRa1PZNDZEr6SFMG3aTWL54gJppRXgCTgmMafNWzsbFoJhtFlLxA
         mNDw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E921B22DAC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.4 28/44] ALSA: hda: Hardening for potential Spectre v1
Date: Mon, 30 Apr 2018 12:24:39 -0700
Message-Id: <20180430190947.463498343@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430190946.093694747@linuxfoundation.org>
References: <20180430190946.093694747@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200409700898059?=
X-GMAIL-MSGID: =?utf-8?q?1599200409700898059?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
