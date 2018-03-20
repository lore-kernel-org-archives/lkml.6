Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753542AbeCTM7N (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 08:59:13 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53405 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753367AbeCTM7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 08:59:07 -0400
From: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH] test_bpf: Fix testing with CONFIG_BPF_JIT_ALWAYS_ON=y on other arches
Date: Tue, 20 Mar 2018 09:58:51 -0300
Message-Id: <20180320125851.19650-1-cascardo@canonical.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 lib/test_bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index 2efb213716faa..3e9335493fe49 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -5467,7 +5467,7 @@ static struct bpf_test tests[] = {
 	{
 		"BPF_MAXINSNS: Jump, gap, jump, ...",
 		{ },
-#ifdef CONFIG_BPF_JIT_ALWAYS_ON
+#if defined(CONFIG_BPF_JIT_ALWAYS_ON) && defined(CONFIG_X86)
 		CLASSIC | FLAG_NO_DATA | FLAG_EXPECTED_FAIL,
 #else
 		CLASSIC | FLAG_NO_DATA,
-- 
2.15.1
