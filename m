Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79C0C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ACD220877
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:05:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ACD220877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731066AbeIXSHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:07:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54000 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730743AbeIXSHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:07:36 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C3E051086;
        Mon, 24 Sep 2018 12:05:47 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 082/111] ARM: hisi: check of_iomap and fix missing of_node_put
Date:   Mon, 24 Sep 2018 13:52:49 +0200
Message-Id: <20180924113112.996931883@linuxfoundation.org>
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

[ Upstream commit 81646a3d39ef14749301374a3a0b8311384cd412 ]

of_find_compatible_node() returns a device node with refcount incremented
and thus needs an explicit of_node_put(). Further relying on an unchecked
of_iomap() which can return NULL is problematic here, after all ctrl_base
is critical enough for hix5hd2_set_cpu() to call BUG() if not available
so a check seems mandated here.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
0002 Fixes: commit 06cc5c1d4d73 ("ARM: hisi: enable hix5hd2 SoC")
Signed-off-by: Wei Xu <xuwei5@hisilicon.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/mach-hisi/hotplug.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

--- a/arch/arm/mach-hisi/hotplug.c
+++ b/arch/arm/mach-hisi/hotplug.c
@@ -180,11 +180,15 @@ static bool hix5hd2_hotplug_init(void)
 	struct device_node *np;
 
 	np = of_find_compatible_node(NULL, NULL, "hisilicon,cpuctrl");
-	if (np) {
-		ctrl_base = of_iomap(np, 0);
-		return true;
-	}
-	return false;
+	if (!np)
+		return false;
+
+	ctrl_base = of_iomap(np, 0);
+	of_node_put(np);
+	if (!ctrl_base)
+		return false;
+
+	return true;
 }
 
 void hix5hd2_set_cpu(int cpu, bool enable)


