Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225lenP/U9sPulrLWc8x7hriqHMalXof2ihrdfHnlCI2E0Me5giWdNtOHgjcPddv6mpwSMjI
ARC-Seal: i=1; a=rsa-sha256; t=1517855086; cv=none;
        d=google.com; s=arc-20160816;
        b=HI9Svfi2roycgmyT72syzMvKhoOl4BuOjUb9hbV+cH2bkMMnB6T3MrxCybLtrP9KBr
         YOjGHY7buxRsUm45vBvhHpIYmLfbOndwUb7dgfm9ESbVyC6OcwuMRW+ISSR9jLjuAeum
         UCjPjNKp7oZReQqROtKya7TEsUi/G43e8p9m9A0bNrD4K3TaXexqToQUAjdPeAFK3pM3
         6kkNPNDY+lGiLAHNYDKHggdQ10/Nm0jaDhBeihoSwM8nvJQVqPb9VpcTWy0LEJQ9Qs9f
         jH55SQ0jvzGKyOhRzieZuTu5KlKscSE+eQixGw17hWEyfB3ZHVrKwfxUJuON1zoJkGVm
         6aMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Rx5UAHdDKSe2lMw07BuyN5PMNlVfmeoPM8qupVnI8zg=;
        b=XSLnx7WUGdaJSZSZOy4+vzNY7U5hc7iL8qGUA1U99625ahKkJ2T/OepArlQL1DI+jZ
         jAWvxEkvtW+rMD8jUjQq35iYRfEQdkbNf/nKhDx3SvnWh/wJt6Mdh3dy393E0w+owx44
         iDQI9rsFvedHpNgfQmtFFB6aoeQ9dV0ayQxmuDGEZcvDQDT3AY1FkFiKMc8qCERpkjyE
         a+XHltYzVS4z1G6YPe5gNDMDy6ofPrxoWAsP38gYZ2bcS4B8StUSQXCpML+hljBlNfPo
         ajK44GGn/b1SuUWLJ3TD+daj6fNFOA/7xxpBx98HL1ex1lkZJwTUaFoQIwzhkvxrPpry
         JTIQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Williams <dan.j.williams@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-arch@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	kernel-hardening@lists.openwall.com,
	Al Viro <viro@zeniv.linux.org.uk>,
	Andy Lutomirski <luto@kernel.org>,
	torvalds@linux-foundation.org,
	alan@linux.intel.com
Subject: [PATCH 4.14 43/64] x86/get_user: Use pointer masking to limit speculation
Date: Mon,  5 Feb 2018 10:23:02 -0800
Message-Id: <20180205182140.346867497@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182138.571333346@linuxfoundation.org>
References: <20180205182138.571333346@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586415777637486?=
X-GMAIL-MSGID: =?utf-8?q?1591586415777637486?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams dan.j.williams@intel.com

commit c7f631cb07e7da06ac1d231ca178452339e32a94

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 arch/x86/lib/getuser.S |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/arch/x86/lib/getuser.S
+++ b/arch/x86/lib/getuser.S
@@ -40,6 +40,8 @@ ENTRY(__get_user_1)
 	mov PER_CPU_VAR(current_task), %_ASM_DX
 	cmp TASK_addr_limit(%_ASM_DX),%_ASM_AX
 	jae bad_get_user
+	sbb %_ASM_DX, %_ASM_DX		/* array_index_mask_nospec() */
+	and %_ASM_DX, %_ASM_AX
 	ASM_STAC
 1:	movzbl (%_ASM_AX),%edx
 	xor %eax,%eax
@@ -54,6 +56,8 @@ ENTRY(__get_user_2)
 	mov PER_CPU_VAR(current_task), %_ASM_DX
 	cmp TASK_addr_limit(%_ASM_DX),%_ASM_AX
 	jae bad_get_user
+	sbb %_ASM_DX, %_ASM_DX		/* array_index_mask_nospec() */
+	and %_ASM_DX, %_ASM_AX
 	ASM_STAC
 2:	movzwl -1(%_ASM_AX),%edx
 	xor %eax,%eax
@@ -68,6 +72,8 @@ ENTRY(__get_user_4)
 	mov PER_CPU_VAR(current_task), %_ASM_DX
 	cmp TASK_addr_limit(%_ASM_DX),%_ASM_AX
 	jae bad_get_user
+	sbb %_ASM_DX, %_ASM_DX		/* array_index_mask_nospec() */
+	and %_ASM_DX, %_ASM_AX
 	ASM_STAC
 3:	movl -3(%_ASM_AX),%edx
 	xor %eax,%eax
@@ -83,6 +89,8 @@ ENTRY(__get_user_8)
 	mov PER_CPU_VAR(current_task), %_ASM_DX
 	cmp TASK_addr_limit(%_ASM_DX),%_ASM_AX
 	jae bad_get_user
+	sbb %_ASM_DX, %_ASM_DX		/* array_index_mask_nospec() */
+	and %_ASM_DX, %_ASM_AX
 	ASM_STAC
 4:	movq -7(%_ASM_AX),%rdx
 	xor %eax,%eax
@@ -94,6 +102,8 @@ ENTRY(__get_user_8)
 	mov PER_CPU_VAR(current_task), %_ASM_DX
 	cmp TASK_addr_limit(%_ASM_DX),%_ASM_AX
 	jae bad_get_user_8
+	sbb %_ASM_DX, %_ASM_DX		/* array_index_mask_nospec() */
+	and %_ASM_DX, %_ASM_AX
 	ASM_STAC
 4:	movl -7(%_ASM_AX),%edx
 5:	movl -3(%_ASM_AX),%ecx
