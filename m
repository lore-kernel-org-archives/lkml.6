Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D366AC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 840ED20868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:34:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 840ED20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbeLABnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 20:43:33 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:20330 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbeLABnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 20:43:32 -0500
Received: from fsav103.sakura.ne.jp (fsav103.sakura.ne.jp [27.133.134.230])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id wAUEXlkV056024;
        Fri, 30 Nov 2018 23:33:47 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav103.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp);
 Fri, 30 Nov 2018 23:33:47 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id wAUEXgEd055987
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Fri, 30 Nov 2018 23:33:47 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] printk: don't unconditionally shortcut print_time()
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
References: <1543056613-4779-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20181129141921.djeumz723fr7pasn@pathway.suse.cz>
 <201811300226.wAU2Q2JG060388@www262.sakura.ne.jp>
 <20181130123027.cyqfi2k34nh2gjmx@pathway.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <02b4ce85-c1e5-6601-e3a7-cecfbd5298dc@i-love.sakura.ne.jp>
Date:   Fri, 30 Nov 2018 23:33:39 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181130123027.cyqfi2k34nh2gjmx@pathway.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/11/30 21:30, Petr Mladek wrote:
> I am not fully happy with the solution passing time parameter.
> It is less secure. But it would not break compatibility.
> This particular race might be solved the following way:
> 
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 1b2a029360b7..5b489988e9b7 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1294,6 +1294,7 @@ static size_t msg_print_text(const struct printk_log *msg, bool syslog, char *bu
>  
>  static int syslog_print(char __user *buf, int size)
>  {
> +	static bool time;
>  	char *text;
>  	struct printk_log *msg;
>  	int len = 0;
> @@ -1318,9 +1319,13 @@ static int syslog_print(char __user *buf, int size)
>  			break;
>  		}
>  
> +		/* Keep partial line consistent */
> +		if (!syslog_partial)
> +			time = printk_time;
> +
>  		skip = syslog_partial;
>  		msg = log_from_idx(syslog_idx);
> -		n = msg_print_text(msg, true, text, LOG_LINE_MAX + PREFIX_MAX);
> +		n = msg_print_text(msg, true, time, text, LOG_LINE_MAX + PREFIX_MAX);
>  		if (n - syslog_partial <= size) {

OK. This should avoid making "n < syslog_partial" true.

Running below test code on current linux.git reads garbage bytes

----------------------------------------
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/klog.h>
#define SYSLOG_ACTION_READ 2
#define SYSLOG_ACTION_SIZE_UNREAD 9
int main(int argc, char *argv[])
{
	static char buffer[1024];
	int fd1 = open("/sys/module/printk/parameters/time", O_WRONLY);
	int fd2 = open("/proc/sysrq-trigger", O_WRONLY);
	int size;
	write(fd1, "1\n", 2);
	write(fd2, "h\n", 2);
	while ((size = klogctl(SYSLOG_ACTION_SIZE_UNREAD, NULL, 0)) > 2)
		klogctl(SYSLOG_ACTION_READ, buffer, (size > sizeof(buffer) ? sizeof(buffer) : size) - 1);
	write(fd1, "0\n", 2);
	klogctl(SYSLOG_ACTION_READ, buffer, sizeof(buffer));
	return 0;
}
----------------------------------------

and (I can't find the reproducer but) sometimes crashes like

[  451.988242] BUG: pagefault on kernel address 0xffff8881337fa000 in non-whitelisted uaccess
[  451.990465] BUG: unable to handle kernel paging request at ffff8881337fa000
[  451.992254] PGD 3602067 P4D 3602067 PUD 3605067 PMD 13ff65067 PTE 800ffffecc805060
[  451.994066] Oops: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC
[  451.995284] CPU: 0 PID: 8147 Comm: a.out Kdump: loaded Not tainted 4.20.0-rc4+ #537
[  451.997268] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 05/19/2017
[  451.999857] RIP: 0010:copy_user_generic_unrolled+0x54/0xc0
[  452.001312] Code: 83 e2 3f c1 e9 06 74 4a 4c 8b 06 4c 8b 4e 08 4c 8b 56 10 4c 8b 5e 18 4c 89 07 4c 89 4f 08 4c 89 57 10 4c 89 5f 18 4c 8b 46 20 <4c> 8b 4e 28 4c 8b 56 30 4c 8b 5e 38 4c 89 47 20 4c 89 4f 28 4c 89
[  452.006119] RSP: 0018:ffffc90002573e90 EFLAGS: 00010202
[  452.007230] RAX: 0000000000701060 RBX: 0000000000100000 RCX: 0000000000002f02
[  452.008792] RDX: 0000000000000000 RSI: ffff8881337f9fd4 RDI: 0000000000644fe0
[  452.010399] RBP: 0000000000601060 R08: 8b494e7401000000 R09: 00000b88858b4900
[  452.011916] R10: 0f02000000c980f6 R11: b4bb830000025d85 R12: ffff8881337b6054
[  452.013351] R13: 0000000000601060 R14: ffff8881337b5fa8 R15: 00000000000000ac
[  452.014807] FS:  00007fb3c9eec740(0000) GS:ffff88813b200000(0000) knlGS:0000000000000000
[  452.016931] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  452.018234] CR2: ffff8881337fa000 CR3: 0000000139153002 CR4: 00000000001606f0
[  452.020038] Call Trace:
[  452.020708]  _copy_to_user+0x56/0x70
[  452.021580]  do_syslog+0x47d/0x7b0
[  452.022359]  ? syscall_trace_enter+0x1c3/0x360
[  452.023395]  ? trace_hardirqs_on_thunk+0x1a/0x1c
[  452.024438]  ? lockdep_hardirqs_off+0x73/0xe0
[  452.025433]  __x64_sys_syslog+0x13/0x20
[  452.026363]  do_syscall_64+0x4f/0x1f0
[  452.027235]  entry_SYSCALL_64_after_hwframe+0x49/0xbe

>  			/* message fits into buffer, move forward */
>  			syslog_idx = log_next(syslog_idx);

But we need to make this "static bool time;" accessible from SYSLOG_ACTION_SIZE_UNREAD case
because syslog_partial subtraction assumes that msg_print_text() used printk_time value
as of syslog_print() updated syslog_partial.

	while (seq < log_next_seq) {
		struct printk_log *msg = log_from_idx(idx);

		error += msg_print_text(msg, true, NULL, 0);
		idx = log_next(idx);
		seq++;
	}
	error -= syslog_partial;

So, we would use a global variable like below?

/*
 * To keep partial line consistent, pass this value to msg_print_text()
 * when accessing syslog_partial.
 */
static bool syslog_partial_printk_time;

