Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4168CC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3B5422419
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NgUuWJMc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3B5422419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388385AbeKLIUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:20:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:42802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388369AbeKLIUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:20:06 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD85421508;
        Sun, 11 Nov 2018 22:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975409;
        bh=EzLepFE8phPPmUjvQ222Wys6IRNuHwf9AgiM6UWbf9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NgUuWJMcfLJlWbCXgEtIXJTFxvVqNaMoOEADzvwZZnUQuUYgxDmXTSRsalMQyjbO4
         7VJPj+IEv0oO3x72RCEM3jVVJxlNk5IxV+jAuoxgJCFB7TABCwqqLBDkAggiA0FPYj
         GEFSkkqb8gLSvSbmvBD7NF8XpMcNMlxR21jvFLdU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Sridhar Samudrala <sridhar.samudrala@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 118/350] failover: Add missing check to validate slave_dev in net_failover_slave_unregister
Date:   Sun, 11 Nov 2018 14:19:42 -0800
Message-Id: <20181111221712.075740451@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
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
@@ -602,6 +602,9 @@ static int net_failover_slave_unregister
 	primary_dev = rtnl_dereference(nfo_info->primary_dev);
 	standby_dev = rtnl_dereference(nfo_info->standby_dev);
 
+	if (WARN_ON_ONCE(slave_dev != primary_dev && slave_dev != standby_dev))
+		return -ENODEV;
+
 	vlan_vids_del_by_dev(slave_dev, failover_dev);
 	dev_uc_unsync(slave_dev, failover_dev);
 	dev_mc_unsync(slave_dev, failover_dev);


