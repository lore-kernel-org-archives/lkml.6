Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D88C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 813AE206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="WAyqiKJu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731169AbfBOPBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 10:01:12 -0500
Received: from uho.ysoft.cz ([81.19.3.130]:48208 "EHLO uho.ysoft.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730831AbfBOPBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 10:01:12 -0500
Received: from [10.1.8.111] (unknown [10.1.8.111])
        by uho.ysoft.cz (Postfix) with ESMTP id C8C75A6490;
        Fri, 15 Feb 2019 16:01:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1550242868;
        bh=jzyhPl3YglK7yUBctudQfISg3mpsITA6KIy8ISSumso=;
        h=To:Cc:From:Subject:Date:From;
        b=WAyqiKJur8zVuzpV52wuQalOnvM5b+5rSMLK46UKw+YfwWhfo8Y12GEXOjb0C1yqL
         N2LncuddOHzcHaVlC5yhEdGWsqtPg6Fr4UgMP2FB7TRBSm3BdmxWWoUGGXBdICr9kJ
         NA7W8jspr69Wu8CBn0+nHivQixp3jrcg7FFxYtiw=
To:     Vinod Koul <vkoul@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
From:   =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Subject: [RFC] net: dsa: qca8k: implement rgmii-id mode
Message-ID: <0c7428dc-736e-c5c4-13e7-b42052c60cd7@ysoft.com>
Date:   Fri, 15 Feb 2019 16:01:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

networking on my boards [1], which are currently in linux-next, suddently
stopped working. I tracked it down to this commit 5ecdd77c61c8 ("net: dsa:
qca8k: disable delay for RGMII mode") [2].

So I think the rgmii-id mode is obviously needed in my case.
I was able to find a couple drivers that read tx/rx-delay or
tx/rx-internal-delay from device tree. Namely:

   drivers/net/ethernet/apm/xgene/xgene_enet_main.c
   drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
   drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
   drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
   drivers/net/phy/dp83867.c

I would appreciate any hints how to add similar function to qca8k driver
if that is the correct way to go. Can I take some of the above mentioned
drivers as a good example for that? How should the binding look like?

I would expect something like this:

	switch@0 {
		compatible = "qca,qca8334";
		reg = <0>;

		switch_ports: ports {
			#address-cells = <1>;
			#size-cells = <0>;

			ethphy0: port@0 {
				reg = <0>;
				label = "cpu";
				phy-mode = "rgmii-id";
				qca,tx-delay = <3>;
				qca,rx-delay = <3>;
				ethernet = <&fec>;
		};
	};


Thanks in advance,
Michal

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=87489ec3a77f3e01bcf0d46e353ae7112ec8c4f0
[2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/net/dsa/qca8k.c?id=5ecdd77c61c8fe1d75ded538701e5e854963c890
