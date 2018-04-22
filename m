Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+FrO52+ur/8iRgh5zJFNn2bM5MRGPXiOH3AyHSSYbUKppdtx3Vdf8Lwck+RpUv9fbywzlK
ARC-Seal: i=1; a=rsa-sha256; t=1524406460; cv=none;
        d=google.com; s=arc-20160816;
        b=wGd/ERwStr+xwS8EjK4G+bKRTSeeypCWCZhB1LlgJ8rRR1BynNWpVLp/LWMuZsb792
         Bxt3+OOtXFoSv8ZgebadYEtp/VFf9FxkpTF+yCWKh+nvWqK9oL+HEdDBW4wYJSJ7sKlR
         TSeY2/5X7eFYF9YZhGTyhWYQJkYPHtLpI8Al6Qeh69aL79D3nQho5YqUqDpRhC7XLTxZ
         WA/9q0eKQ/g7SDl0qBRfVkx9nmp2Hk/N+HO+rZ4iUM3j88z6/ZF2yRSwjALsrjCV/nvO
         dCX47vMJcM+ITMGE3+0O/bgp0rCBW3gAo0H6ArKUnbGAjSFelXodb+D9x5IzjuIUCPUt
         NPAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=STAQkNma3d/hiwRa9ALX5Yg2OUQJZqldljdOFHmqyx4=;
        b=Z5i5UlkBi4aZAXMB71zrD5ACMePnMuiLfxhbTLjAb+2XUS1OJmPZ6hHp4les6AtvdG
         XsMGIssWF0DK7y8gF++Ls6CX7mcmZ6UarlTiPDbHFCoiVu2LZwy/NuVa0ZI7cYbaBIeZ
         d7mE5MdE9dX2knQA2E+47UBL8zb/mKktN3jGatG33BfSQwdN+2n0KSX+yXLqPWpTNj0j
         0C0Ei0L3JaONdmscMlBKKMeVsUHgcA0C/+XYE9iJ5r/pRGEDHeB2SOCCiYX95+dA+VIu
         fAeUqWvLSvl2bYBwYEjoiAU3kL4OPGPTNnbJ3KNCwFf3ICnkKxgsxXkvr5lYBX54Spi0
         +NFg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	James Hogan <jhogan@kernel.org>,
	Matt Redfearn <matt.redfearn@mips.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: [PATCH 4.9 79/95] MIPS: uaccess: Add micromips clobbers to bzero invocation
Date: Sun, 22 Apr 2018 15:53:48 +0200
Message-Id: <20180422135213.660341092@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455259602480989?=
X-GMAIL-MSGID: =?utf-8?q?1598456028228052747?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matt Redfearn <matt.redfearn@mips.com>

commit b3d7e55c3f886493235bfee08e1e5a4a27cbcce8 upstream.

The micromips implementation of bzero additionally clobbers registers t7
& t8. Specify this in the clobbers list when invoking bzero.

Fixes: 26c5e07d1478 ("MIPS: microMIPS: Optimise 'memset' core library function.")
Reported-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 3.10+
Patchwork: https://patchwork.linux-mips.org/patch/19110/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/include/asm/uaccess.h |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/arch/mips/include/asm/uaccess.h
+++ b/arch/mips/include/asm/uaccess.h
@@ -1257,6 +1257,13 @@ __clear_user(void __user *addr, __kernel
 {
 	__kernel_size_t res;
 
+#ifdef CONFIG_CPU_MICROMIPS
+/* micromips memset / bzero also clobbers t7 & t8 */
+#define bzero_clobbers "$4", "$5", "$6", __UA_t0, __UA_t1, "$15", "$24", "$31"
+#else
+#define bzero_clobbers "$4", "$5", "$6", __UA_t0, __UA_t1, "$31"
+#endif /* CONFIG_CPU_MICROMIPS */
+
 	if (eva_kernel_access()) {
 		__asm__ __volatile__(
 			"move\t$4, %1\n\t"
@@ -1266,7 +1273,7 @@ __clear_user(void __user *addr, __kernel
 			"move\t%0, $6"
 			: "=r" (res)
 			: "r" (addr), "r" (size)
-			: "$4", "$5", "$6", __UA_t0, __UA_t1, "$31");
+			: bzero_clobbers);
 	} else {
 		might_fault();
 		__asm__ __volatile__(
@@ -1277,7 +1284,7 @@ __clear_user(void __user *addr, __kernel
 			"move\t%0, $6"
 			: "=r" (res)
 			: "r" (addr), "r" (size)
-			: "$4", "$5", "$6", __UA_t0, __UA_t1, "$31");
+			: bzero_clobbers);
 	}
 
 	return res;
