Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B15C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75F3B217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550578471;
	bh=EY856DV7lAODzYu3bfky+EDHLw6CXkeDEgbonfZiCBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S9zefaHKbUVeiJ3Iez9ZU00aFpKUK/qabiw207D0j0DY0pqMil8TRucb1maUGiwLO
	 CSU+d4XFdKhxe+dbbbAY22pfxPocJ1IH2T/g4XKzOOlBoyzUrzlIapsp1hxWoQn5AF
	 tO3H/o1BVVgIXaGFIfhMgm99GuDWrZmYWVtGCiZM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbfBSMOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 07:14:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:37134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbfBSMOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 07:14:30 -0500
Received: from localhost (unknown [106.200.226.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E29721738;
        Tue, 19 Feb 2019 12:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550578469;
        bh=EY856DV7lAODzYu3bfky+EDHLw6CXkeDEgbonfZiCBY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VSYmEGKxMYGhZtgnhm2hTBfKINXtd5BDc81wvLbqMafcHn3wi3Sf5iwTLRvvGt3MX
         Sx08BBYygSVzgT8zIQCFHgY7Sh2L8d3QJRUrEWcfV9aoReYKDirshy7zRFtwdSkZ3m
         ZcatYaOy67OrYjsn14TN3XVkO4XZUoLLKb0C46/E=
Date:   Tue, 19 Feb 2019 17:44:20 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Long Cheng <long.cheng@mediatek.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Sean Wang <sean.wang@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sean Wang <sean.wang@mediatek.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, srv_heupstream@mediatek.com,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>,
        Zhenbao Liu <zhenbao.liu@mediatek.com>
Subject: Re: [PATCH v10 1/3] dmaengine: 8250_mtk_dma: add MediaTek uart DMA
 support
Message-ID: <20190219121420.GZ21884@vkoul-mobl>
References: <1547781016-890-1-git-send-email-long.cheng@mediatek.com>
 <1547781016-890-2-git-send-email-long.cheng@mediatek.com>
 <20190204072154.GJ4296@vkoul-mobl>
 <1550112296.7678.5.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550112296.7678.5.camel@mhfsdcap03>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-02-19, 10:44, Long Cheng wrote:
> On Mon, 2019-02-04 at 12:51 +0530, Vinod Koul wrote:

> > > +static int mtk_uart_apdma_device_pause(struct dma_chan *chan)
> > > +{
> > > +	/* just for check caps pass */
> > > +	return 0;
> > > +}
> > 
> > please remove, this is not a mandatory fn
> 
> Can't remove it. Before the mail, i had explained it. in 8250 uart
> framework, will check the function..

I think you should fix the 8250 uart to handle driver not having a
pause. Keeping a dummy pause is just wrong and sets wrong expectations
for uart..

-- 
~Vinod
