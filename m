Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79EE0C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 22:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B1C12174D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 22:57:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B1C12174D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732352AbeHNBmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 21:42:00 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:33262 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730203AbeHNBl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 21:41:59 -0400
Received: from localhost (c-71-59-158-49.hsd1.or.comcast.net [71.59.158.49])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5A62F145D1804;
        Mon, 13 Aug 2018 15:57:40 -0700 (PDT)
Date:   Mon, 13 Aug 2018 15:57:39 -0700 (PDT)
Message-Id: <20180813.155739.520994642189876587.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     akpm@linux-foundation.org, peterz@infradead.org,
        caraitto@google.com, willemb@google.com, adobriyan@gmail.com,
        mingo@kernel.org, rakib.mullick@gmail.com,
        amritha.nambiar@intel.com, mhkelley@outlook.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpumask: provide a dummy cpumask_next_wrap
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180813215546.3828228-1-arnd@arndb.de>
References: <20180813215546.3828228-1-arnd@arndb.de>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 13 Aug 2018 15:57:40 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 13 Aug 2018 23:55:16 +0200

> The virtio_net driver has become the first one to call cpumask_next_wrap()
> even if CONFIG_SMP is disabled, leading to a build error:
> 
> drivers/net/virtio_net.c: In function 'virtnet_set_affinity':
> drivers/net/virtio_net.c:1916:10: error: implicit declaration of function 'cpumask_next_wrap'; did you mean 'cpumask_next_and'? [-Werror=implicit-function-declaration]
>     cpu = cpumask_next_wrap(cpu, cpu_online_mask,
> 
> Add a stub function along the lines of cpumask_first(), cpumask_next() etc.
> I'm not entirely sure what should be returned in this case, but at
> least for virtio_net, anything should work.
> 
> Fixes: 2ca653d607ce ("virtio_net: Stripe queue affinities across cores.")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

This should already be fixed in my tree, and:

> +static inline int cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool wrap)
> +{
> +	return n;
> +}

this doesn't handle the "n==0 && wrap" case properly, in that situation you should
return '1'.
