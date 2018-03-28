Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753496AbeC1R5R (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 13:57:17 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:44712 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753220AbeC1R5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 13:57:12 -0400
X-Google-Smtp-Source: AIpwx4+bfUmqx9z5g6yv/CMkVukOMIdRqd29ndsnQGrft8RnO9X8F6Y2fxLHw/US6aTpPRGhJiNa5pIVnx9rsMxDCKE=
MIME-Version: 1.0
In-Reply-To: <c93ed5db-8cfd-1258-3396-62ca2076c44d@codeaurora.org>
References: <1522156287-15169-1-git-send-email-will.deacon@arm.com>
 <20180327150252.GN3675@linux.vnet.ibm.com> <c93ed5db-8cfd-1258-3396-62ca2076c44d@codeaurora.org>
From: Tony Luck <tony.luck@intel.com>
Date: Wed, 28 Mar 2018 10:57:11 -0700
X-Google-Sender-Auth: CJ7SUjkr2_1K7Y7WLhcjBOQ8O94
Message-ID: <CA+8MBb+61AhMkbo8xtd3Y0fY8xRUPD+kUsEvWgOz94KGEuovOw@mail.gmail.com>
Subject: Re: [PATCH] docs/memory-barriers.txt: Fix broken DMA vs MMIO ordering example
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Will Deacon <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2018 at 6:02 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
> +linux-ia64
> Does IA64 follow this requirement? If not, is implementation planned?
>
> "no wmb() before writel()"
>
> Linus asked us to get rid of wmb() in front of writel() for UC memory.
> Just checking that we are not breaking anything for IA64.

We should be OK on ia64, writel() uses a cast to:

 *(volatile unsigned int __force *)

which the compiler takes as a request to use a "st4.rel" instruction
(meaning "store with release semantics"). So the value stored will
be visible to anything that follows.

-Tony
