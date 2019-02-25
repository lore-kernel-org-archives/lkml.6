Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA26C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BA2421872
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129759;
	bh=9gR3wno0JDOKhBM2+lpxqVX0iEoeRhNV4JFInzvJV60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d6eITqtzpcCquNNcTMW7k1vPHBNfkwPnmp0Bcdz8A6BR7N6d64BJmX38mgUgFf4fl
	 lgs5YctH/0GaBEu1hG/fozlEzGDDMzvbRsGCe3Y04ydi72Uve8oxeMRXVUVvXftzmY
	 wzrcJU6ySk0FYSm1OPF7cm6BtFLWpw+kurn16ICY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730923AbfBYVWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:22:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:56768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729463AbfBYVWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:22:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19A2F21855;
        Mon, 25 Feb 2019 21:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129752;
        bh=9gR3wno0JDOKhBM2+lpxqVX0iEoeRhNV4JFInzvJV60=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iRjJ8HcYQikQwRpGKkyeSjd1TiC4v7KauVL12enpiLYT5uYPVRQXaHAGdAUy/L1w1
         uzGNiou0WtID5Px/ZD456vTWfy29kVtaWu9P82TZI1j1gg4VlUl1XSzfCEaJUDi3bt
         4QdD/Y9CvHXwFCPSeekKfzRoTPaFnEH38EaMB2sc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Naresh Kamboju <naresh.kamboju@linaro.org>,
        Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 055/152] bpf: fix panic in stack_map_get_build_id() on i386 and arm32
Date:   Mon, 25 Feb 2019 22:10:47 +0100
Message-Id: <20190225195047.358408033@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
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

[ Upstream commit beaf3d1901f4ea46fbd5c9d857227d99751de469 ]

As Naresh reported, test_stacktrace_build_id() causes panic on i386 and
arm32 systems. This is caused by page_address() returns NULL in certain
cases.

This patch fixes this error by using kmap_atomic/kunmap_atomic instead
of page_address.

Fixes: 615755a77b24 (" bpf: extend stackmap to save binary_build_id+offset instead of address")
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/stackmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 8061a439ef18c..e50ef5bca4213 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -260,7 +260,7 @@ static int stack_map_get_build_id(struct vm_area_struct *vma,
 		return -EFAULT;	/* page not mapped */
 
 	ret = -EINVAL;
-	page_addr = page_address(page);
+	page_addr = kmap_atomic(page);
 	ehdr = (Elf32_Ehdr *)page_addr;
 
 	/* compare magic x7f "ELF" */
@@ -276,6 +276,7 @@ static int stack_map_get_build_id(struct vm_area_struct *vma,
 	else if (ehdr->e_ident[EI_CLASS] == ELFCLASS64)
 		ret = stack_map_get_build_id_64(page_addr, build_id);
 out:
+	kunmap_atomic(page_addr);
 	put_page(page);
 	return ret;
 }
-- 
2.19.1



