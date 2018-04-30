Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrnYTakwxcae8VtbRUMMsJK9ObhglJnOBYKv0edahKf4k0btSG/8JJgPfkAjXGijNX6WxbM
ARC-Seal: i=1; a=rsa-sha256; t=1525116373; cv=none;
        d=google.com; s=arc-20160816;
        b=apudS5Y3O6FwImDLGvOMG83aJ64/UgAYq7TUUcVgo4x2/4vSDM+lHLjDiZ6qb/CCnn
         AXBAC6BctUXj2YhMoFtGmxGRmGv5YeGXQcKRBoV3vrniHbhIVAZQ037dCFEpXnVZuZkq
         4M9B7OB/XdzZy2m3dj3lz5ixtpS988CH39W3GIpcdadb93sAZDuzJpDZu+6OuPaU7jpL
         mHqiFCHaHwAJaVEO5CC1GVIK91ohJCIWHWEH2CIUsVvR4C5lpi+FFJx+zCURryuHxI2v
         ZwbZ6DN8TwzB4okkzWfiu5ZsHerGlGo0koczlH5iKXXy/3m6ksRWm6qHvwo7AoBMi1zP
         Zl1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=0518rMqu1KG5bPoiHuzW/uxqTPvRmuaQ2/T/OK50gZo=;
        b=Ooj/1H2G9RTLOS2+on1yqeyjm0AEJXByA5HIw9seR7zgQy9avD0F9C4X7JEECzgdB2
         wPbPUQCKS281bmtm7J4uRvM5xpfRHidW/xMzKBwtGCJIxKsv9I7dDPdekixqYiEedA3k
         xqF0PpW2PVopxFgA2AFMssR42ygjmrqLfZ5zVAqFDU49FsaVkLcjBGJcg76Rz/GaVzSZ
         c+p48otAJ8TAd3u88R5y8PCLsIlGl6lD6fcebwGMIoIYdOprhkbpniw0hpwFLvbGyc/j
         leKFk7h6bO5lvuEHQ9tW2E28/xOxmD0dcrSoB372l8Ii+j8z4lXzF+rnUq1YCMN5DTNN
         65BA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A813322DAE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.4 23/44] ALSA: rme9652: Hardening for potential Spectre v1
Date: Mon, 30 Apr 2018 12:24:34 -0700
Message-Id: <20180430190947.269049780@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430190946.093694747@linuxfoundation.org>
References: <20180430190946.093694747@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200426117920838?=
X-GMAIL-MSGID: =?utf-8?q?1599200426117920838?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
