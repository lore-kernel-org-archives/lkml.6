Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE20C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 10:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15DE12085B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 10:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="niLVwYA+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15DE12085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbeJZTf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 15:35:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:37170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbeJZTf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 15:35:56 -0400
Received: from localhost (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1C9A20856;
        Fri, 26 Oct 2018 10:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540551558;
        bh=+WmK2EoimfOsr0XVBjFrvCTShi52p4aOPQbSisSRB7c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=niLVwYA+Fn1W7LXJcu1IA3pcJdwU0aueIeM4KuhKnK30W8dH08Mck47MGm29+lNhT
         g4MxOTl39P0AQMwp8QrRtYIPm4RjbDzHsA1QaUAovSKeG06DJ2aRj0vUCk2wuaKAsk
         PvMQPH9eUH03aVrUl1S+yhHq7i7KQBjGtjLhZAfw=
Date:   Fri, 26 Oct 2018 06:59:16 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Subject: Re: [PATCH AUTOSEL 3.18 04/98] USB: qcserial: Fix support for HP
 lt4112 LTE/HSPA+ Gobi 4G Modem
Message-ID: <20181026105916.GE2015@sasha-vm>
References: <20181025141853.214051-1-sashal@kernel.org>
 <20181025141853.214051-4-sashal@kernel.org>
 <20181026084920.GB27852@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181026084920.GB27852@localhost>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 10:49:20AM +0200, Johan Hovold wrote:
>On Thu, Oct 25, 2018 at 10:17:19AM -0400, Sasha Levin wrote:
>> From: Bjørn Mork <bjorn@mork.no>
>>
>> [ Upstream commit 59536da34513c594af2a6fd35ba65ea45b6960a1 ]
>>
>> The DEVICE_HWI type was added under the faulty assumption that Huawei
>> devices based on Qualcomm chipsets and firmware use the static USB
>> interface numbering known from Gobi devices.  But this model does
>> not apply to Huawei devices like the HP branded lt4112 (Huawei me906e).
>> Huawei firmwares will dynamically assign interface numbers. Functions
>> are renumbered when the firmware is reconfigured.
>>
>> Fix by changing the DEVICE_HWI type to use a simplified version
>> of Huawei's subclass + protocol scheme: Blacklisting known network
>> interface combinations and assuming the rest are serial.
>>
>> Reported-and-tested-by: Muri Nicanor <muri+libqmi@immerda.ch>
>> Tested-by: Martin Hauke <mardnh@gmx.de>
>> Cc: <stable@vger.kernel.org>
>> Fixes: e7181d005e84 ("USB: qcserial: Add support for HP lt4112 LTE/HSPA+ Gobi 4G Modem")
>> Signed-off-by: Bjørn Mork <bjorn@mork.no>
>> Signed-off-by: Johan Hovold <johan@kernel.org>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>This one is interesting though; it was marked for stable and has a
>proper fixes tag for a commit that went into 4.19. That patch in turn
>had a stable tag (new device id type patch) and was backported also to
>other active stable trees at the time.
>
>Guess the stable maintainers need to check if the offending patch has
>already been backported when determining how far back to apply a follow
>up fix.
>
>Note that the stable tag above lacks a version comment (e.g. "# 4.19"),
>but I can see how that may be too subtle to convey this (and not all
>maintainers use those). Perhaps an explicit comment should just be added
>in such cases.

Right, the whole "fix for a fix" issue is what this patch series tries
to address (you'll notice that *most* commits follow this pattern).

I'm not sure why Greg's tools missed it to begin with, but hopefully
this patch series will catch up with that.


--
Thanks,
Sasha
