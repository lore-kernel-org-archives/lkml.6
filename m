Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuxosdG8tThdR2YhdjuDL1UUzSYchlYmb/rlskPGoYlFCBaE/gpHrY1DYroAvga/c6wyKDH
ARC-Seal: i=1; a=rsa-sha256; t=1521483794; cv=none;
        d=google.com; s=arc-20160816;
        b=WCBoHGOuW/Sl4w79PaesXe7V082xq2opesTFA5UcWuokWzxu1vKl7YVmLlqriXy+gb
         pPURnZ4YeZL4HlWe92gOJwbk01CR7ehIxZZulX1qxYrTXYvCoFs/0+1S/NX2uFEo6Y9q
         gXEncDQHeT2Hjt+TNrcWaP85jj2K1M0pNMPAx6kaNl7rQBv0NUd9MOIj35d+jlBPaJjA
         PCFhGnO9m17ZtXs7g3a78l8HmgQqVk2jYRSx8WQz67VJmBvFDsQoBq5m6rXy2K6966HG
         y7NSql2D3ezcaglwKmtopBa7coIdgxPS9OxTPVXCAgajLmzsqXyMSSH3GZyo9cjKmmNs
         2LNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=iOU4mP2/RxHeO2l7vfaZc+iKbNaeFaMx3wxUlfJodJE=;
        b=fJmStTvHEuNLOPgJuNlp2S3s1AT3Xl+uaMRyeThCjw7zJexvAD6FrqLPfc4OH39ZLn
         7+ttmChrPyCaX79KgAqur0Gr0TlTufiKIzsF+DujE8MCiOGE9r5rYSYnYfDLaiEP085z
         h1tIk0z/5EfhGQj7pFb2dXARwjx2GMomHnW+EsLwdZOBVzybPxRjEuFUlb9/abOHCncg
         d/aQQLeG1edk3+Wi27fo4dtSpoOQ3OSneWaTdWLR0awl9HgAdsGWQ/rl9OgQGQX7InhL
         J+45kqqmjQ+xBgdEqXzFAJZ2EF0K2FSTU3Xug+vGvRdrpd4LxCWJBAYMBPc2zZGTTxBA
         0LiQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jim Mattson <jmattson@google.com>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 119/241] kvm: nVMX: Disallow userspace-injected exceptions in guest mode
Date: Mon, 19 Mar 2018 19:06:24 +0100
Message-Id: <20180319180756.125127600@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391390879289879?=
X-GMAIL-MSGID: =?utf-8?q?1595391390879289879?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jim Mattson <jmattson@google.com>


[ Upstream commit 28d06353881939703c34d82a1465136af176c620 ]

The userspace exception injection API and code path are entirely
unprepared for exceptions that might cause a VM-exit from L2 to L1, so
the best course of action may be to simply disallow this for now.

1. The API provides no mechanism for userspace to specify the new DR6
bits for a #DB exception or the new CR2 value for a #PF
exception. Presumably, userspace is expected to modify these registers
directly with KVM_SET_SREGS before the next KVM_RUN ioctl. However, in
the event that L1 intercepts the exception, these registers should not
be changed. Instead, the new values should be provided in the
exit_qualification field of vmcs12 (Intel SDM vol 3, section 27.1).

2. In the case of a userspace-injected #DB, inject_pending_event()
clears DR7.GD before calling vmx_queue_exception(). However, in the
event that L1 intercepts the exception, this is too early, because
DR7.GD should not be modified by a #DB that causes a VM-exit directly
(Intel SDM vol 3, section 27.1).

3. If the injected exception is a #PF, nested_vmx_check_exception()
doesn't properly check whether or not L1 is interested in the
associated error code (using the #PF error code mask and match fields
from vmcs12). It may either return 0 when it should call
nested_vmx_vmexit() or vice versa.

4. nested_vmx_check_exception() assumes that it is dealing with a
hardware-generated exception intercept from L2, with some of the
relevant details (the VM-exit interruption-information and the exit
qualification) live in vmcs02. For userspace-injected exceptions, this
is not the case.

5. prepare_vmcs12() assumes that when its exit_intr_info argument
specifies valid information with a valid error code that it can VMREAD
the VM-exit interruption error code from vmcs02. For
userspace-injected exceptions, this is not the case.

Signed-off-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/x86.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3070,7 +3070,8 @@ static int kvm_vcpu_ioctl_x86_set_vcpu_e
 		return -EINVAL;
 
 	if (events->exception.injected &&
-	    (events->exception.nr > 31 || events->exception.nr == NMI_VECTOR))
+	    (events->exception.nr > 31 || events->exception.nr == NMI_VECTOR ||
+	     is_guest_mode(vcpu)))
 		return -EINVAL;
 
 	/* INITs are latched while in SMM */
