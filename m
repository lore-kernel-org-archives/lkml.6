Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF805C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8658E22448
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:54:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8658E22448
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933846AbeGDIyN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 04:54:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:38858 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932439AbeGDIyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 04:54:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 62F37B045;
        Wed,  4 Jul 2018 08:54:09 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <Bart.VanAssche@sandisk.com>,
        Ming Lei <tom.leiming@gmail.com>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH] scsi: switch to scsi-mq by default
Date:   Wed,  4 Jul 2018 10:53:56 +0200
Message-Id: <20180704085356.10888-1-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It has been more than one year since we tried to change the default
from legacy to multi queue in SCSI with commit c279bd9e406 ("scsi:
default to scsi-mq"). But due to issues with suspend/resume and
performance problems it had been reverted again with commit
cbe7dfa26eee ("Revert "scsi: default to scsi-mq"").

In the meantime there have been a substantial amount of performance
improvements and suspend/resume got fixed as well, thus we can
re-enable scsi-mq without a significant performance penalty.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Acked-by: John Garry <john.garry@huawei.com>

---
Changes since RFC:
- Improve Changelog as Bart suggested
- Collect Acks and Reviews
---
 drivers/scsi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index 35c909bbf8ba..bd115bab162e 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -49,6 +49,7 @@ config SCSI_NETLINK
 
 config SCSI_MQ_DEFAULT
 	bool "SCSI: use blk-mq I/O path by default"
+	default y
 	depends on SCSI
 	---help---
 	  This option enables the new blk-mq based I/O path for SCSI
-- 
2.16.4

