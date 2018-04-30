Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZodk4wexTbirYhozt4Khx13nyTsrbIkZVpAPKbdMllcuS25dtfOlZdtL+5YDGg3q9Cxpugl
ARC-Seal: i=1; a=rsa-sha256; t=1525116388; cv=none;
        d=google.com; s=arc-20160816;
        b=rD8venKnQwbi/k0blEWa60mmxQ5dZPkXi3jxlgUebN5+tQX6sC+iWzpkS1bSu1YPhe
         u4VRCpVpT4PCXsZSeiOFX+2nkM1heaaoidxHmHUEHdOjrwpJqbkNX6hPyc6AiwidsHjU
         vlyLxGiW6RUfLVUf2WHVE/+2Z8yFQ6okdHgCd1u3f583FDcDxtBbvYgoDbIG3ioanRgR
         ZJrzAV9qw/rkHxyziWBu8u9U5uLFxsKo/WQ+bCuAyCN2CeP20UuN6mcTzPmFnTanGuI6
         naD6mcrGTdQ57h7YI6EUgsRfdVYNS04cxMlxn2Wo8V1S07GwR8jx4XAOujPzjk3hx0+U
         KWOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=ng9vU5M3GzLhHtECK5iYMD62EqV3dMSxwo0CoqOoU4g=;
        b=KRNLr9dQRReb6trNPs0jM58i1RTlejQJMGpENP+tPw1YAn021bMB9ZARc1RZ3JYQOX
         jibHxtVZrykpr2iYyslhBOEHH8VbbjJE7JlE41DzND+kl+Lc6CIY4S5HF17PP7ujLVe+
         ciMEWJHZOwYRJmWS0aAMmBpkeC7D2dYR7dpxUVgsvT3ufs4sImX6ond37rB60Dub9tma
         ow3Dv7bYPTm5u74A9AXl3cJI7e9gUcSB1xef2+IH5oqTWblsRBZsdgNTx+VuyysrXa8z
         tD8j+iXdXRXODVFFLvj+TjdA2ehCAW8a4UbRPRg2iBdM/U1YzIuML5xyDaoBir308MEr
         Ba+Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74C6922E03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 29/61] ALSA: rme9652: Hardening for potential Spectre v1
Date: Mon, 30 Apr 2018 12:24:32 -0700
Message-Id: <20180430183953.884169906@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183951.312721450@linuxfoundation.org>
References: <20180430183951.312721450@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200426117920838?=
X-GMAIL-MSGID: =?utf-8?q?1599200442848275736?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit f526afcd8f71945c23ce581d7864ace93de8a4f7 upstream.

As recently Smatch suggested, one place in RME9652 driver may expand
the array directly from the user-space value with speculation:
  sound/pci/rme9652/rme9652.c:2074 snd_rme9652_channel_info() warn: potential spectre issue 'rme9652->channel_map' (local cap)

This patch puts array_index_nospec() for hardening against it.

BugLink: https://marc.info/?l=linux-kernel&m=152411496503418&w=2
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/rme9652/rme9652.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/sound/pci/rme9652/rme9652.c
+++ b/sound/pci/rme9652/rme9652.c
@@ -26,6 +26,7 @@
 #include <linux/pci.h>
 #include <linux/module.h>
 #include <linux/io.h>
+#include <linux/nospec.h>
 
 #include <sound/core.h>
 #include <sound/control.h>
@@ -2036,9 +2037,10 @@ static int snd_rme9652_channel_info(stru
 	if (snd_BUG_ON(info->channel >= RME9652_NCHANNELS))
 		return -EINVAL;
 
-	if ((chn = rme9652->channel_map[info->channel]) < 0) {
+	chn = rme9652->channel_map[array_index_nospec(info->channel,
+						      RME9652_NCHANNELS)];
+	if (chn < 0)
 		return -EINVAL;
-	}
 
 	info->offset = chn * RME9652_CHANNEL_BUFFER_BYTES;
 	info->first = 0;
