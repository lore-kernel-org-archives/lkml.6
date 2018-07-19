Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9950AC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5142320862
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:47:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5142320862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731840AbeGSPar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 11:30:47 -0400
Received: from verein.lst.de ([213.95.11.211]:33847 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731813AbeGSPar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 11:30:47 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id E9F3B68D5B; Thu, 19 Jul 2018 16:50:05 +0200 (CEST)
Date:   Thu, 19 Jul 2018 16:50:05 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>,
        James Smart <james.smart@broadcom.com>,
        Hannes Reinecke <hare@suse.de>, Ewan Milne <emilne@redhat.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] Rework NVMe abort handling
Message-ID: <20180719145005.GA21000@lst.de>
References: <20180719132838.15556-1-jthumshirn@suse.de> <20180719134203.GA15212@lst.de> <20180719141025.yveza2svhvc2r4lw@linux-x5ow.site> <20180719142355.GA18800@lst.de> <20180719143534.i36vo45lhz24xbrg@linux-x5ow.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180719143534.i36vo45lhz24xbrg@linux-x5ow.site>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 04:35:34PM +0200, Johannes Thumshirn wrote:
> > No with the the code following what we have in PCIe that just means
> > we'll eventually controller reset after the I/O command times out
> > the second time as we still won't have seen a completion for it.
> 
> Exactly that was my intention.

Which means the only thing you do for your use case is to delay
recovery even further.

> OK, let me see where I'm stuck here. We're issuing a command, it gets
> lost due to $REASON and I'm aborting it. The upper layers then
> eventually retry the command and it arrives at the target side. But so
> does the old command as well and we have a duplicate. Correct?

The upper layer is only going to retry after tearing down the transport
connection.  And a tear down of the connection MUST clear all pending
commands on the way.  If it doesn't we are in deep, deep trouble.

A NVMe abort has no chance of clearing things at the transport layer.
