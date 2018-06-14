Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8A8FCC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40E4F208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OIMB2DHN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40E4F208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966111AbeFNOMq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:12:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:54042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966091AbeFNOMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:12:42 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2C5B208DB;
        Thu, 14 Jun 2018 14:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985562;
        bh=yGiT5RGR+XpaHz5rwo/aXvx6jz3+MtDo+i6gNpDyVMM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OIMB2DHNAkjid3xUiiFYyXh41ZvXngh2HLzSsecrRrmq1t4N9X+FtviNhzgRMwIz4
         bXE3sHUUjIYQ/GVQEMNwXLCM3LUe+yYxiUAB0PMuNfxUTtUDtHdxhYVgYAfXKzV/3X
         Ew2WKIjmPmMDzk5+EKxyyKhakYeCs+jICq/eH1O0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Thumshirn <jthumshirn@suse.de>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.9 08/30] nvmet: Move serial number from controller to subsystem
Date:   Thu, 14 Jun 2018 16:04:49 +0200
Message-Id: <20180614132600.603640328@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614132600.255515394@linuxfoundation.org>
References: <20180614132600.255515394@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Thumshirn <jthumshirn@suse.de>

commit 2e7f5d2af2155084c6f7c86328d36e698cd84954 upstream.

The NVMe specification defines the serial number as:

"Serial Number (SN): Contains the serial number for the NVM subsystem
that is assigned by the vendor as an ASCII string. Refer to section
7.10 for unique identifier requirements. Refer to section 1.5 for ASCII
string requirements"

So move it from the controller to the subsystem, where it belongs.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/nvme/target/admin-cmd.c |    2 +-
 drivers/nvme/target/core.c      |    5 ++---
 drivers/nvme/target/nvmet.h     |    2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)

--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -183,7 +183,7 @@ static void nvmet_execute_identify_ctrl(
 	id->ssvid = 0;
 
 	memset(id->sn, ' ', sizeof(id->sn));
-	snprintf(id->sn, sizeof(id->sn), "%llx", ctrl->serial);
+	snprintf(id->sn, sizeof(id->sn), "%llx", ctrl->subsys->serial);
 
 	memset(id->mn, ' ', sizeof(id->mn));
 	strncpy((char *)id->mn, "Linux", sizeof(id->mn));
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -743,9 +743,6 @@ u16 nvmet_alloc_ctrl(const char *subsysn
 	memcpy(ctrl->subsysnqn, subsysnqn, NVMF_NQN_SIZE);
 	memcpy(ctrl->hostnqn, hostnqn, NVMF_NQN_SIZE);
 
-	/* generate a random serial number as our controllers are ephemeral: */
-	get_random_bytes(&ctrl->serial, sizeof(ctrl->serial));
-
 	kref_init(&ctrl->ref);
 	ctrl->subsys = subsys;
 
@@ -904,6 +901,8 @@ struct nvmet_subsys *nvmet_subsys_alloc(
 		return NULL;
 
 	subsys->ver = NVME_VS(1, 2, 1); /* NVMe 1.2.1 */
+	/* generate a random serial number as our controllers are ephemeral: */
+	get_random_bytes(&subsys->serial, sizeof(subsys->serial));
 
 	switch (type) {
 	case NVME_NQN_NVME:
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -110,7 +110,6 @@ struct nvmet_ctrl {
 
 	struct mutex		lock;
 	u64			cap;
-	u64			serial;
 	u32			cc;
 	u32			csts;
 
@@ -151,6 +150,7 @@ struct nvmet_subsys {
 	u16			max_qid;
 
 	u64			ver;
+	u64			serial;
 	char			*subsysnqn;
 
 	struct config_group	group;


