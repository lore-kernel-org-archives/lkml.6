Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF487C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67616204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:11:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67616204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbeJaAE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 20:04:57 -0400
Received: from mga04.intel.com ([192.55.52.120]:35310 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727078AbeJaAE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 20:04:56 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2018 08:11:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,444,1534834800"; 
   d="scan'208";a="86946152"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga006.jf.intel.com with ESMTP; 30 Oct 2018 08:11:02 -0700
Date:   Tue, 30 Oct 2018 09:08:40 -0600
From:   Keith Busch <keith.busch@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 11/14] irq: add support for allocating (and affinitizing)
 sets of IRQs
Message-ID: <20181030150840.GC18906@localhost.localdomain>
References: <20181029163738.10172-1-axboe@kernel.dk>
 <20181029163738.10172-12-axboe@kernel.dk>
 <20181030142601.GA18906@localhost.localdomain>
 <c11c95ae-5e10-38bd-d2c2-e2407634f52a@kernel.dk>
 <20181030144527.GB18906@localhost.localdomain>
 <46dbcbcd-799f-9970-a68f-de7e96b1a6bb@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46dbcbcd-799f-9970-a68f-de7e96b1a6bb@kernel.dk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 08:53:37AM -0600, Jens Axboe wrote:
> The sum of the set can't exceed the nvecs passed in, the nvecs passed in
> should be the less than or equal to nvecs. Granted this isn't enforced,
> and perhaps that should be the case.

That should at least initially be true for a proper functioning
driver. It's not enforced as you mentioned, but that's only related to
the issue I'm referring to.

The problem is pci_alloc_irq_vectors_affinity() takes a range, min_vecs
and max_vecs, but a range of allowable vector allocations doesn't make
sense when using sets.
