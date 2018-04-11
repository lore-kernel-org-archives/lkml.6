Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49Nm/rLU8T89HnZg4ZK0ntnvY0xFmDyxpYVvU6/DxVqDi0+I6qDIqo+B8prIU8ZYbswIpRO
ARC-Seal: i=1; a=rsa-sha256; t=1523472956; cv=none;
        d=google.com; s=arc-20160816;
        b=TTBsB1xRjnzmc0Qtout/aZM6eNBjjj6nsZIp3/Z1VOG9m6hvh31QMTqg3wL1SuJjJX
         Ocqoqn2dIuhZ9hwMZhZPJxWdCwoPj+DBtQVYT36jrQj2iUuwHNIxkspAndPUERKo4/mX
         QcsDlImiPq4hc9tDDOh56bmVL98iaPu3i1D8ia06ZtaxYoqdEUJwbTUmOWrJFs47YH1/
         Yjkoyaj3h4eTWVCb2UQjhfcuby3TSpr2CUO5P0XLKOdcQm045R6br9Ii5CpeWZvM7XS6
         YZhk6Drbs5Ev0JP1VihamLmK5ZYZjXLImJatyDhEcy1gz6KoQ7xa0+ANnlzqx5RLjUW0
         Mv0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=66WmHLqORCrwY/H3QC6vvMENFfReDDbHJ+haKQP8VG0=;
        b=rH7QTj5HeS5+yzRxNUwi1OgnbGS6+LXoDiYvLQQZUBt+rKjtOdVN/zaGpjszJf/ad4
         WYDYUmLkUC4NRlFp57yROq2Rv47mNtiADGhz66jFtEzjkWHdleVs8NnnDlLrwwmfzOy8
         WbJh7+dkgeoQE8z7Eii0H2va0yFBXFmKRVIMYA4SLBMjjA6fZHajmmioDe+vjo/OmkGy
         atJRwQpM4o4OLa2f39y8RDRPlBpFl3dFxZyJxvUMoRMDkr4nPrhV2EGNL5wRq1Sn+bw3
         S0v5vCVDHRBRvSs8PJXqfuD/4VK0C0U+jlPeIypReBMVuUvWzAeLExIBQjBSWRJ5dKpP
         UrGA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Paul Mackerras <paulus@ozlabs.org>,
	Balbir Singh <bsingharora@gmail.com>,
	Breno Leitao <breno.leitao@gmail.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 078/310] powerpc/mm: Fix virt_addr_valid() etc. on 64-bit hash
Date: Wed, 11 Apr 2018 20:33:37 +0200
Message-Id: <20180411183625.658342181@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476532787324883?=
X-GMAIL-MSGID: =?utf-8?q?1597477179703875927?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Ellerman <mpe@ellerman.id.au>


[ Upstream commit e41e53cd4fe331d0d1f06f8e4ed7e2cc63ee2c34 ]

virt_addr_valid() is supposed to tell you if it's OK to call virt_to_page() on
an address. What this means in practice is that it should only return true for
addresses in the linear mapping which are backed by a valid PFN.

We are failing to properly check that the address is in the linear mapping,
because virt_to_pfn() will return a valid looking PFN for more or less any
address. That bug is actually caused by __pa(), used in virt_to_pfn().

eg: __pa(0xc000000000010000) = 0x10000  # Good
    __pa(0xd000000000010000) = 0x10000  # Bad!
    __pa(0x0000000000010000) = 0x10000  # Bad!

This started happening after commit bdbc29c19b26 ("powerpc: Work around gcc
miscompilation of __pa() on 64-bit") (Aug 2013), where we changed the definition
of __pa() to work around a GCC bug. Prior to that we subtracted PAGE_OFFSET from
the value passed to __pa(), meaning __pa() of a 0xd or 0x0 address would give
you something bogus back.

Until we can verify if that GCC bug is no longer an issue, or come up with
another solution, this commit does the minimal fix to make virt_addr_valid()
work, by explicitly checking that the address is in the linear mapping region.

Fixes: bdbc29c19b26 ("powerpc: Work around gcc miscompilation of __pa() on 64-bit")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Reviewed-by: Paul Mackerras <paulus@ozlabs.org>
Reviewed-by: Balbir Singh <bsingharora@gmail.com>
Tested-by: Breno Leitao <breno.leitao@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/include/asm/page.h |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -132,7 +132,19 @@ extern long long virt_phys_offset;
 #define virt_to_pfn(kaddr)	(__pa(kaddr) >> PAGE_SHIFT)
 #define virt_to_page(kaddr)	pfn_to_page(virt_to_pfn(kaddr))
 #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
+
+#ifdef CONFIG_PPC_BOOK3S_64
+/*
+ * On hash the vmalloc and other regions alias to the kernel region when passed
+ * through __pa(), which virt_to_pfn() uses. That means virt_addr_valid() can
+ * return true for some vmalloc addresses, which is incorrect. So explicitly
+ * check that the address is in the kernel region.
+ */
+#define virt_addr_valid(kaddr) (REGION_ID(kaddr) == KERNEL_REGION_ID && \
+				pfn_valid(virt_to_pfn(kaddr)))
+#else
 #define virt_addr_valid(kaddr)	pfn_valid(virt_to_pfn(kaddr))
+#endif
 
 /*
  * On Book-E parts we need __va to parse the device tree and we can't
