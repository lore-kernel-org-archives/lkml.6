Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0B4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 21:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A85C520675
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 21:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfBVV7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 16:59:37 -0500
Received: from mga05.intel.com ([192.55.52.43]:18747 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbfBVV7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 16:59:37 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Feb 2019 13:59:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,401,1544515200"; 
   d="scan'208";a="301854869"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga005.jf.intel.com with ESMTP; 22 Feb 2019 13:59:35 -0800
Date:   Fri, 22 Feb 2019 14:59:38 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Derrick, Jonathan" <jonathan.derrick@intel.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Alex Gagniuc <alex_gagniuc@dellteam.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme-pci: Prevent mmio reads if pci channel offline
Message-ID: <20190222215938.GG10237@localhost.localdomain>
References: <20190222010502.2434-1-jonathan.derrick@intel.com>
 <CAHk-=wjmjHyovjtzaq=HSegEpiO2SXWaYfJ6qsJrZhXg_YSx5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjmjHyovjtzaq=HSegEpiO2SXWaYfJ6qsJrZhXg_YSx5g@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 01:28:42PM -0800, Linus Torvalds wrote:
> On Thu, Feb 21, 2019 at 5:07 PM Jon Derrick <jonathan.derrick@intel.com> wrote:
> >
> > Some platforms don't seem to easily tolerate non-posted mmio reads on
> > lost (hot removed) devices. This has been noted in previous
> > modifications to other layers where an mmio read to a lost device could
> > cause an undesired firmware intervention [1][2].
> 
> This is broken, and whatever platform that requires this is broken.
> 
> This has absolutely nothing to do with nvme, and should not be handled
> by a driver.
> 
> The platform code should be fixed.

This is, of course, the correct answer. We just find platform firmware
uncooperative, so we see these attempts to avoid them.

I really don't like this driver piecemeal approach if we're going to
quirk around these platforms, though. I'd rather see the invalidated
address ranges remapped to a fault handler fixup exception once and be
done with it.

Or we can say you don't get to use this feature if you bought that
hardware.
