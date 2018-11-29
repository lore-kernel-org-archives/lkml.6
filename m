Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D12C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E59E62133F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qkFzdMZK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E59E62133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387772AbeK3BdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:33:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:33600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731824AbeK3BdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:33:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CED92133F;
        Thu, 29 Nov 2018 14:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501656;
        bh=kgEqI+zF6GRNF9kpTfCH2uleakooyQPseAb6eGHlVro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qkFzdMZKsPTDs6yu5Hd1vzxT/xAlz48hwJ1/uPSt8CdYyBanWxc2xV+4ymtm3JUud
         2QO8NM6Aok+v1ZeEOozLzmjiVtvdYh4gxYQLoEtr1rcvQLcWHEubHKhMli4VlrasQN
         EeHML7K/K4lZ+uMHPrfb/Z3e3UzzQALO7zJuqtnQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julien Thierry <julien.thierry@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 054/100] ARM: make lookup_processor_type() non-__init
Date:   Thu, 29 Nov 2018 15:12:24 +0100
Message-Id: <20181129140103.833952255@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140058.768942700@linuxfoundation.org>
References: <20181129140058.768942700@linuxfoundation.org>
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

[ Upstream commit 899a42f836678a595f7d2bc36a5a0c2b03d08cbc ]

Move lookup_processor_type() out of the __init section so it is callable
from (eg) the secondary startup code during hotplug.

Reviewed-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/kernel/head-common.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/head-common.S b/arch/arm/kernel/head-common.S
index 8733012d231f..7e662bdd5cb3 100644
--- a/arch/arm/kernel/head-common.S
+++ b/arch/arm/kernel/head-common.S
@@ -122,6 +122,9 @@ __mmap_switched_data:
 	.long	init_thread_union + THREAD_START_SP @ sp
 	.size	__mmap_switched_data, . - __mmap_switched_data
 
+	__FINIT
+	.text
+
 /*
  * This provides a C-API version of __lookup_processor_type
  */
@@ -133,9 +136,6 @@ ENTRY(lookup_processor_type)
 	ldmfd	sp!, {r4 - r6, r9, pc}
 ENDPROC(lookup_processor_type)
 
-	__FINIT
-	.text
-
 /*
  * Read processor ID register (CP#15, CR0), and look up in the linker-built
  * supported processor list.  Note that we can't use the absolute addresses
-- 
2.17.1



