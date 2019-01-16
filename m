Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2452C43444
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3FB720657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="A/+1RsA1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbfAPRo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 12:44:26 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44424 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfAPRoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 12:44:25 -0500
Received: by mail-ot1-f66.google.com with SMTP id f18so8462494otl.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 09:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rjGu5CVIAm8AJWA4l+rx6t8yEPYdDyoeZJtii+mb+X4=;
        b=A/+1RsA1qWeOGru+NTCbI9tMTbwUCEmxSB6HjSc61ZmqlQhiyu/+VIDtuT/P/BHQ+9
         baKb5geW6QYq6avK8c446uHe/xAT7dmtNjp4LZJMHg+ai8IdzziCam8gho5Dya9uffa9
         Xa5D2ObyORG/9fqQwnx0m14a1Pk4GKXNrlZEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rjGu5CVIAm8AJWA4l+rx6t8yEPYdDyoeZJtii+mb+X4=;
        b=bYYjTkauerB98wxGRC9iFyA1HA56Qjs2VQk8a1+q3jNeEzw26RHtwDPMy+l/SFyy/Y
         SmA62SuWXnfumGsxHObko5XaSSec7FUTorJdTRu/Ortf856pxuLs8q15PyiJrT17YS6H
         kkQpLCvv1VOg83eSvVoENnQac9gTnq/8pawKm1++44ww3egudVjzQ9n8GJBPexpR63HE
         BLphs1ZhHPZiY0vgZeAMBycgcHG8Ft21E3Lww2KQmH+1oGUI5rVITf4bzn/xETKAmGDO
         zL3a5LdNfFnRSQjYSkjqNSEa89fCCCirAqIfN0MkMsNnMA8voPbDSmEGkkcp43SvGSZa
         hBIw==
X-Gm-Message-State: AJcUukdm9CWtxWUQo2L3TaDxg/zTbd0eqnUNfT0CSL9nQOIDdxxUcKMq
        /XR7CnuHi6nlVQOftNFyDgvkMg==
X-Google-Smtp-Source: ALg8bN6n82Zv+yTcNErlzZwi7o5YkE5AdO25K7+WDFyam2V3ydxRUvKbxDpft9R8+fqNnGg/cqVPaw==
X-Received: by 2002:a9d:4806:: with SMTP id c6mr5894410otf.127.1547660664043;
        Wed, 16 Jan 2019 09:44:24 -0800 (PST)
Received: from alago.cortijodelrio.net (CableLink-189-218-30-19.Hosts.InterCable.net. [189.218.30.19])
        by smtp.googlemail.com with ESMTPSA id m129sm3152973oif.50.2019.01.16.09.44.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 09:44:23 -0800 (PST)
From:   =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>
To:     shuah@kernel.org
Cc:     Fathi Boudra <fathi.boudra@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/4] selftests: net: use LDLIBS instead of LDFLAGS
Date:   Wed, 16 Jan 2019 11:43:18 -0600
Message-Id: <20190116174320.14938-2-daniel.diaz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190116174320.14938-1-daniel.diaz@linaro.org>
References: <20190116174320.14938-1-daniel.diaz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fathi Boudra <fathi.boudra@linaro.org>

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
---
 tools/testing/selftests/net/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index f8f3e90700c0..1e6d14d2825c 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -21,6 +21,6 @@ TEST_GEN_PROGS += reuseport_dualstack reuseaddr_conflict tls
 KSFT_KHDR_INSTALL := 1
 include ../lib.mk
 
-$(OUTPUT)/reuseport_bpf_numa: LDFLAGS += -lnuma
+$(OUTPUT)/reuseport_bpf_numa: LDLIBS += -lnuma
 $(OUTPUT)/tcp_mmap: LDFLAGS += -lpthread
 $(OUTPUT)/tcp_inq: LDFLAGS += -lpthread
-- 
2.17.1

