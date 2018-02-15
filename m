Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225ichfKOgr3Oa6YvEjElFmsPWUigKiGsG4D6sbiAEntyLnBTL4fFdTfSi+hHbb4UcLUm2xo
ARC-Seal: i=1; a=rsa-sha256; t=1518709206; cv=none;
        d=google.com; s=arc-20160816;
        b=B8/HpQlSLGpFtKXbjB5LbXasz9b4jciH7lr4CAJQRuWTzYsOpUcgQLM1R7EaSTq0of
         wQvgxHV0TfbNOAEds54qrLE3V/aawY74zehTriTnoUFY5uIPk+Zuh3ovgPXjrUnJDAK2
         C8Ysy5y+DwTEbQy01yWHtgpF0ozODHUdzPKJK87PesOf/Mi9cdrekQTrS+2J9hDA5KKZ
         t1P+Rk3bnjANfa0zKbt5/9DmevWGh8z84Oe8lqBH5quNikvHa6zpfWVpf+qZaVepxRkS
         K7BLt8Ta2PMwfLLGIBLvTBG4f0ld4lb8Osk0fAe3R6UbfzPjmKWnNJjhAxSuyRocIx+q
         3x+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=k9c8TUsIWfyRVVls/zINC0VdJhYmlY+Hf6EPf4MDeg8=;
        b=A+dSqtSFcExe0Bmmt7c67plFexF4zm7XM0HysVoJ8EpAo23/eMo1e9epEe5MNSlmd3
         FI/CbwIVQGGw6a2OK1Vc1N7tS5VmjvWuuNO7EAGhh5XSV7o4xBoPmSWUAGJ0s+p5meFQ
         PV5KRsuZHNNE238MlIDD9OFmNQXyTHQZcUkRbJYBW8USlxDnlpR8OEVWYmgEmaO+T4bV
         t4iSSZXwrcoChc3e3NNGvL8dokqG9hpc3s1iZi3ngHW8h7lIEDfelZUmDQcO3XDz8fAo
         LdiGtvcYgK2UMJwsj129oTsrM2e7KHYVJkupj39+pRGEI82VlJiyMa9FJMD2V8eb2cLi
         oQzw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Laura Abbott <labbott@redhat.com>,
	Shanker Donthineni <shankerd@codeaurora.org>,
	Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.15 034/202] [Variant 3/Meltdown] arm64: Kconfig: Add CONFIG_UNMAP_KERNEL_AT_EL0
Date: Thu, 15 Feb 2018 16:15:34 +0100
Message-Id: <20180215151714.786408198@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481480355530880?=
X-GMAIL-MSGID: =?utf-8?q?1592482024636402463?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>


Commit 084eb77cd3a8 upstream.

Add a Kconfig entry to control use of the entry trampoline, which allows
us to unmap the kernel whilst running in userspace and improve the
robustness of KASLR.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Laura Abbott <labbott@redhat.com>
Tested-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/Kconfig |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -843,6 +843,19 @@ config FORCE_MAX_ZONEORDER
 	  However for 4K, we choose a higher default value, 11 as opposed to 10, giving us
 	  4M allocations matching the default size used by generic code.
 
+config UNMAP_KERNEL_AT_EL0
+	bool "Unmap kernel when running in userspace (aka \"KAISER\")"
+	default y
+	help
+	  Some attacks against KASLR make use of the timing difference between
+	  a permission fault which could arise from a page table entry that is
+	  present in the TLB, and a translation fault which always requires a
+	  page table walk. This option defends against these attacks by unmapping
+	  the kernel whilst running in userspace, therefore forcing translation
+	  faults for all of kernel space.
+
+	  If unsure, say Y.
+
 menuconfig ARMV8_DEPRECATED
 	bool "Emulate deprecated/obsolete ARMv8 instructions"
 	depends on COMPAT
