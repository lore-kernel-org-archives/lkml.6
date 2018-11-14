Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0216C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 13:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7D7E2089F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 13:27:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7D7E2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=phrozen.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732925AbeKNXas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 18:30:48 -0500
Received: from nbd.name ([46.4.11.11]:55034 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726823AbeKNXar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 18:30:47 -0500
Subject: Re: [resend PATCH 1/3] pwm: mediatek: drop flag 'has_clks'
To:     Thierry Reding <thierry.reding@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-pwm@vger.kernel.org,
        Weijie Gao <weijie.gao@mediatek.com>,
        Roy Luo <cheng-hao.luo@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <4c9044427b1aab373acd6ac76f0c905e2be79784.1542074855.git.ryder.lee@mediatek.com>
 <20181114124752.GI2620@ulmo>
From:   John Crispin <john@phrozen.org>
Message-ID: <2fc9dbac-4919-4ceb-49ac-67ddd7f203b5@phrozen.org>
Date:   Wed, 14 Nov 2018 14:27:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181114124752.GI2620@ulmo>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 14/11/2018 13:47, Thierry Reding wrote:
> On Tue, Nov 13, 2018 at 10:08:22AM +0800, Ryder Lee wrote:
>> The flag 'has_clks' and related checks are superfluous as the CCF
>> subsystem does this for you.
> Both of these mechanisms aren't equivalent. While CCF can deal with
> optional clocks, what the has_clks flag actually means is that the
> device doesn't need a clock (or doesn't have a clock input) on the
> devices where it is cleared.
>
> So I'd actually be in favor of keeping the has_clks property because it
> serves as an additional sanity check. For example if you run this driver
> on an SoC that "has clocks" but if you don't list them in DT, then after
> this patch the driver will happily continue without clocks, even though
> it may break completely without those clocks. I've seen SoCs respond to
> disabled clocks for a hardware block in different ways, in many cases an
> access to any of the registers will completely hang the CPU. In other
> cases it may just crash in some other way or give you some sort of
> machine exception. None of those are good, and make the tiny bit of
> additional code required to support the has_clks flag very attractive.
>
> But that's just my opinion. If you prefer to throw away that safety
> barrier, be my guest. But if you do, please move this functionality into
> the clock framework first and then make the driver use it.
>
> Thierry

Hi,

sorry for my late response. I added the flag for the legacy MIPS 
silicon. These SoCs only have a single clock register with a few on/off 
bits. there is no complex clocktree or scaling. Hence COMMON_CLK is not 
supported by those SoCs. I fully agree with Thierry, that the flag makes 
this explicit and the intent was indeed to make sure that on silicon 
where clocks are required, that they really are listed in OF. This is 
indeed an extra sanity check and hiding it in an implicit check inside 
CCF does not feel right.

     John

