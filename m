Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E55C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF5C208CC
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KwSAUud3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDF5C208CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbeHXRrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 13:47:20 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40576 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbeHXRrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 13:47:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DgeKB7anUmWvsyL45xtZ5hVc8bP17GMtCTJcY9UgTUI=; b=KwSAUud3Vvg0JdcKmQWwUlDyJ
        OfWvhHbxRQGq4+p7YI6tpZTaXrczOFq0UPnpWCIt8pN9EuNzAktExZh6UyaF0rdvL2wud2PphLAy3
        GkbCij8bhpG/4MbBcWWrt++UqkA7+4ugRXM9rQlk6qOVtH5V4Uenbz/Ces2k1pzHSrnJwnYTwGf/C
        N0bM6bYcSkcGPsa7+Fvjq3EVfLjES7Q3EZnzjSpjwEwYDMiEHdAvwpDSczDilopclY+Y9CL0J2ZNL
        9s24GdgvzcglhoDuh6xQi2L0YWnSxVECqFioLZQqc/gnWdk45ooJMTJgMaaizEPvPRiKF6XQ5d4HG
        q/FoZFBeg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ftCp2-0001V8-41; Fri, 24 Aug 2018 14:12:20 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E4A512024C927; Fri, 24 Aug 2018 16:12:18 +0200 (CEST)
Date:   Fri, 24 Aug 2018 16:12:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org, virtualization@lists.linux-foundation.org,
        akataria@vmware.com, rusty@rustcorp.com.au,
        boris.ostrovsky@oracle.com, hpa@zytor.com, tglx@linutronix.de,
        mingo@redhat.com
Subject: Re: [PATCH v2 10/11] x86/paravirt: move the Xen-only pv_mmu_ops
 under the PARAVIRT_XXL umbrella
Message-ID: <20180824141218.GP24124@hirez.programming.kicks-ass.net>
References: <20180813073739.26108-1-jgross@suse.com>
 <20180813073739.26108-11-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180813073739.26108-11-jgross@suse.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2018 at 09:37:38AM +0200, Juergen Gross wrote:
>  struct pv_mmu_ops {
> +	/* TLB operations */
> +	void (*flush_tlb_user)(void);
> +	void (*flush_tlb_kernel)(void);
> +	void (*flush_tlb_one_user)(unsigned long addr);
> +	void (*flush_tlb_others)(const struct cpumask *cpus,
> +				 const struct flush_tlb_info *info);
> +
> +	/* Hook for intercepting the destruction of an mm_struct. */
> +	void (*exit_mmap)(struct mm_struct *mm);

Right, so I just wrecked that for you by adding a new:
tlb_remove_table virt function. But I don't suppose that's a difficult
thing to fix up.
