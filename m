Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36957C6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 12:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ECBF2075D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 12:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="LI9zLaem"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ECBF2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=natalenko.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbeJ1VGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 17:06:42 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:23338 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbeJ1VGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 17:06:42 -0400
Received: from mail.natalenko.name (vulcan.natalenko.name [IPv6:fe80::5400:ff:fe0c:dfa0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id E5FEB44BCA4;
        Sun, 28 Oct 2018 13:22:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1540729330;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TU4HOJ/X4YyTaVXpX1f+JUeterXkauFAf6iTjuxvO6o=;
        b=LI9zLaem15BBxTM2zJiH0BRMyRqzFyoYunChbaI3fHVQOc13+1SR2iP3GxWQOfc1TdCzSv
        91V7/83Bruel0xUJGE4RjYC4HfP0mRdyvIUoOMUbu/Ts05xMVojK5r33G6qFYGIY9d844K
        BL9kT1HfKwnPqoH2zl58FmCl0ZBpoGY=
DMARC-Filter: OpenDMARC Filter v1.3.2 vulcan.natalenko.name E5FEB44BCA4
Authentication-Results: vulcan.natalenko.name; dmarc=fail (p=none dis=none) header.from=natalenko.name
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 28 Oct 2018 13:22:09 +0100
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     David Miller <davem@davemloft.net>
Cc:     dave.taht@gmail.com, hkallweit1@gmail.com, toke@toke.dk,
        jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CAKE and r8169 cause panic on upload in v4.19
In-Reply-To: <20181027.214426.537959459795607171.davem@davemloft.net>
References: <fbd7f0b8-10c8-be17-fce6-327a95d8ea2e@gmail.com>
 <CAA93jw7xoaokrN4oGAyqh6JHAn8nJpUpp_wj-iy+GWNoV-ipNA@mail.gmail.com>
 <b80e6819da8ea74f18b6ec0aaf9128fa@natalenko.name>
 <20181027.214426.537959459795607171.davem@davemloft.net>
Message-ID: <3d749bf1ec48ee9f4172b23bde84ec4b@natalenko.name>
X-Sender: oleksandr@natalenko.name
User-Agent: Roundcube Webmail/1.3.7
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=arc-20170712; t=1540729330;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TU4HOJ/X4YyTaVXpX1f+JUeterXkauFAf6iTjuxvO6o=;
        b=Q37+ycCon28QUGM4KGOfHruBZTE2AfMoK6EmArs3vo+66+gVquaFi2jH8ZeUfMqA5tLeqB
        eYYoisKug0u0atKlq8e5qmK+T5U7iwag7HuCODDEqnwhg5vgoTOEdDkSen7AKZgX4Jod6q
        mR5KqczRUG3WH2j/hhVVKCNmMYdgnyU=
ARC-Seal: i=1; s=arc-20170712; d=natalenko.name; t=1540729330; a=rsa-sha256;
        cv=none;
        b=iMxVdWOGuipjV+IrPpWDZEd3XwerUibdcZUPdLp6lpSPxzWTgkt0D1V1a2af46v4flN7IefIYk8RXU8TRWhO0lYhqnB3nph9aB6lZIskRIIkxJBJEJKNRsQ/I0CqLtTUlQ9AHiaOwstD+z0ldqs/caguinpj+1e/MLs00/HPu+A=
ARC-Authentication-Results: i=1;
        vulcan.natalenko.name;
        auth=pass smtp.auth=oleksandr@natalenko.name smtp.mailfrom=oleksandr@natalenko.name
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On 28.10.2018 05:44, David Miller wrote:
> Does this fix it?
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 022ad73d6253..77d43ae2a7bb 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -5457,7 +5457,7 @@ static void gro_flush_oldest(struct list_head 
> *head)
>  	/* Do not adjust napi->gro_hash[].count, caller is adding a new
>  	 * SKB to the chain.
>  	 */
> -	list_del(&oldest->list);
> +	skb_list_del_init(oldest);
>  	napi_gro_complete(oldest);
>  }

Yes, but I had to apply both a8305bff6852 and 992cba7e276d too to get it 
compiled. With these 3 patches the panic is not triggered any more while 
having GRO enabled.

Thanks!

-- 
   Oleksandr Natalenko (post-factum)
