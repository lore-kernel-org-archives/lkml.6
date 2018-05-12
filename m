Return-Path: <christophe.jaillet@wanadoo.fr>
X-Google-Smtp-Source: AB8JxZqP/wy8A/COzJ78/1KYBJ8LfOf3FkkkyWnBpT72jNs/R1N5YQmXIiEpJc/jEt18Nxrrk9Gn
ARC-Seal: i=1; a=rsa-sha256; t=1526127267; cv=none;
        d=google.com; s=arc-20160816;
        b=dcaOykgr4k9NqfC5c4hXM61OZj9CpghcuPNGk8OVPm+ipvKTdutjuipi9xzVTK/MIN
         tWOyUr8iAX+3ymGdClC4XRcL6J9tgB+wpoJBjmFjRexqy7IKtBMJXwREC98YYUGRjBAF
         Au0LGEygy+/QvLoh1kU9aoyhhK4Rck5f+0cr3u4XZi2WuX0hjUjLvLtZA7hY/ownuwZu
         YaLRYjF6FBZo8Lioufn0xHd+6yrhXpmvUaDwKrIxg8xs4L/L33MNrFxZW6pyUSf/qYsy
         UgjSjQJEx6ZS7q9qjt+bLnZAveBpSqwwhamDs97bpQNW5BpuQc1cvtuEsJHmo3lzwrr/
         uA6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=a1pS1hhTPXJ4SYNt7mJREDMzJGvMfeYFotTS+5/RLPI=;
        b=E059di5Fo1eV0oQ3f9n1PfbzWpEVCpPVsNyBAAXlM3pL270qBHxWSvhLdP6umEwv6k
         RL4G1+5qjWK7/hrIBV5tfnekksySFZhik7Bet5ECqebSHapIfEEoBl4gY3IpcdWizA+D
         M/sgN2sl8x163hiLMPxx3sv616lHYsYPL/Cu9nIEfuZPzkyY3HSbBNTSxSUBVPk3Ygmm
         spwKRto+5tG+pfrmC74uhPs/y5bkVj05txDaFPKujHqZFDTEG+iUEtB/tJR4Sd9f7NDq
         bRh/JGAdQU8GONlEhUISJ8/2or2AksIrnRj+9dgAX9UNnADjpg9Ulk4WzcPPRvgIG2Gg
         qGBQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 80.12.242.133 is neither permitted nor denied by best guess record for domain of christophe.jaillet@wanadoo.fr) smtp.mailfrom=christophe.jaillet@wanadoo.fr
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 80.12.242.133 is neither permitted nor denied by best guess record for domain of christophe.jaillet@wanadoo.fr) smtp.mailfrom=christophe.jaillet@wanadoo.fr
X-ME-Helo: ubuntu-CJ.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 12 May 2018 14:14:27 +0200
X-ME-IP: 86.244.116.1
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: oleg.drokin@intel.com,
	andreas.dilger@intel.com,
	jsimmons@infradead.org,
	gregkh@linuxfoundation.org,
	neilb@suse.com,
	aastha.gupta4104@gmail.com
Cc: lustre-devel@lists.lustre.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] staging: lustre: Use 'kvfree()' for memory allocated by 'kvzalloc()'
Date: Sat, 12 May 2018 14:14:26 +0200
Message-Id: <20180512121426.22988-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.17.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600260426475055864?=
X-GMAIL-MSGID: =?utf-8?q?1600260426475055864?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

'buf' is allocated with 'kvzalloc()'. 'kvfree()' must be used to free it.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Fixes: 11c647caf74b ("staging: lustre: obdclass: variable llog chunk size")
Reviewed-by: NeilBrown <neilb@suse.com>
---
 drivers/staging/lustre/lustre/obdclass/llog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/lustre/lustre/obdclass/llog.c b/drivers/staging/lustre/lustre/obdclass/llog.c
index 693e1129f1f9..5e04d133b596 100644
--- a/drivers/staging/lustre/lustre/obdclass/llog.c
+++ b/drivers/staging/lustre/lustre/obdclass/llog.c
@@ -385,7 +385,7 @@ static int llog_process_thread(void *arg)
 	if (cd)
 		cd->lpcd_last_idx = last_called_index;
 
-	kfree(buf);
+	kvfree(buf);
 	lpi->lpi_rc = rc;
 	return 0;
 }
-- 
2.17.0
