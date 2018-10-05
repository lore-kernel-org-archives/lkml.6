Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F43C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 13:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0304C2087D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 13:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="TLO6k9B4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0304C2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbeJEUrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 16:47:35 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:45740 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728278AbeJEUrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 16:47:35 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 207B71285
        for <linux-kernel@vger.kernel.org>; Fri,  5 Oct 2018 13:48:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uL7Ys6GKfChM for <linux-kernel@vger.kernel.org>;
        Fri,  5 Oct 2018 08:48:45 -0500 (CDT)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id E478A1282
        for <linux-kernel@vger.kernel.org>; Fri,  5 Oct 2018 08:48:45 -0500 (CDT)
Received: by mail-io1-f69.google.com with SMTP id f9-v6so11852504iok.23
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 06:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=0dZpWj3p4D/Wr5ddvWM/V1YBp7qnAV17Poea5d3zSNk=;
        b=TLO6k9B4s0AoJwAoeCwtDncn64Olt2lcRK42MRPNiC43kgoLHBCnbAnztOmWYSiWx0
         y/MKXtqhrxt1Y1fLV5iMnmTMMGVL/sosvNv/sMTFy6j8SPgsj0bwA4ymSrg40vn3tWY8
         Hby6ja7eIalZbhQInHCwhvEeMRWLS1UYMzwtSpybsk+klw4ritDDtGGSAj+xBBr2IxnC
         jEeqpBiqnlP2n2m45B1UEggiCYnfQx3QA4H0uGwPOXlkFR4c0GYwOZVFLI5Q2V/4K/oe
         VPwX+nsce5qFeGgtlMlPVUZKejK323LzBtn4keVEtL+xigRqyfUylNH3cxgyG3f8V4YX
         3yOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0dZpWj3p4D/Wr5ddvWM/V1YBp7qnAV17Poea5d3zSNk=;
        b=cRk9Bz/ua+amCwf3pvu82372kpomrPG2bT1IiXNlpgV3925IAqxh43Dass3c6bk79n
         E10HznMz2oYKvfk7kYB0xIdYlCu8JXlGRXIgUgrp/ivexjOZd+0OtTqXa7FiTD25S8oQ
         imb5yULJm4AKM7SibIiaKEeqilkf016n/VX6eblGap10dg/kZwW5X1QmKx+20a3202GI
         NJArHRahAsUNrh0T/V3GE6MjhPcQ9Zzz0gFYif54anwDxJyYKueuGvm5WWffm6rLwPCA
         wS1fyNXUrFsUKkEkZ15B2ztv79AtSzcTfphuqiDDEbkW3wet1+bZ+r9t5NZKJokobLDA
         B23Q==
X-Gm-Message-State: ABuFfoihXC2G7Zfmv5E7W6qDiygM4CQ31ZPGpW9IMfXp+8xE3K3jbhrq
        kFX7JXWPP5LLRanuZEZsLVgNPaUm1LvoD3rX3Kza0Sm+Fh9M7owBA1MAQKz98AmkpHdtHPnixLv
        GlQURMrLeBDo/EDaiX7T0S32kWueA
X-Received: by 2002:a6b:7a05:: with SMTP id h5-v6mr7241049iom.89.1538747325554;
        Fri, 05 Oct 2018 06:48:45 -0700 (PDT)
X-Google-Smtp-Source: ACcGV63HWh5AFnAa1H5eGkZ3uVqrIn5IG3iVHW4gKhfEZKU/JxqH2Pf1myysosiToDk048xQ2MWw5Q==
X-Received: by 2002:a6b:7a05:: with SMTP id h5-v6mr7241037iom.89.1538747325317;
        Fri, 05 Oct 2018 06:48:45 -0700 (PDT)
Received: from cs-u-cslp16.cs.umn.edu (cs-u-cslp16.cs.umn.edu. [134.84.121.95])
        by smtp.gmail.com with ESMTPSA id q185-v6sm674001itc.30.2018.10.05.06.48.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Oct 2018 06:48:44 -0700 (PDT)
From:   Wenwen Wang <wang6495@umn.edu>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>, Santosh Raspatur <santosh@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        netdev@vger.kernel.org (open list:CXGB3 ETHERNET DRIVER (CXGB3)),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] net: cxgb3_main: fix a missing-check bug
Date:   Fri,  5 Oct 2018 08:48:27 -0500
Message-Id: <1538747307-21403-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In cxgb_extension_ioctl(), the command of the ioctl is firstly copied from
the user-space buffer 'useraddr' to 'cmd' and checked through the
switch statement. If the command is not as expected, an error code
EOPNOTSUPP is returned. In the following execution, i.e., the cases of the
switch statement, the whole buffer of 'useraddr' is copied again to a
specific data structure, according to what kind of command is requested.
However, after the second copy, there is no re-check on the newly-copied
command. Given that the buffer 'useraddr' is in the user space, a malicious
user can race to change the command between the two copies. By doing so,
the attacker can supply malicious data to the kernel and cause undefined
behavior.

