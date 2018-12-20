Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6938C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4F0B20656
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545297778;
	bh=DKSn9G6waU4X/wmoZq7vpvu0bS8zp67LctkTj1ljqWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VaQ7I44Trxz9vsbnMS42iUvjVFMrvDBD6pWaqL+INtjsxZuTNvrLIqLTVkGi8GHzc
	 rzYMTj9HPP0lsJvc7D2eMGoa7ksO1mmpuX1Q3gOXHhvImZjC+xABzY21tFjtfh05/O
	 8qwVq6KzBBtg2PhcYV22TYKyGbOStY6Hjkm2uLBQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731438AbeLTJW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:22:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:48056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729578AbeLTJWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:22:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C68A217D7;
        Thu, 20 Dec 2018 09:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297771;
        bh=DKSn9G6waU4X/wmoZq7vpvu0bS8zp67LctkTj1ljqWo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=svL56PZWg25YnWYueWEAdhsF5BKY8Vt7Oc1CLDCpZ+XeFENHlS95uGLJJ721izHKT
         3BMYaT/7Zd0nuVOkyxmR+YNGAz9q0AJN8+UiZXs6BspQuY5qlcrssd/tz45DDBNZnm
         zIAU1PGygv8NxMwts7VhePaioPw+stY99cQCCWoM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Subject: [PATCH 4.9 11/61] ARM: mmp/mmp2: fix cpu_is_mmp2() on mmp2-dt
Date:   Thu, 20 Dec 2018 10:18:11 +0100
Message-Id: <20181220085844.182515027@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085843.743900603@linuxfoundation.org>
References: <20181220085843.743900603@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -43,10 +43,12 @@ static inline int cpu_is_pxa910(void)
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


