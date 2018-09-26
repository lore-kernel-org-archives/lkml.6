Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA53C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F383320666
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:52:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F383320666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbeI0AG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 20:06:29 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:59528 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726230AbeI0AG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 20:06:29 -0400
Received: from mr2.cc.vt.edu (smtp.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id w8QHqPko020077
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 13:52:25 -0400
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        by mr2.cc.vt.edu (8.14.7/8.14.7) with ESMTP id w8QHqKuN016315
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 13:52:25 -0400
Received: by mail-qk1-f197.google.com with SMTP id z18-v6so30518583qki.22
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 10:52:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:mime-version:date:message-id;
        bh=a+4KZr3g7B3gHfEtkxVFtF6VAXDE3THDzJn6J2IcO+Q=;
        b=uLOnriuyOdN23kAQxpZ+06rTWdBbegQhnyDzeGw9oa1FAlwHTV+tsJWNZ8fGnZXgNn
         6SMuF7fFrCPC22AD+ncKR1FZLtw8Z4GbaZzxTdpBQczfPwLf+ugujrl8H1jeKTqwc+kb
         YXBN0TjrYeSNH4NiXnj3dSrPFCb6GJlgnqTp0SAfnNoELbHJayVQV6F1inO3H2G+metb
         TYKgYX6B9CTiuLCQeWPybcLBKLKYnesELYHAJkHzsFnkO+H3sch9ArszhHdV18MN5fMG
         1dhTxThWTYGOHv699RfS3qPYdlHYjnlDfBwSMZrabGWSM7ODx037pr+F6nqSk4MSd1Oe
         SqGA==
X-Gm-Message-State: ABuFfojdTadjMDaeMKU3G9bhx8lCnpkQ8vBUUIqMNGQG/UVkT0hbEEzj
        V51UJxUF4ndJjBRUsXtdaHmD0W3bd60kQS1w5wNgs5kxYl8D4fNrDIlNdkZP5eh7Xm478d/StD7
        ToGGcPdoljlvj0CxP9fyLPbUmkcxzKGqCfKs=
X-Received: by 2002:a37:d6dc:: with SMTP id p89-v6mr5022243qkl.351.1537984339864;
        Wed, 26 Sep 2018 10:52:19 -0700 (PDT)
X-Google-Smtp-Source: ACcGV60gN0QqK4C0yMT4VWqFZCFC7u8E8jlKsO2vSBRPMan6ByuLc2AOHkw1PugvvL6uFJBevkIeWw==
X-Received: by 2002:a37:d6dc:: with SMTP id p89-v6mr5022224qkl.351.1537984339580;
        Wed, 26 Sep 2018 10:52:19 -0700 (PDT)
Received: from turing-police.cc.vt.edu (turing-police.cc.ipv6.vt.edu. [2001:468:c80:2103:f21f:afff:fe0c:8ada])
        by smtp.gmail.com with ESMTPSA id a8-v6sm3492148qth.43.2018.09.26.10.52.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 10:52:18 -0700 (PDT)
X-Mailer: exmh version 2.8.0 04/21/2017 with nmh-1.7+dev
From:   valdis.kletnieks@vt.edu
To:     gregkh@linuxfoundation.org, John Whitmore <arigead@gmail.com>,
        Kees Cook <keescook@chromium.org>
cc:     kernelnewbies@kernelnewbies.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: [PATCH] fix error handling in drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Wed, 26 Sep 2018 13:52:17 -0400
Message-ID: <13450.1537984337@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

John notes that if the kzalloc of ieee->pHTInfo fails, we fail to call
ieee80211_networks_free().  In addition, that function has an un-needed check
before kfree().

Reported-by: John Whitmore <arigead@gmail.com>
Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
---
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
index 90a097f2cd4e..97ff0371b5bb 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
@@ -78,8 +78,6 @@ static inline int ieee80211_networks_allocate(struct ieee80211_device *ieee)
 
 static inline void ieee80211_networks_free(struct ieee80211_device *ieee)
 {
-	if (!ieee->networks)
-		return;
 	kfree(ieee->networks);
 	ieee->networks = NULL;
 }
@@ -180,6 +178,7 @@ struct net_device *alloc_ieee80211(int sizeof_priv)
 	return dev;
 
  failed:
+	ieee80211_networks_free(ieee);
 	if (dev)
 		free_netdev(dev);
 

