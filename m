Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E770EC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B17382064A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8efyyJO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B17382064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbeJIByA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:54:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:41394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726868AbeJIBx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:53:59 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2B112087D;
        Mon,  8 Oct 2018 18:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024055;
        bh=T6MkDpFjmA3nVsyR5E82UthXt2KPKNEWLjFc47ZCiV0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P8efyyJO/VdquBjsGTSePEsp1AoveSwTTZCNKN0jfIhhstddCdcFMT8i4U9A+rI7u
         7/XejrbDflaSt7TqEB+MTkrrgoxekxRK9cBFwI1qVE7AhYGWY1PCRqS2rFLqPv9ACM
         APlGefCawMucGInmYz7f8f0fJOY76ojZjatQDwlU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenjia Zhang <wenjia@linux.ibm.com>,
        Julian Wiedmann <jwi@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 46/59] s390/qeth: use vzalloc for QUERY OAT buffer
Date:   Mon,  8 Oct 2018 20:31:53 +0200
Message-Id: <20181008175551.597458613@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175546.620836256@linuxfoundation.org>
References: <20181008175546.620836256@linuxfoundation.org>
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
@@ -23,6 +23,7 @@
 #include <linux/netdevice.h>
 #include <linux/netdev_features.h>
 #include <linux/skbuff.h>
+#include <linux/vmalloc.h>
 
 #include <net/iucv/af_iucv.h>
 #include <net/dsfield.h>
@@ -4715,7 +4716,7 @@ int qeth_query_oat_command(struct qeth_c
 
 	priv.buffer_len = oat_data.buffer_len;
 	priv.response_len = 0;
-	priv.buffer =  kzalloc(oat_data.buffer_len, GFP_KERNEL);
+	priv.buffer = vzalloc(oat_data.buffer_len);
 	if (!priv.buffer) {
 		rc = -ENOMEM;
 		goto out;
@@ -4756,7 +4757,7 @@ int qeth_query_oat_command(struct qeth_c
 			rc = -EFAULT;
 
 out_free:
-	kfree(priv.buffer);
+	vfree(priv.buffer);
 out:
 	return rc;
 }


