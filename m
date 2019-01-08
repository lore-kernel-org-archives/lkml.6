Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14676C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDBA42173C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546975613;
	bh=AWghuTEZ9r7Ncpg9n+1Z1fLUheNVwqQGX3RVNz2pxbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Su3/YA4WtbXED8S1rJttBEkynjeYW7g0Nby0HE1dQf4GlyQnQZ285ImN5e23HaqvT
	 zlPXsxG+GZvBvUFUR2LCC/AfU/p94hZeEkuCAUbatFnf3+Wn4RZmLhWA8mxg4IyQHO
	 J5762yJ/thlbOX2H5QDjwVZC0oBk+dlk9yNc0220=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbfAHT0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:26:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:60870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729198AbfAHT0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:26:50 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECBC720827;
        Tue,  8 Jan 2019 19:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975608;
        bh=AWghuTEZ9r7Ncpg9n+1Z1fLUheNVwqQGX3RVNz2pxbY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cYWhpSjkhdu7LbVnGCM6Gjwkd0jsRZtQVgTAPywPBPluR/DvdKa6yBb1UjW+2DjdQ
         AC1lwC1D3K50eVjxTZvL4fxj2e9Hkt7lqEpsccXKDsYQrHFaQrUc1IhmJTRW7IBpq9
         3D/zwBQxLrY9QQthEYm9CE/r5nX4U8oeq6j5LiKc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Quentin Monnet <quentin.monnet@netronome.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 011/117] selftests/bpf: enable (uncomment) all tests in test_libbpf.sh
Date:   Tue,  8 Jan 2019 14:24:39 -0500
Message-Id: <20190108192628.121270-11-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192628.121270-1-sashal@kernel.org>
References: <20190108192628.121270-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Monnet <quentin.monnet@netronome.com>

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
index e39dfb4e7970..ecd79b7fb107 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -135,6 +135,16 @@ endif
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
index 156d89f1edcc..2989b2e2d856 100755
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

