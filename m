Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752501AbeBHQRS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 11:17:18 -0500
Received: from foss.arm.com ([217.140.101.70]:37108 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752016AbeBHQQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 11:16:49 -0500
Date: Thu, 8 Feb 2018 16:16:46 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] UBSAN: support __ubsan_handle_type_mismatch_v1
Message-ID: <20180208161645.lol4xqw677yrz5on@lakrids.cambridge.arm.com>
References: <20180208154636.21320-1-mark.rutland@arm.com>
 <e1561019-21c2-04f9-5db7-1c27c327a8db@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1561019-21c2-04f9-5db7-1c27c327a8db@virtuozzo.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2018 at 07:05:14PM +0300, Andrey Ryabinin wrote:
> On 02/08/2018 06:46 PM, Mark Rutland wrote:
> > Originally, UBSAN's __ubsan_handle_type_mismatch took a struct
> > type_mismatch_data, as defined in lib/ubsan.h. This has an unsigned long
> > alignment field.
> > 
> > New versions of UBSAN call __ubsan_handle_type_mismatch_v1, which is
> > similar to __ubsan_handle_type_mismatch, but takes a different struct
> > where the alignment is stored in an unsigned char (as log2 of the
> > alignment). All other fields are unchanged.
> > 
> > As we don't implement __ubsan_handle_type_mismatch_v1, the kernel will
> > fail to link when compiled with compilers using the new ABI (e.g. clang
> > form the LLVM 5.0.0 release).
> > 
> > This patch adds support for the new ABI. To keep things simple, we
> > simply convert the new data format into the old format, and hand it on
> > to the existing handlers.
> > 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> > ---
> >  lib/ubsan.c | 14 ++++++++++++++
> >  lib/ubsan.h |  7 +++++++
> >  2 files changed, 21 insertions(+)
> > 
> > Andrey, does this look correct to you?
> 
> Almost.
> Commit 42440c1f9911b4b7b8ba3dc4e90c1197bc561211 looks correct to me ;)

Ah, I didn't spot something had already been queued. Sorry for the
noise, and thanks for implementing this!

> Copying ->location is wrong, because we use bit in location struct to suppress multiple
> reports of the same location, see was_reported(). So in you case REPORTED_BIT will be set
> on stack and original source_location remain unchanged.
>
> > Are there any other new ABI bits that need to be plumbed in?
> 
> ABI of __ubsan_handle_nonnull_return() changed as well, but it's never used in the kernel
> and probably never will be. Thus I removed it, see bac7a1fff7926fb9891a18fe33650884b0e13e4

Noted.

I'll cherry-pick these into my local testing branch while I await
v4.16-rc1.

Mark.
