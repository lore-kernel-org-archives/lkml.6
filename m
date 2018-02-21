Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x2250OdkxSMvfps39+oqbFP0AcZbYdVEoTtH/w48Pm6iKidd0+o9ZSmxwVCK3mppe2ghzKJSg
ARC-Seal: i=1; a=rsa-sha256; t=1519231963; cv=none;
        d=google.com; s=arc-20160816;
        b=0cefJ7vcEwszhgqKJ2uYpO0oeIha7FtISYljwK9qb7GQ71Up8B2wwvQck3rNPJoS0B
         MULnwZTO00nM0gbU1bUelIh935uUcqaJbGZsjJo+fP7gw+97FaQFHBbbPWkrQtUy2JmC
         bwgNmcB2epFBHfMpi2Enke3MIIWOq9feIQEE/AIJ0gpIB+4tC2tbKPxS4UlCgDJugk1N
         znu85el0pnfYZyDDOBKEFc3iaZvkDoeezeXjIoSnyDLcu0g/SpQ9O9Va5p8Z/B9xq4JC
         wTT3MG6klOgEibw8OfSYA3qvKRDni/SYDuVLP3bbhBEFbzOo6s6vzY/i67niHDluEUBa
         q4oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=mEvsyzmQjSie2fDWN3Ys+dFIgwV9JXuYQ26koiVh5lw=;
        b=Tot24pRJTMfcJRMOVlcGTgX72kh6dbP2ikatQQSlFLrRYXOHOBwh1re42X1n2C8LGp
         6/tT+yuFB/vkBPt0ahOf2mahEIVuq1kuvXbGxUsN0Ovepf9DPsMa21n1WYM3VV2WnyKN
         r7NKS0aO2j3fNm5HsfmyJ3toVYLARVzGu7BKgDiWik1BFozGusU5hp0X4k6aaPu1d1Qx
         xKBCDqMR87x+H5+uzuCzXsqsV4p80cNnmcDs5a760ENvfpJ+RdALuvYCeHOUubkt9+9b
         UPzgMuyMOJ/eh1pcXQRgMYC/KGlyXXnXvtTG+4imSg0EffvkSYlspB6WjSoBZurtFJKF
         E23Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=CeG76KBV;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=CeG76KBV;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753618AbeBUQvm (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 21 Feb 2018 11:51:42 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:41747 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753559AbeBUQvk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Feb 2018 11:51:40 -0500
From: Anders Roxell <anders.roxell@linaro.org>
To: shuah@kernel.org
Cc: daniel@iogearbox.net, ast@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests/bpf: tcpbpf_kern: use in6_* macros from glibc
Date: Wed, 21 Feb 2018 17:51:16 +0100
Message-Id: <20180221165116.9754-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593030175575827124?=
X-GMAIL-MSGID: =?utf-8?q?1593030175575827124?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Both glibc and the kernel have in6_* macros definitions. Build fails
because it picks up wrong in6_* macro from the kernel header and not the
header from glibc.

Fixes build error below:
clang -I. -I./include/uapi -I../../../include/uapi
     -Wno-compare-distinct-pointer-types \
         -O2 -target bpf -emit-llvm -c test_tcpbpf_kern.c -o - |      \
llc -march=bpf -mcpu=generic -filetype=obj
     -o .../tools/testing/selftests/bpf/test_tcpbpf_kern.o
In file included from test_tcpbpf_kern.c:12:
.../netinet/in.h:101:5: error: expected identifier
    IPPROTO_HOPOPTS = 0,   /* IPv6 Hop-by-Hop options.  */
    ^
.../linux/in6.h:131:26: note: expanded from macro 'IPPROTO_HOPOPTS'
                                ^
In file included from test_tcpbpf_kern.c:12:
/usr/include/netinet/in.h:103:5: error: expected identifier
    IPPROTO_ROUTING = 43,  /* IPv6 routing header.  */
    ^
.../linux/in6.h:132:26: note: expanded from macro 'IPPROTO_ROUTING'
                                ^
In file included from test_tcpbpf_kern.c:12:
.../netinet/in.h:105:5: error: expected identifier
    IPPROTO_FRAGMENT = 44, /* IPv6 fragmentation header.  */
    ^

Since both glibc and the kernel have in6_* macros definitions, use the
one from glibc.  Kernel headers will check for previous libc definitions
by including include/linux/libc-compat.h.

Reported-by: Daniel Díaz <daniel.diaz@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/bpf/test_tcpbpf_kern.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_tcpbpf_kern.c b/tools/testing/selftests/bpf/test_tcpbpf_kern.c
index 57119ad57a3f..3e645ee41ed5 100644
--- a/tools/testing/selftests/bpf/test_tcpbpf_kern.c
+++ b/tools/testing/selftests/bpf/test_tcpbpf_kern.c
@@ -5,7 +5,6 @@
 #include <linux/if_ether.h>
 #include <linux/if_packet.h>
 #include <linux/ip.h>
-#include <linux/in6.h>
 #include <linux/types.h>
 #include <linux/socket.h>
 #include <linux/tcp.h>
-- 
2.11.0

