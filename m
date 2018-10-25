Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B037CC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E9D120854
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sfsWs4UP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E9D120854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbeJYWt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:49:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:58584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729381AbeJYWtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:49:25 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0741620868;
        Thu, 25 Oct 2018 14:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476989;
        bh=4Xq4SOsjVyyVorzbDU/Z8L31vQpAWYy5ZsqzH1VTEak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sfsWs4UPh+d/AZsE7LK74PrUmyLGkcUMH60P2d558ND6+XgvkKzUwp79aMc5KLnFs
         x7YEhVdhlBHd5c4gHbeOfgK1UGy1UdOBy90PtT+83W8lqNwnhCEYml1JW0KyCk20KM
         27OuxK5E/YzteZ5C7E/U8bGTFirgUBMOxvLExqaQ=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 85/98] test_bpf: Fix testing with CONFIG_BPF_JIT_ALWAYS_ON=y on other arches
Date:   Thu, 25 Oct 2018 10:14:10 -0400
Message-Id: <20181025141423.213774-85-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>

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
index 1586dfdea809..960d4d627361 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -4874,7 +4874,7 @@ static struct bpf_test tests[] = {
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

