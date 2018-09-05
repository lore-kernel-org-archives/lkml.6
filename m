Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79315C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 10:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA46A2075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 10:07:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA46A2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=systec-electronic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbeIEOg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 10:36:28 -0400
Received: from webbox1416.server-home.net ([77.236.96.61]:57542 "EHLO
        webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726249AbeIEOg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 10:36:28 -0400
Received: from imapserver.systec-electronic.com (unknown [212.185.67.146])
        by webbox1416.server-home.net (Postfix) with ESMTPA id ABF1F27A61F;
        Wed,  5 Sep 2018 12:06:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by imapserver.systec-electronic.com (Postfix) with ESMTP id 88AB81A1B50;
        Wed,  5 Sep 2018 12:06:57 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at imapserver.systec-electronic.com
Received: from imapserver.systec-electronic.com ([127.0.0.1])
        by localhost (imapserver.systec-electronic.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mHa9MnFhaHze; Wed,  5 Sep 2018 12:06:55 +0200 (CEST)
Received: from ws-140106.localnet (ws-140106.systec.local [192.168.10.92])
        by imapserver.systec-electronic.com (Postfix) with ESMTPA id B0B741A1B4F;
        Wed,  5 Sep 2018 12:06:55 +0200 (CEST)
From:   Alexander Stein <alexander.stein@systec-electronic.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Gromm <christian.gromm@microchip.com>,
        Abdun Nihaal <abdun.nihaal@gmail.com>,
        devel@driverdev.osuosl.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: most: video: fix registration of an empty comp core_component
Date:   Wed, 05 Sep 2018 12:06:55 +0200
Message-ID: <1588498.TolbaFeo5X@ws-140106>
In-Reply-To: <20180905094605.14827-1-colin.king@canonical.com>
References: <20180905094605.14827-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, September 5, 2018, 11:46:05 AM CEST Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently we have structrues comp (which is empty) and comp_info being
> used to register and deregister the component.  This mismatch in naming
> occurred from a previous commit that renamed aim_info to comp. Fix this
> to use consistent component naming in line with most/net, most/sound etc.
> 
> This fixes the message two issues, one with a null empty name when
> loading the module:
> 
> [ 1485.269515] most_core: registered new core component (null)
> 
> and an Oops when removing the module:
> 
> [ 1485.277971] BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
> [ 1485.278648] PGD 0 P4D 0
> [ 1485.279253] Oops: 0002 [#2] SMP PTI
> [ 1485.279847] CPU: 1 PID: 32629 Comm: modprobe Tainted: P      D WC OE     4.18.0-8-generic #9
> [ 1485.280442] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
> [ 1485.281040] RIP: 0010:most_deregister_component+0x3c/0x70 [most_core]
> .. etc
> 
> Fixes: 1b10a0316e2d ("staging: most: video: remove aim designators")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/staging/most/video/video.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/most/video/video.c b/drivers/staging/most/video/video.c
> index cf342eb58e10..ad7e28ab9a4f 100644
> --- a/drivers/staging/most/video/video.c
> +++ b/drivers/staging/most/video/video.c
> @@ -530,7 +530,7 @@ static int comp_disconnect_channel(struct most_interface *iface,
>  	return 0;
>  }
>  
> -static struct core_component comp_info = {
> +static struct core_component comp = {
>  	.name = "video",
>  	.probe_channel = comp_probe_channel,
>  	.disconnect_channel = comp_disconnect_channel,

Doesn't it make more sense to move that variable defintion where currently the forward declaration is?
This way you can't have 2 variables accidentally. You will need forward declarations for those two functions, but a mismatch here results in a linker error rather than a runtime NULL pointer access

Best regards,
Alexander



