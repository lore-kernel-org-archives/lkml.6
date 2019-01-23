Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FDCC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 21:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF8621855
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 21:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iXxCKDe2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfAWVDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 16:03:47 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38720 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfAWVDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 16:03:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=T0Phr2EhPKcmmIwP685clBcqTdjUfPICWGYlUm5b76s=; b=iXxCKDe2r01Sa2n6JZhep4FgM
        rGvhlZkMSNx5p3IR/6lj+776xQKxX+jSAnK0Jy7fQbwjKtpShkBbbhludvB7mdmBy91z4NyTXTK17
        QmzYhw18DUZifqx1abyfJEsHjCDL1WNInX8SZyxJHf3YSenxspgDIS1lAV4OEAB6fPZ0G+rB5zkWY
        M5yZGEXVjKCKmIlhlgVifd0D74Qct17iP3barrYVTKofBvULzvYXKSOHX36UFp/JCLfbkWp5L/pyd
        JwXNmg5YuCZFCRvgNLyLA1mt3opgmrq1sRfmVNgkaE5hpVUOV0sjeVy+kE4wz4d6i5Am4nN8Yb3NJ
        qINGVEFKg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gmPgN-0006Xq-BA; Wed, 23 Jan 2019 21:03:35 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B22C920F51B1C; Wed, 23 Jan 2019 22:03:33 +0100 (CET)
Date:   Wed, 23 Jan 2019 22:03:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     acme@kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com,
        tglx@linutronix.de, alexander.shishkin@linux.intel.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        will.deacon@arm.com, mark.rutland@arm.com, jolsa@redhat.com,
        namhyung@kernel.org, adrian.hunter@intel.com, ast@kernel.org,
        hpa@zytor.com, suzuki.poulose@arm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/7] coresight: Use event attributes for sink selection
Message-ID: <20190123210333.GZ27931@hirez.programming.kicks-ass.net>
References: <20190115230742.13730-1-mathieu.poirier@linaro.org>
 <20190115230742.13730-4-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115230742.13730-4-mathieu.poirier@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 04:07:38PM -0700, Mathieu Poirier wrote:
> +	/* First get the selected sink from user space. */
> +	sink = coresight_get_sink_by_id(event->attr.config2);

(I know there's a new version out, I'll go look there shortly)

should this patch not also have something like:

PMU_FORMAT_ATTR(sinkid, "config2:0-63");

> +	if (!sink)
> +		sink = coresight_get_enabled_sink(true);
>  	if (!sink || !sink_ops(sink)->alloc_buffer)
>  		goto err;
