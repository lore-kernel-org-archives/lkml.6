Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB87C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3B96208B2
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:43:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3B96208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbeH0XbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 19:31:05 -0400
Received: from mga04.intel.com ([192.55.52.120]:5779 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726826AbeH0XbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 19:31:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2018 12:43:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,296,1531810800"; 
   d="scan'208";a="83833358"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by fmsmga004.fm.intel.com with ESMTP; 27 Aug 2018 12:43:03 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>, stable@vger.kernel.org
Subject: [char-misc for 4.9 1/2] mei: bus: fix hw module get/put balance
Date:   Mon, 27 Aug 2018 22:40:15 +0300
Message-Id: <20180827194016.1287-2-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180827194016.1287-1-tomas.winkler@intel.com>
References: <20180827194016.1287-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case the device is not connected it doesn't 'get'
hw module and hence should not 'put' it on disable.

Cc: <stable@vger.kernel.org> 4.16+
Fixes:'commit 257355a44b99 ("mei: make module referencing local to the bus.c")'
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=200455
Tested-by: Georg Müller <georgmueller@gmx.net>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/bus.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/misc/mei/bus.c b/drivers/misc/mei/bus.c
index 7bba62a72921..13c6c9a2248a 100644
--- a/drivers/misc/mei/bus.c
+++ b/drivers/misc/mei/bus.c
@@ -616,9 +616,8 @@ int mei_cldev_disable(struct mei_cl_device *cldev)
 	if (err < 0)
 		dev_err(bus->dev, "Could not disconnect from the ME client\n");
 
-out:
 	mei_cl_bus_module_put(cldev);
-
+out:
 	/* Flush queues and remove any pending read */
 	mei_cl_flush_queues(cl, NULL);
 	mei_cl_unlink(cl);
-- 
2.14.4

