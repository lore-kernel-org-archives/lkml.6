Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EB0C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C892921726
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548359919;
	bh=AeuhT7JyfmwqzqXoaKhh61L0A+q3XgrKdrgjjP8vyhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Qn7GrmzenccVYXqBFESGruj/ewdlRsUA0YpFYCRKeBH6wOwh7y92LVLh5oyuCUmM4
	 AGU8LlAfsE9a+RL9zwZxsUeSsFJWyDeIUXNC8VUoZlzeHUSG/g5YV7lv6acgRCeFeJ
	 xq6NMriRpLYKunFDrUi4L7jBAax8xDDqfyG8/PJY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731395AbfAXT6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:58:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:34212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730158AbfAXTeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:34:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B744218D4;
        Thu, 24 Jan 2019 19:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358464;
        bh=AeuhT7JyfmwqzqXoaKhh61L0A+q3XgrKdrgjjP8vyhs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=je3UVxyyQRWvV75jM0XdINW42B2GD85U7nKZ6eNgs9kGkRL4KDmKJC+kZFdWgJ+N7
         GXpxUiF7v0yBfYpGQn/bu02MXk0ipRb5sb9c5uBM52J2/8eakUDmrORHoqaq9O2WgI
         i4uSxhiN8uQPDhQfd7qnYZphhF13TVfIB+NrrwtM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jesper Dangaard Brouer <brouer@redhat.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 018/106] selftests/bpf: enable (uncomment) all tests in test_libbpf.sh
Date:   Thu, 24 Jan 2019 20:19:35 +0100
Message-Id: <20190124190207.527931483@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190206.342411005@linuxfoundation.org>
References: <20190124190206.342411005@linuxfoundation.org>
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

[ Upstream commit f96afa767baffba7645f5e10998f5178948bb9aa ]

libbpf is now able to load successfully test_l4lb_noinline.o and
samples/bpf/tracex3_kern.o.

For the test_l4lb_noinline, uncomment related tests from test_libbpf.c
and remove the associated "TODO".

For tracex3_kern.o, instead of loading a program from samples/bpf/ that
might not have been compiled at this stage, try loading a program from
BPF selftests. Since this test case is about loading a program compiled
without the "-target bpf" flag, change the Makefile to compile one
program accordingly (instead of passing the flag for compiling all
programs).

Regarding test_xdp_noinline.o: in its current shape the program fails to
load because it provides no version section, but the loader needs one.
The test was added to make sure that libbpf could load XDP programs even
if they do not provide a version number in a dedicated section. But
libbpf is already capable of doing that: in our case loading fails
because the loader does not know that this is an XDP program (it does
not need to, since it does not attach the program). So trying to load
test_xdp_noinline.o does not bring much here: just delete this subtest.

For the record, the error message obtained with tracex3_kern.o was
fixed by commit e3d91b0ca523 ("tools/libbpf: handle issues with bpf ELF
objects containing .eh_frames")

I have not been abled to reproduce the "libbpf: incorrect bpf_call
opcode" error for test_l4lb_noinline.o, even with the version of libbpf
present at the time when test_libbpf.sh and test_libbpf_open.c were
created.

RFC -> v1:
- Compile test_xdp without the "-target bpf" flag, and try to load it
  instead of ../../samples/bpf/tracex3_kern.o.
- Delete test_xdp_noinline.o subtest.

Cc: Jesper Dangaard Brouer <brouer@redhat.com>
Signed-off-by: Quentin Monnet <quentin.monnet@netronome.com>
Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/Makefile       | 10 ++++++++++
 tools/testing/selftests/bpf/test_libbpf.sh | 14 ++++----------
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index fff7fb1285fc..f3f874ba186b 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -124,6 +124,16 @@ endif
 endif
 endif
 
+# Have one program compiled without "-target bpf" to test whether libbpf loads
+# it successfully
+$(OUTPUT)/test_xdp.o: test_xdp.c
+	$(CLANG) $(CLANG_FLAGS) \
+		-O2 -emit-llvm -c $< -o - | \
+	$(LLC) -march=bpf -mcpu=$(CPU) $(LLC_FLAGS) -filetype=obj -o $@
+ifeq ($(DWARF2BTF),y)
+	$(BTF_PAHOLE) -J $@
+endif
+
 $(OUTPUT)/%.o: %.c
 	$(CLANG) $(CLANG_FLAGS) \
 		 -O2 -target bpf -emit-llvm -c $< -o - |      \
diff --git a/tools/testing/selftests/bpf/test_libbpf.sh b/tools/testing/selftests/bpf/test_libbpf.sh
index d97dc914cd49..8b1bc96d8e0c 100755
--- a/tools/testing/selftests/bpf/test_libbpf.sh
+++ b/tools/testing/selftests/bpf/test_libbpf.sh
@@ -33,17 +33,11 @@ trap exit_handler 0 2 3 6 9
 
 libbpf_open_file test_l4lb.o
 
-# TODO: fix libbpf to load noinline functions
-# [warning] libbpf: incorrect bpf_call opcode
-#libbpf_open_file test_l4lb_noinline.o
+# Load a program with BPF-to-BPF calls
+libbpf_open_file test_l4lb_noinline.o
 
-# TODO: fix test_xdp_meta.c to load with libbpf
-# [warning] libbpf: test_xdp_meta.o doesn't provide kernel version
-#libbpf_open_file test_xdp_meta.o
-
-# TODO: fix libbpf to handle .eh_frame
-# [warning] libbpf: relocation failed: no section(10)
-#libbpf_open_file ../../../../samples/bpf/tracex3_kern.o
+# Load a program compiled without the "-target bpf" flag
+libbpf_open_file test_xdp.o
 
 # Success
 exit 0
-- 
2.19.1



