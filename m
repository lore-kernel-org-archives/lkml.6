Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AEC7C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1D7320684
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="ZIc2Vd1G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1D7320684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbeJDWyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 18:54:40 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:39336 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbeJDWyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 18:54:40 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 990CD1195
        for <linux-kernel@vger.kernel.org>; Thu,  4 Oct 2018 16:00:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GfKvsdncQaNm for <linux-kernel@vger.kernel.org>;
        Thu,  4 Oct 2018 11:00:45 -0500 (CDT)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 6AF8E11AB
        for <linux-kernel@vger.kernel.org>; Thu,  4 Oct 2018 11:00:45 -0500 (CDT)
Received: by mail-io1-f69.google.com with SMTP id z15-v6so8078018iob.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 09:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Ie3cKh7tyt3QXvlrAGVJ8y4Hy36L8S8XML8eOFURSKY=;
        b=ZIc2Vd1GrGTeCPPGrR1W13bRcX/GOrEL7m8+n0Tt9tSZkllE5dtrj23OoWtKIj6s3+
         TSwxvJS4qaSp98XUTeyOvcFYe94BVxABr0AaMoyZSggxIvT4Mzrnt0+xKGmZdHhw86ZK
         z+kDUmHF7ynLDz70Pnn3MdJ0KPw7XTZZBWRMJ5oEKzQ+l26SC7IaGASRf4P+/on7eSsB
         KMhHjQo374e8Mi2uo9p45TlkC986OV3Sam7xakMPwjUvIoAeFYGg1BmLegnhYgT/QcLX
         gW21m5TzT2fWsQCBLHuh86/P8GlyPh354gJUhfVEL+IIrH/b6yL+gwujHylCTm3mdc/G
         DcMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ie3cKh7tyt3QXvlrAGVJ8y4Hy36L8S8XML8eOFURSKY=;
        b=KP1NePbK0XwF1tvJ57yjCURQFKiIB+NrZFd4IJpfaywb0UOcV0DXZwp09FIRr2bCUW
         7qmtk+bk5jZ4pw80VSq5CLolYh2TkQ1FAVZmORIPWZiDXmz3iKrypLJBcZjpJ8aDdjpB
         fLVI3cbqIigRtgPIDD4W7hV+WTdbKkMXEcLeNKEIJRPik1NfbMKeISgE5GOMBZP+0M/Q
         K1HC6NiAsJHqTeoG4AdUUQ0u0mopUUYVU08PRcilhOJTylmtAe7MS4FmyM9qwXkwR7F4
         B8ruYdj9urw7Gt9SoKhzIJd9500eORADJxyKaq24UgbxWX8xiu35aJUn2EK6dkvC5B3T
         Wg0A==
X-Gm-Message-State: ABuFfoiQXcp2hNNuP2l7E4sKtJTOvpMZG7LScFmAKdCaaaW0FGg2N8iy
        VYEjV6f4r8COyqrB9sb1fNuLwUCgvIO4+LRNtmC1h7uq1PiUMGMiVwuR+OlcVV8obrlfjb32uAL
        95mNyMI4Fg5FSnV8q/ZYjtNBOs0S8
X-Received: by 2002:a02:238f:: with SMTP id u137-v6mr5702299jau.0.1538668845123;
        Thu, 04 Oct 2018 09:00:45 -0700 (PDT)
X-Google-Smtp-Source: ACcGV60+skhG7cj7TF9eMlqQnjgBQseKEUJl+gCJQfHjir12PsmEQOlElYLiWwPfIZq1lQCAnDxPGg==
X-Received: by 2002:a02:238f:: with SMTP id u137-v6mr5702281jau.0.1538668844884;
        Thu, 04 Oct 2018 09:00:44 -0700 (PDT)
Received: from cs-u-cslp16.cs.umn.edu (cs-u-cslp16.cs.umn.edu. [134.84.121.95])
        by smtp.gmail.com with ESMTPSA id f15-v6sm2225553ita.24.2018.10.04.09.00.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Oct 2018 09:00:44 -0700 (PDT)
From:   Wenwen Wang <wang6495@umn.edu>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org (open list:MEDIA INPUT INFRASTRUCTURE
        (V4L/DVB)),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] media: davinci_vpfe: fix a NULL pointer dereference bug
Date:   Thu,  4 Oct 2018 11:00:31 -0500
Message-Id: <1538668833-18372-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In vpfe_isif_init(), there is a while loop to get the ISIF base address and
linearization table0 and table1 address. In the loop body, the function
platform_get_resource() is called to get the resource. If
platform_get_resource() returns NULL, the loop is terminated and the
execution goes to 'fail_nobase_res'. Suppose the loop is terminated at the
first iteration because platform_get_resource() returns NULL and the
execution goes to 'fail_nobase_res'. Given that there is another while loop
at 'fail_nobase_res' and i equals to 0, one iteration of the second while
loop will be executed. However, the second while loop does not check the
return value of platform_get_resource(). This can cause a NULL pointer
dereference bug if the return value is a NULL pointer.

This patch avoids the above issue by adding a check in the second while
loop after the call to platform_get_resource().

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 drivers/staging/media/davinci_vpfe/dm365_isif.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/media/davinci_vpfe/dm365_isif.c b/drivers/staging/media/davinci_vpfe/dm365_isif.c
index 745e33f..b0425a6 100644
--- a/drivers/staging/media/davinci_vpfe/dm365_isif.c
+++ b/drivers/staging/media/davinci_vpfe/dm365_isif.c
@@ -2080,7 +2080,8 @@ int vpfe_isif_init(struct vpfe_isif_device *isif, struct platform_device *pdev)
 
 	while (i >= 0) {
 		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
-		release_mem_region(res->start, res_len);
+		if (res)
+			release_mem_region(res->start, res_len);
 		i--;
 	}
 	return status;
-- 
2.7.4

