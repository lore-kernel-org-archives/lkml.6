Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B0CFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C63ED20853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:57:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C63ED20853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbeINPK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 11:10:57 -0400
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:33421 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbeINPK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 11:10:57 -0400
X-IronPort-AV: E=Sophos;i="5.53,372,1531785600"; 
   d="scan'208";a="79051706"
Date:   Fri, 14 Sep 2018 11:56:55 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Juergen Gross <jgross@suse.com>
CC:     Dongli Zhang <dongli.zhang@oracle.com>,
        <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>,
        <boris.ostrovsky@oracle.com>, <paul.durrant@citrix.com>,
        <wei.liu2@citrix.com>, <konrad.wilk@oracle.com>,
        <srinivas.eeda@oracle.com>
Subject: Re: [PATCH 6/6] drivers: enable xenwatch multithreading for
 xen-netback and xen-blkback driver
Message-ID: <20180914095655.2ni3xooopouegy6t@mac.bytemobile.com>
References: <1536910456-13337-1-git-send-email-dongli.zhang@oracle.com>
 <1536910456-13337-7-git-send-email-dongli.zhang@oracle.com>
 <518d3ec9-0d2d-7f77-e750-3e1329f7e97b@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <518d3ec9-0d2d-7f77-e750-3e1329f7e97b@suse.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 11:16:30AM +0200, Juergen Gross wrote:
> On 14/09/18 09:34, Dongli Zhang wrote:
> > This is the 6th patch of a (6-patch) patch set.
> > 
> > As the 'use_mtwatch' for xen-netback and xen-blkback are set to true,
> > probing any xenbus devices of those two drivers would create the per-domU
> > xenwatch thread for the domid the new devices belong to, or increment the
> > reference count  of existing thread.
> > 
> > Xenwatch multithreading might be enabled for more xen backend pv drivers in
> > the future.
> > 
> > Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> > ---
> >  drivers/block/xen-blkback/xenbus.c | 3 ++-
> >  drivers/net/xen-netback/xenbus.c   | 1 +
> >  2 files changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
> > index a4bc74e..debbbd0 100644
> > --- a/drivers/block/xen-blkback/xenbus.c
> > +++ b/drivers/block/xen-blkback/xenbus.c
> > @@ -1108,7 +1108,8 @@ static struct xenbus_driver xen_blkbk_driver = {
> >  	.ids  = xen_blkbk_ids,
> >  	.probe = xen_blkbk_probe,
> >  	.remove = xen_blkbk_remove,
> > -	.otherend_changed = frontend_changed
> > +	.otherend_changed = frontend_changed,
> > +	.use_mtwatch = true,
> >  };
> >  
> >  int xen_blkif_xenbus_init(void)
> > diff --git a/drivers/net/xen-netback/xenbus.c b/drivers/net/xen-netback/xenbus.c
> > index cd51492..63d46a7 100644
> > --- a/drivers/net/xen-netback/xenbus.c
> > +++ b/drivers/net/xen-netback/xenbus.c
> > @@ -1203,6 +1203,7 @@ static struct xenbus_driver netback_driver = {
> >  	.remove = netback_remove,
> >  	.uevent = netback_uevent,
> >  	.otherend_changed = frontend_changed,
> > +	.use_mtwatch = true,
> 
> Is there a special reason why kernel based backends shouldn't all use
> the multithread model? This would avoid the need for the use_mtwatch
> struct member.
> 
> This is meant as an honest question. I'm really not sure we should
> switch all backends at once. OTOH I can't see any real downsides.
> 
> Thoughts?

From a blkback PoV, I think it's safe to switch as long as there are
no concurrent watches firing in parallel for the same domain, which
from my reading of the series is indeed not possible.

Roger.
