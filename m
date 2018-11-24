Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DB1C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 06:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 958BB20868
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 06:29:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 958BB20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732012AbeKXRQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 12:16:31 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:42758 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731053AbeKXRQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 12:16:31 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0521A14E03FFF;
        Fri, 23 Nov 2018 22:29:15 -0800 (PST)
Date:   Fri, 23 Nov 2018 22:29:15 -0800 (PST)
Message-Id: <20181123.222915.1197343130823511085.davem@davemloft.net>
To:     claudiu.manoil@nxp.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        alexandru.marginean@nxp.com, catalin.horghidan@nxp.com
Subject: Re: [PATCH net-next v3 1/4] enetc: Introduce basic PF and VF ENETC
 ethernet drivers
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1542969963-10676-2-git-send-email-claudiu.manoil@nxp.com>
References: <1542969963-10676-1-git-send-email-claudiu.manoil@nxp.com>
        <1542969963-10676-2-git-send-email-claudiu.manoil@nxp.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 23 Nov 2018 22:29:16 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Manoil <claudiu.manoil@nxp.com>
Date: Fri, 23 Nov 2018 12:46:00 +0200

> +static int enetc_poll(struct napi_struct *napi, int budget)
> +{
> +	struct enetc_int_vector
> +		*v = container_of(napi, struct enetc_int_vector, napi);
> +	bool complete = true;
> +	int work_done;
> +	int i;
> +
> +	for (i = 0; i < v->count_tx_rings; i++) {
> +		work_done = enetc_clean_tx_ring(&v->tx_ring[i], budget);
> +		if (work_done == budget)
> +			complete = false;
> +	}

You should not count TX completion processing as NAPI poll "work".
It is relatively "free" compared to RX packet processing.
