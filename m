Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
X-Google-Smtp-Source: AIpwx48jsnb9VWUC8WhLd7sYTNSUur+w8GpsFwu0Btao2X0Jq9wUAluiVk8nRKPQ0ofeVT8WoMX2
ARC-Seal: i=1; a=rsa-sha256; t=1524572720; cv=none;
        d=google.com; s=arc-20160816;
        b=XEuJ52/8P8oUxQVAKGj37uK7Xp0qVsJbkPxEf8oR9WMCsvG3C2KmrKZoXXX7G5x85k
         jjV5zRAbiwON89kvWBWrFFbfj+wtd0kGfasFf/Sgoi0zPht7PTkuMkHBY+eqhUYzs8JM
         jpidRE3GJoqJ5EWmvDgu8IYksVFYIQUwlFluQxyl/eos0LqYiNUyY1MRxooNaBssx4+p
         AM3s5/XjNf5xeICxSSo6rTueyrQrvwqGY+E5/Wh16IFYNfSJHpLd2Mg7/Mzl5WD1V4LQ
         OAKW5NqHEmppbkhOmLYbGcfCN2kTNOXlhd6yerxw2ZpYzE/9sjwzlHr2msUgi54WJSCD
         b/bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=hpn2KEwEQR0xtYzaSEy5Fl9TcNlS/N1FlZwqyy8NeP8=;
        b=VgFWqubO13i1zCmOV9ATUOpUmhIN1kHnkf2jatqZ0eWGj7GwQn65eDlxYhCX6fb8EH
         xBgqWC6Lq5U5DrbgTNO6Hirw6Evpc2Mrv9ueY76+uu7Z9hisLhsuoMMd0f0/untblbqf
         mHcHFU+cJ8zpwBaWhJWI1G569whty2gqtZfSqp3Ke1F7KJbaukrhW01ogdr78VPc+SiJ
         J+UB9KExWpcs6pUiqnNtIHAJCXXMnIotnsoki/K115aaIR2mPfaIxDoY3SQZ8/WUyfas
         DDQ9NhCvfQd0PPF1I/AFtG+VwB8XNmcHtdmg2jJhMuHx6ONYEIva0tFO6haaTD38FVDI
         tliA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of penguin-kernel@i-love.sakura.ne.jp designates 202.181.97.72 as permitted sender) smtp.mailfrom=penguin-kernel@i-love.sakura.ne.jp
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of penguin-kernel@i-love.sakura.ne.jp designates 202.181.97.72 as permitted sender) smtp.mailfrom=penguin-kernel@i-love.sakura.ne.jp
Subject: Re: INFO: rcu detected stall in n_tty_receive_char_special
To: gregkh@linuxfoundation.org, jslaby@suse.com,
        Peter Hurley <peter@hurleysoftware.com>
Cc: dvyukov@google.com,
        syzbot <syzbot+18df353d7540aa6b5467@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <883d24f7d4ccc52e19056928c5be@google.com>
 <001a113f8d5cab39bd0569e3482a@google.com>
 <93a0c663-bbcf-0779-5606-6eeda644f8b9@I-love.SAKURA.ne.jp>
 <e7a78d54-20c8-773d-e2aa-b6ad066a1fca@I-love.SAKURA.ne.jp>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <9d6bf77a-0a00-19d7-19f7-53082f494e81@I-love.SAKURA.ne.jp>
