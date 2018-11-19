Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161AAC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD6EF21104
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="URb0b+3S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD6EF21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404503AbeKTDVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:21:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:32936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404484AbeKTDVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:21:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC11C2145D;
        Mon, 19 Nov 2018 16:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646636;
        bh=RvchF3jY0wCyfNU1HPcIlh84MqP8qqIdlZRv88+zgJI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=URb0b+3SwZ7QG+ohuQjyMMguwD0J/eAdcIE8STuaLXZNW9uFeYmC5z7AFdxa43F5i
         ca0wv1hLHbEV+HtJAPHmPtCu4lxapYPcta1ywyI47EmRhqfS7ismuWJhKUjatYBF9c
         PoljvF/gvhPtDI++lYQRnxM7K0go9JQ/hNco9Vmk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenwen Wang <wang6495@umn.edu>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 033/160] scsi: megaraid_sas: fix a missing-check bug
Date:   Mon, 19 Nov 2018 17:27:52 +0100
Message-Id: <20181119162634.146054848@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162630.031306128@linuxfoundation.org>
References: <20181119162630.031306128@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -6510,6 +6510,9 @@ static int megasas_mgmt_compat_ioctl_fw(
 		get_user(user_sense_off, &cioc->sense_off))
 		return -EFAULT;
 
+	if (local_sense_off != user_sense_off)
+		return -EINVAL;
+
 	if (local_sense_len) {
 		void __user **sense_ioc_ptr =
 			(void __user **)((u8 *)((unsigned long)&ioc->frame.raw) + local_sense_off);


