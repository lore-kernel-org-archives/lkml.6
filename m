Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3F9C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2164B2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544027504;
	bh=vKZ+T3/yLJvcJtv0n93/NaSsyMXA5esfFdr7EVo+Kjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=krMiNeL/2Q+pQoYLQxOz5cVUXOrBz7M6GIcJP8WHx9+n9ghJVw1FNr1fH5ueXi7Qd
	 lVvCSIq05EDTWXZ7YPpaFohWFT0S/Rg67OFK8gMgDNoYdVoaImo8BTnq50DDDTSkVj
	 OMNH6DPgDO8zoFt/HS3V+wBj9HAOEgWFv4hGGSjA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2164B2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbeLEQbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 11:31:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:42996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727242AbeLEQbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 11:31:42 -0500
Received: from localhost (unknown [106.201.124.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31FC12082B;
        Wed,  5 Dec 2018 16:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544027502;
        bh=vKZ+T3/yLJvcJtv0n93/NaSsyMXA5esfFdr7EVo+Kjk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bkyOjiHnezjTSL+QwCkDSI+2XZYU2YVFd1CSC7m0RgQCN3uWOWqKnh2UMHQaIhijh
         w5E0Hg2h3k2lWs+2PcIF+gtw8QiEWDXpyPmxMk3ZMP1RSZ83kOgzBUQDfiD0V724LF
         deXHYd7TCUcdvpP93pZIaeXagsbc8Dr6f9T4l1Vs=
Date:   Wed, 5 Dec 2018 22:01:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Long Cheng <long.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jiri Slaby <jslaby@suse.com>,
        Sean Wang <sean.wang@mediatek.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, srv_heupstream@mediatek.com,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>
Subject: Re: [PATCH v2 0/4] add uart DMA function
Message-ID: <20181205163133.GQ2847@vkoul-mobl>
References: <1543999380-7946-1-git-send-email-long.cheng@mediatek.com>
 <20181205100306.GA12106@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205100306.GA12106@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 05-12-18, 11:03, Greg Kroah-Hartman wrote:
> On Wed, Dec 05, 2018 at 04:42:56PM +0800, Long Cheng wrote:
> > In Mediatek SOCs, the uart can support DMA function.
> > Base on DMA engine formwork, we add the DMA code to support uart. And put the code under drivers/dma.
> > 
> > This series contains document bindings, Kconfig to control the function enable or not,
> > device tree including interrupt and dma device node, the code of UART DM
> 
> I've queued up patches 1 and 3 from this series in my tty tree, thanks.

Do you mind not taking patch 2, I would like that to go thru dmaengine
tree

Thanks
-- 
~Vinod
