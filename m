Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237E2ECDE43
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 08:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D90262083A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 08:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D90262083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbeJVQXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 12:23:24 -0400
Received: from mga12.intel.com ([192.55.52.136]:32555 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727523AbeJVQXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 12:23:24 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2018 01:05:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,411,1534834800"; 
   d="scan'208";a="101516638"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga001.jf.intel.com with SMTP; 22 Oct 2018 01:05:54 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 22 Oct 2018 11:05:53 +0300
Date:   Mon, 22 Oct 2018 11:05:53 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] thunderbolt: fix a missing-check bug
Message-ID: <20181022080553.GM2302@lahna.fi.intel.com>
References: <1540064869-17849-1-git-send-email-wang6495@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540064869-17849-1-git-send-email-wang6495@umn.edu>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 20, 2018 at 02:47:49PM -0500, Wenwen Wang wrote:
> In ring_work(), the first while loop is used to collect all completed
> frames from the ring buffer. In each iteration of this loop, the flag of
> the frame, i.e., 'ring->descriptors[ring->tail].flags' is firstly check to
> see whether the frame is completed. If yes, the descriptor of the frame,
> including the flag, is then copied. It is worth noting that the descriptor
> is actually in a DMA region, which is allocated through
> dma_alloc_coherent() in tb_ring_alloc(). Given that the device can also
> access the DMA region, a malicious device controlled by an attacker can
> race to modify the flag of the frame after the check but before the copy.
> By doing so, the attacker can bypass the check and supply uncompleted
> frame, which can cause undefined behavior of the kernel and introduce
> potential security risk.
> 
> This patch firstly copies the flag into a local variable 'desc_flags' and
> then performs the check and copy using 'desc_flags'. Through this way, the
> above issue can be avoided.

Ditto :)
