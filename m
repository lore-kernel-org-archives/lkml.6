Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D787C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3F63217D6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277368;
	bh=WTgGYpivzXALAaZbGLsRvbkY9VG4yvxAfRRAjGt0KZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d3Kt14ATGKU5BYqr8AtmwEuFFpicPNviMIe36aCvSq0h+SCMiDcIj3vIa2SEUJbhO
	 IoGyPVVJzc0tVHARcLFom63Sx++HJTrwSXXKwfIHFiV0+RnJ7YnD3KUY/nv9lZW6sc
	 h/wc1Yq4lXzArdUXvF1KYCAJRafxmVIHmWmchJ9Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbfBDKt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:49:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:47182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731610AbfBDKtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:49:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A81E3217D6;
        Mon,  4 Feb 2019 10:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277356;
        bh=WTgGYpivzXALAaZbGLsRvbkY9VG4yvxAfRRAjGt0KZ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bgHvt89e8AIW34MoY78A8C7Zoz0lZnUURvxIIMxer3Z/toO11M66hxGutr0VteAAJ
         7ey1aFGDHh/+JYh1c+BgFkIVagXcbjZHvQzzMfrb3sox7jTO23ql3SJKIWStVzMb//
         9G8XJH2FQmRHz/DDkn++r32s0nxmcOvd82aktGnA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shijith Thotton <sthotton@marvell.com>,
        Wandun Chen <chenwandun@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.19 42/74] arm64: Do not issue IPIs for user executable ptes
Date:   Mon,  4 Feb 2019 11:36:55 +0100
Message-Id: <20190204103624.955606020@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103619.714714157@linuxfoundation.org>
References: <20190204103619.714714157@linuxfoundation.org>
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
 


