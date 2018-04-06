Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/+TrgIJROqmr2Nuzian70dgiKNKurnGSYrh/rXUm0RC1U3MBfwE/f8qyWibn4E4mTIhDhe
ARC-Seal: i=1; a=rsa-sha256; t=1523021860; cv=none;
        d=google.com; s=arc-20160816;
        b=er4lLRc6VdKKl0pkqUqN8bbvehKnI5zvOzB4Qw5ZkcWrWr5qDISlyCu+dGn/79GJ1T
         //m44PyivC4+j+bDGu1FSXn2uUist1rjkiTCehGriLFdNtNGzY6sDcQjaRTKqEibwJNf
         hpaIYmD4w3vsWn/dfqyDcvAtEySJ7yJxr4q1zrlhs+5QKbMGVpLRDTh6RTt6ED51Yg1m
         OVrn10N5SGqR91KK1Ui9bCaWZ3wAlFgMP4p40NGkQGoO//dS9torHqoB9WH1T9H8H84A
         dIJM3cLSwKNECjCJ2sHaEBsO9XT6M+mQnJ9VSismcbSc5dI/eKGS2EBKrDXU/lUPzrZX
         13tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=bN9tnnuH7OKTHCrdTIZqmvjg+eQK12YMi4ScL50iMec=;
        b=R6gvGe+1ngUBTa5Yr5eQ50Sez0rEmaXEfdFybk2SGrPl5XSWO5N3A3+QCcFBJ51XHh
         6HGidTi3SEq1YDUpufFdlJaTBVVUvLMzKwLHwKn8oR4zYrSdZUBB3yZaCqCQY+SwvuJ1
         lYzhGgeR7pYJNvn9YoOOUWih6562mLbePUOUHnMVZwxhADPAaxbyfe1WZOqMpNrvlnSH
         JDBsmvh1sCYdhytxJVoOUZY7ZU4e/uJis9BXv6bx6LhVx+UqMVBDP7bIIFaI82K1zzc1
         BLhfz9vBdDzDDH4i5FH2wle+6VVGPdBJWJBOTCfxymHxOZo2Nm5Q+OJH3g6bUH3hLy9Y
         IpyQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Laura Abbott <labbott@redhat.com>,
	Shanker Donthineni <shankerd@codeaurora.org>,
	Will Deacon <will.deacon@arm.com>,
	Greg Hackmann <ghackmann@google.com>,
	Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 4.9 065/102] arm64: Kconfig: Add CONFIG_UNMAP_KERNEL_AT_EL0
Date: Fri,  6 Apr 2018 15:23:46 +0200
Message-Id: <20180406084340.697495344@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004170340341691?=
X-GMAIL-MSGID: =?utf-8?q?1597004170340341691?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>

commit 084eb77cd3a8 upstream.

Add a Kconfig entry to control use of the entry trampoline, which allows
us to unmap the kernel whilst running in userspace and improve the
robustness of KASLR.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Laura Abbott <labbott@redhat.com>
Tested-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org> [v4.9 backport]
Signed-off-by: Mark Rutland <mark.rutland@arm.com> [v4.9 backport]
Tested-by: Will Deacon <will.deacon@arm.com>
Tested-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/Kconfig |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -733,6 +733,19 @@ config FORCE_MAX_ZONEORDER
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
