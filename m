Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELufkTRRMEEuTMoQovsIt26PoOqHAHnvW3cJOU99ALK0a3MjhYHPGyC4UYRcU4Qq+6UFMW3v
ARC-Seal: i=1; a=rsa-sha256; t=1520452086; cv=none;
        d=google.com; s=arc-20160816;
        b=i6VXxW2rGHLt5K8mUCHjzm/Zoq4NU66tI6Hpn+8t49bwKXsaedEQkv9ClFNQ3+aKgT
         LPAIGnI5v38EsFI8x3tzINM8nBlckrkG5yvgzDTfNN8i3W0DDG4x4Y57PGl12rouJPiR
         fXfrfk1E9ZNUfpn0mcgE3MpiMQzATEOarLiHRfRW77X/P3WGJ8SMsiqv7s2nf0bNgARX
         kTcLUleDg57SvVB2PG9LiHE9LNzC3a/lD7WI/GsmCk204tT368LdJ7S8m3jyoIPwfrZJ
         XxIDBXFTPgDvp70IjjfsePd2hjQ7NGH42tXNMMYKp/gbXKH7IH+z+b9/9aQRFbWX09fr
         UCHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=M+dTtUgTtOvDb0dWwxuOM8oA2OBjonXweF3GnzEyNVs=;
        b=H9vhbjnTLAEWxnWMJrHHlnxnO01xyIdzkeWrjYo+Hjll9WegHt2QW/95eAIftPIeUk
         598PHUJsauFWj+QoQqGTHPXvUAhZc2BMqLvx9WGBHIOmSyafBefhx4JpzTKTxFssKirt
         IdtJIMCPMiznI7rFiEb+pQb7DPZe9808tYSUAuwg11/H80vMEbjLBiwG/RQ3GqdatV9j
         K0I/+AJhOQyQkNGYj5mCe8CXPMz6xLwiiUaYKYO91e+89WNT+DrnKU+YBecmi8luEn+C
         pdTuw8juvDmmEtj6mly6xytKuIJnJnwPA9Tx50e+aRNGgC5gyJj45CpGza80cuA6tUb1
         sykQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot <syzkaller@googlegroups.com>,
	Eric Biggers <ebiggers@google.com>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
	Jack Wang <jinpu.wang@profitbricks.com>
Subject: [PATCH 4.14 105/110] KVM/x86: remove WARN_ON() for when vm_munmap() fails
Date: Wed,  7 Mar 2018 11:39:28 -0800
Message-Id: <20180307191053.397518502@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309336045746286?=
X-GMAIL-MSGID: =?utf-8?q?1594309567432272253?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit 103c763c72dd2df3e8c91f2d7ec88f98ed391111 upstream.

On x86, special KVM memslots such as the TSS region have anonymous
memory mappings created on behalf of userspace, and these mappings are
removed when the VM is destroyed.

It is however possible for removing these mappings via vm_munmap() to
fail.  This can most easily happen if the thread receives SIGKILL while
it's waiting to acquire ->mmap_sem.   This triggers the 'WARN_ON(r < 0)'
in __x86_set_memory_region().  syzkaller was able to hit this, using
'exit()' to send the SIGKILL.  Note that while the vm_munmap() failure
results in the mapping not being removed immediately, it is not leaked
forever but rather will be freed when the process exits.

It's not really possible to handle this failure properly, so almost
every other caller of vm_munmap() doesn't check the return value.  It's
a limitation of having the kernel manage these mappings rather than
userspace.

So just remove the WARN_ON() so that users can't spam the kernel log
with this warning.

Fixes: f0d648bdf0a5 ("KVM: x86: map/unmap private slots in __x86_set_memory_region")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Jack Wang <jinpu.wang@profitbricks.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/x86.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8251,10 +8251,8 @@ int __x86_set_memory_region(struct kvm *
 			return r;
 	}
 
-	if (!size) {
-		r = vm_munmap(old.userspace_addr, old.npages * PAGE_SIZE);
-		WARN_ON(r < 0);
-	}
+	if (!size)
+		vm_munmap(old.userspace_addr, old.npages * PAGE_SIZE);
 
 	return 0;
 }
