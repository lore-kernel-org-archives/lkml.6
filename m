Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17A8C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB21620675
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388476AbfAORjc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 12:39:32 -0500
Received: from 212-186-180-163.static.upcbusiness.at ([212.186.180.163]:39014
        "EHLO cgate.sperl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729035AbfAORjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 12:39:31 -0500
Received: from msmac.intern.sperl.org (account martin@sperl.org [10.10.10.11] verified)
  by sperl.org (CommuniGate Pro SMTP 6.2.1 _community_)
  with ESMTPSA id 7754790; Tue, 15 Jan 2019 17:39:28 +0000
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Regression: spi: core: avoid waking pump thread from spi_sync instead run teardown delayed
From:   kernel@martin.sperl.org
In-Reply-To: <aabd916e-005e-6cda-25d7-8ab875afa7a0@nvidia.com>
Date:   Tue, 15 Jan 2019 18:39:27 +0100
Cc:     Mark Brown <broonie@kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <AAA7943B-B1F1-4389-AAC3-8621EC6E38B8@martin.sperl.org>
References: <f86eaebb-0359-13be-f4a2-4f2b8832252e@nvidia.com> <7C4A5EFC-8235-40C8-96E1-E6020529DF72@martin.sperl.org> <aabd916e-005e-6cda-25d7-8ab875afa7a0@nvidia.com>
To:     Jon Hunter <jonathanh@nvidia.com>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John!

> On 15.01.2019, at 15:26, Jon Hunter <jonathanh@nvidia.com> wrote:
>> Looks as if there is something missing in spi_stop_queue that 
>> would wake the worker thread one last time without any delays
>> and finish the hw shutdown immediately - it runs as a delayed
>> task...
>> 
>> One question: do you run any spi transfers in
>> your test case before suspend?
> 
> No and before suspending I dumped some of the spi stats and I see no
> tranfers/messages at all ...
> 
> Stats for spi1 ...
> Bytes: 0
> Errors: 0
> Messages: 0
> Transfers: 0

This...

>> /sys/class/spi_master/spi1/statistics/messages gives some
>> counters on the number of spi messages processed which
>> would give you an indication if that is happening.
>> 
>> It could be as easy as adding right after the first lock 
>> in spi_stop_queue:
>> kthread_mod_delayed_work(&ctlr->kworker,
>>  &ctlr->pump_idle_teardown, 0);
>> (plus maybe a yield or similar to allow the worker to 
>> quickly/reliably run on a single core machine)
>> 
>> I hope that this initial guess helps.
> 
> Unfortunately, the above did not help and the issue persists.
> 
> Digging a bit deeper I see that now the 'ctlr->queue' is empty but
> 'ctlr->busy' flag is set and this is causing the 'could not stop message
> queue' error.
> 
> It seems that __spi_pump_messages() is getting called several times
> during boot when registering the spi-flash, then after the spi-flash has
> been registered, about a 1 sec later spi_pump_idle_teardown() is called
> (as expected), but exits because 'ctlr->running' is true. However,

and this contradicts each other!
If there is a call to message pump, then we should process a message
and the counters should increase.

If those counters do not increase then there is something strange.

If we are called without anything to do then the pump should trigger a
tear down and stop.

> spi_pump_idle_teardown() is never called again and when we suspend we
> are stuck in the busy/running state. In this case should something be
> scheduling spi_pump_idle_teardown() again? Although even if it does I
> don't see where the busy flag would be cleared in this path?
> 

I am wondering where busy/running would be set in the first place
if there are no counters...

Is it possible that the specific flash is not using the “normal” 
spi_pump_message, but spi_controller_mem_ops operations? 

Maybe we are missing the teardown in that driver or something is
changing flags there.

grepping a bit:

I see spi_mem_access_start calling spi_flush_queue, which is calling
pump_message, which - if there is no transfer - will trigger a delayed
tear-down, while it maybe should not be doing that.

Maybe spi_mem_access_end needs a call to spi_flush_queue as well?

Unfortunately this is theoretical work and quite a lot of guesswork
without an actual device available for testing...

Thanks,
	Martin

