Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754741AbeCRQM3 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 12:12:29 -0400
Received: from mail.skyhub.de ([5.9.137.197]:56864 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754162AbeCRQM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 12:12:26 -0400
Date: Sun, 18 Mar 2018 17:12:00 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/10] x86/microcode/AMD: Subtract SECTION_HDR_SIZE
 from file leftover length
Message-ID: <20180318161200.GA2036@cz.tnic>
References: <cover.1521150415.git.mail@maciej.szmigiero.name>
 <b4854b17-e3ba-54d6-488d-0e0bfffe4c71@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b4854b17-e3ba-54d6-488d-0e0bfffe4c71@maciej.szmigiero.name>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 12:07:42AM +0100, Maciej S. Szmigiero wrote:
> verify_patch_size() function verifies whether the microcode container file
> remaining size is large enough to contain a patch of the indicated size.
> 
> However, the section header length is not included in this indicated size
> but it is present in the leftover file length so it should be subtracted
> from the leftover file length before passing this value to
> verify_patch_size().
> 
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> ---
>  arch/x86/kernel/cpu/microcode/amd.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

I split the comment and applied this:

---
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Date: Fri, 16 Mar 2018 00:07:42 +0100
Subject: [PATCH] x86/microcode/AMD: Subtract SECTION_HDR_SIZE from file
 leftover length

verify_patch_size() verifies whether the remaining size of the microcode
container file is large enough to contain a patch of the indicated size.

However, the section header length is not included in this indicated
size but it is present in the leftover file length so it should be
subtracted from the leftover file length before passing this value to
verify_patch_size().

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Link: http://lkml.kernel.org/r/b4854b17-e3ba-54d6-488d-0e0bfffe4c71@maciej.szmigiero.name
[ Split comment. ]
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/microcode/amd.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 48179928ff38..ffce949409cc 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -461,8 +461,12 @@ static int collect_cpu_info_amd(int cpu, struct cpu_signature *csig)
 	return 0;
 }
 
-static unsigned int verify_patch_size(u8 family, u32 patch_size,
-				      unsigned int size)
+/*
+ * Check whether the passed remaining file @size is large enough to contain a
+ * patch of the indicated @patch_size (and also whether this size does not
+ * exceed the per-family maximum).
+ */
+static unsigned int verify_patch_size(u8 family, u32 patch_size, unsigned int size)
 {
 	u32 max_size;
 
@@ -613,7 +617,12 @@ static int verify_and_add_patch(u8 family, u8 *fw, unsigned int leftover)
 		return crnt_size;
 	}
 
-	ret = verify_patch_size(family, patch_size, leftover);
+	/*
+	 * The section header length is not included in this indicated size
+	 * but is present in the leftover file length so we need to subtract
+	 * it before passing this value to the function below.
+	 */
+	ret = verify_patch_size(family, patch_size, leftover - SECTION_HDR_SIZE);
 	if (!ret) {
 		pr_err("Patch-ID 0x%08x: size mismatch.\n", mc_hdr->patch_id);
 		return crnt_size;
-- 
2.7.3

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply. Srsly.
