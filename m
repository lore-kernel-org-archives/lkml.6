Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01B9C32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F15320684
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajLBHnI+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F15320684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730349AbeKUD2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:28:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:44886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727085AbeKUD2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:28:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5311E20831;
        Tue, 20 Nov 2018 16:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542733089;
        bh=+1YpEoUYxv8/Ge0Eg8VN6vzwCvtyTn2eXcxNunMdvoU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ajLBHnI+KIckSWq1IUNOHSo9OP7GDHpyr+xtDtstNNoa4Q6igPF+detG6c2PbKFBi
         zknwBxlSuRESpDMojwylVfpXakdFroPa7findRRoXhtVUbRYDVcQ4ahQcJcdgBT2lJ
         L2qZuHlVQXWkvPMUOb9P2vseJHFefdcNy9DTd2FI=
Date:   Tue, 20 Nov 2018 17:58:07 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Ioana Ciornei <ioana.ciornei@nxp.com>
Cc:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev-owner@vger.kernel.org" <netdev-owner@vger.kernel.org>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Leo Li <leoyang.li@nxp.com>
Subject: Re: [PATCH v3 2/4] bus: fsl-mc: add fsl-mc userspace support
Message-ID: <20181120165807.GA28793@kroah.com>
References: <1542728371-6972-1-git-send-email-ioana.ciornei@nxp.com>
 <1542728371-6972-3-git-send-email-ioana.ciornei@nxp.com>
 <20181120164416.GB27531@kroah.com>
 <VI1PR0402MB2800CF10719D11DD21F47356E0D90@VI1PR0402MB2800.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR0402MB2800CF10719D11DD21F47356E0D90@VI1PR0402MB2800.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 04:51:07PM +0000, Ioana Ciornei wrote:
> > On Tue, Nov 20, 2018 at 03:39:45PM +0000, Ioana Ciornei wrote:
> > > +
> > > +			error = fsl_mc_uapi_create_device_file(mc_bus);
> > > +			if (error < 0) {
> > > +				error = -EPROBE_DEFER;
> > > +				goto error_cleanup_msi_domain;
> > > +			}
> > 
> > What error could occur here that would be somehow fixed if you defer and try
> > this all again?  Shouldn't you just return the error given (as something really went
> > wrong here, it's not a "something else needs to start up first issue), and abort?
> > 
> 
> It's really a "something else needs to start up first" type of issue. The fsl_mc_uapi_create_device_file fails only if the misc_register fails and this could really happen when the misc char driver is not yet initialized.
> 
> Initially, I have used the register_chrdev API and you suggested to use a misc device and just defer probe if it's not yet initialized.

Ok, fair enough, looks good to me, thanks for answering.

greg k-h
