Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF0DC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9185C208B2
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:43:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9185C208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbeH0XbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 19:31:03 -0400
Received: from mga04.intel.com ([192.55.52.120]:5779 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726826AbeH0XbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 19:31:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2018 12:43:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,296,1531810800"; 
   d="scan'208";a="83833349"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by fmsmga004.fm.intel.com with ESMTP; 27 Aug 2018 12:43:02 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc for 4.19 0/2] mei: fix suspend/hibernation regression
Date:   Mon, 27 Aug 2018 22:40:14 +0300
Message-Id: <20180827194016.1287-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A kernel panic during suspend/hibernation was reported on kernel 4.17.

RIP:  mei_cl_set_disconnected+0x5/0x260[mei]
Call trace:
mei_cl_all_disconnect+0x22/0x30
mei_reset+0x194/0x250
__synchronize_hardirq+0x43/0x50
_cond_resched+0x15/0x30
mei_me_intr_clear+0x20/0x100
mei_stop+0x76/0xb0
mei_me_shutdown+0x3f/0x80
pci_device_shutdown+0x34/0x60
kernel_restart+0x0e/0x30

Bugzilla entries:
https://bugzilla.redhat.com/show_bug.cgi?id=1597481
https://bugzilla.kernel.org/show_bug.cgi?id=200455

The regression is caused by a combination of two coding errors
in two separate patches. In addition, this currently only happens
on platforms with AMT watchdog enabled that systemd holds.

Both patches bellow should be applied.

Tomas Winkler (2):
  mei: bus: fix hw module get/put balance
  mei: bus: need to unlink client before freeing

 drivers/misc/mei/bus.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

-- 
2.14.4

