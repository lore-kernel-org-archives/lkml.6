Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49ssPfYtsxvVxxqOn5HwAnVcaLhqhDM5+4g4pHWUc12/qt72Llup1sXH6iEd5q2GTpPLlcP
ARC-Seal: i=1; a=rsa-sha256; t=1523022089; cv=none;
        d=google.com; s=arc-20160816;
        b=fQzsFMcUTU9JK+kbzy5zi9hMyYcmJ4b4h4fbdN53vPN03vqiTkuod343cwbACO/yVR
         6R70uSELeiVDj0UnFindLybkjiJMOak4cb8EnHs72GjhwQhozIBXGl5xe56cgXBDluLT
         SCCxv4Fy6gXl4xjticXkzpoFD6/jS8q8P91bs07cvbmERi/nFUosG4YZkxLOzXkGUiLZ
         U5UTUXM55sNoNlxhp3q6GkSJRUHk+Cxl3yo3GHdMSMBLztno3YH4+sImU/EkvZo53ayI
         WeIWr+rQ4yg62HTIV2GbwkePklZC9tSh+D9VPNgh1feUFVWaQwNNiKxPSiwva0jJw7Y/
         yfHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ki5hG4jSZc/xUhF00IgL28+l3isLRZdMtAx6w1eHw64=;
        b=u2wsdnp8Cd682MxEpYvCUrUTRDBMVqIvb52qPl0jVV7BkCqQBOLZpt+zRV+CsYAl2M
         g1Jpxl9ly7EBRAg/p4go/oxwl+Hg7CMHYdDQUAef3DHmOvwH+y2xTzB7FvFWgIkaPsGW
         DryJRhj+em8GRMUGF9V7it2gwBJ/yV3jrs2MbZJbulkmkB/oW/9id80nKVcsk5R788ax
         togipWH0CE83Ju0kedlkDxYUt8ZJWF5TrjiRfM7XSU4WZP5pEf6wUY3oOpBWsXtr0Mp9
         6e8WBWx8bOu4u3Zpw3Ia84X2AeBAOc6pn1Fn0ty9Q0KdGTLwveDkYMZOLyjAsxTm4zNk
         oQWw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Balbir Singh <bsingharora@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.15 16/72] powerpc/mm: Workaround Nest MMU bug with TLB invalidations
Date: Fri,  6 Apr 2018 15:23:51 +0200
Message-Id: <20180406084350.809452852@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084349.367583460@linuxfoundation.org>
References: <20180406084349.367583460@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004411006847716?=
X-GMAIL-MSGID: =?utf-8?q?1597004411006847716?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

commit 80a4ae202f2d319eced8bbf612a4e8b0f11c21f5 upstream.

On POWER9 the Nest MMU may fail to invalidate some translations when
doing a tlbie "by PID" or "by LPID" that is targeted at the TLB only
and not the page walk cache.

This works around it by forcing such invalidations to escalate to
RIC=2 (full invalidation of TLB *and* PWC) when a coprocessor is in
use for the context.

Fixes: 03b8abedf4f4 ("cxl: Enable global TLBIs for cxl contexts")
Cc: stable@vger.kernel.org # v4.15+
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Balbir Singh <bsingharora@gmail.com>
[balbirs: fixed spelling and coding style to quiesce checkpatch.pl]
Tested-by: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/mm/tlb-radix.c |   50 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 7 deletions(-)

--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -85,7 +85,23 @@ static inline void _tlbiel_pid(unsigned
 static inline void _tlbie_pid(unsigned long pid, unsigned long ric)
 {
 	asm volatile("ptesync": : :"memory");
-	__tlbie_pid(pid, ric);
+
+	/*
+	 * Workaround the fact that the "ric" argument to __tlbie_pid
+	 * must be a compile-time contraint to match the "i" constraint
+	 * in the asm statement.
+	 */
+	switch (ric) {
+	case RIC_FLUSH_TLB:
+		__tlbie_pid(pid, RIC_FLUSH_TLB);
+		break;
+	case RIC_FLUSH_PWC:
+		__tlbie_pid(pid, RIC_FLUSH_PWC);
+		break;
+	case RIC_FLUSH_ALL:
+	default:
+		__tlbie_pid(pid, RIC_FLUSH_ALL);
+	}
 	asm volatile("eieio; tlbsync; ptesync": : :"memory");
 }
 
@@ -245,6 +261,16 @@ void radix__local_flush_tlb_page(struct
 }
 EXPORT_SYMBOL(radix__local_flush_tlb_page);
 
+static bool mm_needs_flush_escalation(struct mm_struct *mm)
+{
+	/*
+	 * P9 nest MMU has issues with the page walk cache
+	 * caching PTEs and not flushing them properly when
+	 * RIC = 0 for a PID/LPID invalidate
+	 */
+	return atomic_read(&mm->context.copros) != 0;
+}
+
 #ifdef CONFIG_SMP
 void radix__flush_tlb_mm(struct mm_struct *mm)
 {
@@ -255,9 +281,12 @@ void radix__flush_tlb_mm(struct mm_struc
 		return;
 
 	preempt_disable();
-	if (!mm_is_thread_local(mm))
-		_tlbie_pid(pid, RIC_FLUSH_TLB);
-	else
+	if (!mm_is_thread_local(mm)) {
+		if (mm_needs_flush_escalation(mm))
+			_tlbie_pid(pid, RIC_FLUSH_ALL);
+		else
+			_tlbie_pid(pid, RIC_FLUSH_TLB);
+	} else
 		_tlbiel_pid(pid, RIC_FLUSH_TLB);
 	preempt_enable();
 }
@@ -369,10 +398,14 @@ void radix__flush_tlb_range(struct vm_ar
 	}
 
 	if (full) {
-		if (local)
+		if (local) {
 			_tlbiel_pid(pid, RIC_FLUSH_TLB);
-		else
-			_tlbie_pid(pid, RIC_FLUSH_TLB);
+		} else {
+			if (mm_needs_flush_escalation(mm))
+				_tlbie_pid(pid, RIC_FLUSH_ALL);
+			else
+				_tlbie_pid(pid, RIC_FLUSH_TLB);
+		}
 	} else {
 		bool hflush = false;
 		unsigned long hstart, hend;
@@ -482,6 +515,9 @@ static inline void __radix__flush_tlb_ra
 	}
 
 	if (full) {
+		if (!local && mm_needs_flush_escalation(mm))
+			also_pwc = true;
+
 		if (local)
 			_tlbiel_pid(pid, also_pwc ? RIC_FLUSH_ALL : RIC_FLUSH_TLB);
 		else
