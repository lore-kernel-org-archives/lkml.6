Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C56BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5598F2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551193142;
	bh=A8h6U7ywBzm7fNoogE3FYjHjwbzDpmzGsrROUi4MH68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LwO918M9RwkKPX57A5Ln/L9ZswHBv9UGjZT1ltj9IM4fmSFlnoL9bB7JAh9A4+V2Q
	 wsFb6JBMciYKuRhipPHq0h0oxMv8oszMxeDNdX7yZUmO5je+fs1lZ45X6a/tVohPuf
	 06se2zwIaPpEctksWl7nED7oQ2BFGhIDOdWGbOXg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbfBZO7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 09:59:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:40142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbfBZO7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 09:59:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07B122083D;
        Tue, 26 Feb 2019 14:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551193139;
        bh=A8h6U7ywBzm7fNoogE3FYjHjwbzDpmzGsrROUi4MH68=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CCqucUrP6tCXNTP2Ecy7y6Qd7fDEQbT+Qw4kI+sa2sJJRGsbcZCJKUK8lt9bqvTvo
         np619K72Bn2IuzO2ZkFVfDhEtlwaqM/iogbdJwW9pqEMUUrBHcGCvTNe25JMIeywoS
         iQHqjRWYeY2738HT3NhJO8sY4Pm9UUMQr45fbZXQ=
Date:   Tue, 26 Feb 2019 15:58:57 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>,
        Peter Chen <peter.chen@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] usb: chipidea: tegra: Fix missed
 ci_hdrc_remove_device()
Message-ID: <20190226145857.GB26080@kroah.com>
References: <20190224153622.8877-1-digetx@gmail.com>
 <VI1PR04MB5327FE97DC8C68B4D56DE0A98B7A0@VI1PR04MB5327.eurprd04.prod.outlook.com>
 <20190225080715.4965810a@dimatab>
 <20190226105615.GA12397@kroah.com>
 <e7693387-9ac5-b2d8-0a0f-d507dfe05830@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e7693387-9ac5-b2d8-0a0f-d507dfe05830@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 05:33:05PM +0300, Dmitry Osipenko wrote:
> 26.02.2019 13:56, Greg Kroah-Hartman пишет:
> > On Mon, Feb 25, 2019 at 08:07:15AM +0300, Dmitry Osipenko wrote:
> >> В Mon, 25 Feb 2019 02:27:19 +0000
> >> Peter Chen <peter.chen@nxp.com> пишет:
> >>
> >>>  
> >>>>
> >>>> Fixes: dfebb5f43a78827a ("usb: chipidea: Add support for
> >>>> Tegra20/30/114/124")  
> >>>
> >>> I suppose you need to apply at stable tree too, right?
> >>>
> >>
> >> It is enough to have the "Fixes" tag to get patch backported into all
> >> relevant kernel versions.
> > 
> > No it is not.  My scripts do NOT trigger off of the fixes: tag, please
> > read:
> >     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> > for how to do this properly.
> 
> Okay, my bad then. Maybe this is something that could warned by checkpatch.. adding Joe and Andy to the thread.

Why?  It's allowed to put fixes: tags for a patch that does not belong
in a stable tree.  That happens all the time, and is encouraged.  Look
at some of the stuff in linux-next now, we have Fixes: for commits that
are still in linux-next as well, because we do not rebase our trees.
When they all merge into Linus's tree, all is good.

So this is not something that checkpatch needs to do anything about.

thanks,

greg k-h
