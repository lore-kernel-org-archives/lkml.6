Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D99C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 21:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A74692083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 21:05:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A74692083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388816AbeKGGcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 01:32:42 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:52342 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388525AbeKGGcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 01:32:42 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 798E694B;
        Tue,  6 Nov 2018 21:05:33 +0000 (UTC)
Date:   Tue, 6 Nov 2018 13:05:32 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     jeyu@kernel.org, willy@infradead.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-hardening@lists.openwall.com, daniel@iogearbox.net,
        jannh@google.com, keescook@chromium.org, kristen@linux.intel.com,
        dave.hansen@intel.com, arjan@linux.intel.com
Subject: Re: [PATCH v8 2/4] x86/modules: Increase randomization for modules
Message-Id: <20181106130532.1ef8e080baeedfa0960eebd4@linux-foundation.org>
In-Reply-To: <20181102192520.4522-3-rick.p.edgecombe@intel.com>
References: <20181102192520.4522-1-rick.p.edgecombe@intel.com>
        <20181102192520.4522-3-rick.p.edgecombe@intel.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  2 Nov 2018 12:25:18 -0700 Rick Edgecombe <rick.p.edgecombe@intel.com> wrote:

> This changes the behavior of the KASLR logic for allocating memory for the text
> sections of loadable modules. It randomizes the location of each module text
> section with about 17 bits of entropy in typical use. This is enabled on X86_64
> only. For 32 bit, the behavior is unchanged.
> 
> It refactors existing code around module randomization somewhat. There are now
> three different behaviors for x86 module_alloc depending on config.
> RANDOMIZE_BASE=n, and RANDOMIZE_BASE=y ARCH=x86_64, and RANDOMIZE_BASE=y
> ARCH=i386.
>
> The refactor of the existing code is to try to clearly show what
> those behaviors are without having three separate versions or threading the
> behaviors in a bunch of little spots. The reason it is not enabled on 32 bit
> yet is because the module space is much smaller and simulations haven't been
> run to see how it performs.
> 
> The new algorithm breaks the module space in two, a random area and a backup
> area. It first tries to allocate at a number of randomly located starting pages
> inside the random section without purging any lazy free vmap areas and
> triggering the associated TLB flush.

Surprised.  Is one TLB flush per module loading sufficiently expensive
to justify any effort to avoid it?  IOW, please provide some
justification and explanation in the changelog.

> If this fails, then it will allocate in
> the backup area. The backup area base will be offset in the same way as the
> current algorithm does for the base area, 1024 possible locations.

So presumably the allocation effort in the randomized section is
somewhat likely to fail.  That's unfortunate.  Some discussion about
why these failures occur would be helpful.

Because it would be nice to do away with the backup area altogether. 
But this reader doesn't really understand why the backup area is
needed.

> Due to boot_params being defined with different types in different places,
> placing the config helpers modules.h or kaslr.h caused conflicts elsewhere, and
> so they are placed in a new file, kaslr_modules.h, instead.
> 

