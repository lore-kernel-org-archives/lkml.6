Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13D2C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1E5620862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:16:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1E5620862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388091AbeKGAlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 19:41:51 -0500
Received: from mga01.intel.com ([192.55.52.88]:34270 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729574AbeKGAlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 19:41:50 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2018 07:16:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,472,1534834800"; 
   d="scan'208";a="84388452"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga008.fm.intel.com with ESMTP; 06 Nov 2018 07:16:09 -0800
Date:   Tue, 6 Nov 2018 08:14:02 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Ming Lei <tom.leiming@gmail.com>
Cc:     Johannes Thumshirn <jthumshirn@suse.de>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@fb.com>,
        linux-block <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] block: respect virtual boundary mask in bvecs
Message-ID: <20181106151402.GA6020@localhost.localdomain>
References: <20181105102301.9752-1-jthumshirn@suse.de>
 <20181105105548.GC12367@ming.t460p>
 <7c649b43-f952-cf94-93d6-44fb153acced@suse.de>
 <20181105120153.GD12367@ming.t460p>
 <3c3dd9c2-4240-7bb5-c0ff-af6f2e479c31@suse.de>
 <CACVXFVNOAc1HEPmfu9n8vMjqY2hK8fVqe4Em-g+dvSRLavpO8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACVXFVNOAc1HEPmfu9n8vMjqY2hK8fVqe4Em-g+dvSRLavpO8w@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 10:56:52PM +0800, Ming Lei wrote:
> 
> This patch makes sense on >4KB PAGE_SIZE. 

Granted existing blk_queue_virt_boundary() users all appear to be at
least 4k, the block API doesn't enforce that. Some unlikely device may
require an even smaller alignment in the future, which would benefit
from this patch.

But yes, the changelog description is a bit confusing to me if the
sighting came from a 4K arch.
