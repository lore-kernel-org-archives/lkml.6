Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id TpYLJ4soHltMDwAAmS7hNA
	; Mon, 11 Jun 2018 07:45:20 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A2A4A607E7; Mon, 11 Jun 2018 07:45:19 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m0KeBFD5"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 22403608CA;
	Mon, 11 Jun 2018 07:45:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 22403608CA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754101AbeFKHpP (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 03:45:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37156 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753964AbeFKHpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 03:45:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=J90GsHWbmiMUP60WHu7W/BPoqlHG5vrbzrKoQ+f5kWM=; b=m0KeBFD5c5hPIDsPbBpIEHOGd
        JW/UwWQ9XXImqVbiOGIiU+0m6C5dgDVoJgy2oNEGQ62rYCCXhPV1xyu5t9HccVF2HCbXsov83vt6N
        C9zJzr8x3tgW8Sw1i02ekV+UykjVCEC91qVlqm4Mf0f5JK0YEiWvPmoV4lyBD/i71DTwCfPgW9qzz
        JHI/ZYsu9yeN7BO6OFQ3RSUdXEudaj7R9irg/uV/mGRL8a48C0e0bRPcdASJCC7d7q0zIEiDwZS82
        ivCNZDYkneO5gBYlg/7dxgQvpHSyy/PblrOn6HD75zwzfcKYlPBwEURNpPyJrozCXMfyK7T9czzd6
        BqnQcxfbg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSHVl-0004Uw-9n; Mon, 11 Jun 2018 07:45:09 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 85FD6201EA7B1; Mon, 11 Jun 2018 09:45:07 +0200 (CEST)
Date: Mon, 11 Jun 2018 09:45:07 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Nadav Amit <namit@vmware.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
        Juergen Gross <jgross@suse.com>,
        Alok Kataria <akataria@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v3 6/9] x86: prevent inline distortion by paravirt ops
Message-ID: <20180611074507.GP12258@hirez.programming.kicks-ass.net>
References: <20180610141911.52948-1-namit@vmware.com>
 <20180610141911.52948-7-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180610141911.52948-7-namit@vmware.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 10, 2018 at 07:19:08AM -0700, Nadav Amit wrote:
> +/*
> + * This generates an indirect call based on the operation type number.
> + * The type number, computed in PARAVIRT_PATCH, is derived from the
> + * offset into the paravirt_patch_template structure, and can therefore be
> + * freely converted back into a structure offset.
> + */
> +.macro PARAVIRT_ALT type:req clobber:req pv_opptr:req

Unlike the marcro maze you replaced, this has the CALL hardcoded in. So
maybe name this PARAVIRT_CALL instead of PARAVIRT_ALT ?

> +771:	ANNOTATE_RETPOLINE_SAFE
> +	call *\pv_opptr
> +772:	.pushsection .parainstructions,"a"
> +	_ASM_ALIGN
> +	_ASM_PTR 771b
> +	.byte \type
> +	.byte 772b-771b
> +	.short \clobber
> +	.popsection
> +.endm
