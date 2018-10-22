Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA25C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 08:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3BEB2083A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 08:05:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3BEB2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbeJVQW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 12:22:57 -0400
Received: from mga01.intel.com ([192.55.52.88]:24161 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727523AbeJVQW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 12:22:57 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2018 01:05:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,411,1534834800"; 
   d="scan'208";a="84522669"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga006.jf.intel.com with SMTP; 22 Oct 2018 01:05:27 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 22 Oct 2018 11:05:26 +0300
Date:   Mon, 22 Oct 2018 11:05:26 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] thunderbolt: fix a missing-check bug
Message-ID: <20181022080526.GL2302@lahna.fi.intel.com>
References: <1540060698-17331-1-git-send-email-wang6495@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540060698-17331-1-git-send-email-wang6495@umn.edu>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Oct 20, 2018 at 01:38:18PM -0500, Wenwen Wang wrote:
> In icm_copy(), the packet id 'hdr->packet_id' is firstly compared against
> 'req->npackets'. If it is less than 'req->npackets', the received packet.
> i.e., 'pkg->buffer', is then copied to 'req->response + offset' through
> memcpy(). It is worth noting that 'offset' is also calculated based on
> 'hdr->packet_id'. The problem here is that both the check and the
> calculation are conducted directly on 'pkg->buffer', which is actually a
> DMA memory region. Given that a device can also access the DMA region at
> any time, it is possible that a malicious device controlled by an attacker
> can modify the packet id after the check. By doing so, the attacker can
> supply comprised value into 'offset' and thus cause unexpected errors.
> 
> This patch firstly copies the header of the packet and performs the check
> and the calculation on the copied version to fix the above issue. This
> patch also rewrites the header in 'req->response + offset' using the
> copied header to avoid a potential inconsistency issue.

Same comment here than with the previous one.
