Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8674CC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B5A52083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="bKUl83Yq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B5A52083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731205AbeIHC3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:29:01 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:32030 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728133AbeIHC3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:29:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536356764; x=1567892764;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fMzps2uRqzz58I2miAAfrusRjUa8pr6F+7xe2ISsdoc=;
  b=bKUl83YqFfWVBdxAWdK0sqb1zaZ78wQjvIo1cubh3deRIXY3JDH2CCdg
   Zi+rI7gi98OCpwycwaeIT/ixdTfIOCpOrxG5YuyHhUzj18cKBI0WLdDpC
   RmdET/9ceZvFmlizdFzl85SGodT7gWX871gOtBsSIKEeiy51mDJgcVRaW
   A=;
X-IronPort-AV: E=Sophos;i="5.53,343,1531785600"; 
   d="scan'208";a="752286766"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Sep 2018 21:43:33 +0000
Received: from u7588a65da6b65f.ant.amazon.com (iad7-ws-svc-lb50-vlan2.amazon.com [10.0.93.210])
        by email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w87LfmcA115551
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 7 Sep 2018 21:41:51 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id w87LflGS027304
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Sep 2018 23:41:47 +0200
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id w87LfkUA027300;
        Fri, 7 Sep 2018 23:41:46 +0200
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC 18/60] sched: Fix return value of SCHED_WARN_ON()
Date:   Fri,  7 Sep 2018 23:40:05 +0200
Message-Id: <20180907214047.26914-19-jschoenh@amazon.de>
X-Mailer: git-send-email 2.9.3.1.gcba166c.dirty
In-Reply-To: <20180907214047.26914-1-jschoenh@amazon.de>
References: <20180907214047.26914-1-jschoenh@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SCHED_WARN_ON() is conditionally compiled depending on CONFIG_SCHED_DEBUG.
WARN_ON() and variants can be used in if() statements to take an action
in the unlikely case that the WARN_ON condition is true. This is supposed
to work independently of whether the warning is actually printed. However,
without CONFIG_SCHED_DEBUG, SCHED_WARN_ON() evaluates to false
unconditionally.

Change SCHED_WARN_ON() to not discard the WARN_ON condition, even without
CONFIG_SCHED_DEBUG, so that it can be used within if() statements as
expected.

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 kernel/sched/sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9ecbb57049a2..3e0ad36938fb 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -76,7 +76,7 @@
 #ifdef CONFIG_SCHED_DEBUG
 # define SCHED_WARN_ON(x)	WARN_ONCE(x, #x)
 #else
-# define SCHED_WARN_ON(x)	({ (void)(x), 0; })
+# define SCHED_WARN_ON(x)	({ unlikely(!!(x)); })
 #endif
 
 struct rq;
-- 
2.9.3.1.gcba166c.dirty

