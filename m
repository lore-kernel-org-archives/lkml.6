Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD66C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1C9720850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbeLEPxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:53:32 -0500
Received: from smtprelay0106.hostedemail.com ([216.40.44.106]:34946 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726918AbeLEPxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 10:53:31 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 1523F182CF66F;
        Wed,  5 Dec 2018 15:53:30 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: pot08_1e5f679b27228
X-Filterd-Recvd-Size: 1710
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Wed,  5 Dec 2018 15:53:28 +0000 (UTC)
Message-ID: <ebc6bdba345238ddb0a83e269687007aa3c779b5.camel@perches.com>
Subject: Re: [PATCH AUTOSEL 4.19 100/123] drm/ast: fixed reading monitor
 EDID not stable issue
From:   Joe Perches <joe@perches.com>
To:     Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Y.C. Chen" <yc_chen@aspeedtech.com>,
        Dave Airlie <airlied@redhat.com>,
        dri-devel@lists.freedesktop.org
Date:   Wed, 05 Dec 2018 07:53:27 -0800
In-Reply-To: <20181205093555.5386-100-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
         <20181205093555.5386-100-sashal@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-12-05 at 04:35 -0500, Sasha Levin wrote:
> From: "Y.C. Chen" <yc_chen@aspeedtech.com>
[]
> diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_mode.c
[]
> @@ -973,9 +973,21 @@ static int get_clock(void *i2c_priv)
>  {
>  	struct ast_i2c_chan *i2c = i2c_priv;
>  	struct ast_private *ast = i2c->dev->dev_private;
> -	uint32_t val;
> +	uint32_t val, val2, count, pass;
> +
> +	count = 0;
> +	pass = 0;
> +	val = (ast_get_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xb7, 0x10) >> 4) & 0x01;
> +	do {
> +		val2 = (ast_get_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xb7, 0x10) >> 4) & 0x01;

These could have been simpler as bool using BIT

	val = ast_get_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xb7, 0x10) & BIT(4);
	
etc...

