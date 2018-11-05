Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87962C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5076C2081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WLSxDH1Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5076C2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387987AbeKFCSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 21:18:49 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36436 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387921AbeKFCSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 21:18:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8N9AblV9Wa3qf64I4Lx4g1cXc4FkR6iLu4HkGxAlMzM=; b=WLSxDH1QcoCw44DCmFYz3x3eG
        ThEd+s6wH9AeunMiaZxdfJPj+Xjx8yfDokbPyBqd+dhxekWVU6evXKEUPPt4kmLx1wkJtMqJvoy+i
        xCSEjwEYFmgcNWZaB8hrPBCxLIL1clEYgCFTstF01rYJ1xicuNCLdWjL3r2Y8zUMmz986m43F5oYz
        dALXQ+K8z2XzyxwJSvB6AVQ8R5c1po2RLQPVnl0ziMzMYTil4z2dmVXmlAO1fNkaDDb7D95vtiQQK
        HfLm/4GQnEDEH0LVSBfxzPFkAWpQugrcUxCn6qkaPkRbbwsKD3QTYYYP6QnJK37sF2EuLWIPi/pck
        vCLSHDBSw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gJiCP-0003Jp-Pp; Mon, 05 Nov 2018 16:58:01 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8A9F32029F9FF; Mon,  5 Nov 2018 17:57:59 +0100 (CET)
Date:   Mon, 5 Nov 2018 17:57:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Waiman Long <longman@redhat.com>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@fb.com, pjt@google.com, luto@amacapital.net,
        Mike Galbraith <efault@gmx.de>, torvalds@linux-foundation.org,
        Roman Gushchin <guro@fb.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Tom Hromatka <tom.hromatka@oracle.com>
Subject: Re: [PATCH v14 00/12] Enable cpuset controller in default hierarchy
Message-ID: <20181105165759.GE22431@hirez.programming.kicks-ass.net>
References: <1539635377-22335-1-git-send-email-longman@redhat.com>
 <20181105163656.GK4182586@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105163656.GK4182586@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 08:36:56AM -0800, Tejun Heo wrote:
> Hello,
> 
> So, this looks good to me.  Peter, I'm gonna roll the series into
> cgroup/for-4.21-cpuset.  Please holler if you have any objections /
> comments.

I'll try and have a look before LPC. Thanks!
