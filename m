Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt041RQZa7LF/BwAfOw2jjn3pXogVgX/cAtVsNEPkKxgAmOjSYe9nitApXR2/RckMHlBeAZ
ARC-Seal: i=1; a=rsa-sha256; t=1521214827; cv=none;
        d=google.com; s=arc-20160816;
        b=f4mXrrrHssgTqv/LUqYz4Z9Ls80yHT8Rmai3exXWNtJAajCd8x7Ogdvz04a9xfH5F4
         RBJaNdo8vEGixJFgKDJ3LxVO06rwPomrRgpawRY3kxwFHQfQxV/79Lye8aNE0g9s6vPb
         Oxt4HDG269B1ee/j0vzRS3JDs2jZFoy3wvDXwSEh5USEvnoBn+hnxDvVMTj+xbFBjBjl
         WJZ1h7E2gYFzLvcA8WKqx7UjfF47BZJOhjzmaRVAXCxmRr3PCRSOc5wgMWLYWyqYw6Ax
         2jnxFIds8aBvEmJaal5d4jgT3+pqZvTVK3fwm8J9DEFXbwSzv94+AJAb0FJOJYb1okEi
         Tdvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=DivJ7eOWBJFkLkMv7yb0wRlp67UkWIQKFKS3j4VSvc8=;
        b=tFS6Ee70k01uZ105fGg+obLtn7IwiwgBsObSXIYn3wXSJWcsUqonXGm2DzPgQ3Y6aZ
         10TtVcDGPXMSSgZvLMfZuF4t3li+lm9+TOQw5jAk9MQ8olTEifypQrpKd9d1jJLicn4W
         Ss7ahfJpkNwvYVBkNAIewE6SPYdmf2sWjcTqHPjPzeyb9eLzmOJHQQOCjVfUk7yoguz2
         QCGHzk0V8SAypHgAkDUFOMgASK9GSmmwx3bEq5NJXWMbgQn5yme39ClF6UQh7P3d8eEm
         LvOBTyY5GZd8beaEpZ9YPzR5pVsIIadO7a3nabTvUSb/2tujhUZjb64VE5PLoegrwaFD
         sTtg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Paul Mackerras <paulus@ozlabs.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 031/128] KVM: PPC: Book3S HV: Avoid shifts by negative amounts
Date: Fri, 16 Mar 2018 16:22:52 +0100
Message-Id: <20180316152338.111324352@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109358581904240?=
X-GMAIL-MSGID: =?utf-8?q?1595109358581904240?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Mackerras <paulus@ozlabs.org>


[ Upstream commit cda2eaa35948893d70145490d5d6ded546fc3bc6 ]

The kvmppc_hpte_page_shifts function decodes the actual and base page
sizes for a HPTE, returning -1 if it doesn't recognize the page size
encoding.  This then gets used as a shift amount in various places,
which is undefined behaviour.  This was reported by Coverity.

In fact this should never occur, since we should only get HPTEs in the
HPT which have a recognized page size encoding.  The only place where
this might not be true is in the call to kvmppc_actual_pgsz() near the
beginning of kvmppc_do_h_enter(), where we are validating the HPTE
value passed in from the guest.

So to fix this and eliminate the undefined behaviour, we make
kvmppc_hpte_page_shifts return 0 for unrecognized page size encodings,
and make kvmppc_actual_pgsz() detect that case and return 0 for the
page size, which will then cause kvmppc_do_h_enter() to return an
error and refuse to insert any HPTE with an unrecognized page size
encoding.

To ensure that we don't get undefined behaviour in compute_tlbie_rb(),
we take the 4k page size path for any unrecognized page size encoding.
This should never be hit in practice because it is only used on HPTE
values which have previously been checked for having a recognized
page size encoding.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/include/asm/kvm_book3s_64.h | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index 735cfa35298a..998f7b7aaa9e 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -122,13 +122,13 @@ static inline int kvmppc_hpte_page_shifts(unsigned long h, unsigned long l)
 	lphi = (l >> 16) & 0xf;
 	switch ((l >> 12) & 0xf) {
 	case 0:
-		return !lphi ? 24 : -1;		/* 16MB */
+		return !lphi ? 24 : 0;		/* 16MB */
 		break;
 	case 1:
 		return 16;			/* 64kB */
 		break;
 	case 3:
-		return !lphi ? 34 : -1;		/* 16GB */
+		return !lphi ? 34 : 0;		/* 16GB */
 		break;
 	case 7:
 		return (16 << 8) + 12;		/* 64kB in 4kB */
@@ -140,7 +140,7 @@ static inline int kvmppc_hpte_page_shifts(unsigned long h, unsigned long l)
 			return (24 << 8) + 12;	/* 16MB in 4kB */
 		break;
 	}
-	return -1;
+	return 0;
 }
 
 static inline int kvmppc_hpte_base_page_shift(unsigned long h, unsigned long l)
@@ -159,7 +159,11 @@ static inline int kvmppc_hpte_actual_page_shift(unsigned long h, unsigned long l
 
 static inline unsigned long kvmppc_actual_pgsz(unsigned long v, unsigned long r)
 {
-	return 1ul << kvmppc_hpte_actual_page_shift(v, r);
+	int shift = kvmppc_hpte_actual_page_shift(v, r);
+
+	if (shift)
+		return 1ul << shift;
+	return 0;
 }
 
 static inline int kvmppc_pgsize_lp_encoding(int base_shift, int actual_shift)
@@ -232,7 +236,7 @@ static inline unsigned long compute_tlbie_rb(unsigned long v, unsigned long r,
 		va_low ^= v >> (SID_SHIFT_1T - 16);
 	va_low &= 0x7ff;
 
-	if (b_pgshift == 12) {
+	if (b_pgshift <= 12) {
 		if (a_pgshift > 12) {
 			sllp = (a_pgshift == 16) ? 5 : 4;
 			rb |= sllp << 5;	/*  AP field */
-- 
2.16.2
