Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97A4C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4F5D20661
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550957145;
	bh=czL78sGzLnEiNkinsanjqxWjm/FZt9SpM4kuenFyWwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J+T5TkwtUJeZ7Ft07VCDBt2cb4ml8shu4ht+kECwpBDrgnTStq2GBkwftqIig1Wwb
	 oy59T/9+wxOrAIkmczKlNKF4I0M9LQhoaGbJYIT4nNyTmhiABTHKL2uykdoEXwz4g+
	 gLQBHjZuJPJIrQWezLDLDUqNGiSNPFNN7NPB3cpM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbfBWVZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:25:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:42944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728475AbfBWVHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:07:42 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2D712086A;
        Sat, 23 Feb 2019 21:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550956061;
        bh=czL78sGzLnEiNkinsanjqxWjm/FZt9SpM4kuenFyWwo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SUCVwQGXqJOyZEGT1zj7cbPGlCfdMp1RfdiToyjZWouUwtQT8AT3xJT3HEQ9nGbN6
         9aLNk+yVOvmHYNYrotZfJVXi70Xaxj5zik+7I7g/MqzaTwEklpAH2njKPN4ZaY3mrA
         b6/P13VSAXrfQYVHcOKIyplxB+/Jdwem0UHn27Nc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Fathi Boudra <fathi.boudra@linaro.org>,
        Shuah Khan <shuah@kernel.org>, Sasha Levin <sashal@kernel.org>,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 36/65] selftests: net: use LDLIBS instead of LDFLAGS
Date:   Sat, 23 Feb 2019 16:06:11 -0500
Message-Id: <20190223210640.200911-36-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223210640.200911-1-sashal@kernel.org>
References: <20190223210640.200911-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fathi Boudra <fathi.boudra@linaro.org>

[ Upstream commit 870f193d48c25a97d61a8e6c04e3c29a2c606850 ]

reuseport_bpf_numa fails to build due to undefined reference errors:

 aarch64-linaro-linux-gcc
 --sysroot=/build/tmp-rpb-glibc/sysroots/hikey -Wall
 -Wl,--no-as-needed -O2 -g -I../../../../usr/include/  -Wl,-O1
 -Wl,--hash-style=gnu -Wl,--as-needed -lnuma  reuseport_bpf_numa.c
 -o
 /build/tmp-rpb-glibc/work/hikey-linaro-linux/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/net/reuseport_bpf_numa
 /tmp/ccfUuExT.o: In function `send_from_node':
 /build/tmp-rpb-glibc/work/hikey-linaro-linux/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/net/reuseport_bpf_numa.c:138:
 undefined reference to `numa_run_on_node'
 /tmp/ccfUuExT.o: In function `main':
 /build/tmp-rpb-glibc/work/hikey-linaro-linux/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/net/reuseport_bpf_numa.c:230:
 undefined reference to `numa_available'
 /build/tmp-rpb-glibc/work/hikey-linaro-linux/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/net/reuseport_bpf_numa.c:233:
 undefined reference to `numa_max_node'

It's GNU Make and linker specific.

The default Makefile rule looks like:

$(CC) $(CFLAGS) $(LDFLAGS) $@ $^ $(LDLIBS)

When linking is done by gcc itself, no issue, but when it needs to be passed
to proper ld, only LDLIBS follows and then ld cannot know what libs to link
with.

More detail:
https://www.gnu.org/software/make/manual/html_node/Implicit-Variables.html

LDFLAGS
Extra flags to give to compilers when they are supposed to invoke the linker,
‘ld’, such as -L. Libraries (-lfoo) should be added to the LDLIBS variable
instead.

LDLIBS
Library flags or names given to compilers when they are supposed to invoke the
linker, ‘ld’. LOADLIBES is a deprecated (but still supported) alternative to
LDLIBS. Non-library linker flags, such as -L, should go in the LDFLAGS
variable.

https://lkml.org/lkml/2010/2/10/362

tools/perf: libraries must come after objects

Link order matters, use LDLIBS instead of LDFLAGS to properly link against
libnuma.

Signed-off-by: Fathi Boudra <fathi.boudra@linaro.org>
Signed-off-by: Shuah Khan <shuah@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 919aa2ac00af7..9a3764a1084ea 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -18,6 +18,6 @@ TEST_GEN_PROGS += reuseport_dualstack reuseaddr_conflict tls
 KSFT_KHDR_INSTALL := 1
 include ../lib.mk
 
-$(OUTPUT)/reuseport_bpf_numa: LDFLAGS += -lnuma
+$(OUTPUT)/reuseport_bpf_numa: LDLIBS += -lnuma
 $(OUTPUT)/tcp_mmap: LDFLAGS += -lpthread
 $(OUTPUT)/tcp_inq: LDFLAGS += -lpthread
-- 
2.19.1

