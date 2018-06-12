Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 01205C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC04220891
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="mT6tKf8Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC04220891
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934579AbeFLU4x (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 16:56:53 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:46135 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934342AbeFLU4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 16:56:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1528837005; x=1560373005;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=CaVNlSsvdiSt9FutpnLSEKRFgB42VECALAbNL5pFElw=;
  b=mT6tKf8YGb39dR1oqnseZTSoj4hq/EDdFS1ZtfKBBkV6qqTa3eRhuD2E
   FpdZ/dO67uEBg7Y8MJtr0RLMJ8xuxxgJ0wzTc4uTUSxzL0ySyoZDKLqry
   mc1avbTCefZwdS0RkIRsnYUkeIJ4kQaXU0hSocvGQj1bUldPsRLV4txSC
   0=;
X-IronPort-AV: E=Sophos;i="5.51,216,1526342400"; 
   d="scan'208";a="347699308"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-55156cd4.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 12 Jun 2018 20:56:42 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2b-55156cd4.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w5CKueZq017015
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 12 Jun 2018 20:56:42 GMT
Received: from EX13D05UWB003.ant.amazon.com (10.43.161.26) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 12 Jun 2018 20:56:39 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D05UWB003.ant.amazon.com (10.43.161.26) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 12 Jun 2018 20:56:39 +0000
Received: from localhost (10.25.15.63) by mail-relay.amazon.com
 (10.43.161.249) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Tue, 12 Jun 2018 20:56:39 +0000
From:   Anchal Agarwal <anchalag@amazon.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <x86@kernel.org>
CC:     <boris.ostrovsky@oracle.com>, <konrad.wilk@oracle.com>,
        <roger.pau@citrix.com>, <netdev@vger.kernel.org>,
        <jgross@suse.com>, <xen-devel@lists.xenproject.org>,
        <linux-kernel@vger.kernel.org>, <kamatam@amazon.com>,
        <anchalag@amazon.com>, <fllinden@amazon.com>, <vallish@amazon.com>,
        <guruanb@amazon.com>, <eduval@amazon.com>, <rjw@rjwysocki.net>,
        <pavel@ucw.cz>, <len.brown@intel.com>, <linux-pm@vger.kernel.org>,
        <cyberax@amazon.com>
Subject: [RFC PATCH 12/12] PM / hibernate: update the resume offset on SNAPSHOT_SET_SWAP_AREA
Date:   Tue, 12 Jun 2018 20:56:19 +0000
Message-ID: <20180612205619.28156-13-anchalag@amazon.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180612205619.28156-1-anchalag@amazon.com>
References: <20180612205619.28156-1-anchalag@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aleksei Besogonov <cyberax@amazon.com>

The SNAPSHOT_SET_SWAP_AREA is supposed to be used to set the hibernation
offset on a running kernel to enable hibernating to a swap file.
However, it doesn't actually update the swsusp_resume_block variable. As
a result, the hibernation fails at the last step (after all the data is
written out) in the validation of the swap signature in
mark_swapfiles().

Before this patch, the command line processing was the only place where
swsusp_resume_block was set.

Signed-off-by: Aleksei Besogonov <cyberax@amazon.com>
Signed-off-by: Munehisa Kamata <kamatam@amazon.com>
Signed-off-by: Anchal Agarwal <anchalag@amazon.com>
Reviewed-by: Munehisa Kamata <kamatam@amazon.com>
Reviewed-by: Eduardo Valentin <eduval@amazon.com>
---
 kernel/power/user.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/power/user.c b/kernel/power/user.c
index abd2255..b522a42 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -379,8 +379,12 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
 			if (swdev) {
 				offset = swap_area.offset;
 				data->swap = swap_type_of(swdev, offset, NULL);
-				if (data->swap < 0)
+				if (data->swap < 0) {
 					error = -ENODEV;
+				} else {
+					swsusp_resume_device = swdev;
+					swsusp_resume_block = offset;
+				}
 			} else {
 				data->swap = -1;
 				error = -EINVAL;
-- 
2.7.4

