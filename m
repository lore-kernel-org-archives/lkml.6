Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8EFECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5DE521479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:13:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5DE521479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbeJRRN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 13:13:28 -0400
Received: from mga05.intel.com ([192.55.52.43]:37391 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727363AbeJRRN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 13:13:27 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Oct 2018 02:13:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,395,1534834800"; 
   d="scan'208";a="78951352"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga007.fm.intel.com with SMTP; 18 Oct 2018 02:13:20 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 18 Oct 2018 12:13:19 +0300
Date:   Thu, 18 Oct 2018 12:13:19 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] thunderbolt: Fix a missing-check bug
Message-ID: <20181018091319.GT2302@lahna.fi.intel.com>
References: <1539784829-1159-1-git-send-email-wang6495@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539784829-1159-1-git-send-email-wang6495@umn.edu>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wenwen,

On Wed, Oct 17, 2018 at 09:00:29AM -0500, Wenwen Wang wrote:
> In tb_cfg_copy(), the header of the received control package, which is in
> the buffer 'pkg->buffer', is firstly parsed through parse_header() to make
> sure the header is in the expected format. In parse_header(), the header is
> actually checked by invoking check_header(), which checks the 'unknown'
> field of the header and the response route acquired through
> 'tb_cfg_get_route(header)'. If there is no error in this checking process,
> the package, including the header, is then copied to 'req->response' in
> tb_cfg_copy() through memcpy() and the parsing result is saved to
> 'req->result'.
> 
> The problem here is that the whole parsing and checking process is
> conducted directly on the buffer 'pkg->buffer', which is actually a DMA
> region and allocated through dma_pool_alloc() in tb_ctl_pkg_alloc(). Given
> that the DMA region can also be accessed directly by a device at any time,
> it is possible that a malicious device can race to modify the package data
> after the parsing and checking process but before memcpy() is invoked in
> tb_cfg_copy(). Through this way, the attacker can bypass the parsing and
> checking process and inject malicious data. This can potentially cause
> undefined behavior of the kernel and introduce unexpected security risk.

Here the device doing DMA is the Thunderbolt host controller which is
soldered on the motherboard (not anything connected via the TBT ports).
In addition the buffers we are dealing here are already marked ready by
the host controller hardware so it is not expected to touch them anymore
(if it did, then it would be a quite nasty bug).

What kind of use-case you had in mind that could possibly inject
malicious data to these buffers?
