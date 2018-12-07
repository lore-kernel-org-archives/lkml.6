Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C42AC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 05:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A079D2082D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 05:01:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A079D2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbeLGE6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 23:58:32 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:61814 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeLGE6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 23:58:31 -0500
Received: from fsav302.sakura.ne.jp (fsav302.sakura.ne.jp [153.120.85.133])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id wB74wTsx074320;
        Fri, 7 Dec 2018 13:58:29 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav302.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav302.sakura.ne.jp);
 Fri, 07 Dec 2018 13:58:29 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav302.sakura.ne.jp)
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id wB74wTCH074309;
        Fri, 7 Dec 2018 13:58:29 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: (from i-love@localhost)
        by www262.sakura.ne.jp (8.15.2/8.15.2/Submit) id wB74wTYu074308;
        Fri, 7 Dec 2018 13:58:29 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-Id: <201812070458.wB74wTYu074308@www262.sakura.ne.jp>
X-Authentication-Warning: www262.sakura.ne.jp: i-love set sender to penguin-kernel@i-love.sakura.ne.jp using -f
Subject: Re: [PATCH] printk: Add caller information to printk() output.
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>, Dmitry Vyukov <dvyukov@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
MIME-Version: 1.0
Date:   Fri, 07 Dec 2018 13:58:29 +0900
References: <459018db-763b-9520-ead2-2c0d5975fbf3@i-love.sakura.ne.jp> <20181205115041.GB453@jagdpanzerIV>
In-Reply-To: <20181205115041.GB453@jagdpanzerIV>
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sergey Senozhatsky wrote:
> Do we need PIDs at all?

Yes. I don't like truncating caller information, for I think that PID is
used for not only reconstructing messages but also serving as a clue for
understanding what the process was doing.

> PIDs don't tell that much. When you are grepping serial log you can't
> actually tell if PID 15000 there and PID 15000 here, 200000 log lines
> apart, are same processes; or did PIDs wrap around? And you probably
> don't even care.

I don't care whether PIDs wrapped around. If the goal were to check whether PIDs
wrapped around, we would print "struct task_struct"->[real_]start_time together.

>                  All you need is a way to reconstruct a message around
> some very specific place in the log - say in a range [-500, +500] lines,
> assuming that a backtrace you are trying to reconstruct is badly fragmented.
> I think, even 3 lower digits of a PID should do the trick.

3 lower digits is insufficient for reconstructing PID of interest; it can
conflict at 1/1000 probability.
3 lower hexadecimal digits might be better but is insufficient; it can still
conflict at 1/4096.

3 lower base64 characters might be sufficient; it conflicts at only 1/262144.
4 base64 characters is sufficient, for 64*64*64*64 > PID_MAX_LIMIT.
But what do you feel from example output shown below? While no truncation of
caller information, it is hard for humans to understand.

----------------------------------------
@@ -1227,39 +1254,47 @@ static inline void boot_delay_msec(int level)
 static bool printk_time = IS_ENABLED(CONFIG_PRINTK_TIME);
 module_param_named(time, printk_time, bool, S_IRUGO | S_IWUSR);
 
-static size_t print_time(u64 ts, char *buf)
-{
-	unsigned long rem_nsec = do_div(ts, 1000000000);
-
-	if (!buf)
-		return snprintf(NULL, 0, "[%5lu.000000] ", (unsigned long)ts);
-
-	return sprintf(buf, "[%5lu.%06lu] ",
-		       (unsigned long)ts, rem_nsec / 1000);
-}
-
 static size_t print_prefix(const struct printk_log *msg, bool syslog,
 			   bool time, char *buf)
 {
 	size_t len = 0;
-	unsigned int prefix = (msg->facility << 3) | msg->level;
+	char tmp[PREFIX_MAX];
 
+	if (!buf)
+		buf = tmp;
 	if (syslog) {
-		if (buf) {
-			len += sprintf(buf, "<%u>", prefix);
-		} else {
-			len += 3;
-			if (prefix > 999)
-				len += 3;
-			else if (prefix > 99)
-				len += 2;
-			else if (prefix > 9)
-				len++;
-		}
+		unsigned int prefix = (msg->facility << 3) | msg->level;
+
+		len += sprintf(buf, "<%u>", prefix);
 	}
+#ifdef CONFIG_PRINTK_FROM
+	buf[len++] = '[';
+	if (time) {
+		u64 ts = msg->ts_nsec;
+		unsigned long rem_nsec = do_div(ts, 1000000000);
 
-	if (time)
-		len += print_time(msg->ts_nsec, buf ? buf + len : NULL);
+		len += sprintf(buf + len, "%lu.%06lu", (unsigned long)ts,
+			       rem_nsec / 1000);
+	}
+	{
+		static const char base64[64] = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
+			"abcdefghijklmnopqrstuvwxyz0123456789+/";
+		u32 id = msg->from_id;
+
+		len += sprintf(buf + len, "%c%c%c%c%c] ",
+			       (id & 0x80000000 ? 'C' : 'T'),
+			       base64[(id >> 18) & 63], base64[(id >> 12) & 63],
+			       base64[(id >> 6) & 63], base64[id & 63]);
+	}
+#else
+	if (time) {
+		u64 ts = msg->ts_nsec;
+		unsigned long rem_nsec = do_div(ts, 1000000000);
+
+		len += sprintf(buf + len, "[%5lu.%06lu] ", (unsigned long)ts,
+			       rem_nsec / 1000);
+	}
+#endif
 	return len;
 }
 
----------------------------------------

----------------------------------------
[0.000000TAAAA] Disabled fast string operations
[1.023286TAAAB] Performance Events: Skylake events, core PMU driver.
[5.624742TAACc] systemd-fstab-g (156) used greatest stack depth: 13656 bytes left
[5.680184TAAA+] input: ImPS/2 Generic Wheel Mouse as /devices/platform/i8042/serio1/input/input3
[5.681783TAACb] dracut-rootfs-g (155) used greatest stack depth: 13640 bytes left
[9.299727TAAu+] ata8: SATA link down (SStatus 0 SControl 300)
[15.922239TABI/] e1000: ens32 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: None
[15.923927TABYb] IPv6: ADDRCONF(NETDEV_UP): ens32: link is not ready
[15.930537TABI/] IPv6: ADDRCONF(NETDEV_CHANGE): ens32: link becomes ready
[40.506011CAAAA] random: crng init done
[926.716687TAAAB] reboot: Power down
----------------------------------------

After all, printing all digits without truncation will be the better.
