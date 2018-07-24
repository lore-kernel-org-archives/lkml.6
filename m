Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACFBAECDFBB
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76C7F205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:17:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76C7F205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sony.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388788AbeGXJW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 05:22:56 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:3184 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388735AbeGXJW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 05:22:56 -0400
Subject: Re: [PATCH RESEND] kthread, tracing: Don't expose half-written comm
 when creating kthreads
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Yoshitaka Seto <yoshitaka.seto@sony.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        John Stultz <john.stultz@linaro.org>
References: <20180723134210.54013-1-snild@sony.com>
 <20180723095550.08203a24@gandalf.local.home>
 <9d762b4e-20a7-578f-90c8-10a044921d67@sony.com>
 <20180723113741.66df3b50@gandalf.local.home>
 <7749ed7d-50d5-4b95-fbd2-b056a1fff957@sony.com>
 <20180723124154.14ef0679@gandalf.local.home>
From:   Snild Dolkow <snild@sony.com>
Message-ID: <72573a9f-694e-fc4b-cfd1-d9cde504a480@sony.com>
Date:   Tue, 24 Jul 2018 10:17:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180723124154.14ef0679@gandalf.local.home>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/23/2018 06:41 PM, Steven Rostedt wrote:
> On Mon, 23 Jul 2018 17:49:36 +0200
> Snild Dolkow <snild@sony.com> wrote:
>> Any issues with the commit message? Reading it back again now, it doesn't
>> seem quite as clear as when I wrote it.
> 
> Yeah, I think it does need some updates:
> 
>> There was a window for racing when task->comm was being written. The
> 
> It would be nice to explain this race window in more detail.
> 
I hope the following is more clear:

kthread, tracing: Don't expose half-written comm when creating kthreads

There is a window for racing when printing directly to task->comm,
allowing other threads to see a non-terminated string. The vsnprintf
function fills the buffer, counts the truncated chars, then finally
writes the \0 at the end.

	creator                         other
	vsnprintf:
	  fill (not terminated)
	  count the rest                read/use comm
	  write \0

The consequences depend on how 'other' uses the string. In our case,
it was copied into the tracing system's saved cmdlines, a buffer of
adjacent TASK_COMM_LEN-byte buffers (note the 'n' where 0 should be):

	crash-arm64> x/1024s savedcmd->saved_cmdlines | grep 'evenk'
	0xffffffd5b3818640:     "irq/497-pwr_evenkworker/u16:12"

...and a strcpy out of there would cause stack corruption:

	[224761.522292] Kernel panic - not syncing: stack-protector:
	    Kernel stack is corrupted in: ffffff9bf9783c78

	crash-arm64> kbt | grep 'comm\|trace_print_context'
	#6  0xffffff9bf9783c78 in trace_print_context+0x18c(+396)
	      comm (char [16]) =  "irq/497-pwr_even"

	crash-arm64> rd 0xffffffd4d0e17d14 8
	ffffffd4d0e17d14:  2f71726900000000 5f7277702d373934   ....irq/497-pwr_
	ffffffd4d0e17d24:  726f776b6e657665 3a3631752f72656b   evenkworker/u16:
	ffffffd4d0e17d34:  f9780248ff003231 cede60e0ffffff9b   12..H.x......`..
	ffffffd4d0e17d44:  cede60c8ffffffd4 00000fffffffffd4   .....`..........

The workaround in e09e28671 (use strlcpy in __trace_find_cmdline) was
likely needed because of this same bug.

Solved by vsnprintf:ing to a local buffer, then using set_task_comm().
This way, there won't be a window where comm is not terminated.


//Snild
