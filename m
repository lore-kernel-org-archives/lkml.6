Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
X-Google-Smtp-Source: AIpwx4905TrjlBhREmI7pae4nlD6Bj5gr12MeluPjqYPKqMiWfljUikTyWaLlUAPXc1WQB1DYK6+
ARC-Seal: i=1; a=rsa-sha256; t=1524479687; cv=none;
        d=google.com; s=arc-20160816;
        b=cDlaD2ZhC2hll8AvwezGWx42aUR/ye/jC2MagHYnsB6NcbhXH32/zk5jhi4z/CEE74
         no+TPVmDVqvg5Rev/LlDRVwB0/skUO0Ep9kXcvMCcWXrerF3T0Bc3ES6YzuvJgccch9/
         3/WvNgUy3yFEw4XM/m9MunyJ7XmAOFhCRLhnNAW5iXqqLnLhX18DtbTTllZcihb1Cc0G
         uxob7Cvksa//noJyY0rxaeQuBiRcXz/TXJuegt8VT/XdVB5Rag8gBDfYa+ewE9hL5UQW
         Mwb5KvHZdPgOJlX4EdFk8Sf4Jb/6k+sWjS53W4O1aAKgIES/+Fk19eDj4JVbun0oeqw+
         u4HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:cc:references:to:subject
         :arc-authentication-results;
        bh=rVqJrbCl7g7GGsvZ6GzBDjFBqcDHEnpn9D86HXrPOgU=;
        b=xco9U4TTs3kScCISTE3YK99Vi7nPc/7eDPgQvIopvKcsjP8Zc0TvJAD8ufmpVOxOk8
         YPC0JulPBQbZ2aA3V4joLsVFlT8TI1Kw8x5pSvg0zqhgx4pPGLIkOPQxYWxkkDpv/4W3
         1HZSjBvuDHq4sAvGpXfPG8kysfZyUCs/I0RUT96+yh5IzqPr/WjjX8ZWTg1vnarNPxcU
         mJH+tSQrW7EPqWWIFJPb2+Fh8SQkpLhJustAuL94Rjxe8dC2xW4hJaHT05voMuWNOBa4
         Q/uWO3fG5R5T4bqRFBLJwBg6VpMQ3FFBK/Yu7+fhP2Ng1FXmITWOviCorQe4pE50mPc8
         sUog==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of penguin-kernel@i-love.sakura.ne.jp designates 202.181.97.72 as permitted sender) smtp.mailfrom=penguin-kernel@i-love.sakura.ne.jp
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of penguin-kernel@i-love.sakura.ne.jp designates 202.181.97.72 as permitted sender) smtp.mailfrom=penguin-kernel@i-love.sakura.ne.jp
Subject: Re: KASAN: use-after-free Read in debugfs_remove (2)
To: syzbot <syzbot+db48ce201b524603190a@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com,
        weiping zhang
 <zhangweiping@didichuxing.com>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>
References: <000000000000fbda89056a818f20@google.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <a5b6e0ff-ad8e-18f4-8c24-cdfafe4e3883@I-love.SAKURA.ne.jp>
Date: Mon, 23 Apr 2018 19:34:45 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <000000000000fbda89056a818f20@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598532704298959546?=
X-GMAIL-MSGID: =?utf-8?q?1598532812569366868?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

>From be88e559ec13f49b1c3aec2457c14c70f6b1926a Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Mon, 23 Apr 2018 11:21:03 +0900
Subject: [PATCH] bdi: Fix use after free bug in debugfs_remove()

syzbot is reporting use after free bug in debugfs_remove() [1].

This is because fault injection made memory allocation for
debugfs_create_file() from bdi_debug_register() from bdi_register_va()
fail and continued with setting WB_registered. But when debugfs_remove()
is called from debugfs_remove(bdi->debug_dir) from bdi_debug_unregister()
 from bdi_unregister() from release_bdi() because WB_registered was set
by bdi_register_va(), IS_ERR_OR_NULL(bdi->debug_dir) == false despite
debugfs_remove(bdi->debug_dir) was already called from bdi_register_va().

Fix this by making IS_ERR_OR_NULL(bdi->debug_dir) == true.

[1] https://syzkaller.appspot.com/bug?id=5ab4efd91a96dcea9b68104f159adf4af2a6dfc1

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <syzbot+049cb4ae097049dac137@syzkaller.appspotmail.com>
Fixes: 97f07697932e6faf ("bdi: convert bdi_debug_register to int")
Cc: weiping zhang <zhangweiping@didichuxing.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>
---
 mm/backing-dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 023190c..7fe73fa 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -115,6 +115,7 @@ static int bdi_debug_register(struct backing_dev_info *bdi, const char *name)
 					       bdi, &bdi_debug_stats_fops);
 	if (!bdi->debug_stats) {
 		debugfs_remove(bdi->debug_dir);
+		bdi->debug_dir = NULL;
 		return -ENOMEM;
 	}
 
-- 
1.8.3.1
