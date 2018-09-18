Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFF8ECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 02:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93D5D2088F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 02:35:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93D5D2088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbeIRIFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 04:05:49 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:54400 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbeIRIFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 04:05:48 -0400
Received: from localhost (unknown [104.240.4.228])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E1E5A146228E0;
        Mon, 17 Sep 2018 19:35:31 -0700 (PDT)
Date:   Mon, 17 Sep 2018 19:35:31 -0700 (PDT)
Message-Id: <20180917.193531.1424852853827678152.davem@davemloft.net>
To:     ahs3@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        isubramanian@apm.com, kchudgar@apm.com, qnguyen@apm.com
Subject: Re: [PATCH] net: apm: xgene: force XGene enet driver to re-balance
 IRQ usage
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180917233533.28626-1-ahs3@redhat.com>
References: <20180917233533.28626-1-ahs3@redhat.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 17 Sep 2018 19:35:32 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Stone <ahs3@redhat.com>
Date: Mon, 17 Sep 2018 17:35:33 -0600

> @@ -866,8 +866,11 @@ static int xgene_enet_napi(struct napi_struct *napi, const int budget)
>  	processed = xgene_enet_process_ring(ring, budget);
>  
>  	if (processed != budget) {
> +		struct irq_desc *desc = irq_to_desc(ring->irq);
> +
>  		napi_complete_done(napi, processed);
> -		enable_irq(ring->irq);
> +		if (desc && desc->depth > 0)
> +			enable_irq(ring->irq);

I really can't accept a patch that grovels into IRQ layer internals
to work around a driver's IRQ enable/disable usage problem.

Sorry.
