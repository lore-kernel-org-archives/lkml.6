Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C7DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 17:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01BC920855
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 17:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545930136;
	bh=fYhvfwF/ysp5W3sbZQRvW7WbB+N1JHMzKERvlUWIGas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=w8lBJEvevZxIP59oUuGxwTKcUwMJFm9BPEsO3sRxveQLP5SezjkXAcEzwVJLM9/F7
	 bgbr7SAoY5EAIro5rRUr1G6f8DVZGdQtCXPtThul/w6O34tSHTBzK2NNZqHCT+uGCG
	 R3U7bfTpglZZomzFMSPAuv9DszVAkvl0ZisMp7AQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731220AbeL0RCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 12:02:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:53592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729264AbeL0RCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 12:02:14 -0500
Received: from guoren-Inspiron-7460 (23.83.240.247.16clouds.com [23.83.240.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5133E20861;
        Thu, 27 Dec 2018 17:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545930133;
        bh=fYhvfwF/ysp5W3sbZQRvW7WbB+N1JHMzKERvlUWIGas=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eRrl47oJ1nekCrZkdGs1sRY55tPqN7/DWVTkUHgDapTl+fALe+4K5oFhJYociaqln
         jdfEafGGJKR/fwcdNAhdfNVlMG07qQT8Vm8fbAQdH+CGyCkmi1A/b1fjH07NGD4dN1
         6oXVCJZHedmlbAe/DX8vn6OfjHHtpvIIUkarHyoA=
Date:   Fri, 28 Dec 2018 01:02:08 +0800
From:   Guo Ren <guoren@kernel.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] csky: fix refcount leak in setup_smp()
Message-ID: <20181227170208.GA26897@guoren-Inspiron-7460>
References: <20181227162711.7346-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181227162711.7346-1-tiny.windzz@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Li,

On Thu, Dec 27, 2018 at 11:27:11AM -0500, Yangtao Li wrote:
> The of_find_node_by_type() returns a node pointer with refcount
> incremented, but there is the lack of use of the of_node_put() when
> done. Add the missing of_node_put() to release the refcount.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  arch/csky/kernel/smp.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/csky/kernel/smp.c b/arch/csky/kernel/smp.c
> index 36ebaf9834e1..adec56df613b 100644
> --- a/arch/csky/kernel/smp.c
> +++ b/arch/csky/kernel/smp.c
> @@ -139,11 +139,17 @@ void __init setup_smp(void)
>  	int cpu;
>  
>  	while ((node = of_find_node_by_type(node, "cpu"))) {
> -		if (!of_device_is_available(node))
> +		if (!of_device_is_available(node)) {
> +			of_node_put(node);
>  			continue;
> +		}
>  
> -		if (of_property_read_u32(node, "reg", &cpu))
> +		if (of_property_read_u32(node, "reg", &cpu)) {
> +			of_node_put(node);
>  			continue;
> +		}
> +
> +		of_node_put(node);
If success, of_node_put ?
>  
>  		if (cpu >= NR_CPUS)
Here need a of_node_put()?
>  			continue;

Can you use for_each_of_cpu_node() for the patch?

Thx
 Guo Ren
