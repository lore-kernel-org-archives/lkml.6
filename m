Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81193C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50ACB2147C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131764;
	bh=GJUgN9lEx/05OdjJxNJmirft6BBe9yXHEokdCrdDAW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2YcInNMloep1NDsdV2/zFwIixFjvng9EzMMNiFumKULI2fW9wzSsn+1poVtRo9WlS
	 mkO3QbXiSLuFqiGAoIcJ2WH3LcMvsQa/IyovOuc4xYNoilDcu9voq05aBhxvMuHl0P
	 zDmY9qXYrEZZa7jJwt3m7bQVsfJkBsP/aW4/2p1c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730915AbfBYV4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:56:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:55430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727095AbfBYVVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:21:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB0A721848;
        Mon, 25 Feb 2019 21:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129696;
        bh=GJUgN9lEx/05OdjJxNJmirft6BBe9yXHEokdCrdDAW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jiDCesg3dM2T1brISM5LqL5HUoBXTRJob/KyUA/ezTwyDpSWHmUMb5wXcIuK5UO/U
         3IyiEN52wBr9gElEVhLjoCUbi/Pde3aJ+gZpyb6NWfRLx5FEy0eiVMcgr+vwmWtgu7
         czlQFI26GHYKtMC4oabPI+hrh7ev1K17/OV+ST2s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefano Stabellini <stefanos@xilinx.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 021/152] pvcalls-back: set -ENOTCONN in pvcalls_conn_back_read
Date:   Mon, 25 Feb 2019 22:10:13 +0100
Message-Id: <20190225195045.121154446@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit e6587cdbd732eacb4c7ce592ed46f7bbcefb655f ]

When a connection is closing we receive on pvcalls_sk_state_change
notification. Instead of setting the connection as closed immediately
(-ENOTCONN), let's read one more time from it: pvcalls_conn_back_read
will set the connection as closed when necessary.

That way, we avoid races between pvcalls_sk_state_change and
pvcalls_back_ioworker.

Signed-off-by: Stefano Stabellini <stefanos@xilinx.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/pvcalls-back.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/xen/pvcalls-back.c b/drivers/xen/pvcalls-back.c
index b1092fbefa630..e8b3ff8e7868b 100644
--- a/drivers/xen/pvcalls-back.c
+++ b/drivers/xen/pvcalls-back.c
@@ -160,9 +160,10 @@ static void pvcalls_conn_back_read(void *opaque)
 
 	/* write the data, then modify the indexes */
 	virt_wmb();
-	if (ret < 0)
+	if (ret < 0) {
+		atomic_set(&map->read, 0);
 		intf->in_error = ret;
-	else
+	} else
 		intf->in_prod = prod + ret;
 	/* update the indexes, then notify the other end */
 	virt_wmb();
@@ -288,7 +289,7 @@ static void pvcalls_sk_state_change(struct sock *sock)
 		return;
 
 	intf = map->ring;
-	intf->in_error = -ENOTCONN;
+	atomic_inc(&map->read);
 	notify_remote_via_irq(map->irq);
 }
 
-- 
2.19.1



