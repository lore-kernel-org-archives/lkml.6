Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsstpijfp8HxrrIzumv+qNFrlb/hwf5hnIZF3q7RSnVH3ZrNgI0IcKuOEoSBgDnmBkz+W4p
ARC-Seal: i=1; a=rsa-sha256; t=1520451866; cv=none;
        d=google.com; s=arc-20160816;
        b=iy6m7HiC0VECMlRH0xV3DB7OoTG+Zd5Gs9rmTVOwDYUClMPC0jvcKCrD6Tq2qt5Txo
         lRAeQLGBolnbPAG26GhOq2NKpUenU0vuMdzWmrLfNka8dfCT2zamjUDDQNOOc26+/0ww
         aM9wgHbMbTJrmJzmQ4f31PBp4/puwZxsiMNDYuPHMMPSAhcZtUje+U+8Oav/6WENGde3
         T6oRA4uKiW7C/WmE9kUZXmZzIteOLuIK+kjgcGBzbLf0A8SXo09lSDXQOo/YeO9ty5WR
         cD/9YCWLTj28aEG67HPFeZj3MkS4dq7BSaoqgRbUQdevTz3gkzQH/ieFjOZORgXUi+cB
         iQCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=pO79eqV/ivxr92ESKEKQ91WmldfTs098eVNQR9JdH/Y=;
        b=XBufRvYejphdI9KLRk7dtfiCxnb2b/cbnpa1ixEeNPhuZX7YJ4AJlLEIb3KpXUQXf7
         +G8YhXXxZ26JHGOq5ELZMuZODNFTd6NGAFOo7pBNdep2XXVOFwH6yujCThJL1yrFUiQa
         hzjfhrRlIKN6eSjb7nPZWhVwJXqmYGX0WJku+c+wK/AjZFmvZvz0mDx5p2GdzbHr7kvz
         elf0pG6YHGCHQfIHzgLA6N0uD6TOBaGff2yn/pDmWO6TdYd5xnhgjD5NYOzsXO1BrsuL
         91WSXXIDQbHntsF0X9nEwT9M8U4fP+pyoPqvjhDsqhFAABuoki60PGhbvro4TVgRUeSp
         XpKQ==
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
Subject: [PATCH 4.15 117/122] KVM/x86: remove WARN_ON() for when vm_munmap() fails
Date: Wed,  7 Mar 2018 11:38:49 -0800
Message-Id: <20180307191746.615812700@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309336045746286?=
X-GMAIL-MSGID: =?utf-8?q?1594309336045746286?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -8281,10 +8281,8 @@ int __x86_set_memory_region(struct kvm *
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
