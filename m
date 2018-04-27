Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqbWqF4MIdoUmd9tsDDcIO0eHdnoJjJqvkcoAH+lU8csbaBDQ/nqnY74N11AMsBStJsZVHc
ARC-Seal: i=1; a=rsa-sha256; t=1524837667; cv=none;
        d=google.com; s=arc-20160816;
        b=Kwdym4iDjlKw3GM0FIibDL6kXfjxcfXTZMvuhpiEhIslrNoLzRNxowV7boKWE6a9cH
         loAKqj0rWXUC3fOaMnkBRH3JsiLbpp6sxcVxQQIH4vIbu4Ji/B3ttJbxAz0kswYCq3ZU
         7VasrrW3k3D3OJumrQQl5qCJrTlR6X4hJTkMImqjY1zaVZyG+3O22uNlptbuwoVuNWON
         Y89kxgUVtYoRmDH1L82GiGxzE7PGsGJM71B8ZJYnTBipYs3MfwiYIMgyU7xMb6TKYl9m
         6OVTuvZ1cLhHRsk6DxEvkKR6uZCbYzWfrvg0yw01Mu/LUQ7MTUnp6wlO0J37swDCFVjQ
         2nIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=oxBtFKbCtG8PgkaTN+LoVoPaU+tjdtLmjD1ibmVcdJE=;
        b=eb+qqAIGrL3x1B6YShPiTuNXt0mCFOQ3smqTOM1oQEngc9NhfNdwjl6TopfsO7RMsB
         gP/D83a4CFUicoHnIyX5ebi+7dcCQca8RZ/A4EuhpJosfkl9BSIH1iq/lMxckzjGZVQC
         +a3DLON1wsXjPDBcUYJbAItQLQ06bsn4OvnVrlLHeYm7VHk9xRyxGN/5alaQCq24SP4y
         f8S0mzlW6I3pu0ZpofKTfujKP3KH3scLwbLb3bREfAgE5VtpHLCgFKZAhu9xwB+MKqUy
         cJfsA9ymdzxm2Knz+hsobY0+g/RmQQTocCJZ4G7da2MyJFoJyVbQk89gzS0q/47bjX2+
         r2UA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C25D2185A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Farhan Ali <alifm@linux.vnet.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 4.4 21/50] s390/entry.S: fix spurious zeroing of r0
Date: Fri, 27 Apr 2018 15:58:23 +0200
Message-Id: <20180427135656.973304623@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135655.623669681@linuxfoundation.org>
References: <20180427135655.623669681@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908181616624933?=
X-GMAIL-MSGID: =?utf-8?q?1598908181616624933?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Schwidefsky <schwidefsky@de.ibm.com>


From: Christian Borntraeger <borntraeger@de.ibm.com>

[ Upstream commit d3f468963cd6fd6d2aa5e26aed8b24232096d0e1 ]

when a system call is interrupted we might call the critical section
cleanup handler that re-does some of the operations. When we are between
.Lsysc_vtime and .Lsysc_do_svc we might also redo the saving of the
problem state registers r0-r7:

.Lcleanup_system_call:
[...]
0:      # update accounting time stamp
        mvc     __LC_LAST_UPDATE_TIMER(8),__LC_SYNC_ENTER_TIMER
        # set up saved register r11
        lg      %r15,__LC_KERNEL_STACK
        la      %r9,STACK_FRAME_OVERHEAD(%r15)
        stg     %r9,24(%r11)            # r11 pt_regs pointer
        # fill pt_regs
        mvc     __PT_R8(64,%r9),__LC_SAVE_AREA_SYNC
--->    stmg    %r0,%r7,__PT_R0(%r9)

The problem is now, that we might have already zeroed out r0.
The fix is to move the zeroing of r0 after sysc_do_svc.

Reported-by: Farhan Ali <alifm@linux.vnet.ibm.com>
Fixes: 7041d28115e91 ("s390: scrub registers on kernel entry and KVM exit")
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/kernel/entry.S |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -421,13 +421,13 @@ ENTRY(system_call)
 	UPDATE_VTIME %r10,%r13,__LC_SYNC_ENTER_TIMER
 	BPENTER __TI_flags(%r12),_TIF_ISOLATE_BP
 	stmg	%r0,%r7,__PT_R0(%r11)
-	# clear user controlled register to prevent speculative use
-	xgr	%r0,%r0
 	mvc	__PT_R8(64,%r11),__LC_SAVE_AREA_SYNC
 	mvc	__PT_PSW(16,%r11),__LC_SVC_OLD_PSW
 	mvc	__PT_INT_CODE(4,%r11),__LC_SVC_ILC
 	stg	%r14,__PT_FLAGS(%r11)
 .Lsysc_do_svc:
+	# clear user controlled register to prevent speculative use
+	xgr	%r0,%r0
 	lg	%r10,__TI_sysc_table(%r12)	# address of system call table
 	llgh	%r8,__PT_INT_CODE+2(%r11)
 	slag	%r8,%r8,2			# shift and test for svc 0
