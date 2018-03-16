Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752633AbeCPS0w convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 14:26:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:37054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750877AbeCPS0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 14:26:50 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0153F20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180307190249.GW93895@bjorns-mbp-2.lan>
Cc: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>
References: <20180226175802.20052-1-ilina@codeaurora.org>
 <20180226175802.20052-3-ilina@codeaurora.org>
 <20180305231455.GJ18510@minitux> <20180306155703.GA4930@codeaurora.org>
 <20180307190249.GW93895@bjorns-mbp-2.lan>
Message-ID: <152122480915.70929.13116557401450122973@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v4 2/2] dt-bindings: introduce Command DB for QCOM SoCs
Date: Fri, 16 Mar 2018 11:26:49 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2018-03-07 11:02:49)
> On Tue 06 Mar 07:57 PST 2018, Lina Iyer wrote:
> 
> > On Mon, Mar 05 2018 at 16:15 -0700, Bjorn Andersson wrote:
> > > On Mon 26 Feb 09:58 PST 2018, Lina Iyer wrote:
> 
> > > As such I think you should just describe only the 0x85fe0000 + 0x20000
> > > region here and to support the dynamic aspect of this from a system
> > > point of view you can have the boot loader read the information at
> > > 0xc3f000c and adjust the reserved memory. (Or just keep the step of
> > > manually update the dts without caring about the indirection)
> > > 
> > It would be incorrect and very board specific to just use the 0x85fe000
> > as the address. It is not how the SoC defines the location. Upon request
> > earlier, this memory location was added in DT and the location is
> > typical reference platform usage only.
> > 
> 
> The problem is that as the db resides in a chunk of memory in the middle
> of what Linux considers System RAM the DTS must specify this region as
> reserved. Which means that as you, like described above, update the
> dictionary something (in your scheme a person) has to update the
> reserved-memory region as well.
> 
> That's why I'm proposing that the appropriate implementation for this
> is to have the boot loader to the dictionary part of this and Linux only
> care about the actual reserved-memory region. This way you would still
> implement the dictionary lookup on a system level, but the Linux
> part no longer depend on a human updating the DTS to match the values of
> the dictionary.

Agreed. I thought SMEM had a similar design of a cookie in IMEM to
indicate location and size because coordinating changes across all the
various software images is a hard problem. But coordinating between
linux and the linux bootloader shouldn't be as hard.

> 
> 
> But if we stick with the approach of describing both these and hoping
> that the values in the first region matches the second (or should we add
> a sanity check in probe?). The memory reserve defined as 0xc3f000c + 8
> looks strange, is this system ram as well and what other things resides
> in that same page?
> 

Doesn't look like it could be RAM, the address is not very close to the
other one so I would guess it's something like IMEM. And there are two
32-bit numbers to describe address and size?
