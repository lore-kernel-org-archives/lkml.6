Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49bMV34bbbvnSjzJpK1FsCVZkwwyz3rCmEH4ZRCzkCWoKhbjnvumHfTgDP2FOOFvAAHWipW
ARC-Seal: i=1; a=rsa-sha256; t=1524405927; cv=none;
        d=google.com; s=arc-20160816;
        b=BEqsHJCL6mpG1i0W+/18meU7ggxr5eNKuRw+FMVW5mB+LuW2GRhol/6t6rmQ35Xjl7
         //zZFSrdQAWZFzMxGY+Sgt129UMLY5QkijzeLRGTd+ONhHZY0wCyp3WCM1g6FFfMEjea
         qFzPThC8QIMHM48j+GvvVu7JqVRuNCh+Pi5nHR1MjtUqDlQi64QAAr3YWj0ywfY6r9jP
         pBpAvk7G76P9f6XUKmsBKzxcnb8N+aVnD1jQ6G6Z6YfGAyIePQrMTTRTmI9AD+/NdAxC
         Ibkl2xmkW+1SO534Cr82b164dCb/B9K9ydD/Orx8JlGg7cT80lRslUw8W2FETuKgpRNq
         5iTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RPcKIMkoMkRWGF1Mw1PUwfAfuIqUni5Jm1oNH+ilwPI=;
        b=1JGKBPGChT50jflEnQ2uYn5mVk4SZnQsqeEkyQznDQSUsLpyX3q2rwviZQ49DelIyR
         2TCdIw7zBLU8opGeEuylSys9GNFPkBt74i5rjgGSEULrQ0JUVO03bOtOilCRIHMLBHQh
         GyDN8jP/UYkFGjDgMXX0r/pYXWso3ChFK9FVXd7O+7M7xtvYAV5RflumDqwVHCLBMchA
         DCar90iScKLiiGeRJE1KwQnYSzSWjJG+vbr2MmZraSP9nmc/ZhNwiJehjIDqm4ajJQJh
         jKBnomog3QnAE2dFABaDIsvFpr2Uq6fUsfJ2AQef6zcXTmOAzl/W+3mXU/QK7hT14frm
         d76A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jason Andryuk <jandryuk@gmail.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [PATCH 4.14 032/164] x86/xen: Delay get_cpu_cap until stack canary is established
Date: Sun, 22 Apr 2018 15:51:39 +0200
Message-Id: <20180422135136.725024392@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454870775215893?=
X-GMAIL-MSGID: =?utf-8?q?1598455470643856106?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Andryuk <jandryuk@gmail.com>

commit 36104cb9012a82e73c32a3b709257766b16bcd1d upstream.

Commit 2cc42bac1c79 ("x86-64/Xen: eliminate W+X mappings") introduced a
call to get_cpu_cap, which is fstack-protected.  This is works on x86-64
as commit 4f277295e54c ("x86/xen: init %gs very early to avoid page
faults with stack protector") ensures the stack protector is configured,
but it it did not cover x86-32.

Delay calling get_cpu_cap until after xen_setup_gdt has initialized the
stack canary.  Without this, a 32bit PV machine crashes early
in boot.
(XEN) Domain 0 (vcpu#0) crashed on cpu#0:
(XEN) ----[ Xen-4.6.6-xc  x86_64  debug=n  Tainted:    C ]----
(XEN) CPU:    0
(XEN) RIP:    e019:[<00000000c10362f8>]

And the PV kernel IP corresponds to init_scattered_cpuid_features
   0xc10362f8 <+24>:    mov    %gs:0x14,%eax

Fixes 2cc42bac1c79 ("x86-64/Xen: eliminate W+X mappings")

Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/xen/enlighten_pv.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1258,10 +1258,6 @@ asmlinkage __visible void __init xen_sta
 	 */
 	__userpte_alloc_gfp &= ~__GFP_HIGHMEM;
 
-	/* Work out if we support NX */
-	get_cpu_cap(&boot_cpu_data);
-	x86_configure_nx();
-
 	/* Get mfn list */
 	xen_build_dynamic_phys_to_machine();
 
@@ -1271,6 +1267,10 @@ asmlinkage __visible void __init xen_sta
 	 */
 	xen_setup_gdt(0);
 
+	/* Work out if we support NX */
+	get_cpu_cap(&boot_cpu_data);
+	x86_configure_nx();
+
 	xen_init_irq_ops();
 
 	/* Let's presume PV guests always boot on vCPU with id 0. */
