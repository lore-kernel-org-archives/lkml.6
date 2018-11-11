Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92611C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BCA7208A3
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GG3d4phv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BCA7208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732663AbeKLJvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:51:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:34210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732297AbeKLISA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:18:00 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59202223D8;
        Sun, 11 Nov 2018 22:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975284;
        bh=T0I/fiP8MxDEqeXCr8bArPRmdgYV/wZBM6yk1MzQOfA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GG3d4phvY7F/79N/0zUfElQdjVOHepzIpN1o7gfSSELG+nmFb4K3r9c7+hcRBogz3
         KFvOJLinrAsTK0mR+xmloKHgEGhurd1hleM2EvsjpQ1Tx7UZCyahYzcCNl0484invx
         xGYphciae94O23leAyT8WyApD0+FSQ8hsIjcb4dI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arseny Maslennikov <ar@cs.msu.ru>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 178/361] IB/ipoib: Use dev_port to expose network interface port numbers
Date:   Sun, 11 Nov 2018 14:18:45 -0800
Message-Id: <20181111221645.198352297@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arseny Maslennikov <ar@cs.msu.ru>

[ Upstream commit 9b8b2a323008aedd39a8debb861b825707f01420 ]

Some InfiniBand network devices have multiple ports on the same PCI
function. This initializes the `dev_port' sysfs field of those
network interfaces with their port number.

Prior to this the kernel erroneously used the `dev_id' sysfs
field of those network interfaces to convey the port number to userspace.

The use of `dev_id' was considered correct until Linux 3.15,
when another field, `dev_port', was defined for this particular
purpose and `dev_id' was reserved for distinguishing stacked ifaces
(e.g: VLANs) with the same hardware address as their parent device.

Similar fixes to net/mlx4_en and many other drivers, which started
exporting this information through `dev_id' before 3.15, were accepted
into the kernel 4 years ago.
See 76a066f2a2a0 (`net/mlx4_en: Expose port number through sysfs').

Signed-off-by: Arseny Maslennikov <ar@cs.msu.ru>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/ulp/ipoib/ipoib_main.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -1880,6 +1880,8 @@ static int ipoib_parent_init(struct net_
 	       sizeof(union ib_gid));
 
 	SET_NETDEV_DEV(priv->dev, priv->ca->dev.parent);
+	priv->dev->dev_port = priv->port - 1;
+	/* Let's set this one too for backwards compatibility. */
 	priv->dev->dev_id = priv->port - 1;
 
 	return 0;


