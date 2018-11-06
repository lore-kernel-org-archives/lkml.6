Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE53C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 06:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F7E120862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 06:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrSSx+G7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F7E120862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387545AbeKFPzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 10:55:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:34002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387399AbeKFPzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 10:55:19 -0500
Received: from localhost (mobile-107-77-164-72.mobile.att.net [107.77.164.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6E5E2085B;
        Tue,  6 Nov 2018 06:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541485900;
        bh=eF6cwO8zlD/mSxh7N+j3Ypm/59NGLUjfmUSB4Nx+VD0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lrSSx+G7U4wevt/5W0e7xH3zY7yMuV+uFX0f2nsiizUkp7AVkDEpzNdNnSp5CZkNP
         /hl8Npc1QgIEIjwSIDoUCNTHdqEeHsQFokvdGnL2C3auxUf8nJ6bmK/hWKRPAa6MZL
         rtG1HKR2LFMLiPZHqa0PZwEiTWQ5Mbi3o/zqEXeI=
Date:   Tue, 6 Nov 2018 01:31:38 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     "sudipm.mukherjee@gmail.com" <sudipm.mukherjee@gmail.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "digetx@gmail.com" <digetx@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "treding@nvidia.com" <treding@nvidia.com>
Subject: Re: [PATCH 4.14 069/143] ARM: tegra: Fix ULPI regression on Tegra20
Message-ID: <20181106063138.GB151445@sasha-vm>
References: <20181102182857.064326086@linuxfoundation.org>
 <20181102182902.797148907@linuxfoundation.org>
 <CADVatmOX9FfVGZhFgAZ1sVvnigucFD9DuUu+K8444mTN=Qr+6w@mail.gmail.com>
 <20181103020224.GK194472@sasha-vm>
 <1541426747.7086.15.camel@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1541426747.7086.15.camel@toradex.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 02:05:49PM +0000, Marcel Ziswiler wrote:
>On Fri, 2018-11-02 at 22:02 -0400, Sasha Levin wrote:
>> On Fri, Nov 02, 2018 at 07:56:57PM +0000, Sudip Mukherjee wrote:
>> > Hi Greg,
>> >
>> > On Fri, Nov 2, 2018 at 6:53 PM Greg Kroah-Hartman
>> > <gregkh@linuxfoundation.org> wrote:
>> > >
>> > > 4.14-stable review patch.  If anyone has any objections, please
>> > > let me know.
>> >
>> > It seems this has already been reverted upstream:
>> > 9bf4e370048d ("ARM: dts: tegra20: Revert "Fix ULPI regression on
>> > Tegra20"")
>>
>> The commit log of 9bf4e370048d suggests that this issue was fixed
>> somewhere else which made 9bf4e370048d unnecessary. Can someone point
>> to
>> that fix?
>
>Yes, sorry. That got fixed properly by Dmitry in 5d797111afe1 ("clk:
>tegra: Add quirk for getting CDEV1/2 clocks on Tegra20").

Thank you. I've replaced it for 4.14, but for 4.9 it seems there are
quite a few dependencies to pick 5d797111afe1 so I only removed
4c9a27a6c66d. If you have a backport for 4.9 I'll be happy to take it.

--
Thanks,
Sasha
