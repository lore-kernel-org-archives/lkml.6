Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479D6C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B2AF20856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:11:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B2AF20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388446AbeGXQSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 12:18:40 -0400
Received: from bran.ispras.ru ([83.149.199.196]:23717 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388322AbeGXQSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 12:18:39 -0400
Received: from myklebust.intra.ispras.ru (unknown [10.10.2.207])
        by smtp.ispras.ru (Postfix) with ESMTP id 0362E203C6;
        Tue, 24 Jul 2018 18:11:39 +0300 (MSK)
From:   Anton Vasilyev <vasilyev@ispras.ru>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Anton Vasilyev <vasilyev@ispras.ru>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Holland <samuel@sholland.org>,
        Pan Bian <bianpan2016@163.com>, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH v2] firmware: vpd: Fix section enabled flag on vpd_section_destroy
Date:   Tue, 24 Jul 2018 18:10:38 +0300
Message-Id: <20180724151038.14838-1-vasilyev@ispras.ru>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723183927.GH100814@dtor-ws>
References: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

static struct ro_vpd and rw_vpd are initialized by vpd_sections_init()
in vpd_probe() based on header's ro and rw sizes.
In vpd_remove() vpd_section_destroy() performs deinitialization based
on enabled flag, which is set to true by vpd_sections_init().
This leads to call of vpd_section_destroy() on already destroyed section
for probe-release-probe-release sequence if first probe performs
ro_vpd initialization and second probe does not initialize it.

The patch adds changing enabled flag on vpd_section_destroy and adds
cleanup on the error path of vpd_sections_init.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
---
v2: add cleanup on the error path of vpd_sections_init
---
 drivers/firmware/google/vpd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/google/vpd.c b/drivers/firmware/google/vpd.c
index e9db895916c3..1aa67bb5d8c0 100644
--- a/drivers/firmware/google/vpd.c
+++ b/drivers/firmware/google/vpd.c
@@ -246,6 +246,7 @@ static int vpd_section_destroy(struct vpd_section *sec)
 		sysfs_remove_bin_file(vpd_kobj, &sec->bin_attr);
 		kfree(sec->raw_name);
 		memunmap(sec->baseaddr);
+		sec->enabled = false;
 	}
 
 	return 0;
@@ -279,8 +280,10 @@ static int vpd_sections_init(phys_addr_t physaddr)
 		ret = vpd_section_init("rw", &rw_vpd,
 				       physaddr + sizeof(struct vpd_cbmem) +
 				       header.ro_size, header.rw_size);
-		if (ret)
+		if (ret) {
+			vpd_section_destroy(&ro_vpd);
 			return ret;
+		}
 	}
 
 	return 0;
-- 
2.18.0

