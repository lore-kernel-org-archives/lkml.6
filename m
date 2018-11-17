Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54571C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 03:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19B9721104
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 03:42:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19B9721104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730462AbeKQN5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 08:57:31 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:48124 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729714AbeKQN5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 08:57:31 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id EB18813F5C631;
        Fri, 16 Nov 2018 19:42:19 -0800 (PST)
Date:   Fri, 16 Nov 2018 19:42:19 -0800 (PST)
Message-Id: <20181116.194219.2027125174407236599.davem@davemloft.net>
To:     madalin.bucur@nxp.com
Cc:     netdev@vger.kernel.org, leoyang.li@nxp.com, roy.pledge@nxp.com,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dpaa_eth: add ethtool coalesce control
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1542126591-5114-3-git-send-email-madalin.bucur@nxp.com>
References: <1542126591-5114-1-git-send-email-madalin.bucur@nxp.com>
        <1542126591-5114-3-git-send-email-madalin.bucur@nxp.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 16 Nov 2018 19:42:20 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madalin Bucur <madalin.bucur@nxp.com>
Date: Tue, 13 Nov 2018 18:29:51 +0200

> +	for_each_cpu(cpu, cpus) {
> +		portal = qman_get_affine_portal(cpu);
> +		res = qman_portal_set_iperiod(portal, period);
> +		if (res)
> +			return res;
> +		res = qman_dqrr_set_ithresh(portal, thresh);
> +		if (res)
> +			return res;

Nope, you can't do it like this.

If any intermediate change fails, you have to unwind all of the
changes made up until that point.

Which means you'll have to store the previous setting somewhere
and reinstall those saved values in the error path.
