Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AG47ELv+StC6ydDGfoVDatG1+adHg8KkxqEDja24st43YkngiI0fDy1svlNcjr+9CO7aeSfAYoqN
ARC-Seal: i=1; a=rsa-sha256; t=1520295990; cv=none;
        d=google.com; s=arc-20160816;
        b=Ln5r3vqySQq8i+cZrWarPL6I/93y2zNeKD9tduj+srQ5/CYKhwgnrDz0LYJjPpP0Gp
         MxfEV60UAGND9rS9oKCNx+VtWUOcm15/fL+Q4doOgZG4aVlg6a1hD1wPw/qVgyn2vwUT
         qacnDMCedzYbIfu6FfBgreFHyu3POENNO/cNEnKfWPvd0LxOmmy9CEo0ER2PZ8BBUGDo
         mXZIllUQNZgZliDFEqmgU55rvXiedyJ6JwNH1Bfp/y/GjrWs17wO2qloQsVtwA+XmyE9
         N0ymVXOVPTGlioIq7f1WjzSkMrRFH04rViPoPOwDNaM3T3c8yVf/087UhP/xsZHGSJX9
         aU6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :dkim-signature:arc-authentication-results;
        bh=0E/A+WS3Ey7sYZ822dXZd0RTzhKuTS/sM22xTBn5WRY=;
        b=G97gFo6d//aFST2KWkcL6eEUBcax0HhCX2bALpiDHNtjxnmGsEkfW11qYiwKIzWvrK
         08YTp+zxaJc2oRuuNBBTSo7RzB2gZJDwCHcaKZxcoMxrg7ct2i/T3AkqS10Y16Km1Ly2
         Y11ZQ8QFY/SvFzg5GybaKycj2vA2sKaKIhCC4bnpTrghTnbIfvaLUgwrNhd4yVHqkg14
         FAram3E779D31yaJQxdo/R2tA1hINik5Uh3MfSQl0M0wbpfp3IrgYJBwGFN1yjvbroGA
         wngo+zSsnNDLQw1eNc+/x9oPFLPbdGWnaFcEEEhzurtuxIW+HzZ5wAluOPN9Af+/tDTe
         3iag==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=Ro8GWzvH;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=Ro8GWzvH;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        cminyard@mvista.com, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4.1 32/65] kaiser: fix regs to do_nmi() ifndef CONFIG_KAISER
Date: Mon,  5 Mar 2018 19:25:05 -0500
Message-Id: <20180306002538.1761-33-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306002538.1761-1-pasha.tatashin@oracle.com>
References: <20180306002538.1761-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060003
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594145887785969992?=
X-GMAIL-MSGID: =?utf-8?q?1594145887785969992?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hugh Dickins <hughd@google.com>

pjt has observed that nmi's second (nmi_from_kernel) call to do_nmi()
adjusted the %rdi regs arg, rightly when CONFIG_KAISER, but wrongly
when not CONFIG_KAISER.

Although the minimal change is to add an #ifdef CONFIG_KAISER around
the addq line, that looks cluttered, and I prefer how the first call
to do_nmi() handled it: prepare args in %rdi and %rsi before getting
into the CONFIG_KAISER block, since it does not touch them at all.

And while we're here, place the "#ifdef CONFIG_KAISER" that follows
each, to enclose the "Unconditionally restore CR3" comment: matching
how the "Unconditionally use kernel CR3" comment above is enclosed.

Signed-off-by: Hugh Dickins <hughd@google.com>
Acked-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 487f0b73d82611a2dc48d7d78409e2e9d994006a)
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>

Conflicts:
	arch/x86/entry/entry_64.S (not in this tree)
	arch/x86/kernel/entry_64.S (patched instead of that)
---
 arch/x86/kernel/entry_64.S | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/entry_64.S b/arch/x86/kernel/entry_64.S
index 1bda5ebd1013..8e4056d4b1d6 100644
--- a/arch/x86/kernel/entry_64.S
+++ b/arch/x86/kernel/entry_64.S
@@ -1547,12 +1547,12 @@ ENTRY(nmi)
 	movq	%rax, %cr3
 #endif
 	call	do_nmi
+#ifdef CONFIG_KAISER
 	/*
 	 * Unconditionally restore CR3.  I know we return to
 	 * kernel code that needs user CR3, but do we ever return
 	 * to "user mode" where we need the kernel CR3?
 	 */
-#ifdef CONFIG_KAISER
 	popq	%rax
 	mov	%rax, %cr3
 #endif
@@ -1772,6 +1772,8 @@ end_repeat_nmi:
 	SWAPGS
 	xorl	%ebx, %ebx
 1:
+	movq    %rsp, %rdi
+	movq    $-1, %rsi
 #ifdef CONFIG_KAISER
 	/* Unconditionally use kernel CR3 for do_nmi() */
 	/* %rax is saved above, so OK to clobber here */
@@ -1785,16 +1787,13 @@ end_repeat_nmi:
 	DEFAULT_FRAME 0				/* XXX: Do we need this? */
 
 	/* paranoidentry do_nmi, 0; without TRACE_IRQS_OFF */
-	movq %rsp,%rdi
-	addq	$8, %rdi /* point %rdi at ptregs, fixed up for CR3 */
-	movq $-1,%rsi
 	call do_nmi
+#ifdef CONFIG_KAISER
 	/*
 	 * Unconditionally restore CR3.  We might be returning to
 	 * kernel code that needs user CR3, like just just before
 	 * a sysret.
 	 */
-#ifdef CONFIG_KAISER
 	popq	%rax
 	mov	%rax, %cr3
 #endif
-- 
2.16.2
