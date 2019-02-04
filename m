Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24C7C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 774D52070C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277545;
	bh=Yh63WVOgxHo6CPFkA/9ccIaXEaDhoXbjYzps+F0VQiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Yjzkrau0Ec2Yt8Y01iFFyHnqCjNDFZdqtzmufHZPydofWLQvfiUOkjKY+FgMO/A79
	 YDxYZAyqymihO9/+bUeh9ERcj9F3cOrbEgZfUpOw2DTYH6i61RIg0mZ5jnABb5qDGJ
	 ICBFMS2sQEKV6Ak0wCF2DNDrRtYzKk0d4/v3pouU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732593AbfBDKwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:52:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:50040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732145AbfBDKwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:52:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 115252070C;
        Mon,  4 Feb 2019 10:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277540;
        bh=Yh63WVOgxHo6CPFkA/9ccIaXEaDhoXbjYzps+F0VQiY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ma5qVmt6IOg7XPijLd+6o7Ktr/PEsapoBU7zXEsklu19cB/WG7Pzvk7XpU6rhl57D
         dZIPNhS+UYXGcu+4JcszKCCFC2wNS7uA6iufwBfLEmC4L2hAQp5xlPjDqIY4Z8IDxe
         oSqhRSloDuLIpt8SeFKLY+HZlEv1UFXkhfwgZOBQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shijith Thotton <sthotton@marvell.com>,
        Wandun Chen <chenwandun@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.20 46/80] arm64: Do not issue IPIs for user executable ptes
Date:   Mon,  4 Feb 2019 11:37:06 +0100
Message-Id: <20190204103626.553349859@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103620.287366543@linuxfoundation.org>
References: <20190204103620.287366543@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Catalin Marinas <catalin.marinas@arm.com>

commit 132fdc379eb143932d209a20fd581e1ce7630960 upstream.

Commit 3b8c9f1cdfc5 ("arm64: IPI each CPU after invalidating the I-cache
for kernel mappings") was aimed at fixing the I-cache invalidation for
kernel mappings. However, it inadvertently caused all cache maintenance
for user mappings via set_pte_at() -> __sync_icache_dcache() ->
sync_icache_aliases() to call kick_all_cpus_sync().

Reported-by: Shijith Thotton <sthotton@marvell.com>
Tested-by: Shijith Thotton <sthotton@marvell.com>
Reported-by: Wandun Chen <chenwandun@huawei.com>
Fixes: 3b8c9f1cdfc5 ("arm64: IPI each CPU after invalidating the I-cache for kernel mappings")
Cc: <stable@vger.kernel.org> # 4.19.x-
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/mm/flush.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/arch/arm64/mm/flush.c
+++ b/arch/arm64/mm/flush.c
@@ -33,7 +33,11 @@ void sync_icache_aliases(void *kaddr, un
 		__clean_dcache_area_pou(kaddr, len);
 		__flush_icache_all();
 	} else {
-		flush_icache_range(addr, addr + len);
+		/*
+		 * Don't issue kick_all_cpus_sync() after I-cache invalidation
+		 * for user mappings.
+		 */
+		__flush_icache_range(addr, addr + len);
 	}
 }
 


