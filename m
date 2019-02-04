Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA7BC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F38B1217D6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="e646cnv5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbfBDSPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 13:15:18 -0500
Received: from mail.skyhub.de ([5.9.137.197]:42938 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726585AbfBDSPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 13:15:17 -0500
Received: from zn.tnic (p200300EC2BC6E20088F471E0F0A30C16.dip0.t-ipconnect.de [IPv6:2003:ec:2bc6:e200:88f4:71e0:f0a3:c16])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D66AE1EC03D8;
        Mon,  4 Feb 2019 19:15:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1549304116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=6/CmOVV78zV3xkm2YRNT+RH3MFGFISBTJv/6b731sNg=;
        b=e646cnv5f70C8dQ5mcWWWRucSrNhOuh/2Ef1LihVeL/AMVi0zTzzZP1Q+jWiqaWpJnizl2
        mjhTSKRJm4B0XWkx3hLhE4k63jSv2dA5uwNfjG2ZY8GjF0zYqHNBZeI+bgniOcjZeQs74J
        2wLTjuJ/QfGAmuO5MCpIgrXXLxI74xY=
Date:   Mon, 4 Feb 2019 19:15:04 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        ak@linux.intel.com, eranian@google.com
Subject: Re: [PATCH V6 2/5] perf/x86/kvm: Avoid unnecessary work in guest
 filtering
Message-ID: <20190204181504.GH29639@zn.tnic>
References: <1548106951-4811-1-git-send-email-kan.liang@linux.intel.com>
 <1548106951-4811-2-git-send-email-kan.liang@linux.intel.com>
 <20190204153827.GG17528@hirez.programming.kicks-ass.net>
 <20190204154411.GC17582@hirez.programming.kicks-ass.net>
 <90e071c0-cdf4-3a31-4e44-2c5b84af5fa3@linux.intel.com>
 <20190204162312.GJ17528@hirez.programming.kicks-ass.net>
 <2c429bbd-00fb-2e3a-7d58-27123400b722@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2c429bbd-00fb-2e3a-7d58-27123400b722@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 11:55:27AM -0500, Liang, Kan wrote:

> We cannot apply X86_STEPPING_ANY to ignore the stepping. There will be
> problems for 0-8 stepping for KABYLAKE_MOBILE.

So why are we even doing this new "interface"
x86_cpu_has_min_microcode_rev() if even at the conversion stage it shows
that it is inadequate?

> I think what we need is x86_match_cpu_with_stepping_range().
> But I don't think it is worth enabling it just for this rare case.

Sounds to me like you wanna go back to the drawing board after having
evaluated all the use cases.

And yes, I can imagine:

+struct x86_cpu_desc {
+       __u8    x86;            /* CPU family */
+       __u8    x86_vendor;     /* CPU vendor */
+       __u8    x86_model;
+       __u8    x86_min_stepping;
+       __u8    x86_max_stepping;
+       __u32   x86_microcode_rev;
+};

along with the usage:

INTEL_CPU_DESC(mod, min_step, max_step, rev)

to make it more elegant.

Question is, can you have a given microcode revision X applying to
multiple revisions?

If yes, the above should work...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
