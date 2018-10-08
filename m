Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBDAC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7C1A20645
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="s7Hx7kur"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7C1A20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732501AbeJICFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:05:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727260AbeJICFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:05:24 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 249E3204FD;
        Mon,  8 Oct 2018 18:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024736;
        bh=yWtEXh+rqVE5W+5xSwyjkvxXPUef7qmXGDmd10ktSGE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s7Hx7kurjhiZHU9xaLZJrRsNrtGAOKKxcouGVgQ9OuX7AL5E7giQAEPRwvQ+nMaUJ
         GUzXFcO/ss+XYiHWjDd9KgX64EdMnqKpHKKSl1WOVJA2GQro6iiTKSABu7fXeWy6xX
         kdRPwDoF0YGQxP7t1zzccbc3obz6K15HDq/UMH7w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenjia Zhang <wenjia@linux.ibm.com>,
        Julian Wiedmann <jwi@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 136/168] s390/qeth: use vzalloc for QUERY OAT buffer
Date:   Mon,  8 Oct 2018 20:31:56 +0200
Message-Id: <20181008175625.213889200@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
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

From: Wenjia Zhang <wenjia@linux.ibm.com>

[ Upstream commit aec45e857c5538664edb76a60dd452e3265f37d1 ]

qeth_query_oat_command() currently allocates the kernel buffer for
the SIOC_QETH_QUERY_OAT ioctl with kzalloc. So on systems with
fragmented memory, large allocations may fail (eg. the qethqoat tool by
default uses 132KB).

Solve this issue by using vzalloc, backing the allocation with
non-contiguous memory.

Signed-off-by: Wenjia Zhang <wenjia@linux.ibm.com>
Reviewed-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/net/qeth_core_main.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -25,6 +25,7 @@
 #include <linux/netdevice.h>
 #include <linux/netdev_features.h>
 #include <linux/skbuff.h>
+#include <linux/vmalloc.h>
 
 #include <net/iucv/af_iucv.h>
 #include <net/dsfield.h>
@@ -4738,7 +4739,7 @@ static int qeth_query_oat_command(struct
 
 	priv.buffer_len = oat_data.buffer_len;
 	priv.response_len = 0;
-	priv.buffer =  kzalloc(oat_data.buffer_len, GFP_KERNEL);
+	priv.buffer = vzalloc(oat_data.buffer_len);
 	if (!priv.buffer) {
 		rc = -ENOMEM;
 		goto out;
@@ -4779,7 +4780,7 @@ static int qeth_query_oat_command(struct
 			rc = -EFAULT;
 
 out_free:
-	kfree(priv.buffer);
+	vfree(priv.buffer);
 out:
 	return rc;
 }


