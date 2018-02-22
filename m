Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751883AbeBVW5y (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 17:57:54 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37382 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751716AbeBVW5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 17:57:52 -0500
Date: Thu, 22 Feb 2018 14:57:52 -0800
From: Matthew Wilcox <willy@infradead.org>
To: x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Bad PTEs in page tables
Message-ID: <20180222225752.GA3670@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


We've got a few reports now [1] from users who are seeing a NULL pointer
dereference in the radix tree code.  I've tracked it down to bad PTEs.
I don't think it's been seen on 64-bit x86, but it's definitely been
seen on 32-bit x86 running under Xen.

Feb  9 14:31:27 cs01 kernel: Bad swp_entry: 2000000
Feb  9 14:31:27 cs01 kernel: mm/swap_state.c:683: bad pte
ef3a3f38(8000000100000000)

Feb  9 15:35:19 cs01 kernel: Bad swp_entry: 2000000
Feb  9 15:35:19 cs01 kernel: mm/swap_state.c:683: bad pte
eee17f38(8000000100000000)

(I also have a report from an earlier version of the patch with a Bad
swp_entry of 0e000000, so it's not a simple bit-flip like I had been
hoping)

At this point, I think it's out of my realm of expertise.  Anyone else
got a good idea why bits 63 & 32 would be set in a PTE?  I know 63 is
the XD bit, but bit 32 isn't special in a present PTE.

[1]
https://bugzilla.redhat.com/show_bug.cgi?id=1531779
https://bugzilla.kernel.org/show_bug.cgi?id=198497
