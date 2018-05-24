Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033656AbeEXQ0p (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 12:26:45 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46042 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030515AbeEXQ0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 12:26:04 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8145560A06
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=girishm@codeaurora.org
Subject: Re: [PATCH] spi: spi-geni-qcom: Add SPI driver support for GENI based
 QUP
To: Mark Brown <broonie@kernel.org>, Stephen Boyd <swboyd@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        sdharia@codeaurora.org, kramasub@codeaurora.org, dianders@chromium.org,
        linux-arm-msm@vger.kernel.org
References: <1525383283-18390-1-git-send-email-girishm@codeaurora.org>
 <152607782792.34267.8023817955251139395@swboyd.mtv.corp.google.com>
 <24b3ef71-18c1-1704-e324-5581fd18a998@codeaurora.org>
 <152700759909.210890.13296077062705155869@swboyd.mtv.corp.google.com>
 <20180522173000.GG24776@sirena.org.uk>
From: "Mahadevan, Girish" <girishm@codeaurora.org>
Message-ID: <8968e04c-a200-ef06-5c33-94e399f7b9fe@codeaurora.org>
Date: Thu, 24 May 2018 10:25:58 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180522173000.GG24776@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark, Stephen

On 5/22/2018 11:30 AM, Mark Brown wrote:
>> That's good. The problem I see is that we have to specify the max
>> frequency in the controller/bus node, and also in the child/slave node.
>> It should only need to be specified in the slave node, so making the
>> cur_speed_hz equal the max_speed_hz is problematic. The current speed of
>> the master should be determined by calling clk_get_rate().
>
> We don't require that the slaves all individually set a speed since it
> gets a bit redundant, it should be enough to just use the default the
> controller provides.  A bigger problem with this is that the driver will
> never see a transfer which doesn't explicitly have a speed set as the
> core will ensure something is set, open coding this logic in every
> driver would obviously be tiresome.

Sorry , I need some more clarification.

When I register the master, I specify the max rate the core can support
(50 Mhz). So any transaction that comes to the driver is going to be
requesting at-most 50 Mhz.

The reason I have the cur_speed_hz is that there is a max_speed_hz which
is the max frequency the slave can do; but every transfer can also
specify a speed_hz and override this.

So my point is we can do upto 4 slaves on a given controller, each slave
can have a different max speed and each slave's transfer can override
the max_frequency of that slave device.
(the default frequency is the master's max frequency)

>> Do you mean spi-rx-delay-us and spi-tx-delay-us properties? Those are
>> documented but don't seem to be used. There's also the delay_usecs part
>> of the spi_transfer structure, which may be what you're talking about.
> 
> delay_usecs is for inter-transfer delays within a message rather than
> after the initial chip select assert (it can be used to keep chip select
> asserted for longer after the final transfer too).  Obviously this is
> also something that shouldn't be configured in a driver specific
> fashion.
> 

Hmmm ok, so you mean don't send these as controller_data, rather add new
members to the spi_device struct ?

Best Regards
Girish

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora
Forum, a Linux Foundation Collaborative Project.
