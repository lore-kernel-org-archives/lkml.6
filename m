Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB88BC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3312208E7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544035847;
	bh=GdCfjL6xDzP1JbtpXJKSTTapkT7HFC/yoaXpg4smSeo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dVPmWLJ5JtDVWVHZNavavYbbYAHL0WwzAtukRkpXKsargm59beSSthA+SYbBvMm6x
	 LmUpYs8Pm7V2WqivngMFMLrl0JFvRm+palDRD/XM7ebjL5hvgHTVhhECJsHeRu25Mr
	 qGtCgUaCEywklir2lsADXDwQgrimg1oJAWdYh0wo=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3312208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbeLESuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 13:50:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:58156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727297AbeLESup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 13:50:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D21920892;
        Wed,  5 Dec 2018 18:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544035845;
        bh=GdCfjL6xDzP1JbtpXJKSTTapkT7HFC/yoaXpg4smSeo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t2NZiu16hROCQ7p8r0n3MrISAQ2KI8Ht3c8KBcjofgywbBeS11tdWNWZkyrNmtdEc
         3ahwGISOVgzQG1xAfsNk6Ka5P1JymffARJETkY4vNNPCfc1/Spn2/UVBvnqH+Qt8ku
         DvLdx4I+YGie/xrVoqBHCFOa2k95tRUUdOfixqQ0=
Date:   Wed, 5 Dec 2018 19:50:42 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
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
Message-ID: <20181205185042.GA27295@kroah.com>
References: <1543999380-7946-1-git-send-email-long.cheng@mediatek.com>
 <20181205100306.GA12106@kroah.com>
 <20181205163133.GQ2847@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205163133.GQ2847@vkoul-mobl>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 10:01:33PM +0530, Vinod Koul wrote:
> Hi Greg,
> 
> On 05-12-18, 11:03, Greg Kroah-Hartman wrote:
> > On Wed, Dec 05, 2018 at 04:42:56PM +0800, Long Cheng wrote:
> > > In Mediatek SOCs, the uart can support DMA function.
> > > Base on DMA engine formwork, we add the DMA code to support uart. And put the code under drivers/dma.
> > > 
> > > This series contains document bindings, Kconfig to control the function enable or not,
> > > device tree including interrupt and dma device node, the code of UART DM
> > 
> > I've queued up patches 1 and 3 from this series in my tty tree, thanks.
> 
> Do you mind not taking patch 2, I would like that to go thru dmaengine
> tree

Like I said, I only took patches 1 and 3...
