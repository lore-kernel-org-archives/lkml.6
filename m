Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/lftUYHxqx8So1C8xtlcBchpre4Nm/nItFQX+jcAlymaWXl+PfocgIiuaTelQ07t9zGaZl
ARC-Seal: i=1; a=rsa-sha256; t=1524406248; cv=none;
        d=google.com; s=arc-20160816;
        b=NPMUyflqR1H9yhGaYNyAdBRwZvEkCjVsPURQLxiR7e4p1YMzRP1BgZcr6+Y3upvrna
         bHMnL39sqU7uIADajv0fWj9QdpvG+zBA7UU3HkbKVnseXTnJYstZq5vMT2OD4ddZBGuX
         O6Ao2MzXl7tEaTN22m5BXDShgu5K9P2z+sMIAqH1lOVKzWrKytBtRTlCMmpQxqPRYm66
         FDFpnpmrXv+nsJhLt6lNVt+E68b29ucAcZLuA6epwowQ0xmBAWA04bHIT3mcpTob6RxN
         p0t7siKFRodC9lPgnQa6ilJNAR7sqA4VkCGOH3ZErSoYklH/1sBRaNxurcEo4yaruraa
         O0Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=gFDwHqnVBZaxFO1g1hveXoMdArFzjlF+Ac4qw1recyE=;
        b=0PfVBOrxrR+YGX7fWIMNb56lNMOT1K4rWdKpu2CedN64LXe2syjfkWZ7AUY23gup0W
         Moa8my3iUCBAU4f8tXJyKsWkdkFLRlptndcnUnrLZJSTSCtFv6MSD1aLsNdiydwTebvw
         NzO3tsLXxIhfWT9F49u/YqSyMTdy0l/vcx0upgQJR0R/lVvDXHvZdQIAbrENececsiZB
         o5210+eV2TvrpirzMCECSZILvOInGL9RXDNRNNgU0YxmV2g1hkwrexrrWncBrr2BPswA
         DqHJhGfSL2yQMEgkQBIG8bxz71B+pWePP+l4gKUPPCJWjEMDsHggEjVzNOxQKMcH8suQ
         bJIg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14 147/164] powerpc/lib: Fix off-by-one in alternate feature patching
Date: Sun, 22 Apr 2018 15:53:34 +0200
Message-Id: <20180422135141.524023270@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455279697433577?=
X-GMAIL-MSGID: =?utf-8?q?1598455806755831443?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Ellerman <mpe@ellerman.id.au>

commit b8858581febb050688e276b956796bc4a78299ed upstream.

When we patch an alternate feature section, we have to adjust any
relative branches that branch out of the alternate section.

But currently we have a bug if we have a branch that points to past
the last instruction of the alternate section, eg:

  FTR_SECTION_ELSE
  1:     b       2f
         or      6,6,6
  2:
  ALT_FTR_SECTION_END(...)
         nop

This will result in a relative branch at 1 with a target that equals
the end of the alternate section.

That branch does not need adjusting when it's moved to the non-else
location. Currently we do adjust it, resulting in a branch that goes
off into the link-time location of the else section, which is junk.

The fix is to not patch branches that have a target == end of the
alternate section.

Fixes: d20fe50a7b3c ("KVM: PPC: Book3S HV: Branch inside feature section")
Fixes: 9b1a735de64c ("powerpc: Add logic to patch alternative feature sections")
Cc: stable@vger.kernel.org # v2.6.27+
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/lib/feature-fixups.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -55,7 +55,7 @@ static int patch_alt_instruction(unsigne
 		unsigned int *target = (unsigned int *)branch_target(src);
 
 		/* Branch within the section doesn't need translating */
-		if (target < alt_start || target >= alt_end) {
+		if (target < alt_start || target > alt_end) {
 			instr = translate_branch(dest, src);
 			if (!instr)
 				return 1;
