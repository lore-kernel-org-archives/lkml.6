Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07711C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C162120658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:34:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C162120658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731211AbeICVze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:55:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47762 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728335AbeICVze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:55:34 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 720B2D16;
        Mon,  3 Sep 2018 17:34:24 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michal Wnukowski <wnukowski@google.com>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 4.18 046/123] nvme-pci: add a memory barrier to nvme_dbbuf_update_and_check_event
Date:   Mon,  3 Sep 2018 18:56:30 +0200
Message-Id: <20180903165721.410878907@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165719.499675257@linuxfoundation.org>
References: <20180903165719.499675257@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Wnukowski <wnukowski@google.com>

commit f1ed3df20d2d223e0852cc4ac1f19bba869a7e3c upstream.

In many architectures loads may be reordered with older stores to
different locations.  In the nvme driver the following two operations
could be reordered:

 - Write shadow doorbell (dbbuf_db) into memory.
 - Read EventIdx (dbbuf_ei) from memory.

This can result in a potential race condition between driver and VM host
processing requests (if given virtual NVMe controller has a support for
shadow doorbell).  If that occurs, then the NVMe controller may decide to
wait for MMIO doorbell from guest operating system, and guest driver may
decide not to issue MMIO doorbell on any of subsequent commands.

This issue is purely timing-dependent one, so there is no easy way to
reproduce it. Currently the easiest known approach is to run "Oracle IO
Numbers" (orion) that is shipped with Oracle DB:

orion -run advanced -num_large 0 -size_small 8 -type rand -simulate \
	concat -write 40 -duration 120 -matrix row -testname nvme_test

Where nvme_test is a .lun file that contains a list of NVMe block
devices to run test against. Limiting number of vCPUs assigned to given
VM instance seems to increase chances for this bug to occur. On test
environment with VM that got 4 NVMe drives and 1 vCPU assigned the
virtual NVMe controller hang could be observed within 10-20 minutes.
That correspond to about 400-500k IO operations processed (or about
100GB of IO read/writes).

Orion tool was used as a validation and set to run in a loop for 36
hours (equivalent of pushing 550M IO operations). No issues were
observed. That suggest that the patch fixes the issue.

Fixes: f9f38e33389c ("nvme: improve performance for virtual NVMe devices")
Signed-off-by: Michal Wnukowski <wnukowski@google.com>
Reviewed-by: Keith Busch <keith.busch@intel.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
[hch: updated changelog and comment a bit]
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/nvme/host/pci.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -316,6 +316,14 @@ static bool nvme_dbbuf_update_and_check_
 		old_value = *dbbuf_db;
 		*dbbuf_db = value;
 
+		/*
+		 * Ensure that the doorbell is updated before reading the event
+		 * index from memory.  The controller needs to provide similar
+		 * ordering to ensure the envent index is updated before reading
+		 * the doorbell.
+		 */
+		mb();
+
 		if (!nvme_dbbuf_need_event(*dbbuf_ei, value, old_value))
 			return false;
 	}


