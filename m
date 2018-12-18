Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED83C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2DFE218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545151244;
	bh=8JEP9quJHhWVWjmIM36WrOZN1IpHVr8yKc2APP89WH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MN6TqHCDnKmTt+WzgPzgxSKf59uVErjwexhsV6mfjqVgvqzihDVQ43ZJXd73mpezN
	 o9E/+WAPehahm4qWdYBdXtlrqiZ3t8FbeZstcXvpxkMdltwKpPcX+mdrApta+ozRfA
	 pwGBxFuz0I2n7g2lHmO6bfo/kf92XTpurqO5Su5Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbeLRQkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:40:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:37808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726639AbeLRQkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:40:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1749521873;
        Tue, 18 Dec 2018 16:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545151239;
        bh=8JEP9quJHhWVWjmIM36WrOZN1IpHVr8yKc2APP89WH8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fLycP6EK4wFv0fdY5wJ1cBXnoyR8KehppwVmmkRHLRqSDcnrvnT0yhkR1kMApI/3B
         L8WBq5a3sLl4/oCQqe2S23sruTAdbLAT/wzt5mzXuNqxTOJBzL01yEQ6l5OzfvRLuY
         c+TGltghaOGc26+T91/1K+lKnOt4ga76r7z9sr+w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Subject: [PATCH 4.19 22/44] ARM: mmp/mmp2: fix cpu_is_mmp2() on mmp2-dt
Date:   Tue, 18 Dec 2018 17:39:34 +0100
Message-Id: <20181218163930.124621780@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181218163927.119623235@linuxfoundation.org>
References: <20181218163927.119623235@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lubomir Rintel <lkundrak@v3.sk>

commit 76f4e2c3b6a560cdd7a75b87df543e04d05a9e5f upstream.

cpu_is_mmp2() was equivalent to cpu_is_pj4(), wouldn't be correct for
multiplatform kernels. Fix it by also considering mmp_chip_id, as is
done for cpu_is_pxa168() and cpu_is_pxa910() above.

Moreover, it is only available with CONFIG_CPU_MMP2 and thus doesn't work
on DT-based MMP2 machines. Enable it on CONFIG_MACH_MMP2_DT too.

Note: CONFIG_CPU_MMP2 is only used for machines that use board files
instead of DT. It should perhaps be renamed. I'm not doing it now, because
I don't have a better idea.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Cc: stable@vger.kernel.org
Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/mach-mmp/cputype.h |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/arch/arm/mach-mmp/cputype.h
+++ b/arch/arm/mach-mmp/cputype.h
@@ -44,10 +44,12 @@ static inline int cpu_is_pxa910(void)
 #define cpu_is_pxa910()	(0)
 #endif
 
-#ifdef CONFIG_CPU_MMP2
+#if defined(CONFIG_CPU_MMP2) || defined(CONFIG_MACH_MMP2_DT)
 static inline int cpu_is_mmp2(void)
 {
-	return (((read_cpuid_id() >> 8) & 0xff) == 0x58);
+	return (((read_cpuid_id() >> 8) & 0xff) == 0x58) &&
+		(((mmp_chip_id & 0xfff) == 0x410) ||
+		 ((mmp_chip_id & 0xfff) == 0x610));
 }
 #else
 #define cpu_is_mmp2()	(0)


