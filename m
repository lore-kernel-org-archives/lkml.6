Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E5FECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2607420671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kY3mNtZO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2607420671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731241AbeGSLbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 07:31:33 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35596 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbeGSLbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 07:31:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SQmo12u6GiJDyyohF2e8mRr73/YAIAu4hi1Khuvgq9o=; b=kY3mNtZO2QP+Lcqsak41YU/70
        y7U3R76DRh2Rf2pdfG8hhmVoCkYSNqEHDDRHPnHkMfRs9FRBsZBGUFdAjgvxSWQ+TDh6a8ZEkwRjV
        /lkA+gW5rTjTqPqvdXqVvdODPkpA2U75Xs28nq6oK52iv5wd5i/fjw3MpjFxhrP/OelOIC6SHnps5
        +2jWHHjokk+AFJed8yn7wHzw3G73toX1cYk4h0o+3hwznbgx1LB/jEbEXuiyep0n9w2LiOfsB3pYC
        DolsxSGHB7XqmFOuCNKJUyzmKedQ5+3gLz6VxskhJOZF1xLkFajpY2Ame0rHeJfRkyliTNXRNmgNz
        0WIyffmwQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fg6UB-0002cr-U0; Thu, 19 Jul 2018 10:48:40 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A5A7220289330; Thu, 19 Jul 2018 12:48:38 +0200 (CEST)
Date:   Thu, 19 Jul 2018 12:48:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, prarit@redhat.com, feng.tang@intel.com,
        pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk,
        linux-s390@vger.kernel.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, pbonzini@redhat.com
Subject: Re: [PATCH v14 25/25] sched: use static key for sched_clock_running
Message-ID: <20180719104838.GC2494@hirez.programming.kicks-ass.net>
References: <20180718022211.6259-1-pasha.tatashin@oracle.com>
 <20180718022211.6259-26-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718022211.6259-26-pasha.tatashin@oracle.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 10:22:11PM -0400, Pavel Tatashin wrote:
> sched_clock_running may be read every time sched_clock_cpu() is called.
> Yet, this variable is updated only twice during boot, and never changes
> again, therefore it is better to make it a static key.

Right, so the focus was always on making the sane TSC case fast, and if
TSC isn't stable we'd just make do and not care too much.

But this certainly isn't wrong, so ACK.
