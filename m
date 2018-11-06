Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1E2C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4880A2085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bJFHIdXp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4880A2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730420AbeKFVwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 16:52:24 -0500
Received: from merlin.infradead.org ([205.233.59.134]:58320 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729711AbeKFVwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 16:52:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=V2nrnT5M1J6IdbPsh+PhXK2YsxdNtDsBtEf3m/nbD1s=; b=bJFHIdXphfwF/Jq9jcC+yo2WC
        Zz62jrhcR6QhETAVzQ3L8ipTr3+4k/+SYXhDX9Zdc4/4l0MNaegpaBJwzTIYOFTvljuCP9PnMrtOO
        9pvr0Fs/P5hfHhgzjn5ExXYeDtdxwuZh/JhAupHXR2XZD8DXTdt8PBUyA5EJe3bFBCNrvs/oBBO2m
        vWPqEDxqmj3nPlccBrgInHz+74Nomn8+GZRAhLegpwyp2K73axD9Uv9CAXBnOw5U1MWlWFdoHyHm7
        XsTjlAmdHBDw313VkHQJnQtQQZjetoVDp96+NllaBJ24AR+B03eIORRjueFP6YzbF6QxnVNex8n56
        HDuaGin0g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gK0Ru-00067k-Kg; Tue, 06 Nov 2018 12:27:14 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4071F2029F9FF; Tue,  6 Nov 2018 13:27:13 +0100 (CET)
Date:   Tue, 6 Nov 2018 13:27:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Miao Xie <miaoxie@huawei.com>,
        Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v2] bit_spinlock: introduce smp_cond_load_relaxed
Message-ID: <20181106122713.GR22431@hirez.programming.kicks-ass.net>
References: <1539413249-4402-1-git-send-email-hsiangkao@aol.com>
 <20181030060441.16107-1-gaoxiang25@huawei.com>
 <20181105224654.GA25864@brain-police>
 <20181106090642.GH22431@hirez.programming.kicks-ass.net>
 <5eb42b84-5195-69f2-e7a7-97568f360506@huawei.com>
 <20181106110026.GJ22431@hirez.programming.kicks-ass.net>
 <dedbc211-082b-be4a-1bce-2593084d4ca3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dedbc211-082b-be4a-1bce-2593084d4ca3@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 07:36:41PM +0800, Gao Xiang wrote:
> IMO, to use wrapped up function for the detailed scenario could be better than
> open-coded all the time (eg. do cpu_relax(); while(...)) since it could be
> optimizated even more for the specific architecture...

That's the whole point though; if this actually matters, you're doing it
wrong.
