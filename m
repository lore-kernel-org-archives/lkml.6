Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZocPafGgh30mbXWChr6X+ZpyROpL5kuoSUycqeOdOu2fwOWIXwpNkUoTS6p4e/Kbl4NZEKV
ARC-Seal: i=1; a=rsa-sha256; t=1524837736; cv=none;
        d=google.com; s=arc-20160816;
        b=VhxRNBteEDNcsyH3ems5z49WujDmg8J0QipFKGtey2kQafZq3aVFpfKrr1tcrfXfHU
         U0o9pCi7ibeVT2mPu48KEL57DrywsYOnnKPhX0JYokbv6mWcaKsJqgROISqxE52tVaGI
         vQHIDruNksd2Av/JiKgZWhuUu+xdu0yE0og9PlSqwLmG7WMCnYkQMxt7Fxz7nku1B9LE
         V1CYPh+oA5T/abvmTH5MYdISaVJSJuqjxI0E7DJv8KZl/Gvoy1iJW01BTNLH21HkizEe
         SEkpL3dMP989Z29hSgDje8ZjyBpp16EiWpNVDBdW29HhBIh5GtjjsWezY7NpEPaGHD1R
         6V1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=sN8swHaD3eUQ+u36t5S/lhE1mzE90P3rUoQMeYGq3RM=;
        b=KmICM5ZqWtQOg4AywrlN1xKEfUeK7bZdpBg5eHYIAo5286af+BIlOK3vHeKLWVAmB4
         TjMMQI5UoWKkJoz9SL8hYT1sv3+CT39frTWdD8fUcwMLE22cd+6ebmUlwdZl7PAEBy4c
         5aKXvZUQg23yLBHmwV6tSIoyI2xBB2I9ViYjvRWHViEajb26TaNlAv5jFJ5QhTVHRFGl
         6lX7cDg4d0faytr2b8+kjDHWRr8XdaBNZAQBRZC3BOS+hMDhhPVGI97wNBrD9rumyDaF
         AG5cZ6XlKZiO8hal5c6dTBNxpAaUIy9GP2FDFxnhrtajni9DQvZ4z/2n3PXtFYHECbEu
         OdtQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC3782189F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 4.4 13/50] s390: scrub registers on kernel entry and KVM exit
Date: Fri, 27 Apr 2018 15:58:15 +0200
Message-Id: <20180427135656.501299808@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135655.623669681@linuxfoundation.org>
References: <20180427135655.623669681@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908254418187128?=
X-GMAIL-MSGID: =?utf-8?q?1598908254418187128?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Schwidefsky <schwidefsky@de.ibm.com>


[ Upstream commit 7041d28115e91f2144f811ffe8a195c696b1e1d0 ]

Clear all user space registers on entry to the kernel and all KVM guest
registers on KVM guest exit if the register does not contain either a
parameter or a result value.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/kernel/entry.S |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -244,6 +244,12 @@ ENTRY(sie64a)
 sie_exit:
 	lg	%r14,__SF_EMPTY+8(%r15)		# load guest register save area
 	stmg	%r0,%r13,0(%r14)		# save guest gprs 0-13
+	xgr	%r0,%r0				# clear guest registers to
+	xgr	%r1,%r1				# prevent speculative use
+	xgr	%r2,%r2
+	xgr	%r3,%r3
+	xgr	%r4,%r4
+	xgr	%r5,%r5
 	lmg	%r6,%r14,__SF_GPRS(%r15)	# restore kernel registers
 	lg	%r2,__SF_EMPTY+16(%r15)		# return exit reason code
 	br	%r14
@@ -277,6 +283,8 @@ ENTRY(system_call)
 .Lsysc_vtime:
 	UPDATE_VTIME %r10,%r13,__LC_SYNC_ENTER_TIMER
 	stmg	%r0,%r7,__PT_R0(%r11)
