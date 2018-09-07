Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D447CC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8751820855
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="k0OwiazM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8751820855
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731085AbeIHC2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:28:09 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:29622 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731069AbeIHC2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:28:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536356713; x=1567892713;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AxXYXmA/oaQEZzqG5GxouI+6356lHVQDRY4biIK4kzA=;
  b=k0OwiazMrSsawav7/WOlDm8VVKY1HCUUrUzigvLtGXqGwNFOoH6VIBRR
   WRaOGrlH/Sg0AEVxixJNOxJvUBdr66XfmxDAan8ocsmb2WHMWeRO6YR0E
   5OhUeM7EQZ1l7ooTQ2kai4JLva4kMZuO+aHHmVtqbnv7QF9xmAMOwkBqG
   A=;
X-IronPort-AV: E=Sophos;i="5.53,343,1531785600"; 
   d="scan'208";a="752286680"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Sep 2018 21:42:38 +0000
Received: from u7588a65da6b65f.ant.amazon.com (iad7-ws-svc-lb50-vlan3.amazon.com [10.0.93.214])
        by email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w87LfVjJ098273
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 7 Sep 2018 21:41:34 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id w87LfTSp027205
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Sep 2018 23:41:29 +0200
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id w87LfSvE027204;
        Fri, 7 Sep 2018 23:41:28 +0200
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC 11/60] locking/lockdep: Increase number of supported lockdep subclasses
Date:   Fri,  7 Sep 2018 23:39:58 +0200
Message-Id: <20180907214047.26914-12-jschoenh@amazon.de>
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

With coscheduling the number of required classes is twice the depth of
the scheduling domain hierarchy. For a 256 CPU system, there are eight
levels at most. Adjust the number of subclasses, so that lockdep can
still be used on such systems.

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 include/linux/lockdep.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index b0d0b51c4d85..d93a5ec3077f 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -17,7 +17,7 @@ struct lockdep_map;
 extern int prove_locking;
 extern int lock_stat;
 
-#define MAX_LOCKDEP_SUBCLASSES		8UL
+#define MAX_LOCKDEP_SUBCLASSES		16UL
 
 #include <linux/types.h>
 
-- 
2.9.3.1.gcba166c.dirty

