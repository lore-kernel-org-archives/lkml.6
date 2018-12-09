Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25F5C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71A5F20661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:28:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71A5F20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbeLIW22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:28:28 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34594 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726335AbeLIVzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:11 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72Y-0002iZ-Qz; Sun, 09 Dec 2018 21:55:06 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72X-0003CB-OT; Sun, 09 Dec 2018 21:55:05 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Denis Kirjanov" <kirjanov@gmail.com>,
        "Borislav Petkov" <bp@suse.de>,
        "linux-edac" <linux-edac@vger.kernel.org>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        "Johan Hovold" <johan@kernel.org>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.620630387@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 001/328] EDAC: Fix memleak in module init error path
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 4708aa85d50cc6e962dfa8acf5ad4e0d290a21db upstream.

Make sure to use put_device() to free the initialised struct device so
that resources managed by driver core also gets released in the event of
a registration failure.

Signed-off-by: Johan Hovold <johan@kernel.org>
Cc: Denis Kirjanov <kirjanov@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-edac <linux-edac@vger.kernel.org>
Fixes: 2d56b109e3a5 ("EDAC: Handle error path in edac_mc_sysfs_init() properly")
Link: http://lkml.kernel.org/r/20180612124335.6420-1-johan@kernel.org
Signed-off-by: Borislav Petkov <bp@suse.de>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/edac/edac_mc_sysfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/edac/edac_mc_sysfs.c
+++ b/drivers/edac/edac_mc_sysfs.c
@@ -1161,14 +1161,14 @@ int __init edac_mc_sysfs_init(void)
 
 	err = device_add(mci_pdev);
 	if (err < 0)
-		goto out_dev_free;
+		goto out_put_device;
 
 	edac_dbg(0, "device %s created\n", dev_name(mci_pdev));
 
 	return 0;
 
- out_dev_free:
-	kfree(mci_pdev);
+ out_put_device:
+	put_device(mci_pdev);
  out_put_sysfs:
 	edac_put_sysfs_subsys();
  out:

