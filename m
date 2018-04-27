Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZq+0hzCoz+WxcwODU4n8ozC0+6y+4TLcWY6OtS5QsbAswAUiJMoEiuNI+QPjJ0szYHSlhhr
ARC-Seal: i=1; a=rsa-sha256; t=1524838056; cv=none;
        d=google.com; s=arc-20160816;
        b=a2hdlVLeXKWkLaKn3EgZO7inKXInmRI0otyXofEZyC4su5W4LKbdDtD5fsuPKKl6Ev
         8VshSJv4Oy4CiTNSt3Xfm3k7IxKJhwXtobklZbsLR5n554YdmwQFSUtxReZW3Tqk4jab
         agHK1vFNJ0jn3O8XTSJVqyvkX49oF3auq+c6Rw5NKe+Vxy5dy3HUiyizB7VdsY7uwBiO
         HVAMlsmHNzVWj1/sjNmd2wU+V9AhtIQ2Akv3TkumZXvatjWmSDfu5fGlbYD9Ux0hTx8a
         JrD1f8/fhcrl/brxxsKGTVmyrXlbINHCsaWVl1QgZaM3NJxE9dh3QLEAGCDpOvR9bQUu
         9nLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=KvGn2Vn50O5K2vYrVyB48glW6JD7kd8HvArGM9v5LmY=;
        b=XKNowTa3h2BGhtXDkBQAVfmiyirGYb3i/zE3kK0v1yOSsoP0/Xmy/5Bnjgi1eyNH/4
         mGbwHFRvdsWZ1JPq0Drq9LG2c4U4WDY9Sh0y2vj4FO4HqR2JnK7ydtPXD3OqPgSiFIN3
         McBvMkR6NWMLX7QGxpX1+7xEaQclLLBKnyAvP4fsoac/8EnaNl9UqzTHwAOzR/s3Bu38
         juOoeqrBhszeE6xXNtMVCyQJpDY3vDWu+kWyIngbcO8lre4RJJERC4c8YZ4ldktkvQxz
         U8kEmxkQuTf2G8VzXBes6l2KSyPJgHsK0U+6EbOwZxGgr3OJaiVweEo0n2wprytxWsqe
         SPvg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED538218D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 4.14 45/80] s390: scrub registers on kernel entry and KVM exit
Date: Fri, 27 Apr 2018 15:58:38 +0200
Message-Id: <20180427135735.239444417@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135732.928644313@linuxfoundation.org>
References: <20180427135732.928644313@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908254418187128?=
X-GMAIL-MSGID: =?utf-8?q?1598908590048395683?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -248,6 +248,12 @@ ENTRY(sie64a)
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
@@ -282,6 +288,8 @@ ENTRY(system_call)
 .Lsysc_vtime:
 	UPDATE_VTIME %r8,%r9,__LC_SYNC_ENTER_TIMER
 	stmg	%r0,%r7,__PT_R0(%r11)
+	# clear user controlled register to prevent speculative use
+	xgr	%r0,%r0
 	mvc	__PT_R8(64,%r11),__LC_SAVE_AREA_SYNC
 	mvc	__PT_PSW(16,%r11),__LC_SVC_OLD_PSW
 	mvc	__PT_INT_CODE(4,%r11),__LC_SVC_ILC
@@ -550,6 +558,15 @@ ENTRY(pgm_check_handler)
 3:	stg	%r10,__THREAD_last_break(%r14)
 4:	la	%r11,STACK_FRAME_OVERHEAD(%r15)
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
@@ -615,6 +632,16 @@ ENTRY(io_int_handler)
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
@@ -820,6 +847,16 @@ ENTRY(ext_int_handler)
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
@@ -982,6 +1019,16 @@ ENTRY(mcck_int_handler)
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
