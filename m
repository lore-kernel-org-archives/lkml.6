Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELubhGjbiueDZtWq3+dY2LKWwZE2fi1n1E3TJM5AYK9bNFUqGfW3o6rjqwUWRuGphmcba1DJ
ARC-Seal: i=1; a=rsa-sha256; t=1520824073; cv=none;
        d=google.com; s=arc-20160816;
        b=UZqrfWEPT0cndWhMdFOuK//XmackV5wmUI2PJfWq2Worc6+PC/3Aaq/o0PenxYjfU5
         ELtTT8+LOVgxlQA4peDr98gRg7L/mcVugGMmRVzG2huTuJ6oEr+1DpI99zQght3Ej5yZ
         y3ZPGzoPXFBwg0EC5nr5kogRi20jSymgu1laIuv4KopcWOMqRVoINFWrrJYDo6UAdINM
         Z+OB+Ck5OvVbLKznLEf56NvB634UY4NZqiYBltiZYqyGTMi6J8ZHVvKQ2x4NDyQt4YxS
         LsQX/IXE6oy7zxtioVPJZbEmOKg0w5orYC+zDAq2USB2ShPsV575VdmgzBo9tLoRNDmU
         YKZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=wSaYSwjqY/IU5oXI9i+hTY6vOXRLXwsxct2Z00KrY5Q=;
        b=Ic3sgBC/qEL5K0thH68AbfKuOPuCEKFaedKe1VOYmXVipbJNkysBX3XwXSRdRDIjGi
         +wFe8Woyru6/eu+J8IHydSIrB7FsrHO1JDPDxXSo+P/PiQG3JOS9sdGLpkTn6AVw297J
         F2CQ6X7j8N3a8ZJYoVBTrk5JUw2Zgu56/u/3vXQRPhxLJGkYPE91qbOk69xwu0qEZtAK
         6kPPJICJR2eOzkyX/EYOvmtDHwLROzLHU4ywOOsuZItR8PXBjCw4sJJDhj2JESLmjwVe
         aHNrkFh00c1gOBMBjA7r3AwjAl5WvtBhpaUGXstoZEPAonh1lorj+/UFIHkF7mxG0oKH
         /FvQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, torvalds@linux-foundation.org,
 "Andy Lutomirski" <luto@kernel.org>,
 kernel-hardening@lists.openwall.com,
 "Kees Cook" <keescook@chromium.org>,
 "Al Viro" <viro@zeniv.linux.org.uk>,
 linux-arch@vger.kernel.org, gregkh@linuxfoundation.org,
 "Thomas Gleixner" <tglx@linutronix.de>,
 alan@linux.intel.com,
 "Dan Williams" <dan.j.williams@intel.com>
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.720424377@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 55/76] x86/get_user: Use pointer masking to limit
 speculation
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699610617990203?=
X-GMAIL-MSGID: =?utf-8?q?1594699623749926165?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.56-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

commit c7f631cb07e7da06ac1d231ca178452339e32a94 upstream.

Quoting Linus:

    I do think that it would be a good idea to very expressly document
    the fact that it's not that the user access itself is unsafe. I do
    agree that things like "get_user()" want to be protected, but not
    because of any direct bugs or problems with get_user() and friends,
    but simply because get_user() is an excellent source of a pointer
    that is obviously controlled from a potentially attacking user
    space. So it's a prime candidate for then finding _subsequent_
    accesses that can then be used to perturb the cache.

Unlike the __get_user() case get_user() includes the address limit check
near the pointer de-reference. With that locality the speculation can be
mitigated with pointer narrowing rather than a barrier, i.e.
array_index_nospec(). Where the narrowing is performed by:

	cmp %limit, %ptr
	sbb %mask, %mask
	and %mask, %ptr

With respect to speculation the value of %ptr is either less than %limit
or NULL.

Co-developed-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>
Cc: kernel-hardening@lists.openwall.com
Cc: gregkh@linuxfoundation.org
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: torvalds@linux-foundation.org
Cc: alan@linux.intel.com
Link: https://lkml.kernel.org/r/151727417469.33451.11804043010080838495.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/lib/getuser.S | 10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/arch/x86/lib/getuser.S
+++ b/arch/x86/lib/getuser.S
@@ -40,6 +40,8 @@ ENTRY(__get_user_1)
 	GET_THREAD_INFO(%_ASM_DX)
 	cmp TI_addr_limit(%_ASM_DX),%_ASM_AX
 	jae bad_get_user
+	sbb %_ASM_DX, %_ASM_DX		/* array_index_mask_nospec() */
+	and %_ASM_DX, %_ASM_AX
 	ASM_STAC
 1:	movzbl (%_ASM_AX),%edx
 	xor %eax,%eax
@@ -55,6 +57,8 @@ ENTRY(__get_user_2)
 	GET_THREAD_INFO(%_ASM_DX)
 	cmp TI_addr_limit(%_ASM_DX),%_ASM_AX
 	jae bad_get_user
+	sbb %_ASM_DX, %_ASM_DX		/* array_index_mask_nospec() */
+	and %_ASM_DX, %_ASM_AX
 	ASM_STAC
 2:	movzwl -1(%_ASM_AX),%edx
 	xor %eax,%eax
@@ -70,6 +74,8 @@ ENTRY(__get_user_4)
 	GET_THREAD_INFO(%_ASM_DX)
 	cmp TI_addr_limit(%_ASM_DX),%_ASM_AX
 	jae bad_get_user
+	sbb %_ASM_DX, %_ASM_DX		/* array_index_mask_nospec() */
+	and %_ASM_DX, %_ASM_AX
 	ASM_STAC
 3:	movl -3(%_ASM_AX),%edx
 	xor %eax,%eax
@@ -86,6 +92,8 @@ ENTRY(__get_user_8)
 	GET_THREAD_INFO(%_ASM_DX)
 	cmp TI_addr_limit(%_ASM_DX),%_ASM_AX
 	jae bad_get_user
+	sbb %_ASM_DX, %_ASM_DX		/* array_index_mask_nospec() */
+	and %_ASM_DX, %_ASM_AX
 	ASM_STAC
 4:	movq -7(%_ASM_AX),%rdx
 	xor %eax,%eax
@@ -97,6 +105,8 @@ ENTRY(__get_user_8)
 	GET_THREAD_INFO(%_ASM_DX)
 	cmp TI_addr_limit(%_ASM_DX),%_ASM_AX
 	jae bad_get_user_8
+	sbb %_ASM_DX, %_ASM_DX		/* array_index_mask_nospec() */
+	and %_ASM_DX, %_ASM_AX
 	ASM_STAC
 4:	movl -7(%_ASM_AX),%edx
 5:	movl -3(%_ASM_AX),%ecx
