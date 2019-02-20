Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2572EC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED19C20880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Ji8ztF0K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfBTQOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 11:14:17 -0500
Received: from mail.skyhub.de ([5.9.137.197]:53612 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbfBTQOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 11:14:17 -0500
Received: from zn.tnic (p200300EC2BCB85008CB41DEE22243FB8.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:8500:8cb4:1dee:2224:3fb8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 134121EC0375;
        Wed, 20 Feb 2019 17:14:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1550679255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=va5wQs9EKQ1GeiZlKtwOOE8k4i30bqMSIDq6ZHKsbjU=;
        b=Ji8ztF0KNPSq2TKU/mqM5d2+gQ1HXE6WbaT5lXCP1LRVWqLNWzSCUO69gR5gAHxSgC+AhR
        okn8X6hUV+WjBYED3Mi862I9Uy++eBvKkda8tfepkTSZqGJiVx5Z44/C7M84NwJzvXu9MT
        LjuXADMac2mmrKkYhQGt6NMhDpwlIfo=
Date:   Wed, 20 Feb 2019 17:14:12 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux_dti@icloud.com" <linux_dti@icloud.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>
Subject: Re: [PATCH v2 15/20] vmalloc: New flags for safe vfree on special
 perms
Message-ID: <20190220161412.GE3447@zn.tnic>
References: <20190129003422.9328-1-rick.p.edgecombe@intel.com>
 <20190129003422.9328-16-rick.p.edgecombe@intel.com>
 <20190219124853.GB19514@zn.tnic>
 <b01f3fafb44c31842f897d3f62b5b9ccc1306ec5.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b01f3fafb44c31842f897d3f62b5b9ccc1306ec5.camel@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 07:42:53PM +0000, Edgecombe, Rick P wrote:
> So to capture both of those intentions, maybe I'll slightly tweak your
> suggestion to VM_FLUSH_RESET_PERMS?

Yeah, sure, better.

VM_HAS_SPECIAL_PERMS doesn't tell me what those special permissions are
while flush and reset permissions makes a lot more sense, thx.

> I had thought it was easier to read. If its not the case, I'll change it as you
> suggest.

My logic is, the less local vars, the easier to scan the code quickly.

> Ard had expressed interest in having the set_alias_() functions for Arm, and the
> names were chosen to be arch agnostic. He didn't explicitly commit but I was
> under the impression he might create an implementation for ARM and we could
> remove this block.

Yeah, Will has those on his radar too so we should be good here.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
