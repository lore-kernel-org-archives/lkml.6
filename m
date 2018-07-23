Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DDCECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E3820856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:49:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2E3820856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388853AbeGWRva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 13:51:30 -0400
Received: from bran.ispras.ru ([83.149.199.196]:18376 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726943AbeGWRva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 13:51:30 -0400
Received: from myklebust.intra.ispras.ru (unknown [10.10.2.207])
        by smtp.ispras.ru (Postfix) with ESMTP id 30D5A203C3;
        Mon, 23 Jul 2018 19:49:19 +0300 (MSK)
From:   Anton Vasilyev <vasilyev@ispras.ru>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Anton Vasilyev <vasilyev@ispras.ru>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Samuel Holland <samuel@sholland.org>,
        Pan Bian <bianpan2016@163.com>, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH] firmware: vpd: Fix section enabled flag on vpd_section_destroy
Date:   Mon, 23 Jul 2018 19:48:57 +0300
Message-Id: <20180723164857.24460-1-vasilyev@ispras.ru>
X-Mailer: git-send-email 2.18.0
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

The patch adds changing enabled flag on vpd_section_destroy.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
---
 drivers/firmware/google/vpd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/google/vpd.c b/drivers/firmware/google/vpd.c
index e9db895916c3..5347c17c7108 100644
--- a/drivers/firmware/google/vpd.c
+++ b/drivers/firmware/google/vpd.c
@@ -246,6 +246,7 @@ static int vpd_section_destroy(struct vpd_section *sec)
 		sysfs_remove_bin_file(vpd_kobj, &sec->bin_attr);
 		kfree(sec->raw_name);
 		memunmap(sec->baseaddr);
+		sec->enabled = false;
 	}
 
 	return 0;
-- 
2.18.0

