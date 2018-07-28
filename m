Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF743C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 09:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 684002088E
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 09:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/WtnQu5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 684002088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbeG1K2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 06:28:14 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42049 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727651AbeG1K2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 06:28:13 -0400
Received: by mail-pg1-f196.google.com with SMTP id y4-v6so4548046pgp.9;
        Sat, 28 Jul 2018 02:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=GkAq7Tj2OeFjuXVMmElzKhccyfcH9hgvMt0rWEL+cho=;
        b=k/WtnQu5e1l2KsohOYSW4szKLytki++ZeJsX3Cnxj+xAK0eFX3Er/EYAJ6b0JNjSEl
         iTxKmb30VW/gFlB2ri0ksN7sETkBbRAQ6213DfFK5kBA9CuCf41xRLQnoAdp3IN/pAn0
         ZLHUuCdVE0otRNXsKMTW9Br7XDm2DeC4G+JTcnhUR0NIg8bRDVXixz5WaAyno1IcMJO/
         nx0+3V7a9Kd4e+HH2p0aRxEBP+bL+A6l1HYvEfQFN7nqajIm9oajOUQv8ianRjW9+zwd
         DvpY/OvLxg7HhGt5Ofz4wm+xx50GkjdEvwLjIpsmgsILpGAhPRuUacVc+UROth72aCie
         W6zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=GkAq7Tj2OeFjuXVMmElzKhccyfcH9hgvMt0rWEL+cho=;
        b=kIpzzr3aSTehVC08GgPcfSF2NZRf1/4vNFOko+GESI+k8IhyVZBHy90ADBnNi+Ir20
         CEGhss2hqf28zKQ3xu7ltJpOoAz91V/3kuOCAanJxzxB5YGiHRj/84pdnvfqEG4xs+zz
         vF3Sux8dI7niQcPydISQNPYaLuwvqQujZt7S5VPRK6KtfTy5M/Nu1tGJ+f2ia7x8SYMd
         FN7snFbqZyncdBBkukyG9O3LKnfx7OZPghRj/WUuxNIuTq9y+UBzw3en8ehx9k37ma6a
         QYtIHccLMV6LuoMDJygMes+cXPZMp4Y+kpy0wig/KvU9ZUu/IiqZvPN+XiQ1gMlzBy80
         0ZFA==
X-Gm-Message-State: AOUpUlFINNBAutPmVfohVSCsJV3rIbKfbe1NK47/C2ZKec8ZYlbnzYGK
        t4MSoTXjk/n+eQ8yPWzQaag=
X-Google-Smtp-Source: AAOMgpeBAoYsW9tJJha7EMDP4KfpSxIyAXPEIIWeIyqIEYPU0BB/wjjzMGITKfvOJjFw++R0gdHCyA==
X-Received: by 2002:a62:9dcc:: with SMTP id a73-v6mr9653262pfk.249.1532768547157;
        Sat, 28 Jul 2018 02:02:27 -0700 (PDT)
Received: from zenus ([106.51.26.178])
        by smtp.gmail.com with ESMTPSA id h24-v6sm12439476pfk.113.2018.07.28.02.02.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 28 Jul 2018 02:02:26 -0700 (PDT)
Date:   Sat, 28 Jul 2018 14:32:21 +0530
From:   Sohil Ladhani <supertakumi86@gmail.com>
To:     davem@davemloft.net
Cc:     nic_swsd@realtek.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sohil Ladhani <supertakumi86@gmail.com>
Subject: [PATCH] net: ethernet: realtek: r8169: Add spaces after commas
 coding style issue
Message-ID: <20180728090217.GA19065@zenus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a coding style issue

Signed-off-by: Sohil Ladhani <supertakumi86@gmail.com>
---
 drivers/net/ethernet/realtek/r8169.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
index f4cae2be0fda..e4754f336c34 100644
--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -61,7 +61,7 @@
 #define assert(expr) \
 	if (!(expr)) {					\
 		printk( "Assertion failed! %s,%s,%s,line=%d\n",	\
-		#expr,__FILE__,__func__,__LINE__);		\
+		#expr, __FILE__, __func__, __LINE__);		\
 	}
 #define dprintk(fmt, args...) \
 	do { printk(KERN_DEBUG PFX fmt, ## args); } while (0)
-- 
2.18.0

