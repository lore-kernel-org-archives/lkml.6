Return-Path: <schwidefsky@de.ibm.com>
X-Google-Smtp-Source: AH8x2254mueQN8hABEn5gqO3p5QHSmPuHlhO5U4ReSKQzKu9IqnwbtEL5AoTXpuTIrfjfsgCaO7w
ARC-Seal: i=1; a=rsa-sha256; t=1517986822; cv=none;
        d=google.com; s=arc-20160816;
        b=mR76vpH1qJC0Isu5Tr4Ppav+cW5zBXS4jzKD196EQAfOmh6wxtnQ3jkJwXmfcXl8rY
         yvRN3xiy7y3ZLoofEfM9Bbtd2v4rbKouAmmuGdMF0t0XTThBzQwPsiwZYu8rbOuA0Cp+
         RQJbSwOQ5KawC6MWxhd4ZPulNz9gsv+FqmTC4XuRfrhFRMmFMkJUmtLcLXZDq1wjAH7d
         4oZCiZUmxh/O9SZkdfakPJON6oIOA1SFpkXO8TufBMafA3fE3o/fY9yJsufiLOCko5EO
         fK11VEHOCzm4nYtBBR+k4XoxNq/tDz/0jQ1QhJfSQb9HgFDbMDSb21mmARGCSk5SMoTj
         TpHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:references:in-reply-to:date:subject:cc:to:from
         :arc-authentication-results;
        bh=aBdzwPztLsAUnYudQkCKcKQabIA2VY33YdePNa5qEJ0=;
        b=DxCqQPkXJ9iXeL/Lc5Qc+uPTT79NRbzVglwmuvzHoWBdOyjQAHgK+d+E97xYb9g6wx
         PY4GEoQ41qYWqAAGzGLic9JW2URLipNySDs7RT/2/Rk8S9SOwxfCTduK9zJ1vvrdA+9Z
         Ep3MM9qIHVLwc7wFVLPDDlN3jnGQYPWGv2aP0+wY0UE5/h43ESgBXt2QVWnVu6O2ylVo
         Abr+S/8McXX4xP6boNXdgFE6NQRrG9hy2qceQ9y0Aj9vLMnRd2MabCv3DjkTFY7mL9r5
         2mX1p5DEWJBxwrsSNVhiJm1cm+NMZluKtQEAZcsy/ERQVs9KcvIrLEEZ/bQrUrNUf7C5
         Nn6g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of schwidefsky@de.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=schwidefsky@de.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of schwidefsky@de.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=schwidefsky@de.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Masters <jcm@redhat.com>, Marcus Meissner <meissner@suse.de>,
        Jiri Kosina <jkosina@suse.cz>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@ucw.cz>,
        David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH 1/6] s390: scrub registers on kernel entry and KVM exit
Date: Wed,  7 Feb 2018 08:00:06 +0100
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517986811-27819-1-git-send-email-schwidefsky@de.ibm.com>
References: <1517986811-27819-1-git-send-email-schwidefsky@de.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18020707-0016-0000-0000-0000052033DC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020707-0017-0000-0000-0000285CE859
Message-Id: <1517986811-27819-2-git-send-email-schwidefsky@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-07_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802070089
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591724550351408099?=
X-GMAIL-MSGID: =?utf-8?q?1591724550351408099?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Clear all user space registers on entry to the kernel and all KVM guest
registers on KVM guest exit if the register does not contain either a
parameter or a result value.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 arch/s390/kernel/entry.S | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 6cd444d..5d87eda 100644
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
@@ -561,6 +569,15 @@ ENTRY(pgm_check_handler)
 4:	lgr	%r13,%r11
 	la	%r11,STACK_FRAME_OVERHEAD(%r15)
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
@@ -626,6 +643,16 @@ ENTRY(io_int_handler)
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
@@ -839,6 +866,16 @@ ENTRY(ext_int_handler)
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
@@ -1046,6 +1083,16 @@ ENTRY(mcck_int_handler)
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
-- 
2.7.4
