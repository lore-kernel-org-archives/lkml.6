Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E51ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EFF52088F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:44:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EFF52088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbeIRENy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:13:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43144 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728681AbeIRENy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:13:54 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9BF95C9D;
        Mon, 17 Sep 2018 22:44:29 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anton Vasilyev <vasilyev@ispras.ru>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 20/56] misc: ti-st: Fix memory leak in the error path of probe()
Date:   Tue, 18 Sep 2018 00:41:53 +0200
Message-Id: <20180917213828.790703254@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917213827.913122591@linuxfoundation.org>
References: <20180917213827.913122591@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anton Vasilyev <vasilyev@ispras.ru>

[ Upstream commit 81ae962d7f180c0092859440c82996cccb254976 ]

Free resources instead of direct return of the error code if kim_probe
fails.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/ti-st/st_kim.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/misc/ti-st/st_kim.c
+++ b/drivers/misc/ti-st/st_kim.c
@@ -757,14 +757,14 @@ static int kim_probe(struct platform_dev
 	err = gpio_request(kim_gdata->nshutdown, "kim");
 	if (unlikely(err)) {
 		pr_err(" gpio %d request failed ", kim_gdata->nshutdown);
-		return err;
+		goto err_sysfs_group;
 	}
 
 	/* Configure nShutdown GPIO as output=0 */
 	err = gpio_direction_output(kim_gdata->nshutdown, 0);
 	if (unlikely(err)) {
 		pr_err(" unable to configure gpio %d", kim_gdata->nshutdown);
-		return err;
+		goto err_sysfs_group;
 	}
 	/* get reference of pdev for request_firmware
 	 */


