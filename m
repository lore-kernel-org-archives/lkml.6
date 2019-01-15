Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FBFC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B7F620657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390092AbfAOU67 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 15:58:59 -0500
Received: from 212-186-180-163.static.upcbusiness.at ([212.186.180.163]:39050
        "EHLO cgate.sperl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730050AbfAOU67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 15:58:59 -0500
Received: from [10.10.10.192] (account martin@sperl.org [10.10.10.192] verified)
  by sperl.org (CommuniGate Pro SMTP 6.2.1 _community_)
  with ESMTPSA id 7754801; Tue, 15 Jan 2019 20:58:55 +0000
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: Regression: spi: core: avoid waking pump thread from spi_sync instead run teardown delayed
From:   Martin Sperl <kernel@martin.sperl.org>
X-Mailer: iPad Mail (16C50)
In-Reply-To: <20190115192619.GG5522@sirena.org.uk>
Date:   Tue, 15 Jan 2019 21:58:55 +0100
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <5D3256B1-5DAE-4E3F-9099-5425F4BCA304@martin.sperl.org>
References: <f86eaebb-0359-13be-f4a2-4f2b8832252e@nvidia.com> <7C4A5EFC-8235-40C8-96E1-E6020529DF72@martin.sperl.org> <aabd916e-005e-6cda-25d7-8ab875afa7a0@nvidia.com> <AAA7943B-B1F1-4389-AAC3-8621EC6E38B8@martin.sperl.org> <20190115192619.GG5522@sirena.org.uk>
To:     Mark Brown <broonie@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 15.01.2019, at 20:26, Mark Brown <broonie@kernel.org> wrote:
> 
>> On Tue, Jan 15, 2019 at 06:39:27PM +0100, kernel@martin.sperl.org wrote:
>> 
>> Is it possible that the specific flash is not using the “normal” 
>> spi_pump_message, but spi_controller_mem_ops operations? 
> 
> Right, that's my best guess at the minute as well.
> 
>> Maybe we are missing the teardown in that driver or something is
>> changing flags there.
> 
>> grepping a bit:
> 
>> I see spi_mem_access_start calling spi_flush_queue, which is calling
>> pump_message, which - if there is no transfer - will trigger a delayed
>> tear-down, while it maybe should not be doing that.
> 
> If nothing else it's inefficient.
> 
>> Maybe spi_mem_access_end needs a call to spi_flush_queue as well?
> 
> Hrm, or needs to schedule the queue at any rate (though this will only
> have an impact in the fairly unusual case where there's something
> sharing the bus with a flash).
> 
>> Unfortunately this is theoretical work and quite a lot of guesswork
>> without an actual device available for testing...
> 
> Indeed.

Maybe a bigger change to the reduce the complexity of
the state machine would solve that problem and also
reduce code complexity... 

I may find some time over the weekend if no solution
has been found until then.

The way I would envision it it would have a “state”
as a level (0=shutdown, 1=hw enabled, 2=in pump, 
3=in transfer, 4=in hw-mode,...) and a complete
to allow waking the shutdown thread (and by this
avoiding the busy wait loop we have now).
This would replace those idling, busy, and running flags.

Drawback: it is invasive, but let us see what it
really looks like...

Martin


