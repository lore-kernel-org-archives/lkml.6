Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252CCC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C65B2208CC
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xGDTYUlu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C65B2208CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbeHXRpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 13:45:51 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40554 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbeHXRpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 13:45:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1lxwMUKIfDLHOJQOzCfUbYUmNnFYRgw20SmrRpQPACI=; b=xGDTYUluAXmbsjoeTzyNFOn+c
        laV68S0XQO8c1mVauDGHZq3dZipJ6Csp2NYeWh3Cai8MlHuwcJ65Yl3qMXaKzDj3aKHY/IHDKbGUw
        vVVIG+aMYZCjF1ofadldot7VRg45tHxfeziQA0GlPdH7g+utv1RH1ih4Cx18PqwTsG2AmdJ44O/pF
        AY+HDilRavg5BpNwzTxMPbnn2P/zhlKkFu/kyP/976Kj+TvH7ulcFBS2NRpXA/u/wie09l/ihRhxx
        JlhmOP9KBvAfpSbp8ANKLjr9IJtOuSpnQzMWFfe84MHLponsRuNf+pA9dDq/mxihfkUZWnXg/uKDR
        /dcoFh1ZA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ftCnW-0001Ty-Gv; Fri, 24 Aug 2018 14:10:46 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1915A2024C927; Fri, 24 Aug 2018 16:10:45 +0200 (CEST)
Date:   Fri, 24 Aug 2018 16:10:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org, virtualization@lists.linux-foundation.org,
        akataria@vmware.com, rusty@rustcorp.com.au,
        boris.ostrovsky@oracle.com, hpa@zytor.com, tglx@linutronix.de,
        mingo@redhat.com
Subject: Re: [PATCH v2 09/11] x86/paravirt: move the Xen-only pv_irq_ops
 under the PARAVIRT_XXL umbrella
Message-ID: <20180824141045.GO24124@hirez.programming.kicks-ass.net>
References: <20180813073739.26108-1-jgross@suse.com>
 <20180813073739.26108-10-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180813073739.26108-10-jgross@suse.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2018 at 09:37:37AM +0200, Juergen Gross wrote:
> Some of the paravirt ops defined in pv_irq_ops are for Xen PV guests
> only. Define them only if CONFIG_PARAVIRT_XXL is set.
> diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
> index e652ec27d945..ae53ee36d8fb 100644
> --- a/arch/x86/include/asm/paravirt_types.h
> +++ b/arch/x86/include/asm/paravirt_types.h
> @@ -197,8 +197,10 @@ struct pv_irq_ops {
>  	struct paravirt_callee_save irq_disable;
>  	struct paravirt_callee_save irq_enable;
>  
> +#ifdef CONFIG_PARAVIRT_XXL
>  	void (*safe_halt)(void);
>  	void (*halt)(void);
> +#endif

that makes me sad... but it appears VSMP also uses them. Can't you
simply make VSMP also select XXL, I don't think that's used quite as
much as Xen is :-)
