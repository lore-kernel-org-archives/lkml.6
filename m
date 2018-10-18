Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6402DECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 133D221479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJE+cAEx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 133D221479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729871AbeJSCFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:05:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:53336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728780AbeJSCFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:05:08 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C4C321480;
        Thu, 18 Oct 2018 18:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885781;
        bh=wkU0k5EjsSeZNz4u/y25wL0vVv/bo9SlJKjWjyw4zU0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iJE+cAExyVTqc+STvh8695au/f7dy6Laz4fxcwEwXDU5uoWIOOVwzKRy09wfbqDU/
         6m6UR3PWPRVAJgdjWA3zZeuMaJR/yY+ktyCau3wHdQbwZdqu5zgXZU5Ige5mrZfA25
         hyQLH+g/Lk9neyOmZlxKRxvgbbdki7PehGS19e84=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 18/35] net/mlx4: Use cpumask_available for eq->affinity_mask
Date:   Thu, 18 Oct 2018 19:54:47 +0200
Message-Id: <20181018175425.459090049@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175422.506152522@linuxfoundation.org>
References: <20181018175422.506152522@linuxfoundation.org>
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

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit 8ac1ee6f4d62e781e3b3fd8b9c42b70371427669 ]

Clang warns that the address of a pointer will always evaluated as true
in a boolean context:

drivers/net/ethernet/mellanox/mlx4/eq.c:243:11: warning: address of
array 'eq->affinity_mask' will always evaluate to 'true'
[-Wpointer-bool-conversion]
        if (!eq->affinity_mask || cpumask_empty(eq->affinity_mask))
            ~~~~~^~~~~~~~~~~~~
1 warning generated.

Use cpumask_available, introduced in commit f7e30f01a9e2 ("cpumask: Add
helper cpumask_available()"), which does the proper checking and avoids
this warning.

Link: https://github.com/ClangBuiltLinux/linux/issues/86
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx4/eq.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlx4/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx4/eq.c
@@ -240,7 +240,8 @@ static void mlx4_set_eq_affinity_hint(st
 	struct mlx4_dev *dev = &priv->dev;
 	struct mlx4_eq *eq = &priv->eq_table.eq[vec];
 
-	if (!eq->affinity_mask || cpumask_empty(eq->affinity_mask))
+	if (!cpumask_available(eq->affinity_mask) ||
+	    cpumask_empty(eq->affinity_mask))
 		return;
 
 	hint_err = irq_set_affinity_hint(eq->irq, eq->affinity_mask);


