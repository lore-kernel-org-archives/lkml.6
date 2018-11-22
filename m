Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C70C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D0EB20838
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="plNsEOPm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D0EB20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438287AbeKWGO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 01:14:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:56600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732651AbeKWGO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 01:14:56 -0500
Received: from localhost (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 761ED20824;
        Thu, 22 Nov 2018 19:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542915249;
        bh=6/AoC6NABWMEQY5K85Kgy9gNNi+LE1Vnspafci+qyRQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=plNsEOPmelltehOE7Q2Hd9wROuy8d8JBvY/8Ofq4D48ow0NYDgBgQTRYLENY2PAeb
         teqUjrb9lS3TW/FdLvXMZHxhZNzLBU5FtRZEHwIqbTlY0/KCubEbqfBdNN2aoRh8VD
         /kyI1WqKis4n4bOkP03pvhQA90ojxY6XeuSaa4S8=
Date:   Thu, 22 Nov 2018 14:34:05 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        Andy Duan <fugang.duan@nxp.com>
Subject: Re: [PATCH AUTOSEL 4.19 32/73] ARM: dts: imx6sx-sdb: Fix enet phy
 regulator
Message-ID: <20181122193405.GB9725@sasha-vm>
References: <20181114222207.98701-1-sashal@kernel.org>
 <20181114222207.98701-32-sashal@kernel.org>
 <81c6426b186174a852cf615b4321f4283d9b5fd7.camel@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <81c6426b186174a852cf615b4321f4283d9b5fd7.camel@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 10:39:44AM +0000, Leonard Crestez wrote:
>On Wed, 2018-11-14 at 17:21 -0500, Sasha Levin wrote:
>> From: Leonard Crestez <leonard.crestez@nxp.com>
>>
>> [ Upstream commit 1ad9fb750a104f51851c092edd7b3553f0218428 ]
>>
>> Bindings for "fixed-regulator" only explicitly support "gpio" property,
>> not "gpios". Fix by correcting the property name.
>>
>> The enet PHYs on imx6sx-sdb needs to be explicitly reset after a power
>> cycle, this can be handled by the phy-reset-gpios property. Sadly this
>> is not handled on suspend: the fec driver turns phy-supply off but
>> doesn't assert phy-reset-gpios again on resume.
>>
>> Since additional phy-level work is required to support powering off the
>> phy in suspend fix the problem by just marking the regulator as
>> "boot-on" "always-on" so that it's never turned off. This behavior is
>> equivalent to older releases.
>>
>> Keep the phy-reset-gpios property on fec anyway because it is a correct
>> description of board design.
>>
>> This issue was exposed by commit efdfeb079cc3 ("regulator: fixed:
>> Convert to use GPIO descriptor only") which causes the "gpios" property
>> to also be parsed. Before that commit the "gpios" property had no
>> effect, PHY reset was only handled in the the bootloader.
>>
>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
>> Signed-off-by: Shawn Guo <shawnguo@kernel.org>
>
>This is something of a workaround for gpio core changes in 4.20 and
>there is no need for it in older releases.
>
>I don't think you should backport this.

Dropped, thank you.

Thanks,
Sasha
