Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.4 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5403FECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB08620858
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5zyRTMl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB08620858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbeGUNsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 09:48:42 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52392 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbeGUNsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 09:48:42 -0400
Received: by mail-wm0-f66.google.com with SMTP id o11-v6so11791450wmh.2
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 05:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=nKhMx2dYCHcoJwFEjfICt8dnp8R2K/LIpk7CkmaNJvY=;
        b=k5zyRTMlO+cb71AXqiBDWDHbE7JJBlm0VmmpM7TeRhgi5Dtc/w3Lflll+anw0/q9ef
         xdEiG/T2Hl+4xCbi3i9+V5zlmjXBP4apuSlkjMX1ArlrlfWHvvJdRTt3SUEDgneZPexw
         1b48ral/Ay6V1dENpPHG2wEID++xqgwhPgD6ySpw11netVGB1wiH3yPQJES9p6hVq6D2
         nPkfoewFw8/ZApy/3C7FL427CtCpM+Grblr7a+V3L74hV0DBgUe3jMIlt13bxxxyPvA2
         CZEOqrRT+tCQ1iIU6ga52jYpGkJBio03sg8CtJnsgxjXRYEqM9NiL/OjFEf03PgrxRzW
         5f1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=nKhMx2dYCHcoJwFEjfICt8dnp8R2K/LIpk7CkmaNJvY=;
        b=h5P5BokXHc1xHLgeffw4LrjhA0popzXTG6YcCaEjje4uZfvLi2W73rXCTmSuDnpxdq
         uQT02O4BJoWxBRfrTvpOLUegqZlnIPy53/Nu/I7GWz3eqQps8gaWB3+TdCbpPrT/qIi2
         uxrrRNApoNqDT0l4JPb3MEfgMmczc/aRv3VEUoK5yMmzuJpxHM7X5K+7urTwmCJntjr0
         12q3OU7cI0tUPXwTXzMUAPn/ZCri6ePbe4wjiQOxAspvXxFh9zs26Wnox4H04xR46EYQ
         mzScPAIF40j7An/0qm2oTu9dAR4/VQgyQhDYXneiuDVMTtF6iz5lqWfgF1Pu1Gwj0uRL
         HpGA==
X-Gm-Message-State: AOUpUlGYUjYgIwUhrttnBXByXsR8uGIpLodRKPWE2hKWombT/UKS0tt+
        6OpTvoEZtflwgOUv8xG0YTc=
X-Google-Smtp-Source: AAOMgpd1wV1wanH2oMQkfSa6916qJ++kvCKe4iMPiOkuJ9rTYRtJId0ElNhKlFz618zFFWVyIKe9Cg==
X-Received: by 2002:a1c:5c7:: with SMTP id 190-v6mr3797530wmf.24.1532177762022;
        Sat, 21 Jul 2018 05:56:02 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id e196-v6sm9900716wmf.46.2018.07.21.05.56.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 21 Jul 2018 05:56:01 -0700 (PDT)
Date:   Sat, 21 Jul 2018 14:55:59 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86 fix
Message-ID: <20180721125559.GA21066@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

   # HEAD: fbdb328c6bae0a7c78d75734a738b66b86dffc96 x86/MCE: Remove min interval polling limitation

A single fix for a MCE-polling regression, which prevented the disabling of 
polling.

 Thanks,

	Ingo

------------------>
Dewet Thibaut (1):
      x86/MCE: Remove min interval polling limitation


 arch/x86/kernel/cpu/mcheck/mce.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index c102ad51025e..8c50754c09c1 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -2165,9 +2165,6 @@ static ssize_t store_int_with_restart(struct device *s,
 	if (check_interval == old_check_interval)
 		return ret;
 
-	if (check_interval < 1)
-		check_interval = 1;
-
 	mutex_lock(&mce_sysfs_mutex);
 	mce_restart();
 	mutex_unlock(&mce_sysfs_mutex);