+	# clear user controlled register to prevent speculative use
+	xgr	%r0,%r0
 	mvc	__PT_R8(64,%r11),__LC_SAVE_AREA_SYNC
 	mvc	__PT_PSW(16,%r11),__LC_SVC_OLD_PSW
 	mvc	__PT_INT_CODE(4,%r11),__LC_SVC_ILC
@@ -504,6 +512,15 @@ ENTRY(pgm_check_handler)
 	mvc	__THREAD_trap_tdb(256,%r14),0(%r13)
 3:	la	%r11,STACK_FRAME_OVERHEAD(%r15)
 	stmg	%r0,%r7,__PT_R0(%r11)
+	# clear user controlled registers to prevent speculative use
+	xgr	%r0,%r0
+	xgr	%r1,%r1
+	xgr	%r2,%r2
+	xgr	%r3,%r3
+	xgr	%r4,%r4
+	xgr	%r5,%r5
+	xgr	%r6,%r6
+	xgr	%r7,%r7
 	mvc	__PT_R8(64,%r11),__LC_SAVE_AREA_SYNC
 	stmg	%r8,%r9,__PT_PSW(%r11)
 	mvc	__PT_INT_CODE(4,%r11),__LC_PGM_ILC
@@ -567,6 +584,16 @@ ENTRY(io_int_handler)
 	lmg	%r8,%r9,__LC_IO_OLD_PSW
 	SWITCH_ASYNC __LC_SAVE_AREA_ASYNC,__LC_ASYNC_ENTER_TIMER
 	stmg	%r0,%r7,__PT_R0(%r11)
+	# clear user controlled registers to prevent speculative use
+	xgr	%r0,%r0
+	xgr	%r1,%r1
+	xgr	%r2,%r2
+	xgr	%r3,%r3
+	xgr	%r4,%r4
+	xgr	%r5,%r5
+	xgr	%r6,%r6
+	xgr	%r7,%r7
+	xgr	%r10,%r10
 	mvc	__PT_R8(64,%r11),__LC_SAVE_AREA_ASYNC
 	stmg	%r8,%r9,__PT_PSW(%r11)
 	mvc	__PT_INT_CODE(12,%r11),__LC_SUBCHANNEL_ID
@@ -742,6 +769,16 @@ ENTRY(ext_int_handler)
 	lmg	%r8,%r9,__LC_EXT_OLD_PSW
 	SWITCH_ASYNC __LC_SAVE_AREA_ASYNC,__LC_ASYNC_ENTER_TIMER
 	stmg	%r0,%r7,__PT_R0(%r11)
+	# clear user controlled registers to prevent speculative use
+	xgr	%r0,%r0
+	xgr	%r1,%r1
+	xgr	%r2,%r2
+	xgr	%r3,%r3
+	xgr	%r4,%r4
+	xgr	%r5,%r5
+	xgr	%r6,%r6
+	xgr	%r7,%r7
+	xgr	%r10,%r10
 	mvc	__PT_R8(64,%r11),__LC_SAVE_AREA_ASYNC
 	stmg	%r8,%r9,__PT_PSW(%r11)
 	lghi	%r1,__LC_EXT_PARAMS2
@@ -908,6 +945,16 @@ ENTRY(mcck_int_handler)
 .Lmcck_skip:
 	lghi	%r14,__LC_GPREGS_SAVE_AREA+64
 	stmg	%r0,%r7,__PT_R0(%r11)
+	# clear user controlled registers to prevent speculative use
+	xgr	%r0,%r0
+	xgr	%r1,%r1
+	xgr	%r2,%r2
+	xgr	%r3,%r3
+	xgr	%r4,%r4
+	xgr	%r5,%r5
+	xgr	%r6,%r6
+	xgr	%r7,%r7
+	xgr	%r10,%r10
 	mvc	__PT_R8(64,%r11),0(%r14)
 	stmg	%r8,%r9,__PT_PSW(%r11)
 	xc	__PT_FLAGS(8,%r11),__PT_FLAGS(%r11)
