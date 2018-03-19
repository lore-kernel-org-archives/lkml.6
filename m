Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsAhkQ2fnbhhTb7O+OuY5EbGVcczRgItcDFLnL/EysjPLluI3y/9PoiinN7kszD6A7YYQXm
ARC-Seal: i=1; a=rsa-sha256; t=1521483303; cv=none;
        d=google.com; s=arc-20160816;
        b=K3S6mE5dv9+SE/tmLFcq0LPHQVqeMQVc2Ll/z8DaS32JH1d4hPAF0cpgxEdPePhzeQ
         M340A/W0oGJ0ziWVOIGpjE1NPCcFlo/zu5h2p5axX7JGzgDhbs2R/i/SV3pgz5b0UPhr
         PDJOJXyjKm6uHiXYBT5gU573Tg4QUzTPbSFOV2kSHGV6r5eTwqNFIny/RE2b2AyuUGzC
         k0srsAkf/1+Y/nOLTF/BOHUsJuMI/rl2fTpmfzsRY59e27aF4Tz+AP/nmTtxl2ZSz09d
         M3aVomAEZChcCtIYXLyVXwPUsha0m8wuBttDlmhpGhugSBjKplfmo4M4s65LrUPhIbun
         vtRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=aYRB68j0bwXjR+qU4/FS5nJBXk0j6alxvi3x5StNJKc=;
        b=lCVZ15IlDAp6YqwWs0a5bZhV/06zx9JlVswlvfrpK9GdiIxxSG5ASpMqwe2/WRE8Xp
         9PZm4R4kdxdjPTtZmQiOWUAsaMzVcR1cAlYC+DVksuaKwXf3FQP3at+TqLODzcqIVLV4
         Gkao0/WXNxoQPAv5Iog3HkooFqIND5ty3AiLpumB20yYIIKcCHQpMouAyI7c0Pm+6grb
         IAwJOpt/NqixgwJrXO9dKEwegPWvFQ3UNilabHs/O6Xjd8zwEbC31fa8deUs2Lh1+G87
         s2Eixu+K+SnAqHBQ/V/ZI8KMY9QJwHXMGAcwxcgKhGPzRSocpOyjB2w49FPMV8jUwXhP
         kxdg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 041/134] powerpc/mm/hugetlb: Filter out hugepage size not supported by page table layout
Date: Mon, 19 Mar 2018 19:05:24 +0100
Message-Id: <20180319171855.295206021@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390876998071483?=
X-GMAIL-MSGID: =?utf-8?q?1595390876998071483?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>


[ Upstream commit a525108cf1cc14651602d678da38fa627a76a724 ]

Without this if firmware reports 1MB page size support we will crash
trying to use 1MB as hugetlb page size.

echo 300 > /sys/kernel/mm/hugepages/hugepages-1024kB/nr_hugepages

kernel BUG at ./arch/powerpc/include/asm/hugetlb.h:19!
.....
....
[c0000000e2c27b30] c00000000029dae8 .hugetlb_fault+0x638/0xda0
[c0000000e2c27c30] c00000000026fb64 .handle_mm_fault+0x844/0x1d70
[c0000000e2c27d70] c00000000004805c .do_page_fault+0x3dc/0x7c0
[c0000000e2c27e30] c00000000000ac98 handle_page_fault+0x10/0x30

With fix, we don't enable 1MB as hugepage size.

bash-4.2# cd /sys/kernel/mm/hugepages/
bash-4.2# ls
hugepages-16384kB  hugepages-16777216kB

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/mm/hugetlbpage.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -828,6 +828,24 @@ static int __init add_huge_page_size(uns
 	if ((mmu_psize = shift_to_mmu_psize(shift)) < 0)
 		return -EINVAL;
 
+#ifdef CONFIG_PPC_BOOK3S_64
+	/*
+	 * We need to make sure that for different page sizes reported by
+	 * firmware we only add hugetlb support for page sizes that can be
+	 * supported by linux page table layout.
+	 * For now we have
+	 * Radix: 2M
+	 * Hash: 16M and 16G
+	 */
+	if (radix_enabled()) {
+		if (mmu_psize != MMU_PAGE_2M)
+			return -EINVAL;
+	} else {
+		if (mmu_psize != MMU_PAGE_16M && mmu_psize != MMU_PAGE_16G)
+			return -EINVAL;
+	}
+#endif
+
 	BUG_ON(mmu_psize_defs[mmu_psize].shift != shift);
 
 	/* Return if huge page size has already been setup */
