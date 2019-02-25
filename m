Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277A9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE6DC20684
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbfBYPyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 10:54:53 -0500
Received: from mga01.intel.com ([192.55.52.88]:9836 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727728AbfBYPyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 10:54:53 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2019 07:54:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,411,1544515200"; 
   d="scan'208";a="146376549"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga002.fm.intel.com with ESMTP; 25 Feb 2019 07:54:51 -0800
Date:   Mon, 25 Feb 2019 08:55:01 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     "Alex_Gagniuc@Dellteam.com" <Alex_Gagniuc@Dellteam.com>
Cc:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "mr.nuke.me@gmail.com" <mr.nuke.me@gmail.com>,
        "hch@lst.de" <hch@lst.de>,
        "Derrick, Jonathan" <jonathan.derrick@intel.com>
Subject: Re: [PATCH] nvme-pci: Prevent mmio reads if pci channel offline
Message-ID: <20190225155501.GI10237@localhost.localdomain>
References: <20190222010502.2434-1-jonathan.derrick@intel.com>
 <CAHk-=wjmjHyovjtzaq=HSegEpiO2SXWaYfJ6qsJrZhXg_YSx5g@mail.gmail.com>
 <2b7d8f45d11c47e69f56ad1bc3324dd1@ausx13mps321.AMER.DELL.COM>
 <CAHk-=wg_e5M0b5aJJf8V_UYaqX12YYA9MEg=gHNp6ALE5fK23w@mail.gmail.com>
 <cbe2ed1562a64609be6538f5816ec1b6@ausx13mps321.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbe2ed1562a64609be6538f5816ec1b6@ausx13mps321.AMER.DELL.COM>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 24, 2019 at 03:27:09PM -0800, Alex_Gagniuc@Dellteam.com wrote:
> 
> More like "fatal error, just panic". It looks like this (from a serial 
> console):
> 
> [   57.680494] {1}[Hardware Error]: Hardware error from APEI Generic  Hardware Error Source: 1
> [   57.680495] {1}[Hardware Error]: event severity: fatal
> [   57.680496] {1}[Hardware Error]:  Error 0, type: fatal
> [   57.680496] {1}[Hardware Error]:   section_type: PCIe error
> [   57.680497] {1}[Hardware Error]:   port_type: 6, downstream switch port
> [   57.680498] {1}[Hardware Error]:   version: 3.0
> [   57.680498] {1}[Hardware Error]:   command: 0x0407, status: 0x0010
> [   57.680499] {1}[Hardware Error]:   device_id: 0000:3c:07.0
> [   57.680499] {1}[Hardware Error]:   slot: 1
> [   57.680500] {1}[Hardware Error]:   secondary_bus: 0x40
> [   57.680500] {1}[Hardware Error]:   vendor_id: 0x10b5, device_id: 0x9733
> [   57.680501] {1}[Hardware Error]:   class_code: 000406
> [   57.680502] {1}[Hardware Error]:   bridge: secondary_status: 0x0000, > control: 0x0003

This is a reaction to a ERR_FATAL message, right? What happens if we
ignore firmware first and override control of the AER masking with a
set to the Unsupported Request Error Mask in the root and downstream
ports? You can do a quick test like this for the above's hardware:

  # setpci -s 3c:07.0 ECAP_AER+8.l=100000:100000

You'd probably have to do the same command to the root port BDf, and any
other switches you have them in the hierarchy. 
