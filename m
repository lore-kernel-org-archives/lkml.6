Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA35C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70A592098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kyoSYHvo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70A592098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731020AbeJQBNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:13:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:59230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727433AbeJQBNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:13:24 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B05A20866;
        Tue, 16 Oct 2018 17:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710519;
        bh=SLKn+hw8XKyWJQgXsmUf9pNEBEstH0rrrynS95xQs1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kyoSYHvobWDCFnpA5dOW0Ohi0IztdIsuVctxhFAAFs+z2hrPx42Gd1WODy8+f9dtS
         jfYPDjeWfHDwi/prWIn7Agg+hWf8sloTRJCEmNfHuvSEU1HWn1Kcxe6HDGcnk8KwFR
         fez7OqyyDn14tC/wJAdQpH5KL0EFgo64xc6IsiWE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        "David A. Long" <dave.long@linaro.org>
Subject: [PATCH 4.14 105/109] ARM: oabi-compat: copy semops using __copy_from_user()
Date:   Tue, 16 Oct 2018 19:06:13 +0200
Message-Id: <20181016170530.700505048@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170524.530541524@linuxfoundation.org>
References: <20181016170524.530541524@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Russell King <rmk+kernel@armlinux.org.uk>

Commit 8c8484a1c18e3231648f5ba7cc5ffb7fd70b3ca4 upstream.

__get_user_error() is used as a fast accessor to make copying structure
members as efficient as possible.  However, with software PAN and the
recent Spectre variant 1, the efficiency is reduced as these are no
longer fast accessors.

In the case of software PAN, it has to switch the domain register around
each access, and with Spectre variant 1, it would have to repeat the
access_ok() check for each access.

Rather than using __get_user_error() to copy each semops element member,
copy each semops element in full using __copy_from_user().

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David A. Long <dave.long@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/kernel/sys_oabi-compat.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/arch/arm/kernel/sys_oabi-compat.c
+++ b/arch/arm/kernel/sys_oabi-compat.c
@@ -329,9 +329,11 @@ asmlinkage long sys_oabi_semtimedop(int
 		return -ENOMEM;
 	err = 0;
 	for (i = 0; i < nsops; i++) {
-		__get_user_error(sops[i].sem_num, &tsops->sem_num, err);
-		__get_user_error(sops[i].sem_op,  &tsops->sem_op,  err);
-		__get_user_error(sops[i].sem_flg, &tsops->sem_flg, err);
+		struct oabi_sembuf osb;
+		err |= __copy_from_user(&osb, tsops, sizeof(osb));
+		sops[i].sem_num = osb.sem_num;
+		sops[i].sem_op = osb.sem_op;
+		sops[i].sem_flg = osb.sem_flg;
 		tsops++;
 	}
 	if (timeout) {


