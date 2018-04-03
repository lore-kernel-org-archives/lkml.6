Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756641AbeDCWbL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 18:31:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50446 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756099AbeDCWat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 18:30:49 -0400
Date: Tue, 3 Apr 2018 15:30:46 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: jglisse@redhat.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: Re: [PATCH] mm/migrate: properly preserve write attribute in
 special migrate entry
Message-Id: <20180403153046.88cae4ab18646e8e23a648ce@linux-foundation.org>
In-Reply-To: <20180402023506.12180-1-jglisse@redhat.com>
References: <20180402023506.12180-1-jglisse@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  1 Apr 2018 22:35:06 -0400 jglisse@redhat.com wrote:

> From: Ralph Campbell <rcampbell@nvidia.com>
> 
> Use of pte_write(pte) is only valid for present pte, the common code
> which set the migration entry can be reach for both valid present
> pte and special swap entry (for device memory). Fix the code to use
> the mpfn value which properly handle both cases.
> 
> On x86 this did not have any bad side effect because pte write bit
> is below PAGE_BIT_GLOBAL and thus special swap entry have it set to
> 0 which in turn means we were always creating read only special
> migration entry.

Does this mean that the patch only affects behaviour of non-x86 systems?

> So once migration did finish we always write protected the CPU page
> table entry (moreover this is only an issue when migrating from device
> memory to system memory). End effect is that CPU write access would
> fault again and restore write permission.

That sounds a bit serious.  Was a -stable backport considered?
