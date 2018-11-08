Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B6C2ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA8AB20892
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWyXhECL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA8AB20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731871AbeKIHnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:43:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:35840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731817AbeKIHna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:43:30 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4CEA208A3;
        Thu,  8 Nov 2018 22:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714759;
        bh=8pIylFoXJvt7gljvYoNLM3t0sQH+BLPBBd4VSvOGBQU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eWyXhECLYtI+h8WEVBEbNlgb+ZnHCsb+BQAKIyynFuW7HpqRVRCpIolIpcR57ITTo
         UItRe6nNsNQ0sAUYt3Sxg2iIXZlIKRimwc95wKxbNHVPWR/ktsAYgFE5ZAbV0PjjTe
         n0SNVdaoCG6FcPncL1a6Mt+N0n/HoBqoyjZyO110=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 113/171] test_bpf: Fix testing with CONFIG_BPF_JIT_ALWAYS_ON=y on other arches
Date:   Thu,  8 Nov 2018 13:51:23 -0800
Message-Id: <20181108215135.496714004@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

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



