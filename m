Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93E0ECDE45
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 08:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 538DA2083A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 08:06:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 538DA2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbeJVQXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 12:23:41 -0400
Received: from mga14.intel.com ([192.55.52.115]:44872 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727523AbeJVQXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 12:23:41 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2018 01:06:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,411,1534834800"; 
   d="scan'208";a="274462046"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga006.fm.intel.com with SMTP; 22 Oct 2018 01:06:10 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 22 Oct 2018 11:06:09 +0300
Date:   Mon, 22 Oct 2018 11:06:09 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] thunderbolt: fix a missing-check bug
Message-ID: <20181022080609.GN2302@lahna.fi.intel.com>
References: <1540066556-18088-1-git-send-email-wang6495@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540066556-18088-1-git-send-email-wang6495@umn.edu>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 20, 2018 at 03:15:56PM -0500, Wenwen Wang wrote:
> In tb_ring_poll(), the flag of the frame, i.e.,
> 'ring->descriptors[ring->tail].flags', is checked to see whether the frame
> is completed. If yes, the frame including the flag will be read from the
> ring and returned to the caller. The problem here is that the flag is
> actually in a DMA region, which is allocated through dma_alloc_coherent()
> in tb_ring_alloc(). Given that the device can also access this DMA region,
> it is possible that a malicious device controlled by an attacker can modify
> the flag between the check and the copy. By doing so, the attacker can
> bypass the check and supply uncompleted frame, which can cause undefined
> behavior of the kernel and introduce potential security risk.
> 
> This patch firstly copies the flag into a local variable 'desc_flags' and
> then performs the check and copy using 'desc_flags'. Through this way, the
> above issue can be avoided.

Same here :)