This patch adds a re-check in each case of the switch statement if there is
a second copy in that case, to re-check whether the command obtained in the
second copy is the same as the one in the first copy. If not, an error code
EINVAL is returned.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
index a19172d..c34ea38 100644
--- a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
@@ -2159,6 +2159,8 @@ static int cxgb_extension_ioctl(struct net_device *dev, void __user *useraddr)
 			return -EPERM;
 		if (copy_from_user(&t, useraddr, sizeof(t)))
 			return -EFAULT;
+		if (t.cmd != CHELSIO_SET_QSET_PARAMS)
+			return -EINVAL;
 		if (t.qset_idx >= SGE_QSETS)
 			return -EINVAL;
 		if (!in_range(t.intr_lat, 0, M_NEWTIMER) ||
@@ -2258,6 +2260,9 @@ static int cxgb_extension_ioctl(struct net_device *dev, void __user *useraddr)
 		if (copy_from_user(&t, useraddr, sizeof(t)))
 			return -EFAULT;
 
+		if (t.cmd != CHELSIO_GET_QSET_PARAMS)
+			return -EINVAL;
+
 		/* Display qsets for all ports when offload enabled */
 		if (test_bit(OFFLOAD_DEVMAP_BIT, &adapter->open_device_map)) {
 			q1 = 0;
@@ -2303,6 +2308,8 @@ static int cxgb_extension_ioctl(struct net_device *dev, void __user *useraddr)
 			return -EBUSY;
 		if (copy_from_user(&edata, useraddr, sizeof(edata)))
 			return -EFAULT;
+		if (edata.cmd != CHELSIO_SET_QSET_NUM)
+			return -EINVAL;
 		if (edata.val < 1 ||
 			(edata.val > 1 && !(adapter->flags & USING_MSIX)))
 			return -EINVAL;
@@ -2343,6 +2350,8 @@ static int cxgb_extension_ioctl(struct net_device *dev, void __user *useraddr)
 			return -EPERM;
 		if (copy_from_user(&t, useraddr, sizeof(t)))
 			return -EFAULT;
+		if (t.cmd != CHELSIO_LOAD_FW)
+			return -EINVAL;
 		/* Check t.len sanity ? */
 		fw_data = memdup_user(useraddr + sizeof(t), t.len);
 		if (IS_ERR(fw_data))
@@ -2366,6 +2375,8 @@ static int cxgb_extension_ioctl(struct net_device *dev, void __user *useraddr)
 			return -EBUSY;
 		if (copy_from_user(&m, useraddr, sizeof(m)))
 			return -EFAULT;
+		if (m.cmd != CHELSIO_SETMTUTAB)
+			return -EINVAL;
 		if (m.nmtus != NMTUS)
 			return -EINVAL;
 		if (m.mtus[0] < 81)	/* accommodate SACK */
@@ -2407,6 +2418,8 @@ static int cxgb_extension_ioctl(struct net_device *dev, void __user *useraddr)
 			return -EBUSY;
 		if (copy_from_user(&m, useraddr, sizeof(m)))
 			return -EFAULT;
+		if (m.cmd != CHELSIO_SET_PM)
+			return -EINVAL;
 		if (!is_power_of_2(m.rx_pg_sz) ||
 			!is_power_of_2(m.tx_pg_sz))
 			return -EINVAL;	/* not power of 2 */
@@ -2440,6 +2453,8 @@ static int cxgb_extension_ioctl(struct net_device *dev, void __user *useraddr)
 			return -EIO;	/* need the memory controllers */
 		if (copy_from_user(&t, useraddr, sizeof(t)))
 			return -EFAULT;
+		if (t.cmd != CHELSIO_GET_MEM)
+			return -EINVAL;
 		if ((t.addr & 7) || (t.len & 7))
 			return -EINVAL;
 		if (t.mem_id == MEM_CM)
@@ -2492,6 +2507,8 @@ static int cxgb_extension_ioctl(struct net_device *dev, void __user *useraddr)
 			return -EAGAIN;
 		if (copy_from_user(&t, useraddr, sizeof(t)))
 			return -EFAULT;
+		if (t.cmd != CHELSIO_SET_TRACE_FILTER)
+			return -EINVAL;
 
 		tp = (const struct trace_params *)&t.sip;
 		if (t.config_tx)
-- 
2.7.4

