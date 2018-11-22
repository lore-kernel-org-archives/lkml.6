Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC3FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 00:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47D442080F
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 00:54:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47D442080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391168AbeKVLbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 06:31:37 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:48870 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730678AbeKVLbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 06:31:37 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1096514E06F63;
        Wed, 21 Nov 2018 16:54:47 -0800 (PST)
Date:   Wed, 21 Nov 2018 16:52:44 -0800 (PST)
Message-Id: <20181121.165244.777667590099933299.davem@davemloft.net>
To:     vijaykhemka@fb.com
Cc:     sam@mendozajonas.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Justin.Lee1@Dell.com, joel@jms.id.au, linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH net-next] net/ncsi: Add NCSI Mellanox OEM command
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181120203516.3460764-1-vijaykhemka@fb.com>
References: <20181120203516.3460764-1-vijaykhemka@fb.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 21 Nov 2018 16:54:47 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vijay Khemka <vijaykhemka@fb.com>
Date: Tue, 20 Nov 2018 12:35:16 -0800

> +static int ncsi_oem_gma_handler_mlx(struct ncsi_cmd_arg *nca)
> +{
> +	unsigned char data[NCSI_OEM_MLX_CMD_GMA_LEN];
> +	int ret = 0;
> +
> +	nca->payload = NCSI_OEM_MLX_CMD_GMA_LEN;
> +
> +	memset(data, 0, NCSI_OEM_MLX_CMD_GMA_LEN);
> +	*(unsigned int *)data = ntohl(NCSI_OEM_MFR_MLX_ID);

'data' is not necessarily aligned on an unsigned int boundary.

But second of all you want to use a fixed size type like "u32" or
similar here, not "unsigned int".

Altogether, something like:

	union {
		u8 data_u8[NCSI_OEM_MLX_CMD_GMA_LEN];
		u32 data_u32[[NCSI_OEM_MLX_CMD_GMA_LEN / sizeof(u32)];
	} u;

	memset(&u, 0, sizeof(u));
	u.data_u32[0] = ntohl(NCSI_OEM_MFR_MLX_ID);
	u.data_u8[5] = NCSI_OEM_MLX_CMD_GMA;
	u.data_u8[6] = NCSI_OEM_MLX_CMD_GMA_PARAM;

If the rest of the ncsi driver has crud like this, it all needs
to be fixed up similarly.
