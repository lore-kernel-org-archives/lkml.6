Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E88C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D639F20871
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RlXwxjQv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D639F20871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731832AbeKLKBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 05:01:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:60278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730704AbeKLIRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:17:24 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D111215EA;
        Sun, 11 Nov 2018 22:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975249;
        bh=e/bIhPxoE2ySsFZe0BEakIHjmRQ+RQ1Sb/jsTwa/940=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RlXwxjQvbWCz8GhxeS1esNYhM4j9fgHGkt32+C+WoieCO1mg4q+AR09TE00zTE2Rr
         44rYYeg56i0waaY8gN7iG9Azcn5Hyamc78o+mCUVjkkVD2S0bPoY7rWgayjD3UhU2D
         MJ0450YV5Gy64dcX3aYMTsdFBGb0wy1dmds/l1FM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Sridhar Samudrala <sridhar.samudrala@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 110/361] failover: Add missing check to validate slave_dev in net_failover_slave_unregister
Date:   Sun, 11 Nov 2018 14:17:37 -0800
Message-Id: <20181111221635.102448420@linuxfoundation.org>
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

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 9e7e6cabf371cc008cb2244a04c012b516753693 ]

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/net/net_failover.c: In function 'net_failover_slave_unregister':
drivers/net/net_failover.c:598:35: warning:
 variable 'primary_dev' set but not used [-Wunused-but-set-variable]

There should check the validity of 'slave_dev'.

Fixes: cfc80d9a1163 ("net: Introduce net_failover driver")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/net_failover.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/net_failover.c
+++ b/drivers/net/net_failover.c
@@ -603,6 +603,9 @@ static int net_failover_slave_unregister
 	primary_dev = rtnl_dereference(nfo_info->primary_dev);
 	standby_dev = rtnl_dereference(nfo_info->standby_dev);
 
+	if (WARN_ON_ONCE(slave_dev != primary_dev && slave_dev != standby_dev))
+		return -ENODEV;
+
 	vlan_vids_del_by_dev(slave_dev, failover_dev);
 	dev_uc_unsync(slave_dev, failover_dev);
 	dev_mc_unsync(slave_dev, failover_dev);


