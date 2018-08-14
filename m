Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33924C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E01D92172C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:47:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E01D92172C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732647AbeHNPeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 11:34:02 -0400
Received: from mail.bootlin.com ([62.4.15.54]:55499 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732186AbeHNPeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 11:34:02 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C07C520799; Tue, 14 Aug 2018 14:46:56 +0200 (CEST)
Received: from localhost (unknown [37.169.111.59])
        by mail.bootlin.com (Postfix) with ESMTPSA id 562982072C;
        Tue, 14 Aug 2018 14:46:46 +0200 (CEST)
Date:   Tue, 14 Aug 2018 14:45:47 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Quentin Schulz <quentin.schulz@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, mark.rutland@arm.com,
        davem@davemloft.net, kishon@ti.com, andrew@lunn.ch,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        allan.nielsen@microsemi.com, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH 07/10] dt-bindings: phy: add DT binding for Microsemi
 Ocelot SerDes muxing
Message-ID: <20180814124547.GL943@piout.net>
References: <cover.aa759035f6eefdd0bb2a5ae335dab5bd5399bd46.1532954208.git-series.quentin.schulz@bootlin.com>
 <cd75c96640cc7fe306ee355acb1db85adb5b796f.1532954208.git-series.quentin.schulz@bootlin.com>
 <bcea7c75-e5a6-4533-aee0-65c893e8a422@gmail.com>
 <20180801081539.gxkviv6rnpwzoyxb@qschulz>
 <20180813223748.GA20086@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180813223748.GA20086@rob-hp-laptop>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/08/2018 16:37:48-0600, Rob Herring wrote:
> > I'm fine with a define for the second value (which is basically the enum
> > serdes_type I've defined at the beginning of the serdes driver) but I
> > don't see the point of defining the index of the SerDes. What would it
> > look like?
> > 
> > enum serdes_type {
> > 	SERDES1G = 1,
> > 	SERDES6G = 6,
> > }
> > 
> > #define SERDES1G_0	0
> > #define SERDES1G_1	1
> > #define SERDES1G_2	2
> > #define SERDES6G_0	0
> > #define SERDES6G_1	1
> > 
> > Then, e.g.:
> > 
> > &port5 {
> > 	phys = <&serdes 5 SERDES1G SERDES1G_0>
> > };
> > 
> > If you want a define for the pair (serdes_type, serdes_index), I don't
> > see how I could re-use it on the driver side but it makes more sense on the
> > DeviceTree side:
> > 
> > #define SERDES1G_0	1 0
> > #define SERDES1G_1	1 1
> > #define SERDES1G_2	1 2
> > #define SERDES6G_0	6 0
> > #define SERDES6G_1	6 1
> 
> I prefer #defines which are a single number. Otherwise if you read a dts 
> file when #phy-cells is 3, it will look like an error in that you have 
> what looks like 2 cells.
> 

Maybe we should not have the type in DT and simply have an index. The
driver will now what the serdes type is anyway and the defines would be:

#define SERDES1G_0  0
#define SERDES1G_1  1
#define SERDES1G_2  2
#define SERDES6G_0  3
#define SERDES6G_1  4

The main drawback is that this requires one include file per soc.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
