Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 34D3AC5CFF0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAC8E208BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="nxi75fbH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAC8E208BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933066AbeFKRgE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 13:36:04 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:28724 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932462AbeFKRgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 13:36:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1528738562; x=1560274562;
  h=from:to:cc:subject:date:message-id;
  bh=xu5vgvBUlflgV0dklsM3flSrsCRZewxCowIUfi2B6LM=;
  b=nxi75fbHag3IrN9tN7dQXz7eUHQB2rawxgpZlGl/iX9j9JUo1Wg15maG
   /Q6vWeD/XFymbiCjMajZXQcd4PPHjSpeiZS41UxVh3NMmzhyDvaGdwXPp
   R0RDSUX9iPriDuz1krhvPqg7PrbW5FsIQz1m2FZcebBtokHldjxTDeUMs
   w=;
X-IronPort-AV: E=Sophos;i="5.51,502,1526342400"; 
   d="scan'208";a="723626962"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-9ec21598.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 11 Jun 2018 17:36:01 +0000
Received: from u480fcf47319e58177d3b.ant.amazon.com (iad1-ws-svc-lb91-vlan2.amazon.com [10.0.103.146])
        by email-inbound-relay-1d-9ec21598.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w5BHZwW4112269
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 11 Jun 2018 17:35:59 GMT
Received: from u480fcf47319e58177d3b.ant.amazon.com (localhost [127.0.0.1])
        by u480fcf47319e58177d3b.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id w5BHZw6B003374;
        Mon, 11 Jun 2018 10:35:58 -0700
Received: (from jmf@localhost)
        by u480fcf47319e58177d3b.ant.amazon.com (8.15.2/8.15.2/Submit) id w5BHZvBX003371;
        Mon, 11 Jun 2018 10:35:57 -0700
From:   Jarrett Farnitano <jmf@amazon.com>
To:     Eric Biederman <ebiederm@xmission.com>
Cc:     kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jarrett Farnitano <jmf@amazon.com>
Subject: [PATCH] kexec: yield to scheduler when loading kimage segments
Date:   Mon, 11 Jun 2018 10:35:46 -0700
Message-Id: <1528738546-3328-1-git-send-email-jmf@amazon.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without yielding while loading kimage segments, a large initrd
will block all other work on the CPU performing the load until
it is completed. For example loading an initrd of 200MB on a
low power single core system will lock up the system for a few
seconds.

To increase system responsiveness to other tasks at that time,
call cond_resched() in both the crash kernel and normal kernel
segment loading loops.

Signed-off-by: Jarrett Farnitano <jmf@amazon.com>
---
 kernel/kexec_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 5616755..8ee07d6 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -783,6 +783,8 @@ static int kimage_load_normal_segment(struct kimage *image,
 		else
 			buf += mchunk;
 		mbytes -= mchunk;
+
+		cond_resched();
 	}
 out:
 	return result;
@@ -847,6 +849,8 @@ static int kimage_load_crash_segment(struct kimage *image,
 		else
 			buf += mchunk;
 		mbytes -= mchunk;
+
+		cond_resched();
 	}
 out:
 	return result;
-- 
2.7.4

