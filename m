Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D923BC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 02:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9682921526
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 02:44:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9682921526
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sympatico.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbeHQFqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 01:46:21 -0400
Received: from belmont79srvr.owm.bell.net ([184.150.200.79]:41139 "EHLO
        mtlfep01.bell.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726094AbeHQFqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 01:46:21 -0400
Received: from bell.net mtlfep01 184.150.200.30 by mtlfep01.bell.net
          with ESMTP
          id <20180817024448.VAV10498.mtlfep01.bell.net@mtlspm02.bell.net>
          for <linux-kernel@vger.kernel.org>;
          Thu, 16 Aug 2018 22:44:48 -0400
Received: from arcusix ([70.55.50.38]) by mtlspm02.bell.net with ESMTP
          id <20180817024448.JMEI6415.mtlspm02.bell.net@arcusix>;
          Thu, 16 Aug 2018 22:44:48 -0400
Message-ID: <0055c50937cff963e243bba815947cfcdd8b3d0b.camel@sympatico.ca>
Subject: Re: [PATCH 0/3] PTI for x86-32 Fixes
From:   "David H. Gutteridge" <dhgutteridge@sympatico.ca>
To:     Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brian Gerst <brgerst@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>, aliguori@amazon.com,
        daniel.gruss@iaik.tugraz.at, hughd@google.com, keescook@google.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        jroedel@suse.de
Date:   Thu, 16 Aug 2018 22:44:47 -0400
In-Reply-To: <1533637471-30953-1-git-send-email-joro@8bytes.org>
References: <1533637471-30953-1-git-send-email-joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Cloudmark-Analysis: v=2.2 cv=IaFoYSia c=1 sm=0 tr=0 a=e5NqWeyudnn36+hvbsSv9g==:17 a=IkcTkHD0fZMA:10 a=dapMudl6Dx4A:10 a=k_m-kdumAAAA:8 a=W_vHiYWUJ7UVWE1JRxsA:9 a=QEXdDO2ut3YA:10 a=2aFmp3DG3lfw9CblUY6y:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-08-07 at 12:24 +0200, Joerg Roedel wrote:
> Hi,
> 
> here is a small patch-set to fix two small issues in the
> PTI implementation for 32 bit x86. The issues are:
> 
> 	1) Fix the 32 bit PCID check. I used the wrong
> 	   operator there and this caused false-positive
> 	   warnings.
> 
> 	2) The other two patches make sure the init-hole is
> 	   not mapped into the user page-table. It is the
> 	   32 bit counterpart to commit
> 
> 	   c40a56a7818c ('x86/mm/init: Remove freed kernel image areas
> from alias mapping')
> 
> 	   for the 64 bit PTI implementation.
> 
> I tested that no-PAE, PAE and 64 bit kernel all boot and
> have correct user page-tables with identical global mappings
> between user and kernel.
> 
> Regards,
> 
> 	Joerg
> 
> Joerg Roedel (3):
>   x86/mm/pti: Fix 32 bit PCID check
>   x86/mm/pti: Don't clear permissions in pti_clone_pmd()
>   x86/mm/pti: Clone kernel-image on PTE level for 32 bit
> 
>  arch/x86/mm/pti.c | 143 ++++++++++++++++++++++++++++++++++++++-------
> ---------
>  1 file changed, 100 insertions(+), 43 deletions(-)

I've tested this in a VM and on an Atom laptop, as usual. No
regressions noted.

Tested-by: David H. Gutteridge <dhgutteridge@sympatico.ca>

Regards,

Dave


