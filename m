Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FEFC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EF63214C4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789292;
	bh=qsPUqN+4Xcz1ZxjFe9cfJBAljbWaOWppvPnqDqf/Vcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ofF3rH79DrnAmelICF2M8Yv+XTxLa9WbLQWI0jmYE2l5Nm7PA/W5v17c9+w+FCNKm
	 fc0I+ZUWpTa/20CkcoVCM6XqTMnnAygcuwtsbslDSh6W87f971YIlkh89j0FbWGXGP
	 f22if40pb1tkAzeAZUm+xKSIM4G2dRCiFKW8eiG4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EF63214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731230AbeLNMIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:08:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:53522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730706AbeLNMIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:08:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D29F621486;
        Fri, 14 Dec 2018 12:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789286;
        bh=qsPUqN+4Xcz1ZxjFe9cfJBAljbWaOWppvPnqDqf/Vcs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AucZyBtBBcCFzsZq2ypK2BG3WbOxh/vzVQduLDs+J4fzdYH2+UlK9oq4JkrsFkhX0
         uyEV31LLMsMRPzui2IquFrpst/pgfSmBTs9lMoEM7R9uVmxY+gT56wMCQ2i3IqDTCM
         M5BuTN3eg1S8YCZ4mASgSSMHM6VYLocrtAf0yVQY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 16/89] ARM: OMAP2+: prm44xx: Fix section annotation on omap44xx_prm_enable_io_wakeup
Date:   Fri, 14 Dec 2018 12:59:29 +0100
Message-Id: <20181214115730.479437512@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115729.658859279@linuxfoundation.org>
References: <20181214115729.658859279@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit eef3dc34a1e0b01d53328b88c25237bcc7323777 ]

When building the kernel with Clang, the following section mismatch
warning appears:

WARNING: vmlinux.o(.text+0x38b3c): Section mismatch in reference from
the function omap44xx_prm_late_init() to the function
.init.text:omap44xx_prm_enable_io_wakeup()
The function omap44xx_prm_late_init() references
the function __init omap44xx_prm_enable_io_wakeup().
This is often because omap44xx_prm_late_init lacks a __init
annotation or the annotation of omap44xx_prm_enable_io_wakeup is wrong.

Remove the __init annotation from omap44xx_prm_enable_io_wakeup so there
is no more mismatch.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-omap2/prm44xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 1c0c1663f078..5affa9f5300b 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -344,7 +344,7 @@ static void omap44xx_prm_reconfigure_io_chain(void)
  * to occur, WAKEUPENABLE bits must be set in the pad mux registers, and
  * omap44xx_prm_reconfigure_io_chain() must be called.  No return value.
  */
-static void __init omap44xx_prm_enable_io_wakeup(void)
+static void omap44xx_prm_enable_io_wakeup(void)
 {
 	s32 inst = omap4_prmst_get_prm_dev_inst();
 
-- 
2.19.1



