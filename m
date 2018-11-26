Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D3DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E41321104
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pStg9ICG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E41321104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731128AbeKZV6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:58:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:43884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbeKZV6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:58:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE15620672;
        Mon, 26 Nov 2018 11:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230289;
        bh=9U5DRpVWBsvViSDMUEXgjtdoXkcjRTUmq0Jch9Wm098=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pStg9ICGvtsrKzKyhWiduMOxm72hLFyMFjxD+Fl53kNCTahVJdJ+dljKL6EQoIj8s
         JvdqohpP0/TXEUXAWW91/VuSq5b6MSapvqiX5Fk6qPN5LkS8Hb9hsmk23I0B0H489o
         Xu4E9s2yHvtGMqj1zPVRByBBRiYSS4LGS7evCBq0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Sandipan Das <sandipan@linux.vnet.ibm.com>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 046/118] bpf: fix bpf_prog_get_info_by_fd to return 0 func_lens for unpriv
Date:   Mon, 26 Nov 2018 11:50:40 +0100
Message-Id: <20181126105102.663939142@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105059.832485122@linuxfoundation.org>
References: <20181126105059.832485122@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 675eb6d36e47..382c09dddf93 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1974,6 +1974,7 @@ static int bpf_prog_get_info_by_fd(struct bpf_prog *prog,
 		info.jited_prog_len = 0;
 		info.xlated_prog_len = 0;
 		info.nr_jited_ksyms = 0;
+		info.nr_jited_func_lens = 0;
 		goto done;
 	}
 
-- 
2.17.1



