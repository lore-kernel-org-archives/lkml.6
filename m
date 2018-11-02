Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A207C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F9FB2084C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SR8LZfLq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F9FB2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731150AbeKCECO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:02:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:58012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729463AbeKCECN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:02:13 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5982C2082D;
        Fri,  2 Nov 2018 18:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184838;
        bh=xope5YjRmQg7SzEpfjTOMrXxr+mq+pTjjXDPFmF4l1Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SR8LZfLq2nafXLEPq0uEJkU8NzEjRYbuIG9P5YEgf0EdvR+L4t02vUhEQfCGquog1
         foh05MljuqRMdyoFUXgDiI7vlpimv18TkAMIrsRIzwCAYocMwDFTVEjrdgaBtILhfS
         xBR2RcNjQ06sUsw0oT7seHrsGGE8xdN9b+Fja/lg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 072/143] test_bpf: Fix testing with CONFIG_BPF_JIT_ALWAYS_ON=y on other arches
Date:   Fri,  2 Nov 2018 19:34:17 +0100
Message-Id: <20181102182903.134205822@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 52fda36d63bfc8c8e8ae5eda8eb5ac6f52cd67ed ]

Function bpf_fill_maxinsns11 is designed to not be able to be JITed on
x86_64. So, it fails when CONFIG_BPF_JIT_ALWAYS_ON=y, and
commit 09584b406742 ("bpf: fix selftests/bpf test_kmod.sh failure when
CONFIG_BPF_JIT_ALWAYS_ON=y") makes sure that failure is detected on that
case.

However, it does not fail on other architectures, which have a different
JIT compiler design. So, test_bpf has started to fail to load on those.

After this fix, test_bpf loads fine on both x86_64 and ppc64el.

Fixes: 09584b406742 ("bpf: fix selftests/bpf test_kmod.sh failure when CONFIG_BPF_JIT_ALWAYS_ON=y")
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Reviewed-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/test_bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index 64701b4c9900..75ebf2bbc2ee 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -5427,7 +5427,7 @@ static struct bpf_test tests[] = {
 	{
 		"BPF_MAXINSNS: Jump, gap, jump, ...",
 		{ },
-#ifdef CONFIG_BPF_JIT_ALWAYS_ON
+#if defined(CONFIG_BPF_JIT_ALWAYS_ON) && defined(CONFIG_X86)
 		CLASSIC | FLAG_NO_DATA | FLAG_EXPECTED_FAIL,
 #else
 		CLASSIC | FLAG_NO_DATA,
-- 
2.17.1



