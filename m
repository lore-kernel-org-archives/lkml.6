Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpabbYSQgmUKImX6vVqc9ZTmhS7EJwynrK1DiC606i02+dome8roIC3A4WmiLVOBKhOxvJ2
ARC-Seal: i=1; a=rsa-sha256; t=1524837851; cv=none;
        d=google.com; s=arc-20160816;
        b=ErU7QhMMVyJTI9sESOFfF6xRXGcaZCOP/h1K9KK5GhYB87pi4vBA5TD9gtrrqZSzkv
         GctNb7+qSaRZroUOadrjsKDoWeRFMHnJdVu7XuUuwOM3EAHFZ87svEu7Xe30xJjuutB2
         dmu153K06QZNfpaIexDKHSA+hE8Far242xY4n4Q1amtVoUOVz6Q4eT5ooWSWnlHdANtQ
         YP33iDSpZuSk20nYKiK2hkNqEp7DqTOmv0w6yut+YI1lY+Os9Nh1aim8rDWoJ40cBPNx
         98t2GRNiLjcUoknXKgFhCXJuhweeWG2KOnyrpoJaFLSYUHhD5fWieb8xn+WUIEsO6/C1
         ISOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=4f42l7bBK+po4LLPHUrlWUxqOCAtpc0IdmICZUXDSJc=;
        b=Ll/q26oUKRAeqfDGjvqYy4QTwfk+vVt2QXZoGKgoo23aYGPlBfqUnk04+zx1Y4EAA7
         hg5zNCrBzV6cPk+U9WgqDnleL3HT8pGP5Wg/fKUwAzAjGGjY/5paTRDiDGwzYwaE8xKM
         zLybVPgKrPcLAkAVQ+ri+Nli0MZnDxhqEnRo3gAPcat8ia/LyFxD9sRIEQalPYd/S1ME
         ZXZMoWJ0oBE/qv2oKMWiBwqZsBeWYP8RF2PE0kkc3+P/s3w4MvhQv4W+MDxHH2LkMaxG
         QqvmdliDgKrnMyQ9fTNPU8H4jwnlynOhG6jTMX0Vf/wMahUrym+gqZ7C8bWPz0bSBFej
         X4xg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 239D92189D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Farhan Ali <alifm@linux.vnet.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 4.9 40/74] s390/entry.S: fix spurious zeroing of r0
Date: Fri, 27 Apr 2018 15:58:30 +0200
Message-Id: <20180427135711.583204394@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
References: <20180427135709.899303463@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908181616624933?=
X-GMAIL-MSGID: =?utf-8?q?1598908374715256524?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/kernel/entry.S |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -434,13 +434,13 @@ ENTRY(system_call)
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
