Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6040EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24427223DD
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRvO9MJP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24427223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388304AbeKOIod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:44:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:36000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbeKOI3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:29:12 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F120D22527;
        Wed, 14 Nov 2018 22:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234248;
        bh=OXwmR47vh17dVim0cmkjQhNJCv+Egbaq8phYPnvkLWc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BRvO9MJP+tEvjKmMsQhSXAvRFDxt7mOZAUeBX+NcUt5P12HBgxW1jM/u2O2QjdFsX
         6ZYmDCvWLyGHiFEDt58wlw0vl5UBEi7NL02+iyPZ+lyQG0HhOcER/td79qnjG7ZDi1
         mrtiPFLR35CafJlJAO6T1fdniZ5Iv/twwnaI5474=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Sandipan Das <sandipan@linux.vnet.ibm.com>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.18 10/59] bpf: fix bpf_prog_get_info_by_fd to return 0 func_lens for unpriv
Date:   Wed, 14 Nov 2018 17:22:42 -0500
Message-Id: <20181114222335.99339-10-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222335.99339-1-sashal@kernel.org>
References: <20181114222335.99339-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Borkmann <daniel@iogearbox.net>

[ Upstream commit 28c2fae726bf5003cd209b0d5910a642af98316f ]

While dbecd7388476 ("bpf: get kernel symbol addresses via syscall")
zeroed info.nr_jited_ksyms in bpf_prog_get_info_by_fd() for queries
from unprivileged users, commit 815581c11cc2 ("bpf: get JITed image
lengths of functions via syscall") forgot about doing so and therefore
returns the #elems of the user set up buffer which is incorrect. It
also needs to indicate a info.nr_jited_func_lens of zero.

Fixes: 815581c11cc2 ("bpf: get JITed image lengths of functions via syscall")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Sandipan Das <sandipan@linux.vnet.ibm.com>
Cc: Song Liu <songliubraving@fb.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/syscall.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a31a1ba0f8ea..482215292b0f 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1896,6 +1896,7 @@ static int bpf_prog_get_info_by_fd(struct bpf_prog *prog,
 		info.jited_prog_len = 0;
 		info.xlated_prog_len = 0;
 		info.nr_jited_ksyms = 0;
+		info.nr_jited_func_lens = 0;
 		goto done;
 	}
 
-- 
2.17.1

