Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936224AbeEYOfc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 10:35:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56552 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935826AbeEYOf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 10:35:29 -0400
From: Christoph Hellwig <hch@lst.de>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: x86@kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        netdev@vger.kernel.org
Subject: refactor 32-bit dma limit quirks
Date: Fri, 25 May 2018 16:35:05 +0200
Message-Id: <20180525143512.1466-1-hch@lst.de>
X-Mailer: git-send-email 2.17.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

x86 currently has some quirks to force lower dma masks.  They are mostly
useful for certain VIA systems that otherwise corrupt data, but otherwise
don't make much sense given that the modern DMA APIs do the right thing
automatically.

This series dumps a few of these old kernel command lines (including their
not really working version on ia64), and moves the VIA quirk to a flag
in struct device so that it can be apply generically.  This will be needed
to support Xylinx root ports with a similar issue that show up in common
RISC-V boards.
