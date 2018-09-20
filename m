Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CADBECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 587E22152F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gkx14ckn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 587E22152F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387647AbeITRu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 13:50:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57928 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbeITRu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 13:50:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qGql0kUIra1xlvKqDGcc8fWXj+VBs45GyL+og79ptRc=; b=Gkx14cknKywhUbpRTpEMLyMT9
        Qnl2H+bzzisaaTxZGjyJFEqnOn83LYrIPsXD/5SstcnExNnaT1hK6FcA/deTFq0Qm9VTU6T3VC7AB
        K4mbwhF7yspF8y/wSiSz8FkJts8XXHLyFjvdC19rW3XlEa8wpuNQxKa+qruTlsBawQl9Egrip47U6
        qDV0uqlHirJCEwVsEkQC5YcPqhbSsT0dppQA3ZPKviHRW76OqFXwWgTr2fp75oIEr95mpdaekrMxO
        jxYc1WwoKlL0dF1MZroD9AfMPbagcDzB+jDZlPi1GoMyw7z2sJ/EmZFmpmP0v88PgBSn6lgUxb1v+
        HCcsT5OTg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g2xjk-000880-02; Thu, 20 Sep 2018 12:07:12 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D67392015F392; Thu, 20 Sep 2018 14:07:09 +0200 (CEST)
Date:   Thu, 20 Sep 2018 14:07:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, ak@linux.intel.com, kan.liang@intel.com,
        mingo@redhat.com, rkrcmar@redhat.com, like.xu@intel.com,
        jannh@google.com, arei.gonglei@huawei.com
Subject: Re: [PATCH v3 1/5] perf/x86: add a function to get the lbr stack
Message-ID: <20180920120709.GQ24124@hirez.programming.kicks-ass.net>
References: <1537437959-8751-1-git-send-email-wei.w.wang@intel.com>
 <1537437959-8751-2-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537437959-8751-2-git-send-email-wei.w.wang@intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 06:05:55PM +0800, Wei Wang wrote:
> The LBR stack MSRs are architecturally specific. The perf subsystem has
> already assigned the abstracted MSR values based on the CPU architecture.
> 
> This patch enables a caller outside the perf subsystem to get the LBR
> stack info. This is useful for hyperviosrs to prepare the lbr feature
> for the guest.
> 
> Signed-off-by: Like Xu <like.xu@intel.com>
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>

Also, that SoB chain is broken. Since you're the author (per From), your
SoB should be first, also since you're the one sending it, your SoB
should also be last.

Nowhere did Like Xu handle the patch so he shouldn't be having a SoB at
all.
