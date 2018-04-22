Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49RUc6raIbKeXBpoMw8J3PI4BncDLY0MSldKCKzIO2ljD/RuJLq08wc2TsUOR+rd68CYuLC
ARC-Seal: i=1; a=rsa-sha256; t=1524405356; cv=none;
        d=google.com; s=arc-20160816;
        b=fsDqTkgShKuFZ9nosRGNeAaMTNJjCkcTzjO61VjJKZPm0E1S3aS3IqDFgggKoHdbxQ
         TyZvhLg4/dqPPlKEgU+QWgGehdXCwgVarLRBbyQ3THJ6KogTzdSou+8DtDpbDQz3CpHV
         SNn6WxE2ojfQabvDC3Mmi4NzAfeb7OR1iya1JargpQoQagw+v/JyNn1s83rHhpCoFL4w
         fjOzVFLWjKN4MuYQyk10T0swnxCZRW6FHWVHPLN48LIfFL0kOnDczXLMYpXMnRMq9jr9
         8ZPxAaV/uW6cAryq3wHlgI2UbK70JJVT2rAQG1W98tjvOWsPA3SpMUi58hQxczX0FO7z
         zlHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=apUiSRUhgX74oVquj8GUOU4eGKQGuw6VwojoVz+m+ZU=;
        b=HH5VEa/6V7bjZXmX8ykMkVIpMP5t3UZ0BddtxYTJEvrM+6VAB4EAXi87ZjQ7CEZdhX
         m97hp6GJrY7F3woRtgei1J5q/7W6n8rGVJLlSrF2GtfEU0VNQ0TpKzOFpOPA9zzMKt+4
         YcS5d+iHO8WSiudBTCmiaRQE/0IlKfKaD6lgCQ9fa1NdmazZGWHzwr9FgQp0j7NzlzkT
         zxjz+z6nf/cqA/9Pnvhc96LbLhCkiCRyRaDAdsGuRsRni3mikmaj7LK3t4PGIjXppSg0
         dHBrBpOgx6XsVu7bH5J3s0PFBha9nG6OBtj/82bsUuth9gdDNQ3gZ2jUGN3A6k5naCfR
         +b3g==
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
Subject: [PATCH 4.16 035/196] x86/xen: Delay get_cpu_cap until stack canary is established
Date: Sun, 22 Apr 2018 15:50:55 +0200
Message-Id: <20180422135105.924554029@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454870775215893?=
X-GMAIL-MSGID: =?utf-8?q?1598454870775215893?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1259,10 +1259,6 @@ asmlinkage __visible void __init xen_sta
 	 */
 	__userpte_alloc_gfp &= ~__GFP_HIGHMEM;
 
-	/* Work out if we support NX */
-	get_cpu_cap(&boot_cpu_data);
-	x86_configure_nx();
-
 	/* Get mfn list */
 	xen_build_dynamic_phys_to_machine();
 
@@ -1272,6 +1268,10 @@ asmlinkage __visible void __init xen_sta
 	 */
 	xen_setup_gdt(0);
 
+	/* Work out if we support NX */
+	get_cpu_cap(&boot_cpu_data);
+	x86_configure_nx();
+
 	xen_init_irq_ops();
 
 	/* Let's presume PV guests always boot on vCPU with id 0. */
