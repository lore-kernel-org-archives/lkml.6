Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C2AECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F33E021529
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nyw8iQA/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F33E021529
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732758AbeITSAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 14:00:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58230 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730984AbeITSAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 14:00:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wNTPBaMcowimbcQp+VAC27jTBobwu/66OzwD/n4qdA0=; b=nyw8iQA/6X4tSlSmz6TQG5wwK
        K7BQ0l+UJkRzvhZrOEBoUl/NOPVudLCIszRy3xu5vbHE3h+ywOvC+t9THic2PoPSup+J2ioSSzz2p
        FKs0ZKfb0qz++R4B8iFFQz57XrnGY+t1n8EqsqfI1jTeDHq2b+ws8H3Lu52vujNE50ciU/usoGBJn
        irDwr9kYVbljKP0iBI50nzim+udWqz53wOfP4YC/UprfH9IA4XZ7vbIoSejQZBix1TcC71Z2k8D1L
        p09N26qZrECuU3rMzvxhtlO7y1p9i7FZnlXDn+zJQi4dnCM4r59+wxOF4n/GFGQ28mvVd49eTybDt
        noVDRJ1Eg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g2xtm-0003Bs-Jz; Thu, 20 Sep 2018 12:17:34 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 004A42015F390; Thu, 20 Sep 2018 14:17:32 +0200 (CEST)
Date:   Thu, 20 Sep 2018 14:17:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, ak@linux.intel.com, kan.liang@intel.com,
        mingo@redhat.com, rkrcmar@redhat.com, like.xu@intel.com,
        jannh@google.com, arei.gonglei@huawei.com
Subject: Re: [PATCH v3 4/5] KVM/x86/vPMU: Add APIs to support host
 save/restore the guest lbr stack
Message-ID: <20180920121732.GR24124@hirez.programming.kicks-ass.net>
References: <1537437959-8751-1-git-send-email-wei.w.wang@intel.com>
 <1537437959-8751-5-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537437959-8751-5-git-send-email-wei.w.wang@intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 06:05:58PM +0800, Wei Wang wrote:
> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> index 1562863..a91fdef 100644
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -223,6 +223,7 @@ struct cpu_hw_events {
>  	 */
>  	u64				intel_ctrl_guest_mask;
>  	u64				intel_ctrl_host_mask;
> +	bool				guest_lbr;
>  	struct perf_guest_switch_msr	guest_switch_msrs[X86_PMC_IDX_MAX];
>  
>  	/*

Please, no bools in aggregate types.

Either use a bitfield or u8, there's more LBR related bools, convert and
group the lot to avoid holes.
