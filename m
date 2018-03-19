Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtYi+P6OlExvFPw902MFZnlzpb4dxJj472CT187uX5iG1sZ+RyXmiUkbwlGqcw8WVlVrH9l
ARC-Seal: i=1; a=rsa-sha256; t=1521483968; cv=none;
        d=google.com; s=arc-20160816;
        b=HgEy0PQ0W4OL2khw6PjN89biPSIfE/Q0ejjMi6BWLcM16Gm8INUE8jKpgotlqOGlH6
         Oe4n4go3HcbajscBGKtMwxU0TiBCF8wWg4HVh0YaD9YKm3LR97EoG7HLb72OU8d70spW
         6dZXcOku70U6CZimbcwIZ3LylKhKrlBR38NkH3ZJycn9udh0KPeHGL0ZPmpvo5cbUSV1
         bs6+HdJKew/fKY5BrRqznooDQpcpQDxL4UX5phrOIis8E/Ijvm96eje72qL/UDQyt75k
         KMhpgEDgSnFqXr39cUpuC5Xr/AlFmByKRmfP0tHLxsbvvOKgQykkaq99e0XX5tzxLWgZ
         mN/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=dKSmY1Aw/p00WDgoNADstyWvt9/aJ1qe7cg14dtos7A=;
        b=fB8BCY3ehhXG94jiMaeHBWMJ0TiMsFv6ZkOZgtLwieAc7XpCwDqrTy6F51IPwe0s8C
         clcTDs70SjoESHlhFnabgqLuQlH9Yi+K05uI8DIbB2RcGUfjdkNg6kfXjJEdSeDxyGXz
         bn4xmVPryGKp11DiHw0ddOI2K5kEqTSWD2OyGs+PDl6+N3faxxJawCaziCldnnGnF0ya
         NaFyPz2HEDo4fL3kUbZ3Wh6ZxPl8h0xLbGkADb2ZR+GsT8jpxoHfG1d3czjJhvPSX+UB
         0Saa88VnH55TYTqTqYApEC8iz2yFXqvcHd8ZBx3LjnF/XD1dFRK/ZhcrNLTk9kdzcGVB
         yzcw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 138/241] powerpc/nohash: Fix use of mmu_has_feature() in setup_initial_memory_limit()
Date: Mon, 19 Mar 2018 19:06:43 +0100
Message-Id: <20180319180756.902541981@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391574206462454?=
X-GMAIL-MSGID: =?utf-8?q?1595391574206462454?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Ellerman <mpe@ellerman.id.au>


[ Upstream commit 4868e3508d1934d28961f940ed6b9f1e347ab52c ]

setup_initial_memory_limit() is called from early_init_devtree(), which
runs prior to feature patching. If the kernel is built with CONFIG_JUMP_LABEL=y
and CONFIG_JUMP_LABEL_FEATURE_CHECKS=y then we will potentially get the
wrong value.

If we also have CONFIG_JUMP_LABEL_FEATURE_CHECK_DEBUG=y we get a warning
and backtrace:

  Warning! mmu_has_feature() used prior to jump label init!
  CPU: 0 PID: 0 Comm: swapper Not tainted 4.11.0-rc4-gccN-next-20170331-g6af2434 #1
  Call Trace:
  [c000000000fc3d50] [c000000000a26c30] .dump_stack+0xa8/0xe8 (unreliable)
  [c000000000fc3de0] [c00000000002e6b8] .setup_initial_memory_limit+0xa4/0x104
  [c000000000fc3e60] [c000000000d5c23c] .early_init_devtree+0xd0/0x2f8
  [c000000000fc3f00] [c000000000d5d3b0] .early_setup+0x90/0x11c
  [c000000000fc3f90] [c000000000000520] start_here_multiplatform+0x68/0x80

Fix it by using early_mmu_has_feature().

Fixes: c12e6f24d413 ("powerpc: Add option to use jump label for mmu_has_feature()")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/mm/tlb_nohash.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/mm/tlb_nohash.c
+++ b/arch/powerpc/mm/tlb_nohash.c
@@ -751,7 +751,7 @@ void setup_initial_memory_limit(phys_add
 	 * avoid going over total available memory just in case...
 	 */
 #ifdef CONFIG_PPC_FSL_BOOK3E
-	if (mmu_has_feature(MMU_FTR_TYPE_FSL_E)) {
+	if (early_mmu_has_feature(MMU_FTR_TYPE_FSL_E)) {
 		unsigned long linear_sz;
 		unsigned int num_cams;
 
