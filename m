Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226hjIqIjULYmsdmM5+tUlbJIr79p1BK+dLjEqhdCzwlhd24igVGzjZsnxu531rCJsJhMDdL
ARC-Seal: i=1; a=rsa-sha256; t=1517591375; cv=none;
        d=google.com; s=arc-20160816;
        b=afGaSVh3O+TYgLu7qwlGcwOsc+IIX4Oj5QdHRCVu0P6jPpsq4tIHbKsCgsWMO2u6gU
         aYgE7nDZp68D/5FTqcrKWMLuAYq92pU650yLh5lEIdORlY00DWXmAsprb1xlMjv/1zX3
         DDXQyevIIXWyDnRj7q3svqBa6NeVz7SOyEeSLyuAnCZmKEcb68uj6AGzZIQUe/NSFgC3
         XIJS08I0w3q+CxRqc62aBdLFao9UWlvKQLeZuf9mI27E2qyEuvg/iP0dTM5w+gx4xPDN
         ZisGXA3pPGnBTFSHL2Dhci4Lzs67PcxEVsBVYZ5XTthSOSyGagSjXevKSCbAdP42SEgT
         ta6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=J6YQ01Flw5+63TYjsMg/36A/q0/YT2m86iEJoVv4IGQ=;
        b=UdWLdPnTL8WMPzvwR/FcEAmbNSBl5icLQNxgOoIQyLme/PXO/59KUcEcpbR7QLs7ux
         MPPxcwlo37ihxHrjkHQOpqCqlBsHRdQ8BUcsbJW1RWPdu9oigt84+gvJi6pv66bR3Hy8
         hjmgiq+XMbwNrHriWL+HSaKgdJyfSMm/Iw2KwfnApUPigszB9xbKCahFJr30mWZe/Y+5
         YtAjijZQjWXx5XrlkHQGCgM/iYPnViskX9OPhm80RDz2/45M3vhvD34fmCoFpoMyPgiX
         wbjMfAMS26vuQVvjfZsrrN3LYh0bq9ThrpnTxpK0onm0KNXU+0UoP2oFW5JASVqZgmUW
         c+VA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 057/156] s390: fix alloc_pgste check in init_new_context again
Date: Fri,  2 Feb 2018 17:57:18 +0100
Message-Id: <20180202140842.868941974@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309893804809529?=
X-GMAIL-MSGID: =?utf-8?q?1591309893804809529?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Schwidefsky <schwidefsky@de.ibm.com>


[ Upstream commit 53c4ab70c11c3ba1b9e3caa8e8c17e9c16d9cbc0 ]

git commit badb8bb983e9 "fix alloc_pgste check in init_new_context" fixed
the problem of 'current->mm == NULL' in init_new_context back in 2011.

git commit 3eabaee998c7 "KVM: s390: allow sie enablement for multi-
threaded programs" completely removed the check against alloc_pgste.

git commit 23fefe119ceb "s390/kvm: avoid global config of vm.alloc_pgste=1"
re-added a check against the alloc_pgste flag but without the required
check for current->mm != NULL.

For execve() called by a kernel thread init_new_context() reads from
((struct mm_struct *) NULL)->context.alloc_pgste to decide between
2K vs 4K page tables. If the bit happens to be set for the init process
it will be created with large page tables. This decision is inherited by
all the children of init, this waste quite some memory.

Re-add the check for 'current->mm != NULL'.

Fixes: 23fefe119ceb ("s390/kvm: avoid global config of vm.alloc_pgste=1")
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/include/asm/mmu_context.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/s390/include/asm/mmu_context.h
+++ b/arch/s390/include/asm/mmu_context.h
@@ -28,7 +28,7 @@ static inline int init_new_context(struc
 #ifdef CONFIG_PGSTE
 	mm->context.alloc_pgste = page_table_allocate_pgste ||
 		test_thread_flag(TIF_PGSTE) ||
-		current->mm->context.alloc_pgste;
+		(current->mm && current->mm->context.alloc_pgste);
 	mm->context.has_pgste = 0;
 	mm->context.use_skey = 0;
 	mm->context.use_cmma = 0;
