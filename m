Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B11C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 08:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0345522360
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 08:20:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0345522360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sony.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbeKLSMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 13:12:17 -0500
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:4437 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727296AbeKLSMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 13:12:17 -0500
X-Greylist: delayed 602 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Nov 2018 13:12:15 EST
Subject: Re: [PATCH 3.16 298/366] kthread, tracing: Don't expose half-written
 comm when creating kthreads
To:     Ben Hutchings <ben@decadent.org.uk>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
CC:     <akpm@linux-foundation.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
References: <lsq.1541965745.673358820@decadent.org.uk>
From:   Snild Dolkow <snild@sony.com>
Message-ID: <17edd54d-a979-b66d-1b30-1d1f9b1142a3@sony.com>
Date:   Mon, 12 Nov 2018 09:10:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <lsq.1541965745.673358820@decadent.org.uk>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/18 8:49 PM, Ben Hutchings wrote:
> 3.16.61-rc1 review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Snild Dolkow <snild@sony.com>
> 
> commit 3e536e222f2930534c252c1cc7ae799c725c5ff9 upstream.
> 
> There is a window for racing when printing directly to task->comm,
> allowing other threads to see a non-terminated string. The vsnprintf
> function fills the buffer, counts the truncated chars, then finally
> writes the \0 at the end.
> 
> 	creator                     other
> 	vsnprintf:
> 	  fill (not terminated)
> 	  count the rest            trace_sched_waking(p):
> 	  ...                         memcpy(comm, p->comm, TASK_COMM_LEN)
> 	  write \0
> 
> The consequences depend on how 'other' uses the string. In our case,
> it was copied into the tracing system's saved cmdlines, a buffer of
> adjacent TASK_COMM_LEN-byte buffers (note the 'n' where 0 should be):
> 
> 	crash-arm64> x/1024s savedcmd->saved_cmdlines | grep 'evenk'
> 	0xffffffd5b3818640:     "irq/497-pwr_evenkworker/u16:12"
> 
> ...and a strcpy out of there would cause stack corruption:
> 
> 	[224761.522292] Kernel panic - not syncing: stack-protector:
> 	    Kernel stack is corrupted in: ffffff9bf9783c78
> 
> 	crash-arm64> kbt | grep 'comm\|trace_print_context'
> 	#6  0xffffff9bf9783c78 in trace_print_context+0x18c(+396)
> 	      comm (char [16]) =  "irq/497-pwr_even"
> 
> 	crash-arm64> rd 0xffffffd4d0e17d14 8
> 	ffffffd4d0e17d14:  2f71726900000000 5f7277702d373934   ....irq/497-pwr_
> 	ffffffd4d0e17d24:  726f776b6e657665 3a3631752f72656b   evenkworker/u16:
> 	ffffffd4d0e17d34:  f9780248ff003231 cede60e0ffffff9b   12..H.x......`..
> 	ffffffd4d0e17d44:  cede60c8ffffffd4 00000fffffffffd4   .....`..........
> 
> The workaround in e09e28671 (use strlcpy in __trace_find_cmdline) was
> likely needed because of this same bug.
> 
> Solved by vsnprintf:ing to a local buffer, then using set_task_comm().
> This way, there won't be a window where comm is not terminated.
> 
> Link: http://lkml.kernel.org/r/20180726071539.188015-1-snild@sony.com
> 
> Fixes: bc0c38d139ec7 ("ftrace: latency tracer infrastructure")
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Signed-off-by: Snild Dolkow <snild@sony.com>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> [bwh: Backported to 3.16: adjust context]
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> ---
>  kernel/kthread.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -309,10 +309,16 @@ struct task_struct *kthread_create_on_no
>  	if (!IS_ERR(task)) {
>  		static const struct sched_param param = { .sched_priority = 0 };
>  		va_list args;
> +		char name[TASK_COMM_LEN];
>  
> +		/*
> +		 * task is already visible to other tasks, so updating
> +		 * COMM must be protected.
> +		 */
>  		va_start(args, namefmt);
> -		vsnprintf(task->comm, sizeof(task->comm), namefmt, args);
> +		vsnprintf(name, sizeof(name), namefmt, args);
>  		va_end(args);
> +		set_task_comm(task, name);
>  		/*
>  		 * root may have changed our (kthreadd's) priority or CPU mask.
>  		 * The kernel thread should not inherit these properties.
> 

Reviewed-by: Snild Dolkow <snild@sony.com>