Date: Tue, 24 Apr 2018 21:25:13 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <e7a78d54-20c8-773d-e2aa-b6ad066a1fca@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596979907220664835?=
X-GMAIL-MSGID: =?utf-8?q?1598630364878846125?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018/04/24 1:01, Tetsuo Handa wrote:
> Bisection reached to commit e052c6d15c61cc4c ("tty: Use unbound workqueue
> for all input workers") added in 4.4-rc1.
> 
> Reverting that commit on top of 4.4 solved the lockup. But unfortunately,
> reverting that commit on top of 4.16 only helped surviving the test longer
> than vanilla 4.16; still stalls at __process_echoes(). There might be similar
> changes which need to be reverted as well.

I noticed that when stall inside __process_echoes() occurs, it is looping at
discard loop added by commit cbfd0340ae199337 ("n_tty: Process echoes in blocks").
Since ldata->echo_commit < ldata->echo_tail is for some reason true upon entry,
the discard loop serves as almost infinite loop.

--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -613,12 +613,21 @@ static size_t __process_echoes(struct tty_struct *tty)
 	int	space, old_space;
 	size_t tail;
 	unsigned char c;
+	unsigned long start = jiffies;
 
 	old_space = space = tty_write_room(tty);
 
 	tail = ldata->echo_tail;
+	if (ldata->echo_commit < tail)
+		printk("BUG1: ldata->echo_commit=%ld tail=%ld space=%d old_space=%d\n",
+		       ldata->echo_commit, tail, space, old_space);
 	while (ldata->echo_commit != tail) {
 		c = echo_buf(ldata, tail);
+		if (time_after(jiffies, start + 5 * HZ)) {
+			printk("ldata->echo_commit=%ld tail=%ld c=%c space=%d old_space=%d\n",
+			       ldata->echo_commit, tail, c, space, old_space);
+			start = jiffies;
+		}
 		if (c == ECHO_OP_START) {
 			unsigned char op;
 			int no_space_left = 0;
@@ -729,6 +738,11 @@ static size_t __process_echoes(struct tty_struct *tty)
 	 * of echo overrun before the next commit), then discard enough
 	 * data at the tail to prevent a subsequent overrun */
 	while (ldata->echo_commit - tail >= ECHO_DISCARD_WATERMARK) {
+		if (time_after(jiffies, start + 5 * HZ)) {
+			printk("ldata->echo_commit=%ld ldata->echo_tail=%ld tail=%ld space=%d old_space=%d\n",
+			       ldata->echo_commit, ldata->echo_tail, tail, space, old_space);
+			start = jiffies;
+		}
 		if (echo_buf(ldata, tail) == ECHO_OP_START) {
 			if (echo_buf(ldata, tail + 1) == ECHO_OP_ERASE_TAB)
 				tail += 3;
@@ -739,6 +753,9 @@ static size_t __process_echoes(struct tty_struct *tty)
 	}
 
 	ldata->echo_tail = tail;
+	if (ldata->echo_commit < tail)
+		printk("BUG2: ldata->echo_commit=%ld tail=%ld space=%d old_space=%d\n",
+		       ldata->echo_commit, tail, space, old_space);
 	return old_space - space;
 }
 


[    5.890788] input: PC Speaker as /devices/platform/pcspkr/input/input4
[   27.357324] BUG1: ldata->echo_commit=120 tail=130 space=7936 old_space=7936
[   32.358527] ldata->echo_commit=120 ldata->echo_tail=130 tail=2994833619 space=0 old_space=7936
[   37.362404] ldata->echo_commit=120 ldata->echo_tail=130 tail=5930715049 space=0 old_space=7936
[   42.366124] ldata->echo_commit=120 ldata->echo_tail=130 tail=8943875147 space=0 old_space=7936
[   47.370508] ldata->echo_commit=120 ldata->echo_tail=130 tail=11950164125 space=0 old_space=7936
[   52.374224] ldata->echo_commit=120 ldata->echo_tail=130 tail=14880807667 space=0 old_space=7936
[   57.378597] ldata->echo_commit=120 ldata->echo_tail=130 tail=17821338400 space=0 old_space=7936
[   62.383638] ldata->echo_commit=120 ldata->echo_tail=130 tail=20811717629 space=0 old_space=7936
[   63.203807] sysrq: SysRq : Resetting

[    5.843667] input: PC Speaker as /devices/platform/pcspkr/input/input4
[   28.306346] BUG1: ldata->echo_commit=128 tail=130 space=7936 old_space=7936
[   33.307133] ldata->echo_commit=128 ldata->echo_tail=130 tail=2892537244 space=0 old_space=7936
[   38.311478] ldata->echo_commit=128 ldata->echo_tail=130 tail=5766457276 space=0 old_space=7936
[   43.315319] ldata->echo_commit=128 ldata->echo_tail=130 tail=8686538551 space=0 old_space=7936
[   48.319164] ldata->echo_commit=128 ldata->echo_tail=130 tail=11556458920 space=0 old_space=7936
[   50.122017] sysrq: SysRq : Resetting

[    6.026322] input: PC Speaker as /devices/platform/pcspkr/input/input4
[   38.149864] BUG1: ldata->echo_commit=118 tail=130 space=7936 old_space=7936
[   43.150167] ldata->echo_commit=118 ldata->echo_tail=130 tail=2789490540 space=0 old_space=7936
[   48.154012] ldata->echo_commit=118 ldata->echo_tail=130 tail=5592467000 space=0 old_space=7936
[   53.158365] ldata->echo_commit=118 ldata->echo_tail=130 tail=8376906144 space=0 old_space=7936
[   58.162211] ldata->echo_commit=118 ldata->echo_tail=130 tail=11158984120 space=0 old_space=7936
[   60.487338] sysrq: SysRq : Resetting

[    9.170831] input: PC Speaker as /devices/platform/pcspkr/input/input4
[   25.929908] BUG1: ldata->echo_commit=120 tail=130 space=7936 old_space=7936
[   30.930553] ldata->echo_commit=120 ldata->echo_tail=130 tail=3008469343 space=0 old_space=7936
[   35.935475] ldata->echo_commit=120 ldata->echo_tail=130 tail=5857403750 space=0 old_space=7936
[   40.940153] ldata->echo_commit=120 ldata->echo_tail=130 tail=8858176994 space=0 old_space=7936
[   45.944527] ldata->echo_commit=120 ldata->echo_tail=130 tail=11838898685 space=0 old_space=7936
[   48.948625] sysrq: SysRq : Resetting

[    6.071991] input: PC Speaker as /devices/platform/pcspkr/input/input4
[   22.890428] BUG1: ldata->echo_commit=128 tail=130 space=7936 old_space=7936
[   27.891372] ldata->echo_commit=128 ldata->echo_tail=130 tail=3064270209 space=0 old_space=7936
[   32.895212] ldata->echo_commit=128 ldata->echo_tail=130 tail=6085270166 space=0 old_space=7936
[   37.899047] ldata->echo_commit=128 ldata->echo_tail=130 tail=9102650663 space=0 old_space=7936
[   42.903405] ldata->echo_commit=128 ldata->echo_tail=130 tail=12195198062 space=0 old_space=7936
[   44.497876] sysrq: SysRq : Resetting

[    5.804688] input: PC Speaker as /devices/platform/pcspkr/input/input4
[   23.632487] BUG1: ldata->echo_commit=102 tail=130 space=7936 old_space=7936
[   28.633878] ldata->echo_commit=102 ldata->echo_tail=130 tail=2930081035 space=0 old_space=7936
[   33.638168] ldata->echo_commit=102 ldata->echo_tail=130 tail=5867627875 space=0 old_space=7936
[   38.654062] ldata->echo_commit=102 ldata->echo_tail=130 tail=8804236495 space=0 old_space=7936
[   40.296804] sysrq: SysRq : Resetting
