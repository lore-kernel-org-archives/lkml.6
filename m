Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A54C46465
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 06:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A93E20857
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 06:33:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A93E20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbeKHQHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 11:07:08 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:52136 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbeKHQHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 11:07:07 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 83544145E7441;
        Wed,  7 Nov 2018 22:33:11 -0800 (PST)
Date:   Wed, 07 Nov 2018 22:33:11 -0800 (PST)
Message-Id: <20181107.223311.1952221214450219759.davem@davemloft.net>
To:     madalin.bucur@nxp.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dpaa_eth: add ethtool coalesce control
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1541598823-22533-1-git-send-email-madalin.bucur@nxp.com>
References: <1541598823-22533-1-git-send-email-madalin.bucur@nxp.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 07 Nov 2018 22:33:11 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madalin Bucur <madalin.bucur@nxp.com>
Date: Wed,  7 Nov 2018 15:53:43 +0200

> +static int dpaa_set_coalesce(struct net_device *dev,
> +			     struct ethtool_coalesce *c)
> +{
> +	const cpumask_t *cpus = qman_affine_cpus();
> +	struct qman_portal *portal;
> +	u32 period;
> +	u8 thresh;
> +	int cpu;
> +
> +	period = c->rx_coalesce_usecs;
> +	thresh = c->rx_max_coalesced_frames;
> +
> +	for_each_cpu(cpu, cpus) {
> +		portal = qman_get_affine_portal(cpu);
> +		qman_portal_set_iperiod(portal, period);
> +		qman_dqrr_set_ithresh(portal, thresh);
> +	}

You really have to check to see if the user is trying to configure
a setting you don't support, for example if the user tries
to set ->use_adative_rx_coalesce or uses a period or threshold
value which is out of range.

Thanks.
