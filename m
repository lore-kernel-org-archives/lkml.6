Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC63C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D78552146D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zEoRwhAg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D78552146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387717AbeK3BdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:33:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:33354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731824AbeK3BdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:33:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EB802145D;
        Thu, 29 Nov 2018 14:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501647;
        bh=92nkkWMo5qQHmGq97ishUOWystyY8x3PIMTUlFNrl8I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zEoRwhAgDiZkpZbQhLMJKdzHSllo+ZLzorN7hVWnMuENVnlcfKqlyS/i97CA/RqFz
         5uv+Ga3JJx9hpVwdJgmBgmrHgrg8HIRs2fLN7x9/2wln8wxjMLWf9KRsvnIpw/slYH
         /n76ZSqAZS9ExMcN1fYhW5uxex1zImAl8iKqH/wQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eran Ben Elisha <eranbe@mellanox.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Tariq Toukan <tariqt@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.14 082/100] net/mlx4_core: Fix wrong calculation of free counters
Date:   Thu, 29 Nov 2018 15:12:52 +0100
Message-Id: <20181129140105.864772116@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140058.768942700@linuxfoundation.org>
References: <20181129140058.768942700@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eran Ben Elisha <eranbe@mellanox.com>

commit 0bb9fc4f5429ac970181c073aa32e521e20f7b73 upstream.

The field res_free indicates the total number of counters which are
available for allocation (reserved and unreserved). Fixed a bug where
the reserved counters were subtracted from res_free before any
allocation was performed.

Before this fix, free counters which were not reserved could not be
allocated.

Fixes: 9de92c60beaa ("net/mlx4_core: Adjust counter grant policy in the resource tracker")
Signed-off-by: Eran Ben Elisha <eranbe@mellanox.com>
Reviewed-by: Jack Morgenstein <jackm@dev.mellanox.co.il>
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/mellanox/mlx4/resource_tracker.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlx4/resource_tracker.c
+++ b/drivers/net/ethernet/mellanox/mlx4/resource_tracker.c
@@ -611,7 +611,6 @@ int mlx4_init_resource_tracker(struct ml
 						MLX4_MAX_PORTS;
 				else
 					res_alloc->guaranteed[t] = 0;
-				res_alloc->res_free -= res_alloc->guaranteed[t];
 				break;
 			default:
 				break;


