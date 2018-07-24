Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E92C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA5E20844
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:14:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EA5E20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388533AbeGXSVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 14:21:34 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:35054 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388422AbeGXSVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 14:21:34 -0400
Received: from localhost (c-24-20-22-31.hsd1.or.comcast.net [24.20.22.31])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5D00C108B62A7;
        Tue, 24 Jul 2018 10:14:06 -0700 (PDT)
Date:   Tue, 24 Jul 2018 10:14:05 -0700 (PDT)
Message-Id: <20180724.101405.797730329231867648.davem@davemloft.net>
To:     dsahern@gmail.com
Cc:     xiyou.wangcong@gmail.com, netdev@vger.kernel.org,
        nikita.leshchenko@oracle.com, roopa@cumulusnetworks.com,
        stephen@networkplumber.org, idosch@mellanox.com, jiri@mellanox.com,
        saeedm@mellanox.com, alex.aring@gmail.com,
        linux-wpan@vger.kernel.org, netfilter-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC/RFT net-next 00/17] net: Convert neighbor tables to
 per-namespace
From:   David Miller <davem@davemloft.net>
In-Reply-To: <5021d874-8e99-6eba-f24b-4257c62d4457@gmail.com>
References: <28c30574-391c-b4bd-c337-51d3040d901a@gmail.com>
        <CAM_iQpW4-JkZY7jXx0Q1b907hQ85UOL1eXv2YHwSukb5L=apUg@mail.gmail.com>
        <5021d874-8e99-6eba-f24b-4257c62d4457@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 24 Jul 2018 10:14:06 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Ahern <dsahern@gmail.com>
Date: Tue, 24 Jul 2018 09:14:01 -0600

> I get the impression there is no longer a strong resistance against
> moving the tables to per namespace, but deciding what is the right
> approach to handle backwards compatibility. Correct? Changing the
> accounting is inevitably going to be noticeable to some use case(s), but
> with sysctl settings it is a simple runtime update once the user knows
> to make the change.
> 
> neighbor entries round up to 512 byte allocations, so with the current
> gc_thresh defaults (128/512/1024) 512k can be consumed. Using those
> limits per namespace seems high which is why I suggested a per-namespace
> default of (16/32/64) which amounts to 32k per namespace limit by
> default. Open to other suggestions as well.

No objection from me about going to per-ns neigh tables.

About the defaults, I wonder if we can scale them to the amount of
memory given to the ns or something like that?  I bet this will better
match the intended use of the ns.
