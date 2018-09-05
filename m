Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E371CC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 10:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98BEC20652
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 10:36:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98BEC20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbeIEPGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 11:06:34 -0400
Received: from smtp.eu.citrix.com ([185.25.65.24]:9054 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbeIEPGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 11:06:34 -0400
X-IronPort-AV: E=Sophos;i="5.53,333,1531785600"; 
   d="scan'208";a="78572978"
Date:   Wed, 5 Sep 2018 12:36:49 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Valentin Vidic <Valentin.Vidic@CARNet.hr>
CC:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, <xen-devel@lists.xenproject.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH] xen-blkback: Switch to closed state after releasing the
 backing device
Message-ID: <20180905103649.edugijsjx4v2fbxd@mac.bytemobile.com>
References: <20180829065214.23546-1-Valentin.Vidic@CARNet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180829065214.23546-1-Valentin.Vidic@CARNet.hr>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 08:52:14AM +0200, Valentin Vidic wrote:
> Switching to closed state earlier can cause the block-drbd
> script to fail with 'Device is held open by someone':
> 
> root: /etc/xen/scripts/block-drbd: remove XENBUS_PATH=backend/vbd/6/51712
> kernel: [ 2222.278235] block drbd6: State change failed: Device is held open by someone
> kernel: [ 2222.278304] block drbd6:   state = { cs:Connected ro:Primary/Secondary ds:UpToDate/UpToDate r----- }
> kernel: [ 2222.278340] block drbd6:  wanted = { cs:Connected ro:Secondary/Secondary ds:UpToDate/UpToDate r----- }
> root: /etc/xen/scripts/block-drbd: Writing backend/vbd/6/51712/hotplug-error /etc/xen/scripts/block-drbd failed; error detected. backend/vbd/6/51712/hotplug-status error to xenstore.
> root: /etc/xen/scripts/block-drbd: /etc/xen/scripts/block-drbd failed; error detected.
> 
> Signed-off-by: Valentin Vidic <Valentin.Vidic@CARNet.hr>
> Cc: stable@vger.kernel.org
> ---
>  drivers/block/xen-blkback/xenbus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
> index a4bc74e72c39..43bddc996709 100644
> --- a/drivers/block/xen-blkback/xenbus.c
> +++ b/drivers/block/xen-blkback/xenbus.c
> @@ -323,6 +323,7 @@ static void xen_blkif_free(struct xen_blkif *blkif)
>  {
>  	WARN_ON(xen_blkif_disconnect(blkif));
>  	xen_vbd_free(&blkif->vbd);
> +	xenbus_switch_state(blkif->be->dev, XenbusStateClosed);
>  	kfree(blkif->be->mode);
>  	kfree(blkif->be);
>  
> @@ -814,7 +815,6 @@ static void frontend_changed(struct xenbus_device *dev,
>  
>  	case XenbusStateClosed:
>  		xen_blkif_disconnect(be->blkif);
> -		xenbus_switch_state(dev, XenbusStateClosed);
>  		if (xenbus_dev_is_online(dev))
>  			break;

AFAICT, this will cause the backend to never switch to 'Closed' state
until the toolstack sets online to 0, which is not good IMO.

If for example a frontend decides to close a device, the backend will
stay in state 'Closing' until the toolstack actually removes the disk
by setting online to 0.

This will prevent resetting blk connections, as blkback will refuse to
switch to state XenbusStateInitWait unless it's at XenbusStateClosed
(see the XenbusStateInitialising case in frontend_changed), which will
never be reached with your patch.

Maybe the easiest solution would be to wait in the block-drbd script
until the device is released? Maybe using fstat in a loop or one of
the drbd tools?

Thanks, Roger.
