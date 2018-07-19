Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61ABDC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 20:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B1FF2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 20:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TG5gl7K/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B1FF2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729692AbeGSVAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 17:00:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44528 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbeGSVAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 17:00:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=syFHJI6ZbBPHcIUcx9AUPpSlHcQ/GEwJN8Eins1w9KY=; b=TG5gl7K/ogk7Icg5eKETf7bLY
        0z1TBOP0OXsw6KCiekI7VMkCo+IsQQ4O4pqt1wyi4l/IqDvCVA9De4xtB1e7I6kNjnYBw1hhkrhKT
        JkW+v1Ej7BGpohlHJJYBqxzye3o/lzyYEnXyvhic+Q6qkhBWayFl9ZY19Jg/fdEoj9fr/OpEjw4XZ
        WitXJQnF3S3WcjulN9XBsjxLLMXWm/ABYhOvqppSz+/SmPSdKyRU59fy7xqhvIthpN2gV3K0HZ3L/
        0bkcUzFUdtpOLoHUFrIiFUd9/lKHRZ17NNd+FYT6tBpLCqN+EBZRdT1B9mTE4bRpb/pZop7BUD2RS
        ctoxFOfVA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fgFL8-00058I-O6; Thu, 19 Jul 2018 20:15:54 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] security: export security_kernel_load_data to fix
 firmware_loader build
Message-ID: <7a8dd892-39ec-3973-5f41-5ec23f1feb3f@infradead.org>
Date:   Thu, 19 Jul 2018 13:15:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix build error when CONFIG_FW_LOADER=m, CONFIG_FW_LOADER_USER_HELPER=y,
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y, and CONFIG_SECURITY=y:

ERROR: "security_kernel_load_data" [drivers/base/firmware_loader/firmware_class.ko] undefined!

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org
Cc: Luis R. Rodriguez <mcgrof@kernel.org>
---
 security/security.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20180717.orig/security/security.c
+++ linux-next-20180717/security/security.c
@@ -1121,6 +1121,7 @@ int security_kernel_load_data(enum kerne
 		return ret;
 	return ima_load_data(id);
 }
+EXPORT_SYMBOL_GPL(security_kernel_load_data);
 
 int security_task_fix_setuid(struct cred *new, const struct cred *old,
 			     int flags)

