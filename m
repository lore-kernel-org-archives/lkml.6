Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C132AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88E0E20823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="d8aQTDU/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88E0E20823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbeKSU4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 15:56:00 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:59555 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbeKSUz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 15:55:59 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id wAJAVrOA009918;
        Mon, 19 Nov 2018 19:31:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com wAJAVrOA009918
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542623513;
        bh=+LKuroFmzxn4Iv2kghmjy3Fv1P/6HtUAjZsqkO5MVRA=;
        h=From:To:Cc:Subject:Date:From;
        b=d8aQTDU/NnCbJq5jalDLUcMb2UiQovuCMj/IjNJ5UQNLASRDggGDCEDPn5dyVcKK3
         We7Ydll0cr8h2P/91yTboxcU+ochBe6DlhOQCuDFIAs+TVHegFR5l/dWFgwXrLUNSz
         MxFV3e/YIZgTMyii7Rn+wvgukt4zxMRJxAvS8NER9gkCJ0UUfMbRvNFbnvnIIoYyji
         THUH3cFofmWWpJi3UjBS3J1vcdlWudY111h50gWE9MRTFSXtLREIm2mm24hGd3GJfi
         8vqZleQT2N882diV6fYdWtRJFwgKvQGTiKaF09jDkNzyRaxVBN34ep7BivZGVDgCbl
         qXGrlm+hv/ZkQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Paul Burton <paul.burton@mips.com>
Subject: [PATCH v3 1/3] compiler_types.h: make __builtin_types_compatible_p() noop for Sparse
Date:   Mon, 19 Nov 2018 19:31:41 +0900
Message-Id: <1542623503-3755-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I tried to delete BUILD_BUG_ON stubs for sparse, the kbuild test
robot reported lots of Sparse warnings from container_of(), which
seem false positive.

The following checker in container_of() seems to be causing something
strange for Sparse.

  BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) &&   \
                   !__same_type(*(ptr), void),                    \
                   "pointer type mismatch in container_of()");    \

I narrowed down the problem into the following test code:

  --------------------(test_code.c begin)--------------------
  struct foo {
          int (*callback)(void);
  };

  void assert(int);

  static inline struct foo *get_foo(void)
  {
          assert(__builtin_types_compatible_p(void, void));

          return (struct foo *)0;
  }

  int test(void);
  int test(void)
  {
          return get_foo()->callback();
  }
  ---------------------(test_code.c end)---------------------

Of course, GCC (and Clang as well) can compile it:

  $ gcc -Wall -c -o test_code.o test_code.c

However, Sparse complains about this obviously correct code:

  $ sparse test_code.c
  test_code.c:9:45: warning: unknown expression (4 0)
  test_code.c:9:51: warning: unknown expression (4 0)

Interstingly, just removing the 'inline' keyword in the test code
makes Sparse happy.

I concluded that Sparse cannot handle __builtin_types_compatible_p()
correctly. Make it no-op.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3:
  - New patch

Changes in v2: None

 include/linux/compiler_types.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 4a3f9c0..9e7da0b 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -23,6 +23,7 @@
 extern void __chk_user_ptr(const volatile void __user *);
 extern void __chk_io_ptr(const volatile void __iomem *);
 # define ACCESS_PRIVATE(p, member) (*((typeof((p)->member) __force *) &(p)->member))
+# define __builtin_types_compatible_p(t1, t2)	(1)
 #else /* __CHECKER__ */
 # ifdef STRUCTLEAK_PLUGIN
 #  define __user __attribute__((user))
-- 
2.7.4

