Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AB8JxZrX/2MduiJNq/RkFQ6o47yA0vdMtYAXsqVm0UKub50sODcOU14LW4j6+yvgxRdxcftcA5SJ
ARC-Seal: i=1; a=rsa-sha256; t=1524652660; cv=none;
        d=google.com; s=arc-20160816;
        b=qp8hlpRIJYDE5UHGdFgC3/V1Jd6a2yFdQXtCiZcofYQkX3qGQNDKu1gY/Avl7/SbJ4
         aag3M+g9taDKHXUQsjRKL98qyalB4voLGssc1kFEJ3xJNsI3nXMUBWEGDQsSBADv1prS
         Wt15GHcoOoWNLCSn1EGnZh91SLtuOx4fbmMXr5+KM3GFwZchtAydHaSwFcPzxd+HMd1Q
         GWTbPXP2YGrmJJ10E88C4Spbgr6TWKUMIQENZEa2Yi0odqYkkVhLHEBEvw6lOeUn/8kT
         qPU2V5lnso7p+5PgJ1SUmKpechOm5m63cYqVCvnVBVxzaUlt7XsFC8g6MFsWErRFI6tS
         UrvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=2zZrnecd3NPJ398J52gZxDEdx7F9GqA1fdOpMctkwf4=;
        b=vsmuHpBB/OmvUFkzaDYYui/oTGHBdZUJgum30wWk8X4ojFrH4//8QTOV+B6wrd8eHS
         +xs3G9GrNQwvT2+0bpfEgT89gfgRc+Qwn21erpDetBEbbJmZJgujXMDwLNTAn3veOOkM
         5V9t/mn12QkdJ235znd2F2p51ddmJv0i8jM3OnVMof0FjRPiw6dgRWeqj2va89JAhhH6
         z7zXYd+q1gK5Lv68SoZ2W9BpJ4q0WZi2mE8P5dBr3jWbAjEkDxwoTYshkZ7vlMkCu3nf
         qdSw78BHRislVe/E1gXHC9fCGvINZCMp9Rrj0N8AyTSCZdwEDTWkL4gXlpFyYKOejVpt
         zrfA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	kernel-hardening@lists.openwall.com,
	Kees Cook <keescook@chromium.org>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 022/183] kvm: x86: fix KVM_XEN_HVM_CONFIG ioctl
Date: Wed, 25 Apr 2018 12:34:02 +0200
Message-Id: <20180425103243.501870353@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714187972473710?=
X-GMAIL-MSGID: =?utf-8?q?1598714187972473710?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Bonzini <pbonzini@redhat.com>


[ Upstream commit 51776043afa415435c7e4636204fbe4f7edc4501 ]

This ioctl is obsolete (it was used by Xenner as far as I know) but
still let's not break it gratuitously...  Its handler is copying
directly into struct kvm.  Go through a bounce buffer instead, with
the added benefit that we can actually do something useful with the
flags argument---the previous code was exiting with -EINVAL but still
doing the copy.

This technically is a userspace ABI breakage, but since no one should be
using the ioctl, it's a good occasion to see if someone actually
complains.

Cc: kernel-hardening@lists.openwall.com
Cc: Kees Cook <keescook@chromium.org>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/x86.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4225,13 +4225,14 @@ long kvm_arch_vm_ioctl(struct file *filp
 		mutex_unlock(&kvm->lock);
 		break;
 	case KVM_XEN_HVM_CONFIG: {
+		struct kvm_xen_hvm_config xhc;
 		r = -EFAULT;
-		if (copy_from_user(&kvm->arch.xen_hvm_config, argp,
-				   sizeof(struct kvm_xen_hvm_config)))
+		if (copy_from_user(&xhc, argp, sizeof(xhc)))
 			goto out;
 		r = -EINVAL;
-		if (kvm->arch.xen_hvm_config.flags)
+		if (xhc.flags)
 			goto out;
+		memcpy(&kvm->arch.xen_hvm_config, &xhc, sizeof(xhc));
 		r = 0;
 		break;
 	}
