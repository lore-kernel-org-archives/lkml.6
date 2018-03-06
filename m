Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AG47ELtRNlAW1AUngecinqVPgD+FqX8HD/j+sUSXkKM+jdkv8EOvSgJRCln1WJ2HJeobwwe/bkXk
ARC-Seal: i=1; a=rsa-sha256; t=1520296006; cv=none;
        d=google.com; s=arc-20160816;
        b=vgYijjT6c0YSaLqO85DZiRjugsAqAG+VgabPLAmxoe8+ay0DR+wIAht6kq6pjOLnmj
         rqBAGCFTNMukKWqzzxGXOEWctUHQVJOuvhy90JAKxxv3QgdElX/ezTw++dobfZTlUSWr
         4nx5/JD5CqfMcJ2WLlBzJDK5IOpXJHOX1S3PTXOxWn32tMvOBPnMj0NjmlNlUhpHuaEF
         ZSgTHvwuW9QoLBpfinpOhxqlebX5CliOVUSN8oQ26F6TrpjptpPZqtzMBcIqPPlvmKd4
         Ijbv6GMwXFK3oWhYH3Jh9jF2HkHBW3Q+2R32CfzuKtIUfk+qUuuBlTYnSUvu/wgJ6gPU
         xTLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :dkim-signature:arc-authentication-results;
        bh=ubGaHsHeebIW5YMsXMACLxnvLv09X8RIxqEyqzJe3BQ=;
        b=AL3o7MpalEnD64mM1/2vpuBjkObk8x/Y3DuuXJl8E9aa9YV5SuauIMT7YJLvd6ru1I
         ShamV4cBSw7dmjI4CZeSU6dKTYvf1RwAYkSIzXb3MqEeu8NQCSEaavPqB+5ZKhowlKw+
         XwVE5sVgdc98TZ2VWt8TwXQd2VwBkP9XwVQWrnK7AtgndzaKwUj2s+UVnG/Vw2fK4gfy
         9MNWfz9noPTWeaBWoqeXpGX4CIvprUyar0sGi9ePbJn7av7j5W08QpIV3AUc2QFhzkJ/
         MM+kcen+3Eo/wMSFdVo+9KLOC+Ix9QpGGjoAROkeweMtALlQ9UxWrGnq0kfm26gDe4Kd
         FuAw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=ixtwzHbE;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=ixtwzHbE;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        cminyard@mvista.com, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4.1 50/65] kaiser: add "nokaiser" boot option, using ALTERNATIVE
Date: Mon,  5 Mar 2018 19:25:23 -0500
Message-Id: <20180306002538.1761-51-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306002538.1761-1-pasha.tatashin@oracle.com>
References: <20180306002538.1761-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060003
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594145904753334673?=
X-GMAIL-MSGID: =?utf-8?q?1594145904753334673?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hugh Dickins <hughd@google.com>

Added "nokaiser" boot option: an early param like "noinvpcid".
Most places now check int kaiser_enabled (#defined 0 when not
CONFIG_KAISER) instead of #ifdef CONFIG_KAISER; but entry_64.S
and entry_64_compat.S are using the ALTERNATIVE technique, which
patches in the preferred instructions at runtime.  That technique
is tied to x86 cpu features, so X86_FEATURE_KAISER is fabricated.

Prior to "nokaiser", Kaiser #defined _PAGE_GLOBAL 0: revert that,
but be careful with both _PAGE_GLOBAL and CR4.PGE: setting them when
nokaiser like when !CONFIG_KAISER, but not setting either when kaiser -
neither matters on its own, but it's hard to be sure that _PAGE_GLOBAL
won't get set in some obscure corner, or something add PGE into CR4.
By omitting _PAGE_GLOBAL from __supported_pte_mask when kaiser_enabled,
all page table setup which uses pte_pfn() masks it out of the ptes.

It's slightly shameful that the same declaration versus definition of
kaiser_enabled appears in not one, not two, but in three header files
(asm/kaiser.h, asm/pgtable.h, asm/tlbflush.h).  I felt safer that way,
than with #including any of those in any of the others; and did not
feel it worth an asm/kaiser_enabled.h - kernel/cpu/common.c includes
them all, so we shall hear about it if they get out of synch.

Cleanups while in the area: removed the silly #ifdef CONFIG_KAISER
from kaiser.c; removed the unused native_get_normal_pgd(); removed
the spurious reg clutter from SWITCH_*_CR3 macro stubs; corrected some
comments.  But more interestingly, set CR4.PSE in secondary_startup_64:
the manual is clear that it does not matter whether it's 0 or 1 when
4-level-pts are enabled, but I was distracted to find cr4 different on
BSP and auxiliaries - BSP alone was adding PSE, in probe_page_size_mask().

Signed-off-by: Hugh Dickins <hughd@google.com>
Acked-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit e345dcc9481543edf4a0a5df4c4c2f9597b0a997)
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>

Conflicts:
	arch/x86/entry/entry_64.S (not in this tree)
	arch/x86/kernel/entry_64.S (patched instead of that)
---
 arch/x86/include/asm/cpufeature.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index b62f5b1a4361..8effe086de27 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -201,6 +201,9 @@
 /* Because the ALTERNATIVE scheme is for members of the X86_FEATURE club... */
 #define X86_FEATURE_KAISER	( 7*32+31) /* CONFIG_KAISER w/o nokaiser */
 
+/* Because the ALTERNATIVE scheme is for members of the X86_FEATURE club... */
+#define X86_FEATURE_KAISER	( 7*32+31) /* CONFIG_KAISER w/o nokaiser */
+
 /* Virtualization flags: Linux defined, word 8 */
 #define X86_FEATURE_TPR_SHADOW  ( 8*32+ 0) /* Intel TPR Shadow */
 #define X86_FEATURE_VNMI        ( 8*32+ 1) /* Intel Virtual NMI */
-- 
2.16.2
