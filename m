Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1690C61CE4
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 11:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A2A2087E
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 11:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730515AbfATLY1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 06:24:27 -0500
Received: from 212-186-180-163.static.upcbusiness.at ([212.186.180.163]:39902
        "EHLO cgate.sperl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730458AbfATLY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 06:24:26 -0500
Received: from msmac.intern.sperl.org (account martin@sperl.org [10.10.10.11] verified)
  by sperl.org (CommuniGate Pro SMTP 6.2.1 _community_)
  with ESMTPSA id 7755101; Sun, 20 Jan 2019 11:24:23 +0000
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Regression: spi: core: avoid waking pump thread from spi_sync instead run teardown delayed
From:   kernel@martin.sperl.org
In-Reply-To: <20190118191202.GG6260@sirena.org.uk>
Date:   Sun, 20 Jan 2019 12:24:23 +0100
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <EE52ED32-CBB4-40D4-8615-CA814158C826@martin.sperl.org>
References: <f86eaebb-0359-13be-f4a2-4f2b8832252e@nvidia.com> <7C4A5EFC-8235-40C8-96E1-E6020529DF72@martin.sperl.org> <aabd916e-005e-6cda-25d7-8ab875afa7a0@nvidia.com> <AAA7943B-B1F1-4389-AAC3-8621EC6E38B8@martin.sperl.org> <20190115192619.GG5522@sirena.org.uk> <5D3256B1-5DAE-4E3F-9099-5425F4BCA304@martin.sperl.org> <20190115212539.GK5522@sirena.org.uk> <EA757B47-A264-4B4D-9E5F-16611ABA0278@martin.sperl.org> <20190118191202.GG6260@sirena.org.uk>
To:     Mark Brown <broonie@kernel.org>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark!

> On 18.01.2019, at 20:12, Mark Brown <broonie@kernel.org> wrote:
> 
> On Fri, Jan 18, 2019 at 06:11:31PM +0100, kernel@martin.sperl.org wrote:
> 
>> Does something like this looks acceptable?
> 
> Yes, it does!

> 
>> SPI_CONTROLLER_MODE_EXCLUSIVE could replace the bus_lock_flag.
>> I am also not sure of the “convention” of memory mode (i.e
>> using mem_ops). Is it maybe implicitly spi_bus_locked - i.e
>> typically only a single device?
> 
> Yes, it does - we're basically handing over the entire SPI bus to
> another bit of hardware that will do memory mapped flash access so we
> can't really have anything else trying to do SPI operations at the same
> time.

These kind of changes it requires are consuming a bit more time than
I was hoping for.

So maybe at this very moment the best is reverting the patch.

I have some patches that would move towards that goal in
baby steps without having to resort to a big rewrite at
this very moment.

Maybe Jon can check each patch one after another to see if any is 
producing the unexpected behavior and only then you would include
them...

As for the root cause of the regression: my guess is that spi-mem is
just not triggering a shutdown any more because of how message_pump works.

The improvement of the state-machine can then get addressed
separately.

Martin


