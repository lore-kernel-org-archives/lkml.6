Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099E5C43334
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5ACE205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="hZf1Iy/l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5ACE205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728919AbeH3BWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 21:22:07 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:49732 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727609AbeH3BWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 21:22:06 -0400
Received: from avalon.localnet (rec54-5-78-202-243-150.fbx.proxad.net [78.202.243.150])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8E6F5B92;
        Wed, 29 Aug 2018 23:23:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1535577800;
        bh=5ljkoa/Q4UTPzTLgLpHS681lGcb4NUEeXTvbO78QJAQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hZf1Iy/ltSi9+wTMlthCVMMmXObDybjMYkgkjTA+NtR53WKjU3n1GF5RwZQOAvh7S
         QtWuKzY4LfxhWKiSdu7ZjGRro1jt3HZyZDKNFX0nxt3qwjG/PQIelcsG9yBRuqcPEx
         qkoKfDzAJX4M98QB3xFuvPmpUq5rD4VOe9ZpHJjc=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     Philippe De Muyter <phdm@macq.eu>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        linux-media@vger.kernel.org, Leon Luo <leonl@leopardimaging.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] media: imx274: don't hard-code the subdev name to DRIVER_NAME
Date:   Thu, 30 Aug 2018 00:23:23 +0300
Message-ID: <1552922.PBQrL6RDxY@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180829113843.4v63cxf3clvbzbtd@valkosipuli.retiisi.org.uk>
References: <20180824163525.12694-1-luca@lucaceresoli.net> <20180829112936.GA15244@frolo.macqel> <20180829113843.4v63cxf3clvbzbtd@valkosipuli.retiisi.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wednesday, 29 August 2018 14:38:43 EEST Sakari Ailus wrote:
> On Wed, Aug 29, 2018 at 01:29:36PM +0200, Philippe De Muyter wrote:
> > On Wed, Aug 29, 2018 at 02:07:21PM +0300, Sakari Ailus wrote:
> >> On Tue, Aug 28, 2018 at 06:02:55PM +0200, Philippe De Muyter wrote:

[snip]

> >>> Then we should probably also apply the following patch I submitted :
> >>> 
> >>> "media: v4l2-common: v4l2_spi_subdev_init : generate unique name"
> >>> 
> >>> 	https://patchwork.kernel.org/patch/10553035/
> >>> 
> >>> and perhaps
> >>> 
> >>> "media: v4l2-common: simplify v4l2_i2c_subdev_init name generation"
> >>> 
> >>> 	https://patchwork.kernel.org/patch/10553037/
> >> 
> >> The problem with this patch is that the existing naming scheme is very
> >> similar while the new one offers no tangible benefits apart from being
> >> in line with the rest of the kernel. That's still not a benefit for uAPI:
> >> changing the name is certain to break user space applications.
> > 
> > I agree with you on the patch for v4l2_i2c_subdev_init (I wrote
> > 'perhaps'), but you don't say anything on the one about
> > v4l2_spi_subdev_init :), which fixes an actual bug.  I have 2 identical
> > SPI-controlled sensors on the same board, and without my patch they get
> > the same subdev name.  Of course, I could fix that in the sensor driver
> > itself, but that's not what we want, or do we ?
> 
> Good point. I missed the naming of the SPI devices ignored any bus
> information there. I'm rather inclined towards taking the SPI patch. Hans,
> Mauro, Laurent; any opinion on that?

I agree that the SPI patch makes sense, I think we should take it.

-- 
Regards,

Laurent Pinchart



