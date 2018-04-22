Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48wvrdmh0/3w7puGf6H4c/oEplI0e6pRutdadKscLpU28uOKwXgmnXa+DU4kiYpr0liVxvZ
ARC-Seal: i=1; a=rsa-sha256; t=1524405726; cv=none;
        d=google.com; s=arc-20160816;
        b=nNYjysQdv5Vx3oUgyPSvuCKjyEDqKRgNY7AqZug5MuedgqIDsjzSU2uDaimQNFVdFB
         +4uJjFJWHL0D3zrNT8in00YglehBaEdNhc9NeGHGJbh9QRTX73TLHyT1cPkDKHEjcqNx
         9xRhTP2kd+rtF1YOElpys+AOzSaFVG2M+dvu1/n8BJ+v7h0l1SLsyRdqDsB2iceLS+NR
         0V3WxkNXyRCXsvGpSUz37NPgGVM2LZl3FTQqEvrHu5StPRjz6OTzd64vgIOWTRfTPbuu
         Aa+IF7+idynqKTIcdB0PdHJFr6dblIFa4WckxwdXEZBQRFjCaut/g/lSxNrpVcObjMaG
         U/bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=B2Z6jrr50MzBKxwv/fg2uBFq4mfctJ/WGXGXBzI3P4M=;
        b=hRkkkrj2m5OJEk8bUk0ZomIfkYDX/Tbrz4S21mt4kNEecPhkVrsjIjEba/Wow+coUo
         QuSxPXLrkCqSgi+CU6mfKdOm6kA5iVj4FtYfuhOnVg2C5sD2JDbvnlAf8PNlZ00QjWry
         JlE1+xQlBOgZNp1XugliAXlDh3Nr6z/t+NJB4tEJY6SOW6ZLzoZt9QHOffeqpoLZK3LM
         9XaLx+OOiG4+RQwoqUVFASFWbM4UNC8ONIJVZmZlWCYEzKa8ArsknfchMj+DAaImL05Z
         MzJUuOWQUQgneLs74rvAaRy9yjI40ga55BtR/m+n+AzwYzk8t7Ok7pyYhWyKGIqZqUt0
         LFuw==
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
Subject: [PATCH 4.16 173/196] MIPS: uaccess: Add micromips clobbers to bzero invocation
Date: Sun, 22 Apr 2018 15:53:13 +0200
Message-Id: <20180422135113.201192144@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455259602480989?=
X-GMAIL-MSGID: =?utf-8?q?1598455259602480989?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -654,6 +654,13 @@ __clear_user(void __user *addr, __kernel
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
@@ -663,7 +670,7 @@ __clear_user(void __user *addr, __kernel
 			"move\t%0, $6"
 			: "=r" (res)
 			: "r" (addr), "r" (size)
-			: "$4", "$5", "$6", __UA_t0, __UA_t1, "$31");
+			: bzero_clobbers);
 	} else {
 		might_fault();
 		__asm__ __volatile__(
@@ -674,7 +681,7 @@ __clear_user(void __user *addr, __kernel
 			"move\t%0, $6"
 			: "=r" (res)
 			: "r" (addr), "r" (size)
-			: "$4", "$5", "$6", __UA_t0, __UA_t1, "$31");
+			: bzero_clobbers);
 	}
 
 	return res;
