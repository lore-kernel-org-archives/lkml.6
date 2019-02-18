Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3610FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 23:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08BC421848
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 23:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731232AbfBRXdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 18:33:14 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:56132 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729104AbfBRXdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 18:33:14 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 69E9212E4E2D5;
        Mon, 18 Feb 2019 15:33:13 -0800 (PST)
Date:   Mon, 18 Feb 2019 15:33:10 -0800 (PST)
Message-Id: <20190218.153310.393264778478086662.davem@davemloft.net>
To:     vlomovtsev@marvell.com
Cc:     sgoutham@cavium.com, rric@kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, dnelson@redhat.com
Subject: Re: [PATCH v2 3/8] net: thunderx: make CFG_DONE message to run
 through generic send-ack sequence
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190218095159.3847-4-vlomovtsev@marvell.com>
References: <20190218095159.3847-1-vlomovtsev@marvell.com>
        <20190218095159.3847-4-vlomovtsev@marvell.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 18 Feb 2019 15:33:13 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vadim Lomovtsev <vlomovtsev@marvell.com>
Date: Mon, 18 Feb 2019 09:52:14 +0000

> @@ -169,6 +169,20 @@ static int nicvf_check_pf_ready(struct nicvf *nic)
>  	return 1;
>  }
>  
> +static int nicvf_send_cfg_done(struct nicvf *nic)
> +{
> +	union nic_mbx mbx = {};
> +
> +	mbx.msg.msg = NIC_MBOX_MSG_CFG_DONE;
> +	if (nicvf_send_msg_to_pf(nic, &mbx)) {
> +		netdev_err(nic->netdev,
> +			   "PF didn't respond to CFG DONE msg\n");
> +		return 0;
> +	}
> +
> +	return 1;
> +}
 ...
> @@ -1515,8 +1528,7 @@ int nicvf_open(struct net_device *netdev)
>  		nicvf_enable_intr(nic, NICVF_INTR_RBDR, qidx);
>  
>  	/* Send VF config done msg to PF */
> -	mbx.msg.msg = NIC_MBOX_MSG_CFG_DONE;
> -	nicvf_write_to_mbx(nic, &mbx);
> +	nicvf_send_cfg_done(nic);

If the one and only call site doesn't even bother to check the return
value, just make it return void.

Thanks.
