Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752140AbeCNPim (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 11:38:42 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:34337 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751366AbeCNPij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 11:38:39 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Shaohua Li <shli@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-raid@vger.kernel.org
Subject: [PATCH 07/47] raid: remove tile specific raid6 implementation
Date: Wed, 14 Mar 2018 16:35:20 +0100
Message-Id: <20180314153603.3127932-8-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180314153603.3127932-1-arnd@arndb.de>
References: <20180314153603.3127932-1-arnd@arndb.de>
X-Provags-ID: V03:K0:drkzofKeJ4x6meiDQsb+7PL0lNA5wierTu2QulNTFi2M487GN8f
 rQpXJlQY0KLGKQ4ghU10WoUeQnBenCuquYLszFA1rcaHrJLRzPLAt9DhpRUpHRbVJ00jp8m
 hRr+45tjp6M8h5FL1f6PSpK4d8Fmyd6P3dBrNbdVmCPllH/+kXT4jje/gkCX3txoqOpPlnB
 XaNssmMBYBEkqo8954VsA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FQXA9P5HT9k=:Dn5zeEkiuhdInc6Wok4kCZ
 MMRpb5cGaeEVHAzQV9ZuV/JKV6mGp5UFU2YHIfgXwYDAYdlQrudss3fiA3+9AfblrKZabskcm
 FUQgxUcy2nv+Y3AHQT4hW284HktB3veJzBXY0Ft8lax0N3wFjw+Cs2HNc2ribMlqOh+XMzMVZ
 hJOsDpgu+PbkyUK15wveEjYz8whZcuZRswobVkqa/ZG05jwz2k4tm8+QAXT9gU0jTq5mDPmF6
 WVQL6FJCWLzoxdAFxWlc9TwIeNOsDRBNEb7zY6pngVyYhBbuUVX1kqtJJ5XPPPaL3mlriXHht
 irHkNrvOJ6ULeMmZGxJ9r7YBPLZyaOP1E5cmvLE1x7LzyErNchZqNwRl8sQseFMR5ZcelL0sf
 Nbed6bTJcmDEDuCfqBHRqdg43TCK3xKtwsIf4oEmeWSy50XU2KEWkdy3Vv9tzzWOmTNdaGsNc
 +7lSRgKycIYxuguv5X8XBl5ZYY29EJ52jElEstfvjTJw7RWG0LXF2NJ5J5NrOiw3ULBlW9lRQ
 G0WaRsKqeCHauzysJdRk+pNnDHjhupE0+I3g6lBR9OzXIiFKe9B6F4df4CzxdZvRq3xeYwNLu
 11fMBNX6MmuznO+1DlEoaJ4E2A6b2VE+4AdWdWke+BzWmXBWKqZhicYZF1f50MNA4QmeEGrNd
 hRaYzv9vtF7BdBKiDuZB104VNyTOpoNdFBqKQG6JwYHSbxPRE9DYORdh+hNaaGi7ZZMO0B8Ip
 HphcIrko3lY75llh30cZc4Cn4aD5G5NC5ryeoA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Tile architecture is getting removed, so we no longer need this either.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/raid/pq.h |  1 -
 lib/raid6/Makefile      |  6 ----
 lib/raid6/algos.c       |  3 --
 lib/raid6/test/Makefile |  7 ----
 lib/raid6/tilegx.uc     | 87 -------------------------------------------------
 5 files changed, 104 deletions(-)
 delete mode 100644 lib/raid6/tilegx.uc

diff --git a/include/linux/raid/pq.h b/include/linux/raid/pq.h
index 583cdd3d49ca..a366cc314479 100644
--- a/include/linux/raid/pq.h
+++ b/include/linux/raid/pq.h
@@ -105,7 +105,6 @@ extern const struct raid6_calls raid6_avx2x4;
 extern const struct raid6_calls raid6_avx512x1;
 extern const struct raid6_calls raid6_avx512x2;
 extern const struct raid6_calls raid6_avx512x4;
-extern const struct raid6_calls raid6_tilegx8;
 extern const struct raid6_calls raid6_s390vx8;
 
 struct raid6_recov_calls {
diff --git a/lib/raid6/Makefile b/lib/raid6/Makefile
index 4add700ddfe3..44d6b46df051 100644
--- a/lib/raid6/Makefile
+++ b/lib/raid6/Makefile
@@ -7,7 +7,6 @@ raid6_pq-y	+= algos.o recov.o tables.o int1.o int2.o int4.o \
 raid6_pq-$(CONFIG_X86) += recov_ssse3.o recov_avx2.o mmx.o sse1.o sse2.o avx2.o avx512.o recov_avx512.o
 raid6_pq-$(CONFIG_ALTIVEC) += altivec1.o altivec2.o altivec4.o altivec8.o
 raid6_pq-$(CONFIG_KERNEL_MODE_NEON) += neon.o neon1.o neon2.o neon4.o neon8.o recov_neon.o recov_neon_inner.o
-raid6_pq-$(CONFIG_TILEGX) += tilegx8.o
 raid6_pq-$(CONFIG_S390) += s390vx8.o recov_s390xc.o
 
 hostprogs-y	+= mktables
@@ -115,11 +114,6 @@ $(obj)/neon8.c:   UNROLL := 8
 $(obj)/neon8.c:   $(src)/neon.uc $(src)/unroll.awk FORCE
 	$(call if_changed,unroll)
 
-targets += tilegx8.c
-$(obj)/tilegx8.c:   UNROLL := 8
-$(obj)/tilegx8.c:   $(src)/tilegx.uc $(src)/unroll.awk FORCE
-	$(call if_changed,unroll)
-
 targets += s390vx8.c
 $(obj)/s390vx8.c:   UNROLL := 8
 $(obj)/s390vx8.c:   $(src)/s390vx.uc $(src)/unroll.awk FORCE
diff --git a/lib/raid6/algos.c b/lib/raid6/algos.c
index 476994723258..c65aa80d67ed 100644
--- a/lib/raid6/algos.c
+++ b/lib/raid6/algos.c
@@ -75,9 +75,6 @@ const struct raid6_calls * const raid6_algos[] = {
 	&raid6_altivec4,
 	&raid6_altivec8,
 #endif
-#if defined(CONFIG_TILEGX)
-	&raid6_tilegx8,
-#endif
 #if defined(CONFIG_S390)
 	&raid6_s390vx8,
 #endif
diff --git a/lib/raid6/test/Makefile b/lib/raid6/test/Makefile
index be1010bdc435..fabc477b1417 100644
--- a/lib/raid6/test/Makefile
+++ b/lib/raid6/test/Makefile
@@ -51,9 +51,6 @@ else
                 OBJS += altivec1.o altivec2.o altivec4.o altivec8.o
         endif
 endif
-ifeq ($(ARCH),tilegx)
-OBJS += tilegx8.o
-endif
 
 .c.o:
 	$(CC) $(CFLAGS) -c -o $@ $<
@@ -116,15 +113,11 @@ int16.c: int.uc ../unroll.awk
 int32.c: int.uc ../unroll.awk
 	$(AWK) ../unroll.awk -vN=32 < int.uc > $@
 
-tilegx8.c: tilegx.uc ../unroll.awk
-	$(AWK) ../unroll.awk -vN=8 < tilegx.uc > $@
-
 tables.c: mktables
 	./mktables > tables.c
 
 clean:
 	rm -f *.o *.a mktables mktables.c *.uc int*.c altivec*.c neon*.c tables.c raid6test
-	rm -f tilegx*.c
 
 spotless: clean
 	rm -f *~
diff --git a/lib/raid6/tilegx.uc b/lib/raid6/tilegx.uc
deleted file mode 100644
index 2dd291a11264..000000000000
-- 
2.9.0
