Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675E3ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 145AA214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:10:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 145AA214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732133AbeIREkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:40:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50338 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729160AbeIREkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:40:02 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 596D8C49;
        Mon, 17 Sep 2018 23:10:31 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anton Vasilyev <vasilyev@ispras.ru>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 071/158] firmware: vpd: Fix section enabled flag on vpd_section_destroy
Date:   Tue, 18 Sep 2018 00:41:41 +0200
Message-Id: <20180917211714.530065667@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211710.383360696@linuxfoundation.org>
References: <20180917211710.383360696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anton Vasilyev <vasilyev@ispras.ru>

[ Upstream commit 45ca3f76de0507ecf143f770570af2942f263812 ]

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
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/firmware/google/vpd.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/firmware/google/vpd.c
+++ b/drivers/firmware/google/vpd.c
@@ -246,6 +246,7 @@ static int vpd_section_destroy(struct vp
 		sysfs_remove_bin_file(vpd_kobj, &sec->bin_attr);
 		kfree(sec->raw_name);
 		memunmap(sec->baseaddr);
+		sec->enabled = false;
 	}
 
 	return 0;
@@ -279,8 +280,10 @@ static int vpd_sections_init(phys_addr_t
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


