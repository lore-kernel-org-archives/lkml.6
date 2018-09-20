Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9FAECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87ACA2152A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Yz4YLBJT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87ACA2152A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387728AbeITSVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 14:21:24 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60838 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387424AbeITSVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 14:21:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vhmq1rFUrxnuoiBVLGhplCmMJ/ZdIhVEGv/nMhrDT8A=; b=Yz4YLBJTfKUWwGHEo2JOtqRZF
        cuPDWRLL8yojCB7gOoLjM0Vl1NWkrt5ZMFsoxHgNO0zGXtlOKWhdQfgAeg/6GujtJyqUs47s4IY8x
        s54xlVZGw6gEkACOxKErLkLkVVmvChyjXv91hcp693Vh+GqmVl7fsz4LE5PkmreydetvMH/bvc2s4
        CU5LMIkuSQ9i7p58hcsaHUDteXiW5VGXgCdPym2snYBv4jb234tS54HBZHXMzI9lVWjPhhqi9Ci7e
        A6TeMW6dtDubss1EBe+XdyczUO9WRWtEF+JvK+Ahvh9bHdgNJuNormO6auMx9NcEBqzJ1+86HuaRV
        kEgfOr85w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g2yDS-0001iS-Iv; Thu, 20 Sep 2018 12:37:54 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 331E22015F391; Thu, 20 Sep 2018 14:37:53 +0200 (CEST)
Date:   Thu, 20 Sep 2018 14:37:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, ak@linux.intel.com, kan.liang@intel.com,
        mingo@redhat.com, rkrcmar@redhat.com, like.xu@intel.com,
        jannh@google.com, arei.gonglei@huawei.com
Subject: Re: [PATCH v3 5/5] KVM/x86/lbr: lazy save the guest lbr stack
Message-ID: <20180920123753.GT24124@hirez.programming.kicks-ass.net>
References: <1537437959-8751-1-git-send-email-wei.w.wang@intel.com>
 <1537437959-8751-6-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537437959-8751-6-git-send-email-wei.w.wang@intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 06:05:59PM +0800, Wei Wang wrote:
>  /**
> + * lbr_select_user_callstack - check if the user callstack mode is set
> + *
> + * @lbr_select: the lbr select msr
> + *
> + * Returns: true if the msr is configured to the user callstack mode.
> + * Otherwise, false.
> + *
> + */
> +bool lbr_select_user_callstack(u64 lbr_select)
> +{
> +	return !!(lbr_select & LBR_USER_CALLSTACK);
> +}
> +EXPORT_SYMBOL_GPL(lbr_select_user_callstack);

That function is pure and tiny, wth is that an exported symbol and not
an inline?
