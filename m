Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988B8C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 08:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55ACF27BD3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 08:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mlXdOIfO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55ACF27BD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934952AbeF2IUY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 04:20:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:39292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934450AbeF2ITx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 04:19:53 -0400
Received: from localhost (unknown [122.167.66.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3920627BD0;
        Fri, 29 Jun 2018 08:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530260393;
        bh=NfPIYk9xddzrsPnC3APkgW7Qri6Vca9Zw0aXZdd8NeY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mlXdOIfOhivzBqG8V1/kzvvXlOPKGBBI4ClCSWrb3T/I8SOtc4Aa2OPBz99xm7kCu
         AHMpP2kJoehsjrnQOKaySaoUXK92WfSwxVoLpZHPBONJYR2nQiTICaLS2PoQvWLoq+
         cCBzZZ7wwY0NN/IAIEpul8AoLBINBfDAv6jTFdZE=
Date:   Fri, 29 Jun 2018 13:49:39 +0530
From:   Vinod <vkoul@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     dan.j.williams@intel.com, michal.simek@xilinx.com,
        appana.durga.rao@xilinx.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: Re: [PATCH v3 1/5] dmaengine: xilinx_dma: in axidma slave_sg and
 dma_cylic mode align split descriptors
Message-ID: <20180629081939.GA22377@vkoul-mobl>
References: <20180625092724.22164-1-andrea.merello@gmail.com>
 <20180629072552.GY22377@vkoul-mobl>
 <CAN8YU5Owh2Sb+-mOR0nVFkdZpD=dRd2jCin5MCdnsNLPo5zwwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN8YU5Owh2Sb+-mOR0nVFkdZpD=dRd2jCin5MCdnsNLPo5zwwg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-06-18, 09:46, Andrea Merello wrote:
> On Fri, Jun 29, 2018 at 9:25 AM, Vinod <vkoul@kernel.org> wrote:

> >> +
> >> +                     if ((copy + sg_used < period_len) &&
> >> +                         chan->xdev->common.copy_align) {
> >> +                             /*
> >> +                              * If this is not the last descriptor, make sure
> >> +                              * the next one will be properly aligned
> >> +                              */
> >> +                             copy = rounddown(copy,
> >> +                                     (1 << chan->xdev->common.copy_align));
> >> +                     }
> >
> > same code pasted twice, can we have a routine for this... perhaps more
> > code can be made common too
> 
> Yes, I see.. Indeed there was duplicated code before this series and
> it is still there after it.
> 
> I can see if we can have a routine as you suggested at least for the
> code portions touched by this patch. Do you eventually want this extra
> change to be done in the same patch 1/5 or do you want a separate
> patch i.e. 2/6 or 6/6 ?

Each patch should do one thing, so would make sense to move first and
then add you on top of that. 1/6 commonize and 2/6 add this bit.


-- 
~Vinod
