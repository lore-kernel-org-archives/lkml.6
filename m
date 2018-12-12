Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52174C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1332920849
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544622102;
	bh=Q/liFnaRV2NZHw9epeIa8L8FJ39cIgBOQezry13/bQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lqT1d3xFx7hKLeaPYBla7LwwozFOQrmhOdnrewH6cC+bdTtMrX0Y5X0+vg7PnEkRV
	 t5hTr6me3sA2rJug6arVtyZO42WMT/QkyFpBZ6/OMYJOVT6MJAjkx0C43T5a2p+XPZ
	 dGiEww5AfjgceB3kpaeYD0FJTqUjPXZKLnvr7GnI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1332920849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbeLLNll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 08:41:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:33052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbeLLNlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 08:41:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1044F20849;
        Wed, 12 Dec 2018 13:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544622099;
        bh=Q/liFnaRV2NZHw9epeIa8L8FJ39cIgBOQezry13/bQ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yvWchS95VkMGlxlB30DhDCiSgL5ZCR78Yv3FfgyUCVmh03PLzivCdVOFL46y+KL6H
         YOgHm7ods8z3U6ECoASoXnti7J8X7fEQ2DkhAS5Z5mZZnrkGlRIyG4Z+DEAzf+AI19
         NYxq8Z5B8i0QQrhbOwvf0PZCuli5WpRdtM11l78U=
Date:   Wed, 12 Dec 2018 14:41:37 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     robh+dt@kernel.org, arnd@arndb.de, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        bkumar@qti.qualcomm.com, thierry.escande@linaro.org
Subject: Re: [PATCH v2 6/6] misc: fastrpc: Add support for compat ioctls
Message-ID: <20181212134137.GA4358@kroah.com>
References: <20181207163513.16412-1-srinivas.kandagatla@linaro.org>
 <20181207163513.16412-7-srinivas.kandagatla@linaro.org>
 <20181212105932.GA1990@kroah.com>
 <864aaef3-8d60-3beb-ce20-a9f41f78a32f@linaro.org>
 <20181212115037.GA31075@kroah.com>
 <9867e420-de78-abc3-ab9d-deea3cf2491e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9867e420-de78-abc3-ab9d-deea3cf2491e@linaro.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 12:26:26PM +0000, Srinivas Kandagatla wrote:
> 
> 
> > > > 
> > > > What prevents you from doing that and requiring compat support?
> > > > 
> > > I removed most of the compat IOCTLS except this one.
> > > The reason is that this ioctl takes arguments which can vary in number for
> > > each call.
> > 
> > Then do not do that :)
> > 
> > Remember, you get to design the api, fix the structure size to work
> > properly everywhere.
> > 
> > > So args are passed as pointer to structure, rather than fixed
> > > size. I could not find better way to rearrange this to give a fixed size
> > > data structure. In theory number of arguments can vary from 0-255 for both
> > > in & out.
> > > 
> > > current data structure looks like this:
> > > 
> > > struct fastrpc_invoke_args {
> > > 	__s32 fd;
> > > 	size_t length;
> > > 	void *ptr;
> > > };
> > 
> > Make length and ptr both __u64 and you should be fine, right?  If you do
> > that, might as well make fd __u64 as well to align things better.
> > 
> 
> That is fine for the args structure, but below "args" pointer in "struct
> fastrpc_invoke" is still not fixed size, unless we change that to __u64
> pointing to array of struct fastrpc_invoke_args. I have seen such usages in
> i915_drm.h.
> Is that the preferred?

Yes, force all pointers to be __u64 and you should be fine.

thanks,

greg k-h
