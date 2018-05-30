Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932568AbeE3X7A (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 19:59:00 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33832 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932091AbeE3X64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 19:58:56 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D62FD6063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=collinsd@codeaurora.org
Subject: Re: [PATCH v4 2/2] regulator: add QCOM RPMh regulator driver
To: Doug Anderson <dianders@chromium.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>
References: <cover.1527040878.git.collinsd@codeaurora.org>
 <7489cd65fedb8a31488cf8188885759bcd4820ce.1527040878.git.collinsd@codeaurora.org>
 <CAD=FV=WF+onhAAWrbmwcHiWyCjuZ=6vvnhodUsia=Ps-da6_4A@mail.gmail.com>
From: David Collins <collinsd@codeaurora.org>
Message-ID: <5e65b713-6d45-4b33-d05e-6ebe2c6b6cec@codeaurora.org>
Date: Wed, 30 May 2018 16:58:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <CAD=FV=WF+onhAAWrbmwcHiWyCjuZ=6vvnhodUsia=Ps-da6_4A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Doug,

On 05/29/2018 10:32 PM, Doug Anderson wrote:
> On Tue, May 22, 2018 at 7:43 PM, David Collins <collinsd@codeaurora.org> wrote:
>> + * @ever_enabled:              Boolean indicating that the regulator has been
>> + *                             explicitly enabled at least once.  Voltage
>> + *                             requests should be cached when this flag is not
>> + *                             set.
> 
> Do you really need this extra boolean?  Can't you just check if
> "enabled" is still "-EINVAL"?  If it is then you don't pass the
> voltage along.
> 
> ...this would mean that you'd also need to send the voltage vote when
> the regulator core tries to disable unused regulators at the end of
> bootup, but that should be OK right?  If we never touched a regulator
> anywhere at probe time and we're about to vote to disable it, we know
> there's nobody requiring it to still be on.  We can vote for the
> voltage now without fear of messing up a vote that the BIOS left in
> place.
> 
> In theory this should also allow you to assert your vote about the
> voltage of a regulator that has never been enabled, which (if I
> understand correctly) you consider to be a feature.

Removing 'ever_enabled' and caching the voltage when 'enabled == -EINVAL'
seems workable.  I'm a little concerned about this resulting in voltage =
regulator-min-microvolt requests being sent for all regulators that are
not explicitly enabled by Linux consumers before late_initcall_sync().
Theoretically all of the boot loader hand-off cases should be taken care
of by this point so it should be safe.

I'll make this change.

Take care,
David

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
