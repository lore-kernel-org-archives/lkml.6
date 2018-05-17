Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751965AbeEQLwy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 07:52:54 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:44162 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751839AbeEQLwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 07:52:53 -0400
X-Google-Smtp-Source: AB8JxZq13bcbVZX/hqOXZHUsEybRws8cnpsqyps1hNC/W9SOuJt8NG4D09uXxSZX+5kRssQ9Oxl7jQ==
Date: Thu, 17 May 2018 20:52:48 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, dvyukov@google.com,
        pmladek@suse.com, sergey.senozhatsky@gmail.com,
        syzkaller@googlegroups.com, rostedt@goodmis.org,
        fengguang.wu@intel.com, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org
Subject: Re: [PATCH] printk: inject caller information into the body of
 message
Message-ID: <20180517115248.GA409@jagdpanzerIV>
References: <20180511014515.GA895@jagdpanzerIV>
 <201805110238.w4B2cIGH079602@www262.sakura.ne.jp>
 <20180511062151.GA18160@jagdpanzerIV>
 <CACT4Y+ahAHZa7WGW41rY5TtApU7F9x2jo=iPv8GvjaGZbzMOCQ@mail.gmail.com>
 <20180511095004.GA6575@jagdpanzerIV>
 <201805112058.AAB05258.HJQFFOMFOVtOSL@I-love.SAKURA.ne.jp>
 <20180517112135.GB20796@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517112135.GB20796@jagdpanzerIV>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (05/17/18 20:21), Sergey Senozhatsky wrote:
> Dunno...
> For instance, can we store context tracking info as a extended record
> data? We have that dict/dict_len thing. So may we can store tracking
> info there? Extended records will appear on the serial console /* if
> console supports extended data */ or can be read in via devkmsg_read().

Those extended records are already there for exactly the same
reason - people want to attach a special context to printk() entries.
See dev_vprintk_emit() and create_syslog_header(). So we can add more
key/value data to that context. Sounds kinda-sorta reasonable.

So, for example, this output
cat /dev/kmsg

6,577,3156036,-;snd_hda_codec_generic hdaudioC1D0: autoconfig for Generic: line_outs=0 (0x0/0x0/0x0/0x0/0x0) type:line
 SUBSYSTEM=hdaudio
 DEVICE=+hdaudio:hdaudioC1D
6,578,3156807,-;snd_hda_codec_generic hdaudioC1D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
 SUBSYSTEM=hdaudio
 DEVICE=+hdaudio:hdaudioC1D

Becomes this:
6,566,3033752,-;snd_hda_codec_realtek hdaudioC0D0:      Front Mic=0x19
 3/207: 0/0/0
 SUBSYSTEM=hdaudio
 DEVICE=+hdaudio:hdaudioC0D
6,567,3033754,-;snd_hda_codec_realtek hdaudioC0D0:      Rear Mic=0x18
 3/207: 0/0/0
 SUBSYSTEM=hdaudio
 DEVICE=+hdaudio:hdaudioC0D


"3/207: 0/0/0" is smp_processor_id/task_pid_nr and then masked
out bits of preempt count: hard irq, soft irq, nmi.

We definitely can change the format, etc. This is just a very quick and
dirty PoC.

Something as follows?
/* just to demonstrate the idea */

---

 kernel/printk/printk.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 2f4af216bd6e..4a82d52a343d 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -580,16 +580,33 @@ static u32 truncate_msg(u16 *text_len, u16 *trunc_msg_len,
 	return msg_used_size(*text_len + *trunc_msg_len, 0, pad_len);
 }
 
+static size_t add_log_origin(char *buf, size_t buf_len)
+{
+	return snprintf(buf,
+			buf_len,
+			"%d/%d: %lu/%lu/%lu",
+			raw_smp_processor_id(),
+			task_pid_nr(current),
+			preempt_count() & HARDIRQ_MASK,
+			preempt_count() & SOFTIRQ_MASK,
+			preempt_count() & NMI_MASK);
+}
+
 /* insert record into the buffer, discard old ones, update heads */
 static int log_store(int facility, int level,
 		     enum log_flags flags, u64 ts_nsec,
 		     const char *dict, u16 dict_len,
 		     const char *text, u16 text_len)
 {
+	static char log_origin[64];
+	static size_t log_origin_len;
 	struct printk_log *msg;
 	u32 size, pad_len;
 	u16 trunc_msg_len = 0;
 
+	log_origin_len = add_log_origin(log_origin, sizeof(log_origin));
+	dict_len += log_origin_len;
+
 	/* number of '\0' padding bytes to next message */
 	size = msg_used_size(text_len, dict_len, &pad_len);
 
@@ -620,7 +637,10 @@ static int log_store(int facility, int level,
 		memcpy(log_text(msg) + text_len, trunc_msg, trunc_msg_len);
 		msg->text_len += trunc_msg_len;
 	}
-	memcpy(log_dict(msg), dict, dict_len);
+	memcpy(log_dict(msg), log_origin, log_origin_len);
+	memcpy(log_dict(msg) + log_origin_len + 1,
+		dict,
+		dict_len - log_origin_len);
 	msg->dict_len = dict_len;
 	msg->facility = facility;
 	msg->level = level & 7;
 
