Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227rfv6qUAs2+yWP0mZgIXK2yzuCQKRGx2mM5Xpy6fWNiUerHiU468WX9Fs0pNVFNPpv5lnv
ARC-Seal: i=1; a=rsa-sha256; t=1518709265; cv=none;
        d=google.com; s=arc-20160816;
        b=PIvK/bwRpqJ4xxn/BWXiC33mqWe3QrOQoBhDIt565/usSoCZ91gWI235JXPMjuiGJ0
         hccBYI/Cyq5Avw1YD8G6JhZogR6OqTElN480s2xi13kIWtBjeVMecg6kFX08iBiX3cCt
         ZaD3kOK/Os9A4vgQsskh8NhpHxyKsNAScTK6uXgz23xVPUQmXYx1uv238F10q5izohWc
         Od5FvXj/e0vFML6CTbG++mTNzoCOZyyHhjjKOzBwzJ2W5rdHM8+DQkeuNwknmcF0ApFv
         5ed+FmkgzWCh73C5CZC3QP6BZaXjhuvpHrU56ckB6480ocQcQeZuk6bkpKG07i08boLe
         UvoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=XCw9XrlCjMKahc480yOzSNP6690JVebfaU33W0vL5TE=;
        b=w4JgNPMWE9kqxn2VvpuDXSZydq6qtQ5irhB6rGQzhweZcLLuFYlbhWdVmurGLx64oZ
         oV8zLAH0821jW2FkWGTIWD4Ssl4alJAJEdq1x8/1WkA3vAe9JBc38VOO67HRrik49GM9
         nbsjyp4nD7uPUOBysRHZJu0F3l1z7cfysgCHEKaYOx2Xq62CZrqnL/Yb3k6hTwW050Kn
         uav1v5p3eCcAa+MU80SevHCDfgQ2dLK8eBsUFDitpFBXWWGL2shotVp30xRUNAqMRXU6
         e2beCIk+myThQjHGdKjpdMWR94mfll1dkVLdqsa/mpd+FYocZWORIKmfdRZAGEr3s2Lm
         0RGA==
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
Subject: [PATCH 4.15 057/202] [Variant 1/Spectre-v1] arm64: futex: Mask __user pointers prior to dereference
Date: Thu, 15 Feb 2018 16:15:57 +0100
Message-Id: <20180215151716.256293611@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481537914190837?=
X-GMAIL-MSGID: =?utf-8?q?1592482086507830173?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>


Commit 91b2d3442f6a upstream.

The arm64 futex code has some explicit dereferencing of user pointers
where performing atomic operations in response to a futex command. This
patch uses masking to limit any speculative futex operations to within
the user address space.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/futex.h |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/arch/arm64/include/asm/futex.h
+++ b/arch/arm64/include/asm/futex.h
@@ -48,9 +48,10 @@ do {									\
 } while (0)
 
 static inline int
-arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
+arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *_uaddr)
 {
 	int oldval = 0, ret, tmp;
+	u32 __user *uaddr = __uaccess_mask_ptr(_uaddr);
 
 	pagefault_disable();
 
@@ -88,15 +89,17 @@ arch_futex_atomic_op_inuser(int op, int
 }
 
 static inline int
-futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
+futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *_uaddr,
 			      u32 oldval, u32 newval)
 {
 	int ret = 0;
 	u32 val, tmp;
+	u32 __user *uaddr;
 
-	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
+	if (!access_ok(VERIFY_WRITE, _uaddr, sizeof(u32)))
 		return -EFAULT;
 
+	uaddr = __uaccess_mask_ptr(_uaddr);
 	uaccess_enable();
 	asm volatile("// futex_atomic_cmpxchg_inatomic\n"
 "	prfm	pstl1strm, %2\n"
