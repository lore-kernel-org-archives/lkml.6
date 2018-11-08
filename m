Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20030C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0FCB20818
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qiIkmS3q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0FCB20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730502AbeKIICE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 03:02:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:34486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730387AbeKIHmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:42:36 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DDEA2086C;
        Thu,  8 Nov 2018 22:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714706;
        bh=t031WiWdkzihlwvrToUYUpmpj9dD01vZZ0IrVGJPd3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qiIkmS3qiWi4B4KwDDvpSUiksJ11YTaKy3Uw3H+lai2UhcYz9YzfX5To5oq95ZDza
         mW1mHwNPMe4/7p2j2FfJdnliRlb5MjNtJolTEhkCxJoSEUDKq8+VwWuYWRTuBmQuI6
         l/DYfCG6FRDo5/uO+9p+3+g9shAPDIsdtVFcHQNg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Moshe Shemesh <moshe@mellanox.com>,
        kernel-team@fb.com, Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 051/171] net/mlx5: Fix command completion after timeout access invalid structure
Date:   Thu,  8 Nov 2018 13:50:21 -0800
Message-Id: <20181108215131.205451114@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
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

[ Upstream commit 061870800efb4e3d1ad4082a2569363629bdfcfc ]

Completion on timeout should not free the driver command entry structure
as it will need to access it again once real completion event from FW
will occur.

Fixes: 73dd3a4839c1 ('net/mlx5: Avoid using pending command interface slots')
Signed-off-by: Moshe Shemesh <moshe@mellanox.com>
Cc: kernel-team@fb.com
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
index 9680c8805178..1d5263c46eee 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -965,7 +965,7 @@ static int mlx5_cmd_invoke(struct mlx5_core_dev *dev, struct mlx5_cmd_msg *in,
 
 	err = wait_func(dev, ent);
 	if (err == -ETIMEDOUT)
-		goto out_free;
+		goto out;
 
 	ds = ent->ts2 - ent->ts1;
 	op = MLX5_GET(mbox_in, in->first.data, opcode);
@@ -1428,6 +1428,7 @@ void mlx5_cmd_comp_handler(struct mlx5_core_dev *dev, u64 vec, bool forced)
 					mlx5_core_err(dev, "Command completion arrived after timeout (entry idx = %d).\n",
 						      ent->idx);
 					free_ent(cmd, ent->idx);
+					free_cmd(ent);
 				}
 				continue;
 			}
@@ -1486,7 +1487,8 @@ void mlx5_cmd_comp_handler(struct mlx5_core_dev *dev, u64 vec, bool forced)
 				free_msg(dev, ent->in);
 
 				err = err ? err : ent->status;
-				free_cmd(ent);
+				if (!forced)
+					free_cmd(ent);
 				callback(err, context);
 			} else {
 				complete(&ent->done);
-- 
2.17.1



