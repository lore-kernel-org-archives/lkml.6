Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349FCECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E62792146D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qszJgXAc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E62792146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbeKIHep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:34:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:51364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbeKIHeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:34:44 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA5F220892;
        Thu,  8 Nov 2018 21:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714236;
        bh=qmzza5Wuq3KTp/kzgYC9I56VBGY8sAAxZT1/hRtFKgg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qszJgXAc7Nw+N1oZl5tGR2t9k1FdeWPkcYHXlyWHyvxMzgNDGjVPOzLGLe9nLfVUF
         efVIjDz3Zk1hgBoj8FBD0R45XichF4c+po7ugxPtnCturNqOUr+RwqhjpmfaluCW/M
         W/c02hjChtOmi1aU1VHLh/xD5p4N5mn/n634EwJo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        Niklas Cassel <niklass@axis.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 098/144] MIPS: Fix up obsolete cpu_set usage
Date:   Thu,  8 Nov 2018 13:51:09 -0800
Message-Id: <20181108215104.760339510@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 7363cb7de3999e84243bca79ffea257fd86a2cc6 ]

cpu_set was removed (along with a bunch of cpumask helpers) by
commit 2f0f267ea072 ("cpumask: remove deprecated functions.").

Fix this by replacing cpu_set with cpumask_set_cpu. Without this
fix the following error is triggered when CONFIG_MIPS_MT_FPAFF=y.

  arch/mips/kernel/smp-cps.c: In function 'cps_smp_setup':
  arch/mips/kernel/smp-cps.c:95:3: error: implicit declaration of function 'cpu_set' [-Werror=implicit-function-declaration]

Fixes: 90db024f140d ("MIPS: smp-cps: cpu_set FPU mask if FPU present")
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Acked-by: Niklas Cassel <niklass@axis.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/9912/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/kernel/smp-cps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index 0854f17829f3..5680ff0eb599 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -92,7 +92,7 @@ static void __init cps_smp_setup(void)
 #ifdef CONFIG_MIPS_MT_FPAFF
 	/* If we have an FPU, enroll ourselves in the FPU-full mask */
 	if (cpu_has_fpu)
-		cpu_set(0, mt_fpu_cpumask);
+		cpumask_set_cpu(0, &mt_fpu_cpumask);
 #endif /* CONFIG_MIPS_MT_FPAFF */
 }
 
-- 
2.17.1



