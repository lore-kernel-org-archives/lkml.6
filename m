Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BF3C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 879242084D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTzqRTiF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 879242084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbeKCDxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:53:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:49194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729726AbeKCDxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:53:32 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACDBA2084A;
        Fri,  2 Nov 2018 18:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184319;
        bh=lRPzoeZ4eCJf6uQ/H9CWi259RBT00djbNBBO+HCbF9k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CTzqRTiFXVl5vG5GzE0afky/AasQMX6Dv/1kuVBrrgqHhM/0ftXQIYch8eLmk0vkZ
         Jc3Z+IRfVEnzQr423yVEkPCGweG6rV07ykkO8CFrhDYdqhcw9ttb2Ay4J7ZHqd3rSd
         x+Z+Si+k4uXzqmqVL3PWn9MVQ+Z54lqc0swG7gT0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Talat Batheesh <talatb@mellanox.com>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.18 134/150] net/mlx5: Fix memory leak when setting fpga ipsec caps
Date:   Fri,  2 Nov 2018 19:34:56 +0100
Message-Id: <20181102182912.006225198@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
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

From: Talat Batheesh <talatb@mellanox.com>

[ Upstream commit fd7e848077c1a466b9187537adce16658f7cb94b ]

Allocated memory for context should be freed once
finished working with it.

Fixes: d6c4f0298cec ("net/mlx5: Refactor accel IPSec code")
Signed-off-by: Talat Batheesh <talatb@mellanox.com>
Reviewed-by: Or Gerlitz <ogerlitz@mellanox.com>
Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/fpga/ipsec.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/fpga/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fpga/ipsec.c
@@ -245,7 +245,7 @@ static void *mlx5_fpga_ipsec_cmd_exec(st
 		return ERR_PTR(res);
 	}
 
-	/* Context will be freed by wait func after completion */
+	/* Context should be freed by the caller after completion. */
 	return context;
 }
 
@@ -418,10 +418,8 @@ static int mlx5_fpga_ipsec_set_caps(stru
 	cmd.cmd = htonl(MLX5_FPGA_IPSEC_CMD_OP_SET_CAP);
 	cmd.flags = htonl(flags);
 	context = mlx5_fpga_ipsec_cmd_exec(mdev, &cmd, sizeof(cmd));
-	if (IS_ERR(context)) {
-		err = PTR_ERR(context);
-		goto out;
-	}
+	if (IS_ERR(context))
+		return PTR_ERR(context);
 
 	err = mlx5_fpga_ipsec_cmd_wait(context);
 	if (err)
@@ -435,6 +433,7 @@ static int mlx5_fpga_ipsec_set_caps(stru
 	}
 
 out:
+	kfree(context);
 	return err;
 }
 


