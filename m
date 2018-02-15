Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1797899-1518707877-2-262032012897055752
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518707876; b=OAz5zeSfJ3+gueU4p3Ubg4tN7pa84s2IDe2NGBAikN3wMsj
    0DYvdeBaSivk5thCJ97S+tbOrxmKTuRFII2Gm9x0Qjv4urAan+XAa1JR/7mcp3yR
    xB9NSC5L7trST30AGh0JgBRj6vZmwC/MIfSOpkieKlaJftIyy/FuTTvII/apbvEK
    u1VSdCwWePE1woEBUztH4AHBJNFTiJAEwVc0qJbPZAHNXQyQcgnF0DAyaq4t4gi+
    v2Az9FPiSJMgCB4u1jYHMHAx4WtxEZiIQdQy1RDfIyWK3cjlDa8nUjSP0S5AzgcU
    JmppFMBKERCFUqc4FvcnnitSJYdjKvSPsdBxsHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1518707876; bh=+t8H48aTCJ/7PuBQovkPR8uZcm
    aa7TdWloCY0e9G6iM=; b=gpwcaGHbHWEUlpo7QdrW/m6Q9Z53ayAoj5vXw6dS6v
    LwKvbymSg06eQv17LIFkW2X9w9cUfApzbk/dQ8zlv5/QHrCgiKk2mPF4nBG0gW1J
    DHUbufM8TjWjLv9yTNRmhMFK2yRwwas7aOObi0W9PZu/Ylae7yxG/Ln4N3SVGcgD
    J3Y/w8gwmTBACFwwompMHkGiDWvI5KfWvjnl1Avw6P8CJBhO0wrpKKg7BEL59Rw4
    UuDrJ70s7bmiXlow3zmTWi/89M5neXvKTK4kYRwEFhLIVB8enh7mlTO5gsGPwumB
    rYXdEgSoc4F6eE47oVc1aotT66c3brp434bBQguzV6SQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033676AbeBOPRy (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:17:54 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:46733 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033088AbeBOPRx (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:17:53 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: stable@vger.kernel.org
Cc: x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>, Hugh Dickins <hughd@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] [stable-4.9] x86: fix build without CONFIG_X86_VSYSCALL_EMULATION
Date: Thu, 15 Feb 2018 16:16:56 +0100
Message-Id: <20180215151710.1473117-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:h8PYdX4vUhO5lA7sMXfex+JEYEq0gSc10qodm/Mf7r6DGa1bHXb
 VUZ7e351d8i011IuLVRgHqws5usV2Sp9NAzX1J5O/LO81qq6hJy4DIrp/uaH6T/OBfjxoEW
 IGubTV7BYptUXHtfh0VNNc8DDQiYSz8OWVchGz0ldyp7lVAQqF8lcCNuNj20edF8xdyc12R
 gHG+g2QP6lA6/dpfBiibg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uvigUY2wKMc=:hOgF03DJuu5bIkiN3BiIfT
 yPF8du2oHtj1pHGK9cWULJic/vWvqiV552BBNuNv139XQuwBVyXF2j3Y0ezmd2HAoqOlHH9L4
 JbCAbP8v72/Dn8HyQw8NYhr8J1JRITP6Q9BwKWju1xxjiOkwfugdnColzWMyxu1rqVKNumn/C
 V4R4/ufrgJhloAfpcTOj0SG3JVJtsR7cCFfzQMWebpDLRT0G6siY0XJvS2mWgcpP/co0J21L8
 yag6bKhMAfRm/Q7ieFZuGo5zRMmUsx6GerPg1NFqXdvZqLUT2KLJv29WIYgZ4RUcfybbNKT2D
 adnon343XWZ3+MWFoxoKnVxcgg8KmAhlhr0o6GMPycivzd5sfgvJpzytN120k+s4hYx1KMUzM
 lsmx+94W5u+m5j+cVHe2tx2wVf8lLZMjcCa5cax9JTQJxm5CN3OzTndOgK0ubhBCTdIT9QgKw
 oFlIiXy8E1EntRkO/VfCI3m+U730aOzDKPPCYuuJ0k1hj6+s1MtKWNgMaStoZk4kaom3LopAx
 lU2WUBrNo8xgxB7OX8pgv0dsY7EOoBWNzKvDjW0aNX6pgFWOCMUajvXR0hJKFfcjCxLRvzKRB
 YKX16Vf/pOL3B9MbrAxrBFEgXW7074hUZsCrxqKo7QW6imun3wwuA9Wa3np24QmtDtq4i+c3I
 o7W+wFUOqCmd3puQWMw4MrPnTRKq19D734F4yjtrkmWT7/1nwFwZYHAO3c42tUppbj+6IAI/g
 Z2VoxiTPUuunVGDDuy0S8+YN5DB8EgjvuSuGbw==
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I ran into a 4.9 build regression in randconfig testing, starting with the
KAISER patches:

arch/x86/mm/kaiser.c: In function 'kaiser_init':
arch/x86/mm/kaiser.c:347:8: error: 'vsyscall_pgprot' undeclared (first use in this function); did you mean 'massage_pgprot'?

This is easy enough to fix, we just need to make the declaration visible
outside of the #ifdef. This works because the code using it is optimized
away when vsyscall_enabled() returns false at compile time.

Fixes: 9a0be5afbfbb ("vsyscall: Fix permissions for emulate mode with KAISER/PTI")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/include/asm/vsyscall.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/vsyscall.h b/arch/x86/include/asm/vsyscall.h
index 9ee85066f407..c98c21b7f4cd 100644
--- a/arch/x86/include/asm/vsyscall.h
+++ b/arch/x86/include/asm/vsyscall.h
@@ -13,7 +13,6 @@ extern void map_vsyscall(void);
  */
 extern bool emulate_vsyscall(struct pt_regs *regs, unsigned long address);
 extern bool vsyscall_enabled(void);
-extern unsigned long vsyscall_pgprot;
 #else
 static inline void map_vsyscall(void) {}
 static inline bool emulate_vsyscall(struct pt_regs *regs, unsigned long address)
@@ -23,4 +22,6 @@ static inline bool emulate_vsyscall(struct pt_regs *regs, unsigned long address)
 static inline bool vsyscall_enabled(void) { return false; }
 #endif
 
+extern unsigned long vsyscall_pgprot;
+
 #endif /* _ASM_X86_VSYSCALL_H */
-- 
2.9.0
