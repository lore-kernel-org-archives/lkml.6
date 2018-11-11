Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986B1C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DA9821508
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMXpdp+r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DA9821508
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391174AbeKLIeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:34:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:58632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391161AbeKLIXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:23:55 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7973621780;
        Sun, 11 Nov 2018 22:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975637;
        bh=3LfejInjT8Kpmi+AZZl9fob6nj4nU2eagd3p8VduAZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PMXpdp+rqDs6/ja3BhB3ZeQyoflK87RGCzlgUrIdWu2q1IDIp5CQWaR+LXTj6EjJN
         s8wy3CewFlH/3QHFwlBQiu+BzBj4N5RZj8QOhN5YfDpGlNsinHswo/lFq0oexdM94E
         LnpznMtoxkDwNdKm61v7yM9KgGzOvvj4J82G2oI0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenwen Wang <wang6495@umn.edu>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 054/141] scsi: megaraid_sas: fix a missing-check bug
Date:   Sun, 11 Nov 2018 14:25:13 -0800
Message-Id: <20181111221635.026669080@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221627.853046496@linuxfoundation.org>
References: <20181111221627.853046496@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wenwen Wang <wang6495@umn.edu>

[ Upstream commit 47db7873136a9c57c45390a53b57019cf73c8259 ]

In megasas_mgmt_compat_ioctl_fw(), to handle the structure
compat_megasas_iocpacket 'cioc', a user-space structure megasas_iocpacket
'ioc' is allocated before megasas_mgmt_ioctl_fw() is invoked to handle
the packet. Since the two data structures have different fields, the data
is copied from 'cioc' to 'ioc' field by field. In the copy process,
'sense_ptr' is prepared if the field 'sense_len' is not null, because it
will be used in megasas_mgmt_ioctl_fw(). To prepare 'sense_ptr', the
user-space data 'ioc->sense_off' and 'cioc->sense_off' are copied and
saved to kernel-space variables 'local_sense_off' and 'user_sense_off'
respectively. Given that 'ioc->sense_off' is also copied from
'cioc->sense_off', 'local_sense_off' and 'user_sense_off' should have the
same value. However, 'cioc' is in the user space and a malicious user can
race to change the value of 'cioc->sense_off' after it is copied to
'ioc->sense_off' but before it is copied to 'user_sense_off'. By doing
so, the attacker can inject different values into 'local_sense_off' and
'user_sense_off'. This can cause undefined behavior in the following
execution, because the two variables are supposed to be same.

This patch enforces a check on the two kernel variables 'local_sense_off'
and 'user_sense_off' to make sure they are the same after the copy. In
case they are not, an error code EINVAL will be returned.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
Acked-by: Sumit Saxena <sumit.saxena@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/megaraid/megaraid_sas_base.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -6901,6 +6901,9 @@ static int megasas_mgmt_compat_ioctl_fw(
 		get_user(user_sense_off, &cioc->sense_off))
 		return -EFAULT;
 
+	if (local_sense_off != user_sense_off)
+		return -EINVAL;
+
 	if (local_sense_len) {
 		void __user **sense_ioc_ptr =
 			(void __user **)((u8 *)((unsigned long)&ioc->frame.raw) + local_sense_off);


