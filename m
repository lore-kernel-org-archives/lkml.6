Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135F4ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95ABC20824
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pEtgizWZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95ABC20824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbeJYJFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 05:05:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42048 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbeJYJFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 05:05:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Uxtv525ctmyV7D1xX/yaiynglmzyaV/8ih02aNnrvRI=; b=pEtgizWZuGtXPBJg89SwfICEO
        UxE/IWlkF5MkZ9rRqynslKksGRC9HxeNcCrm7ggcEWzQo/FL7OoMWmkPozdbjcvlT4CITc3uxAqzG
        GuFWLk3u/0hPyXM+IYxVAFrsmU3dbiWwCGbvEJVLlgHQ/rEi/E7Tix7kEetV8buYt+iNBFUMasqRy
        c9sJg9fKiDlYSXHM0j3JpuvEzKkmjFe/AdJnPVpgm15EAg9rg1ErCjO1/w8PG1bzwSfEejP4+ScOF
        yCjSgvDFxInT2/m1jMjvLwmeWlm+xWzJIGd88W30v51uW+rcgL8Ju5qWmri2aV/aS/SusbsOvy+ZF
        LdM5iMbhw==;
Received: from [167.98.65.38] (helo=worktop)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gFTbq-0001C1-Fm; Thu, 25 Oct 2018 00:34:46 +0000
Received: by worktop (Postfix, from userid 1000)
        id F01E96E0794; Thu, 25 Oct 2018 02:34:44 +0200 (CEST)
Date:   Thu, 25 Oct 2018 02:34:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 1/2] perf: Add munmap callback
Message-ID: <20181025003444.GV3109@worktop.c.hoisthospitality.com>
References: <20181024151116.30935-1-kan.liang@linux.intel.com>
 <CABPqkBQEp9SLQuAonW7-c9HzH4bSgUyJGJ5ZZNXHy-0phHvvZQ@mail.gmail.com>
 <20181025002312.GS3109@worktop.c.hoisthospitality.com>
 <CABPqkBR1NTcpD3WxFsk4XZ6mT+jteec3kZBgBTxR5gFUL9Zffw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBR1NTcpD3WxFsk4XZ6mT+jteec3kZBgBTxR5gFUL9Zffw@mail.gmail.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 05:25:59PM -0700, Stephane Eranian wrote:
> On Wed, Oct 24, 2018 at 5:23 PM Peter Zijlstra <peterz@infradead.org> wrote:

> > That is actually a different problem. And you're right, we never did fix
> > that.
> >
> it is a different problem but the solution is the same: PERF_RECORD_UNMAP!

But he's not actually doing PERF_RECORD_UNMAP, nor is his perf_munmap()
hook sufficient to actually generate those.

Now I agree that if he's going to do an munmap hook, he should do it
'right' and at the very least allow for PERF_RECORD_UNMAP to be done,
but ideally simply pick up and finish that patch we had back then.
