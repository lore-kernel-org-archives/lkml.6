Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED8FC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4850F20850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hR5Ub0E4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4850F20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbeLFJ5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 04:57:34 -0500
Received: from merlin.infradead.org ([205.233.59.134]:46902 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728144AbeLFJ5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 04:57:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pphfmW7d0SKARFYi8RfqJI9+aTtVREWwtRPx6ZqaDk8=; b=hR5Ub0E4lm2kuUbuuX+YKzBiP
        Dtuj+kdDan5VDeZ5y6FiBUHhqA+DWbQPhlSLPwth2VCOq50deoS1KMXl/xxe1nlGVaXqBJ6UlRjVx
        Ctw/Ph99rEGP5fWmw3ddJyyaaWE6PL42ghSqdklytXLl1A6R1FV4LTG+5hmeUjMdQLLTnmrnwWHoJ
        qLrX0wboFlsfRuhj/f8ytWyDSIVLvn7agsLdRBZtXeBOXpohqHjzOehbcnkIPJxgxsxVxJBDzdhBQ
        wsK4+tvd++M6JzV2lIOSJ4gc+SDGeY/+EGIPlWZOLdpWmtjdsTO2gECbfPYQnirLRGNHm1wEQTB9C
        amHynOdvQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gUqPE-0005Mw-Ag; Thu, 06 Dec 2018 09:57:16 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1EC27200FBC3D; Thu,  6 Dec 2018 10:57:15 +0100 (CET)
Date:   Thu, 6 Dec 2018 10:57:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux_dti@icloud.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Rick P Edgecombe <rick.p.edgecombe@intel.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v7 13/14] module: Do not set nx for module memory before
 freeing
Message-ID: <20181206095715.GD13538@hirez.programming.kicks-ass.net>
References: <20181205013408.47725-1-namit@vmware.com>
 <20181205013408.47725-14-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205013408.47725-14-namit@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 05:34:07PM -0800, Nadav Amit wrote:

> So let's remove it. Andy suggested that the changes of the PTEs can be
> avoided (excluding the direct-mapping alias), which is true. However,
> in x86 it requires some cleanup of the contiguous page allocator, which
> is outside of the scope of this patch-set.

I think x86-cpa stands for change_page_attr() :-)
