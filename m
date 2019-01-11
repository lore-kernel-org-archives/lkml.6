Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFC8C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 620E820870
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="RblCAEjI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731304AbfAKRg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 12:36:59 -0500
Received: from mail.skyhub.de ([5.9.137.197]:50406 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbfAKRg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 12:36:58 -0500
Received: from zn.tnic (p200300EC2BCAC5003956DFF8679C923C.dip0.t-ipconnect.de [IPv6:2003:ec:2bca:c500:3956:dff8:679c:923c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8C4101EC0432;
        Fri, 11 Jan 2019 18:36:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547228217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+CCqKfeR1VAuRhQk8t21C6yoxZes1BsouZ93Be7mIDo=;
        b=RblCAEjIV05bLQEJHC1f4m1muAVxkkdRYGbowGCGbzPtRB/kwtDpdUS7XkYSGIqUTK2ohe
        GjKU0tSHh9/5sgod9HaWtx9rf7JBfopMkUudqzzK0urpvKWsW+8W1V44Zokh6hA0Yx9oO7
        9LHGuRMR/320paSXcj6DAPDVUOB6XSI=
Date:   Fri, 11 Jan 2019 18:36:48 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Waiman Long <longman@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        SRINIVAS <srinivas.eeda@oracle.com>
Subject: Re: Question about qspinlock nest
Message-ID: <20190111173648.GH4729@zn.tnic>
References: <e784a592-5dec-b0b3-6c70-d9ef775621d5@oracle.com>
 <910e9fb6-d0df-4711-fe2b-244b3c20eb82@redhat.com>
 <2eca6f60-3e8b-a389-27cb-8adbd9676607@oracle.com>
 <20190111091638.GK30894@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190111091638.GK30894@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 10:16:38AM +0100, Peter Zijlstra wrote:
> > Not for debug exception, for MCE exception handler I found below two:
> > 
> > do_machine_check->mce_report_event->schedule_work

That has been the case at least since 2009. We probably never hit it or
I've never seen a deadlock caused by it.

> > do_machine_check->force_sig->force_sig_info

This does:

        ist_begin_non_atomic(regs);
        local_irq_enable();

before forcing the signal. And there's blurb above
ist_begin_non_atomic() why it is OK to schedule when the exception came
from usermode.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
