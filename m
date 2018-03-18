Return-Path: <liuwenliang@huawei.com>
X-Google-Smtp-Source: AG47ELu6UpvYIYRUzT9acMPFZuxe5f074wRyWcOKEaupTCfMFdUW8JCUPqa0+SO1Qj2mHpW0XEb3
ARC-Seal: i=1; a=rsa-sha256; t=1521378829; cv=none;
        d=google.com; s=arc-20160816;
        b=yCj3YV2pDWPQoHC/MJilLueW89pL8/d4p5gYewKrbdy2uI/eJQuEKilUNzuouVa9GP
         g3AF4EjpJO+glcP9ELQiCN9HHg63YKQ8zh4HFl66cNdnvEckQ5ttZ/qO3m95d7cgNTi1
         72T9r8eLtrf7Udwp8+IpKaKa0xK01ep3RJWGg6rTkQTvf638an4SipoFc9VPQqry4BJ4
         qsW6PgkyjqSUpf6pq8tpIlMn/6DySHoAStR8if9cannJNhefU79dEuPbGhX1EUTPmLAv
         Z/TqftAY9bFgQp1sWn88yJ2+Noar5jy6MhcSn3JdkajnrCYiYH0NknR03beL91A5XdaT
         QyDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=lTxpIFFh58vmJxEWR02loWAsikfJ+s9CWRPwhE1dby8=;
        b=ZHZYF2Mnfw0wophEJ8x8f/Y3aogiPRE6h2eCgD+61Se3LZlWtDUdNxKutNdth7UPWO
         GvnLvKxAHsx1divvYmEtYWvA7CXTJwGU8vYgx+f7eYGIKL2bmu0bC4GjjuogR/lDotMY
         giY0PYHhOWqd/yhparK/CR5vGzH2HTvfaJcYEp3dpElSgyH0jxsqf/qXgeVDMq2CtlHO
         eRqOKYXPHNsKHg1Qp2M9m8VdzMl6USm9VJ8TaxdoNr3EOKb/93GU6Lt8A65f9zNzTC/9
         TjIwhdRZTRPUYzH6Lw3uj0eJ9SstMQKwL0yYmXO7ichKtlonmSLD2FpDmN8IJoJJJESz
         UetA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of liuwenliang@huawei.com designates 45.249.212.35 as permitted sender) smtp.mailfrom=liuwenliang@huawei.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of liuwenliang@huawei.com designates 45.249.212.35 as permitted sender) smtp.mailfrom=liuwenliang@huawei.com
From: Abbott Liu <liuwenliang@huawei.com>
To: <linux@armlinux.org.uk>, <aryabinin@virtuozzo.com>,
	<marc.zyngier@arm.com>, <kstewart@linuxfoundation.org>,
	<gregkh@linuxfoundation.org>, <f.fainelli@gmail.com>,
	<liuwenliang@huawei.com>, <akpm@linux-foundation.org>,
	<afzal.mohd.ma@gmail.com>, <alexander.levin@verizon.com>
CC: <glider@google.com>, <dvyukov@google.com>, <christoffer.dall@linaro.org>,
	<linux@rasmusvillemoes.dk>, <mawilcox@microsoft.com>, <pombredanne@nexb.com>,
	<ard.biesheuvel@linaro.org>, <vladimir.murzin@arm.com>,
	<nicolas.pitre@linaro.org>, <tglx@linutronix.de>, <thgarnie@google.com>,
	<dhowells@redhat.com>, <keescook@chromium.org>, <arnd@arndb.de>,
	<geert@linux-m68k.org>, <tixy@linaro.org>, <mark.rutland@arm.com>,
	<james.morse@arm.com>, <zhichao.huang@linaro.org>, <jinb.park7@gmail.com>,
	<labbott@redhat.com>, <philip@cog.systems>, <grygorii.strashko@linaro.org>,
	<catalin.marinas@arm.com>, <opendmb@gmail.com>,
	<kirill.shutemov@linux.intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <kasan-dev@googlegroups.com>,
	<kvmarm@lists.cs.columbia.edu>, <linux-mm@kvack.org>
Subject: [PATCH 1/7] 2 1-byte checks more safer for memory_is_poisoned_16
Date: Sun, 18 Mar 2018 20:53:36 +0800
Message-ID: <20180318125342.4278-2-liuwenliang@huawei.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180318125342.4278-1-liuwenliang@huawei.com>
References: <20180318125342.4278-1-liuwenliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.187.223]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595281327885358177?=
X-GMAIL-MSGID: =?utf-8?q?1595281327885358177?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Because in some architecture(eg. arm) instruction set, non-aligned
access support is not very well, so 2 1-byte checks is more
safer than 1 2-byte check. The impact on performance is small
because 16-byte accesses are not too common.

Cc: Andrey Ryabinin <a.ryabinin@samsung.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Russell King - ARM Linux <linux@armlinux.org.uk>
Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Acked-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Abbott Liu <liuwenliang@huawei.com>
---
 mm/kasan/kasan.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/mm/kasan/kasan.c b/mm/kasan/kasan.c
index e13d911..104839a 100644
--- a/mm/kasan/kasan.c
+++ b/mm/kasan/kasan.c
@@ -151,13 +151,20 @@ static __always_inline bool memory_is_poisoned_2_4_8(unsigned long addr,
 
 static __always_inline bool memory_is_poisoned_16(unsigned long addr)
 {
-	u16 *shadow_addr = (u16 *)kasan_mem_to_shadow((void *)addr);
-
-	/* Unaligned 16-bytes access maps into 3 shadow bytes. */
-	if (unlikely(!IS_ALIGNED(addr, KASAN_SHADOW_SCALE_SIZE)))
-		return *shadow_addr || memory_is_poisoned_1(addr + 15);
+	u8 *shadow_addr = (u8 *)kasan_mem_to_shadow((void *)addr);
 
-	return *shadow_addr;
+	if (unlikely(shadow_addr[0] || shadow_addr[1])) {
+		return true;
+	} else if (likely(IS_ALIGNED(addr, KASAN_SHADOW_SCALE_SIZE))) {
+		/*
+		 * If two shadow bytes covers 16-byte access, we don't
+		 * need to do anything more. Otherwise, test the last
+		 * shadow byte.
+		 */
+		return false;
+	} else {
+		return memory_is_poisoned_1(addr + 15);
+	}
 }
 
 static __always_inline unsigned long bytes_is_nonzero(const u8 *start,
-- 
2.9.0
