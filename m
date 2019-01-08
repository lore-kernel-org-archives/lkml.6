Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0B8C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 01:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5228420663
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 01:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbfAHBQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 20:16:09 -0500
Received: from ale.deltatee.com ([207.54.116.67]:44620 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbfAHBQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 20:16:09 -0500
Received: from s0106602ad0811846.cg.shawcable.net ([68.147.191.165] helo=[192.168.0.18])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1ggfzy-00049v-ON; Mon, 07 Jan 2019 18:16:08 -0700
To:     Joey Zhang <joey.zhang@microchip.com>, jdmason@kudzu.us,
        dave.jiang@intel.com, allenbh@gmail.com,
        linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
References: <1546830776-3138-1-git-send-email-joey.zhang@microchip.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <2dccf9e6-d9d7-200e-f689-56c962ea5e7e@deltatee.com>
Date:   Mon, 7 Jan 2019 18:16:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1546830776-3138-1-git-send-email-joey.zhang@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 68.147.191.165
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, allenbh@gmail.com, dave.jiang@intel.com, jdmason@kudzu.us, joey.zhang@microchip.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH] NTB: ntb_transport: Free MWs in
 ntb_transport_link_cleanup()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/01/19 08:12 PM, Joey Zhang wrote:
> If NTB peer host crashes or reboots, the NTB transport link will be
> down and the MWs of NTB transport will be invalid. But the
> ntb_transport_link_cleanup() does not free these invalid MWs. When
> the NTB peer host is recovered later, NTB transport link will be
> up and the ntb_set_mw() will not reset up MWs. Because the MWs of
> NTB transport are invalid, the NTB transport will not work.
> 
> We can fix it by freeing MWs when NTB transport link is down, then
> the ntb_set_mw() will reset up MWs when NTB transport link is up.
> 
> Signed-off-by: Joey Zhang <joey.zhang@microchip.com>

Looks ok to me.

Reviewed By: Logan Gunthorpe <logang@deltatee.com>

> ---
>  drivers/ntb/ntb_transport.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 3bfdb45..6e8902d 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -862,6 +862,9 @@ static void ntb_transport_link_cleanup(struct ntb_transport_ctx *nt)
>  	if (!nt->link_is_up)
>  		cancel_delayed_work_sync(&nt->link_work);
>  
> +	for (i = 0; i < nt->mw_count; i++)
> +		ntb_free_mw(nt, i);
> +
>  	/* The scratchpad registers keep the values if the remote side
>  	 * goes down, blast them now to give them a sane value the next
>  	 * time they are accessed
> 
