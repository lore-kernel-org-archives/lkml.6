Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F1AC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 04:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E2EB20882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 04:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9ezvdls"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E2EB20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbeILJHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 05:07:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:47418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725737AbeILJHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 05:07:40 -0400
Received: from localhost (unknown [171.76.126.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A04320839;
        Wed, 12 Sep 2018 04:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536725106;
        bh=xm/iYCXRL/GBgk6nOhAZAVyMDKqwjffY6ub9MFxuizs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a9ezvdlspVCnr9Nm3e58aQcZIHb7b6kVeCBvaihjltWt2mClevfbFIVZabACAvFSl
         0lhNKd+pq7m6EZR7BkZIkIxUX3IeBrGYeelvFv/1t9XGrlPYM8NTxBTGHBWgj9sT+S
         3LnBClH0gJeDab/ea4Y/MOFKJ5GniiVi3SSbuYBU=
Date:   Wed, 12 Sep 2018 09:34:56 +0530
From:   Vinod <vkoul@kernel.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org,
        Rakesh Ughreja <rakesh.a.ughreja@intel.com>,
        Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH 2/3] sound: enable interrupt after dma buffer
 initialization
Message-ID: <20180912040456.GD2766@vkoul-mobl>
References: <20180910211718.200802-1-yuzhao@google.com>
 <20180910212150.202655-1-yuzhao@google.com>
 <s5hbm9436va.wl-tiwai@suse.de>
 <20180911205825.GB18086@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911205825.GB18086@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-09-18, 14:58, Yu Zhao wrote:
> On Tue, Sep 11, 2018 at 08:06:49AM +0200, Takashi Iwai wrote:
> > On Mon, 10 Sep 2018 23:21:50 +0200,
> > Yu Zhao wrote:
> > > 
> > > In snd_hdac_bus_init_chip(), we enable interrupt before
> > > snd_hdac_bus_init_cmd_io() initializing dma buffers. If irq has
> > > been acquired and irq handler uses the dma buffer, kernel may crash
> > > when interrupt comes in.
> > > 
> > > Fix the problem by postponing enabling irq after dma buffer
> > > initialization. And warn once on null dma buffer pointer during the
> > > initialization.
> > > 
> > > Signed-off-by: Yu Zhao <yuzhao@google.com>
> > 
> > Looks good to me.
> > 
> > Reviewed-by: Takashi Iwai <tiwai@suse.de>
> > 
> > 
> > BTW, the reason why this hasn't been hit on the legacy HD-audio driver
> > is that we allocate usually with MSI, so the irq is isolated.
> > 
> > Any reason that Intel SKL driver doesn't use MST?
> 
> This I'm not sure. Vinod might have answer to it, according to
> https://patchwork.kernel.org/patch/6375831/#13796611

IIRC (seemed quite some time back) we faced issues with using MSI on SKL
and didnt try afterwards. If Intel folks can try it and check. Pierre is
out, maybe Liam can help..?

-- 
~Vinod
