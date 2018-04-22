Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49Gv7K2Jinrj+/eWcik4vGXsZchVrZMNdgYx/cvHU9v1Q61bPEXmyBg6C0JZOFKgJoHr/0C
ARC-Seal: i=1; a=rsa-sha256; t=1524405745; cv=none;
        d=google.com; s=arc-20160816;
        b=v9oLlo9Q7C3oMJHOkwz0qiGiKD6/BZbLYJUINSO7kluryYXSEP1nAQKVMCPHWkC6uX
         B69QegrkDaJ64rh53bb/zHjt1lfrGDe0F6ZyPX5ur1Jpom23JLLYJcQhMEdVgRbrQV9N
         J+ZnZNvfrbyOP26x1xYCejRIjonlyVYB81l4j5dQCRR9ZnCPjirKsQ7Xv+i0ZR0Wdh+S
         PhTw+tKrmu8aIkiQJrrlUgWPjpl32UdVaM8SNvFLN9/s89baZu15gSBAiz4mei5L+gXE
         1vtHjZCE02IjCj+EDSoh/iXpN1iKzwR4Mf7rOSih9gDC/6sUQtfWp0OXgfE0q7diq5Ar
         yxQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0xtahmpkj2QNBDeFqNZiLdpD3a6AlQkjYVXL2X23Ibg=;
        b=psgJGyik3v42X3gUJh7MVqTtqSIbf7US1FcZP14EToWq+6Yqkh6Hk3JpCbWPhow7TV
         2L8Qvkom2ALmdc4utvP32wicF4vg63gtszIbd45x6tZP24wGdRSRDsryqvSX95C5elpJ
         KJgcJoiCUHZ/Glg0zL2iUX9r1TENxDpe6IqhmCzIriLpxTl3B7ChUC7+PepZR9ISLYxS
         8nJpk7hli996sJDyWq5Xz/N5OVtUF8szPdQ787CCk6TDpZRNknGggJEv0NWjSHb8gMBM
         YzTseqD2+FIY5a4wseiszbx/IBvj0zcCxJm+clIRUdJT5dKbFTXokwz9BF8mU/zdl18k
         r5nQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.16 179/196] powerpc/lib: Fix off-by-one in alternate feature patching
Date: Sun, 22 Apr 2018 15:53:19 +0200
Message-Id: <20180422135113.506068837@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455279697433577?=
X-GMAIL-MSGID: =?utf-8?q?1598455279697433577?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
