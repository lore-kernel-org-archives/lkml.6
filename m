Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324DCC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0B8F20862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L+/Q3Gqg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0B8F20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388058AbeKFWIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 17:08:18 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45994 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387905AbeKFWIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 17:08:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=J35X0MYi+boCXUX5xxpI/O4WWQjlRZ8NVgfT02OTDiU=; b=L+/Q3GqguYHqeqZDvZCbOed/d
        WB4T0+TslVXFiavtjJLUyYt8LUZCaL1/DO7Br/WJnYc9S3q+SpX5D/AbZIJhsXq2Y4DqY7UKu3kqx
        jDA5ePxUIv6ZhrftV+ydPYAX9vZk88BwLtwDvfmn6bElIDH6TY79S+M2NFjs+KZ2cVBU23JgmcAtO
        9EPaRdm0qsaA/wChMPhUb/8zBtIhvFKalUwT53Z99kpet5Z6DqklAe9Hoaolc7Ky4WZN3Qx0GBiPo
        PPvEAzVhS7RupF0jBcf0xtelAuR+AK16f9nHKFk8BvMMjyoVh68bwktbujWUcFcqcCXDlo2icPvr9
        5jm1Tdn1w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gK0hK-00023Y-Ni; Tue, 06 Nov 2018 12:43:11 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 47E4B2029F9FF; Tue,  6 Nov 2018 13:43:08 +0100 (CET)
Date:   Tue, 6 Nov 2018 13:43:08 +0100
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
Message-ID: <20181106124308.GE22467@hirez.programming.kicks-ass.net>
References: <1539413249-4402-1-git-send-email-hsiangkao@aol.com>
 <20181030060441.16107-1-gaoxiang25@huawei.com>
 <20181105224654.GA25864@brain-police>
 <20181106090642.GH22431@hirez.programming.kicks-ass.net>
 <5eb42b84-5195-69f2-e7a7-97568f360506@huawei.com>
 <20181106110026.GJ22431@hirez.programming.kicks-ass.net>
 <dedbc211-082b-be4a-1bce-2593084d4ca3@huawei.com>
 <20181106122713.GR22431@hirez.programming.kicks-ass.net>
 <cd305483-97f3-6935-65d6-d5de47cdfcd7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd305483-97f3-6935-65d6-d5de47cdfcd7@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 08:33:56PM +0800, Gao Xiang wrote:
> Hi Peter,
> 
> On 2018/11/6 20:27, Peter Zijlstra wrote:
> > On Tue, Nov 06, 2018 at 07:36:41PM +0800, Gao Xiang wrote:
> >> IMO, to use wrapped up function for the detailed scenario could be better than
> >> open-coded all the time (eg. do cpu_relax(); while(...)) since it could be
> >> optimizated even more for the specific architecture...
> > That's the whole point though; if this actually matters, you're doing it
> > wrong.
> 
> I cannot fully understand your point...Sorry about my English...
> 
> To the point, you mean it is much better to fix it as Will suggested before or
> leave the matter as it is since the performance of bit_spinlock itself doesn't matter?

Right, bit-spinlocks are terrible when contended. If the contended
behaviour of bit-spinlocks start to matter, you've lost already.
