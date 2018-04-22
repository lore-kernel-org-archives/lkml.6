Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/5Ev0NLa1OGsEknldQooiT95DkeSqo6R+HYLoCPg+6lLtnC9yshsesV/r76ACoQNJtrKNu
ARC-Seal: i=1; a=rsa-sha256; t=1524406727; cv=none;
        d=google.com; s=arc-20160816;
        b=F2bfKXE17wxI4H8ngS4XjkEQbOAASf4MLDvTpm58OhMlj3Q4u3dFqbEZr/jJQyP01A
         B/VYBCAJIT1lYO3/tcxNqQA6Pb1f1iC/nIXYre2/vKgMyZ1CcnLNHzslHKuNZw+9/Gaf
         PzVsTlnyDOnNEM+BZ0Lj4TKsiW6VBw7LI2Vj3djURsxCyNpp6hS7xMWAKOOqV1fwvNQx
         mBlLLGUJL9ZD0nV4tXPbOItdg6ZJK96Y0XUBVdIHwg528vBj8yDxNtdnad4avBVbAUUs
         i21Mu+qq61su8KKK+IZxNDDTCBf7vLXCuWFzg/c2dmMP1Cx5Fgq+DgNcZeOA868It9jC
         iTeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=MHm1/xchah81mEFay9oWCNm30KXyi7SAzdU0xTZCI9k=;
        b=QR0/zuxBN+gvQDtas+YAkYhzA7xWY9J5PzHfQ7KKboxz1Dx+WUtYnnmWHAhIdRSJ8p
         u+9vg3nFDnkpNVNn8jwsrWpIosMnDiOd//VRux/1zm6Dd8TviOumzeldaud0fhcRZ5v+
         RMf4N0evIj1jV8nMNttk5+e7tmWziu/v1Lln9VuC5PVtK6HnYlz2+7AXGTWQbepvBuYc
         6F0xO1Q/qeDwvE9agfPS6dXkaV/PcrLkOV6pNxxJC/NnhgYEwLDSgh2IkKeHxDKpv92t
         zWappV9reP44cRNwTgpbeqbTRsXdHNH2BNmRZA2qCM6YGVRGniMfRIZVUSc1FK6HyNe8
         RNsw==
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
Subject: [PATCH 4.4 82/97] MIPS: uaccess: Add micromips clobbers to bzero invocation
Date: Sun, 22 Apr 2018 15:54:00 +0200
Message-Id: <20180422135309.683857392@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455259602480989?=
X-GMAIL-MSGID: =?utf-8?q?1598456307847051244?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1238,6 +1238,13 @@ __clear_user(void __user *addr, __kernel
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
@@ -1247,7 +1254,7 @@ __clear_user(void __user *addr, __kernel
 			"move\t%0, $6"
 			: "=r" (res)
 			: "r" (addr), "r" (size)
-			: "$4", "$5", "$6", __UA_t0, __UA_t1, "$31");
+			: bzero_clobbers);
 	} else {
 		might_fault();
 		__asm__ __volatile__(
@@ -1258,7 +1265,7 @@ __clear_user(void __user *addr, __kernel
 			"move\t%0, $6"
 			: "=r" (res)
 			: "r" (addr), "r" (size)
-			: "$4", "$5", "$6", __UA_t0, __UA_t1, "$31");
+			: bzero_clobbers);
 	}
 
 	return res;
