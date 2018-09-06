Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF32C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4A0B204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jjGHxc8e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4A0B204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbeIFTXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 15:23:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56456 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729840AbeIFTXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 15:23:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=W/ss8ssgpE7WXWaH2yTlb156wPiBdu0VdxFunSPagrU=; b=jjGHxc8ehQ6epmQBpL4zO0f6p
        mqw0zvPcTXcoPjDIqSj3shGEH+tthlBZ7gkdPE+AqPbO9i/1erq0i3t9Yg8Pzp7Y2n8I/pOkTGMBQ
        0NvZyPLugc2F+TZVWPl50pLoIyJjHvF3l3wfHCWT2XfhVZE/joZqlHDivXPQxKgXXp/xSKuVNuCra
        CNC2TsB3DmrwMs3UeBhX/XiKHzP6wbOF8ouzEAmHt1VXPm8gzPPXWAu5GrnnVhqq03pBTZVgtWA3r
        SwW/MOX4wI8UdenWi5T9NYXnBbxvolIQ8s+KRtM6YM+SAfAFmuaYbF9EQVQctBvF6KeCDfT1LJMlx
        X7MzEvUMg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fxvZZ-0008H4-Db; Thu, 06 Sep 2018 14:47:53 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C3E1F2018BF7D; Thu,  6 Sep 2018 16:47:51 +0200 (CEST)
Date:   Thu, 6 Sep 2018 16:47:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        mingo@redhat.com, acme@kernel.org, vikas.shivappa@linux.intel.com,
        gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 4/6] x86/intel_rdt: Add helper to obtain performance
 counter index
Message-ID: <20180906144751.GH24106@hirez.programming.kicks-ass.net>
References: <cover.1534450299.git.reinette.chatre@intel.com>
 <ec245dd86408b92b5cb1553b7004a6a391d54640.1534450299.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec245dd86408b92b5cb1553b7004a6a391d54640.1534450299.git.reinette.chatre@intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 01:16:07PM -0700, Reinette Chatre wrote:

> +static inline int x86_perf_rdpmc_ctr_get(struct perf_event *event)
> +{
> +	lockdep_assert_irqs_disabled();
> +
> +	return IS_ERR_OR_NULL(event) ? -1 : event->hw.event_base_rdpmc;
> +}

That should be in arch/x86/include/asm/perf_event.h if anywhere. Also,
call the thing x86_perf_rdpmc_index(), that's consistent with the other
naming.

I don't think there's any point in testing for !event, this is an
interface that mandates you know wth you're doing anyway.
