Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEDEC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 650C62084C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZzb2/jU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 650C62084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbeKCEAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:00:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:56004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbeKCEAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:00:14 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EA272082D;
        Fri,  2 Nov 2018 18:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184719;
        bh=BIhuO/CsvpqwsV3tVq1Mee/QHaVeygD2nbi5GvmPn6g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rZzb2/jUR3SbGgKT/u9RAJ4w9a3NGkm3mfkRcxifzn6z1kTk5fYU4RbKCOAhm84L7
         xrMVBkWfIik2dDmia+TxXBDt2MVAtXsIe4hqPbSfK6mtqWLEF73LcXq4bTOX1IT1Je
         nuzGye/jOXqciuaxGqe/Npuzpsq/zKbjip/PEqSg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 079/143] xen-netfront: Fix mismatched rtnl_unlock
Date:   Fri,  2 Nov 2018 19:34:24 +0100
Message-Id: <20181102182903.868672916@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
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

[ Upstream commit cb257783c2927b73614b20f915a91ff78aa6f3e8 ]

Fixes: f599c64fdf7d ("xen-netfront: Fix race between device setup and open")
Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/xen-netfront.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index ca239912c0e6..6ea95b316256 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -1824,7 +1824,7 @@ static int talk_to_netback(struct xenbus_device *dev,
 	err = xen_net_read_mac(dev, info->netdev->dev_addr);
 	if (err) {
 		xenbus_dev_fatal(dev, err, "parsing %s/mac", dev->nodename);
-		goto out;
+		goto out_unlocked;
 	}
 
 	rtnl_lock();
@@ -1939,6 +1939,7 @@ abort_transaction_no_dev_fatal:
 	xennet_destroy_queues(info);
  out:
 	rtnl_unlock();
+out_unlocked:
 	device_unregister(&dev->dev);
 	return err;
 }
-- 
2.17.1



