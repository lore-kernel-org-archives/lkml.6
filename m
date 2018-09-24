Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C0BECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DCC920877
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:05:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DCC920877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731020AbeIXSHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:07:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53988 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730508AbeIXSHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:07:32 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 913F11080;
        Mon, 24 Sep 2018 12:05:44 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 081/111] ARM: hisi: fix error handling and missing of_node_put
Date:   Mon, 24 Sep 2018 13:52:48 +0200
Message-Id: <20180924113112.900060105@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.337261320@linuxfoundation.org>
References: <20180924113103.337261320@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Mc Guire <hofrat@osadl.org>

[ Upstream commit 9f30b5ae0585ca5234fe979294b8f897299dec99 ]

of_iomap() can return NULL which seems critical here and thus should be
explicitly flagged so that the cause of system halting can be understood.
As of_find_compatible_node() is returning a device node with refcount
incremented it must be explicitly decremented here.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: commit 7fda91e73155 ("ARM: hisi: enable smp for HiP01")
Signed-off-by: Wei Xu <xuwei5@hisilicon.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/mach-hisi/hotplug.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/arm/mach-hisi/hotplug.c
+++ b/arch/arm/mach-hisi/hotplug.c
@@ -226,10 +226,10 @@ void hip01_set_cpu(int cpu, bool enable)
 
 	if (!ctrl_base) {
 		np = of_find_compatible_node(NULL, NULL, "hisilicon,hip01-sysctrl");
-		if (np)
-			ctrl_base = of_iomap(np, 0);
-		else
-			BUG();
+		BUG_ON(!np);
+		ctrl_base = of_iomap(np, 0);
+		of_node_put(np);
+		BUG_ON(!ctrl_base);
 	}
 
 	if (enable) {


