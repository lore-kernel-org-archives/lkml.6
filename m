Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BA2FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 635A2205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ERsNxviW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 635A2205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbeG3RfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 13:35:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42776 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbeG3RfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 13:35:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=JhUGT8sN1qnvQgwPcAGp95UI9VXlMTxKP19lrE71egg=; b=ERsNxviW6dodssOHkG98471HCn
        g2inBLUt0s27o+JlXhTEftTY1k/G85PyUglbq4T3m6zb/Y4/LonVS3IcqvLV6o7f0PisL5ft4hNs0
        ADg4mmAMHUzY7yEKjM9tI/70mV0vM0ndvudZIrediVniAeAVSj0d/PfCfJwtlRSYNTcrbXiyg8BfY
        XOpEE8ysM9XC47UDEcJ8sDimyWVIoYBoslRSiAXjdHys2hNMskjE3gKWkszFOWfnAMbGu5EnhRIRC
        MxpxNA1C7ZwS3i2oh8rbUlYHCBW2s4CXtfoj6l3WQOVl2oQkCyFZHzMFxo6MYP9mrWI30pChB7UgY
        hzwXYRzQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fkAa7-0003y6-AA; Mon, 30 Jul 2018 15:59:35 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 15B742026873D; Mon, 30 Jul 2018 17:59:33 +0200 (CEST)
Date:   Mon, 30 Jul 2018 17:59:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "weiqi (C)" <weiqi4@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        Zhanghailiang <zhang.zhanghailiang@huawei.com>
Subject: Re: [Question] load balance move tasks not suitable ?
Message-ID: <20180730155933.GK2494@hirez.programming.kicks-ass.net>
References: <6e782fa5-de1d-93a9-ed11-5b43b65b20c9@huawei.com>
 <20180730125606.GP2476@hirez.programming.kicks-ass.net>
 <8513a5c1-2067-cdf6-285f-3fb422274c05@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8513a5c1-2067-cdf6-285f-3fb422274c05@huawei.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

On Mon, Jul 30, 2018 at 09:42:27PM +0800, weiqi (C) wrote:
> in latest  linux kernel version,  load-balance's  detach_tasks() keeps
> "load/2"  behavior:
> 
> """
> 
>         if (( load / 2 ) > env->imbalance)
>                 goto next;
> """
> 
> It  means  a task  "p",  which  load  is 1.5 times than "env->imbalance" can
> move from "src_rq" to "dst_rq".
> after this move,  imbalance between  "src_rq"  and "dst_rq" may larger than
> before.

imbalance is how much we should move to get in balance. So if we move 1
imbalance we'll end up being just right. If we move 1.5 we end up
slightly better then before, but imbalanced the other way.

If we move 2 imbalance, we're exactly where we were, just the other way
around.

> but if use "load*2" here,  It means we can pick a task "p" , which load is
> half of "env->imbalance"， and after move，
> "src_rq" and "dst_rq"  is balanced.

We might not move anything and not improve even if we could.
