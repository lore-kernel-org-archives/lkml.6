Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225ZnR1wfRWD4p0p2wjESXmBnrzYhfrGSf21yyhPivrb9ug1siVpFT7ToRrZjfgoWOTi+uGC
ARC-Seal: i=1; a=rsa-sha256; t=1518709211; cv=none;
        d=google.com; s=arc-20160816;
        b=ZL5nhdb1nehkPdn01jf/zq7BoFKl5cBZNkVpapdqBl2nZPTr1xPe5DvyN5EBC7+0Zq
         xE3Q64+ZNdYLZ7DDH11dccBbuY+ypWs7XLEnjB/muQR2Ku+RyMasqedE+ydR8DdCHm6I
         vV5P1vfPkTBw3WsreIg7/lS1j2lw/8bICxspyu5plAv7rx04EtxgBCUngsG6UbaXKC8L
         llBWo1ZoStB7dIjsfc8tEcpkVIfoYZVXa9ci7buVCLnRA0ClDkxTFhFr5zLRrUoNTh3V
         Dy1inaZHgGrFnQ79Vm6+xaHe6YOsrg7E1tusydHZsKVOv65VnWmduFYk02rDNKL4HPgf
         A/Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5lJaiqZQ7PeZ2CLWdHj3jbhrUk3OSbvCTM5QCMIyPOo=;
        b=cr/b9rJPMPtFdpxr6sQFXM9WXehXhaKh0yTO0M1qdcdjAewwoKFWCNmB+LtAKxtR6O
         b6YAosAWOXeyCYiqllCRZwNW1W8h/wFjMNo/PGPTgRLv1oUJfgDLZ96DYRxKRfMhL7Ms
         bx9rUuD5rmwGstD8gLTT0adB7BsMXzWplwpskCSGqIHSezn4EctwCrYYxLhqYm0GDcUm
         Zcj1P8Q71U2PlaHzGCMXQItjtSneWjO2Dn8tsed1A2eW2gU5bF7COx+6VxxRSnv/nDWJ
         ozD/ErlzP2szFf6E5gBTX6VkZWVjj0MaNf20HSNzayKjBL/CMVQAJbp8eDUcA/6uslRX
         kcHQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.15 035/202] [Variant 3/Meltdown] arm64: Kconfig: Reword UNMAP_KERNEL_AT_EL0 kconfig entry
Date: Thu, 15 Feb 2018 16:15:35 +0100
Message-Id: <20180215151714.840722419@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481483131893734?=
X-GMAIL-MSGID: =?utf-8?q?1592482030026602443?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>


Commit 0617052ddde3 upstream.

Although CONFIG_UNMAP_KERNEL_AT_EL0 does make KASLR more robust, it's
actually more useful as a mitigation against speculation attacks that
can leak arbitrary kernel data to userspace through speculation.

Reword the Kconfig help message to reflect this, and make the option
depend on EXPERT so that it is on by default for the majority of users.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/Kconfig |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -844,15 +844,14 @@ config FORCE_MAX_ZONEORDER
 	  4M allocations matching the default size used by generic code.
 
 config UNMAP_KERNEL_AT_EL0
-	bool "Unmap kernel when running in userspace (aka \"KAISER\")"
+	bool "Unmap kernel when running in userspace (aka \"KAISER\")" if EXPERT
 	default y
 	help
-	  Some attacks against KASLR make use of the timing difference between
-	  a permission fault which could arise from a page table entry that is
-	  present in the TLB, and a translation fault which always requires a
-	  page table walk. This option defends against these attacks by unmapping
-	  the kernel whilst running in userspace, therefore forcing translation
-	  faults for all of kernel space.
+	  Speculation attacks against some high-performance processors can
+	  be used to bypass MMU permission checks and leak kernel data to
+	  userspace. This can be defended against by unmapping the kernel
+	  when running in userspace, mapping it back in on exception entry
+	  via a trampoline page in the vector table.
 
 	  If unsure, say Y.
 
