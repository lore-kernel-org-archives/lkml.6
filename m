Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FA9C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 282902251E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HvdJ+1aV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 282902251E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732206AbeKMPrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 10:47:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:33718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732167AbeKMPru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 10:47:50 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD7CC2250E;
        Tue, 13 Nov 2018 05:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542088282;
        bh=7mQEjIV2IFnljtef90NPlS5B4LarDbNuW7HZDt0nVlo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HvdJ+1aV8KYlkDGo8BjZILp8xpzc7dsasGNKaxZgxO5atzzcy0aHEvMJ9xINP0+uy
         1xFS3GDEotbQpAGkpZdOy8MoVmYwPPIiQ1u+Nt2RbUG4n+domF6iy7tjQmijMV2p4Y
         GD0fZ5roKQSDa12pwgmoXXPrxQUCGLAaRL6gSWLo=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Keith Busch <keith.busch@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org
Subject: [PATCH AUTOSEL 4.18 16/39] mm/gup_benchmark.c: prevent integer overflow in ioctl
Date:   Tue, 13 Nov 2018 00:50:30 -0500
Message-Id: <20181113055053.78352-16-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181113055053.78352-1-sashal@kernel.org>
References: <20181113055053.78352-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 4b408c74ee5a0b74fc9265c2fe39b0e7dec7c056 ]

The concern here is that "gup->size" is a u64 and "nr_pages" is unsigned
long.  On 32 bit systems we could trick the kernel into allocating fewer
pages than expected.

Link: http://lkml.kernel.org/r/20181025061546.hnhkv33diogf2uis@kili.mountain
Fixes: 64c349f4ae78 ("mm: add infrastructure for get_user_pages_fast() benchmarking")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Keith Busch <keith.busch@intel.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/gup_benchmark.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/gup_benchmark.c b/mm/gup_benchmark.c
index 7405c9d89d65..7e6f2d2dafb5 100644
--- a/mm/gup_benchmark.c
+++ b/mm/gup_benchmark.c
@@ -23,6 +23,9 @@ static int __gup_benchmark_ioctl(unsigned int cmd,
 	int nr;
 	struct page **pages;
 
+	if (gup->size > ULONG_MAX)
+		return -EINVAL;
+
 	nr_pages = gup->size / PAGE_SIZE;
 	pages = kvcalloc(nr_pages, sizeof(void *), GFP_KERNEL);
 	if (!pages)
-- 
2.17.1

