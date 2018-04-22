Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49m8toRBC26VpbolZVcMaP9yYm5F9KGSHVMd+z52LqHZNvI+CQ2VpK9SxXTsMsEq38KsrCC
ARC-Seal: i=1; a=rsa-sha256; t=1524405946; cv=none;
        d=google.com; s=arc-20160816;
        b=V133bimudShAU6cSNxOx25CEbU40aA83IYZQ8cWyAZbdGbTOC+TXimgYRfzJ6tG45y
         MYPm/pb0yxSrLX3OPJNGAn5DNP/TEQB4U2MDiy8M85qhls7ej528HQ+5nz5SYQBTV2rP
         ZuL1udj1jhgHwb6lRwdNjQ32MxK95yueaAs7erciHCkr5JanEtuwOh04zb7VhAhINrNK
         tqGW/5kLUUQrtJK84xMT8cMLoFYoi431JaRKXzPRFPpNCq2Fkbrfuj8Qz7bwJV7LGKLl
         zcaFSa+3OiSYpPIybs3c/qVGDivyH5jW7bYnCAi1+nFkePhG8NW+TyBSP9h4Ue8zLpxy
         tYSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LTRzoCWnheiBz+N7Lvn7RFx7cLEHJVW35ZrmqNs5EV4=;
        b=db/iDsbGbEXhCQZaTgAKNJtZ/x5lUWD6+z8OAmOP+4R2zcRwIuwKLxBhMfi5PmLp2X
         p1FXrdTuFdYOttTUq7OOWSlR8aeaWMnMv46ys1hj4KvxLlpA3O2kroGfbZJUk6AupL2o
         Co6fJFUpX79Z0UDpw4cq+WNOxksn9Un4l3LMQDZ/WdjYO9sSOV+7sUkNsxm05I6Kri2y
         xFMVsOHlV5aixYmzwZf3egdkOuQbjfay1V1kXYoY+gi2mrg3Tf8kB0tmMWnzKH6kZLfy
         oM9IzZjAmMpkRmclTKabDS96aPI28MT88rd/8Atq6QCDCgqwXt13jl5rIeToda6aGby6
         UVqA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dave Young <dyoung@redhat.com>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	Simon Horman <horms@verge.net.au>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14 056/164] powerpc/kexec_file: Fix error code when trying to load kdump kernel
Date: Sun, 22 Apr 2018 15:52:03 +0200
Message-Id: <20180422135137.730596274@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454956801762645?=
X-GMAIL-MSGID: =?utf-8?q?1598455489862415624?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>

commit bf8a1abc3ddbd6e9a8312ea7d96e5dd89c140f18 upstream.

kexec_file_load() on powerpc doesn't support kdump kernels yet, so it
returns -ENOTSUPP in that case.

I've recently learned that this errno is internal to the kernel and
isn't supposed to be exposed to userspace. Therefore, change to
-EOPNOTSUPP which is defined in an uapi header.

This does indeed make kexec-tools happier. Before the patch, on
ppc64le:

  # ~bauermann/src/kexec-tools/build/sbin/kexec -s -p /boot/vmlinuz
  kexec_file_load failed: Unknown error 524

After the patch:

  # ~bauermann/src/kexec-tools/build/sbin/kexec -s -p /boot/vmlinuz
  kexec_file_load failed: Operation not supported

Fixes: a0458284f062 ("powerpc: Add support code for kexec_file_load()")
Cc: stable@vger.kernel.org # v4.10+
Reported-by: Dave Young <dyoung@redhat.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Reviewed-by: Simon Horman <horms@verge.net.au>
Reviewed-by: Dave Young <dyoung@redhat.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/machine_kexec_file_64.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/kernel/machine_kexec_file_64.c
+++ b/arch/powerpc/kernel/machine_kexec_file_64.c
@@ -43,7 +43,7 @@ int arch_kexec_kernel_image_probe(struct
 
 	/* We don't support crash kernels yet. */
 	if (image->type == KEXEC_TYPE_CRASH)
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	for (i = 0; i < ARRAY_SIZE(kexec_file_loaders); i++) {
 		fops = kexec_file_loaders[i];
