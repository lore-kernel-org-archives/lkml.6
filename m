Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E28DC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 03:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FAA220855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 03:11:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FAA220855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbeKIMtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 07:49:52 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:41958 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727238AbeKIMtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 07:49:52 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id AA4D614B3D579;
        Thu,  8 Nov 2018 19:11:16 -0800 (PST)
Date:   Thu, 08 Nov 2018 19:11:16 -0800 (PST)
Message-Id: <20181108.191116.1317160901826988583.davem@davemloft.net>
To:     robh@kernel.org
Cc:     frowand.list@gmail.com, linux-kernel@vger.kernel.org,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH 2/8] of: Drop full path from Sparc PDT full_name
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181107223151.14991-3-robh@kernel.org>
References: <20181107223151.14991-1-robh@kernel.org>
        <20181107223151.14991-3-robh@kernel.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 08 Nov 2018 19:11:16 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Herring <robh@kernel.org>
Date: Wed,  7 Nov 2018 16:31:45 -0600

> @@ -32,24 +32,7 @@ unsigned int of_pdt_unique_id __initdata;
>  
>  static char * __init of_pdt_build_full_name(struct device_node *dp)
>  {
> -	int len, ourlen, plen;
> -	char *n;
> -
> -	dp->path_component_name = build_path_component(dp);
> -
> -	plen = strlen(dp->parent->full_name);
> -	ourlen = strlen(dp->path_component_name);
> -	len = ourlen + plen + 2;
> -
> -	n = prom_early_alloc(len);
> -	strcpy(n, dp->parent->full_name);
> -	if (!of_node_is_root(dp->parent)) {
> -		strcpy(n + plen, "/");
> -		plen++;
> -	}
> -	strcpy(n + plen, dp->path_component_name);
> -
> -	return n;
> +	return build_path_component(dp);
>  }
>  
>  #else /* CONFIG_SPARC */

Hmmm, shouldn't this be doing what the non-SPARC version of
of_pdt_build_full_name() does which is to return the component string
appended to the parent's full_name?

You're just returning the component string here.
