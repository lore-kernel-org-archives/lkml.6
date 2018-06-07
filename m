Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id vJpqMt/BGVtYRwAAmS7hNA
	; Thu, 07 Jun 2018 23:38:07 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id AB92E608C1; Thu,  7 Jun 2018 23:38:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1EDBC6074D;
	Thu,  7 Jun 2018 23:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1EDBC6074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752252AbeFGXiC (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 19:38:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44132 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751631AbeFGXiB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 19:38:01 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0A4D78A3DE;
        Thu,  7 Jun 2018 23:38:01 +0000 (UTC)
Received: from sky.random (ovpn-122-246.rdu2.redhat.com [10.10.122.246])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B88F1117634;
        Thu,  7 Jun 2018 23:38:00 +0000 (UTC)
Date: Thu, 7 Jun 2018 19:38:00 -0400
From: Andrea Arcangeli <aarcange@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>,
        Jia He <hejianet@gmail.com>, Minchan Kim <minchan@kernel.org>,
        Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jia.he@hxt-semitech.com,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v2] mm/ksm: ignore STABLE_FLAG of rmap_item->address in
 rmap_walk_ksm
Message-ID: <20180607233800.GA6965@redhat.com>
References: <20180503124415.3f9d38aa@p-imbrenda.boeblingen.de.ibm.com>
 <1525403506-6750-1-git-send-email-hejianet@gmail.com>
 <20180509163101.02f23de1842a822c61fc68ff@linux-foundation.org>
 <2cd6b39b-1496-bbd5-9e31-5e3dcb31feda@arm.com>
 <6c417ab1-a808-72ea-9618-3d76ec203684@arm.com>
 <20180524133805.6e9bfd4bf48de065ce1d7611@linux-foundation.org>
 <20180607151344.a22a1e7182a2142e6d24e4de@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607151344.a22a1e7182a2142e6d24e4de@linux-foundation.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 07 Jun 2018 23:38:01 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 07 Jun 2018 23:38:01 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'aarcange@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 03:13:44PM -0700, Andrew Morton wrote:
> This patch is quite urgent and is tagged for -stable backporting, yet
> it remains in an unreviewed state.  Any takers?

It looks a straightforward safe fix, on x86 hva_to_gfn_memslot would
zap those bits and hide the misalignment caused by the low metadata
bits being erroneously left set in the address, but the arm code
notices when that's the last page in the memslot and the hva_end is
getting aligned and the size is below one page.

> [35380.933345] [<ffff000008088f00>] dump_backtrace+0x0/0x22c
> [35380.938723] [<ffff000008089150>] show_stack+0x24/0x2c
> [35380.943759] [<ffff00000893c078>] dump_stack+0x8c/0xb0
> [35380.948794] [<ffff00000820ab50>] bad_page+0xf4/0x154
> [35380.953740] [<ffff000008211ce8>] free_pages_check_bad+0x90/0x9c
> [35380.959642] [<ffff00000820c430>] free_pcppages_bulk+0x464/0x518
> [35380.965545] [<ffff00000820db98>] free_hot_cold_page+0x22c/0x300
> [35380.971448] [<ffff0000082176fc>] __put_page+0x54/0x60
> [35380.976484] [<ffff0000080b1164>] unmap_stage2_range+0x170/0x2b4
> [35380.982385] [<ffff0000080b12d8>] kvm_unmap_hva_handler+0x30/0x40
> [35380.988375] [<ffff0000080b0104>] handle_hva_to_gpa+0xb0/0xec
> [35380.994016] [<ffff0000080b2644>] kvm_unmap_hva_range+0x5c/0xd0
> [35380.999833] [<ffff0000080a8054>] 
> 
> I even injected a fault on purpose in kvm_unmap_hva_range by seting
> size=size-0x200, the call trace is similar as above.  So I thought the
> panic is similarly caused by the root cause of WARN_ON.

I think the problem triggers in the addr += PAGE_SIZE of
unmap_stage2_ptes that never matches end because end is aligned but
addr is not.

	} while (pte++, addr += PAGE_SIZE, addr != end);

x86 again only works on hva_start/hva_end after converting it to
gfn_start/end and that being in pfn units the bits are zapped before
they risk to cause trouble.

> 
> Link: http://lkml.kernel.org/r/1525403506-6750-1-git-send-email-hejianet@gmail.com
> Signed-off-by: Jia He <jia.he@hxt-semitech.com>
> Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
> Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>
> Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
> Cc: Jia He <hejianet@gmail.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 

Reviewed-by: Andrea Arcangeli <aarcange@redhat.com>
