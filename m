Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753895AbeAaQTf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 11:19:35 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:50625 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753310AbeAaQTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 11:19:30 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
MIME-Version: 1.0
Content-Type: text/plain
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        Al Viro <viro@ZenIV.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <87372oph61.fsf@xmission.com> <87a7wwnkce.fsf@xmission.com>
Date: Wed, 31 Jan 2018 10:19:01 -0600
In-Reply-To: <87a7wwnkce.fsf@xmission.com> (Eric W. Biederman's message of
        "Mon, 29 Jan 2018 20:36:49 -0600")
Message-ID: <87607im26i.fsf_-_@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
X-XM-SPF: eid=1egv6P-0001Lm-WC;;;mid=<87607im26i.fsf_-_@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18QFrjpa3blCB3I8JV5rR17JimcOv7JPSk=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 15026 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.8 (0.0%), b_tie_ro: 1.90 (0.0%), parse: 0.75 (0.0%),
        extract_message_metadata: 13 (0.1%), get_uri_detail_list: 1.70 (0.0%),
        tests_pri_-1000: 2.8 (0.0%), tests_pri_-950: 1.23 (0.0%), tests_pri_-900:
        1.00 (0.0%), tests_pri_-400: 22 (0.1%), check_bayes: 21 (0.1%), b_tokenize: 7
        (0.0%), b_tok_get_all: 7 (0.0%), b_comp_prob: 2.1 (0.0%), b_tok_touch_all:
        3.2 (0.0%), b_finish: 0.60 (0.0%), tests_pri_0: 148 (1.0%),
        check_dkim_signature: 0.46 (0.0%), check_dkim_adsp: 2.5 (0.0%),
        tests_pri_500: 14832 (98.7%), poll_dns_idle: 14819 (98.6%), rewrite_mail:
        0.00 (0.0%)
Subject: [GIT PULL] siginfo fix for 4.16-rc1
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the siginfo-linus branch from the git tree:

   git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git siginfo-linus

   HEAD: f20239c0d2d720d7deb8a40fd05c31849ddc8293  mm/memory_failure: update powerpc for memory_failure() API change

I had a brain fart when I received Stephen email about a compile failure
in linux-next.  I thought the powerpc call to memory_failure had not
merged yet.  Instead it simply failed to compile :(

Linus can you please pull Stephen's fix so that powerpc builds correctly.

Thank you,
Eric 

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 26 Jan 2018 12:05:12 +1100
Subject: [PATCH] mm/memory_failure: update powerpc for memory_failure() API change

After merging the userns tree, today's linux-next build (powerpc
allyesconfig) failed like this:

arch/powerpc/kernel/mce.c: In function 'machine_process_ue_event':
arch/powerpc/kernel/mce.c:276:5: error: too many arguments to function 'memory_failure'
     memory_failure(pfn, SIGBUS, 0);
     ^~~~~~~~~~~~~~
In file included from include/linux/pid_namespace.h:7:0,
                 from include/linux/ptrace.h:10,
                 from arch/powerpc/kernel/mce.c:27:
include/linux/mm.h:2571:12: note: declared here
 extern int memory_failure(unsigned long pfn, int flags);
            ^~~~~~~~~~~~~~

Caused by commit

  83b57531c58f ("mm/memory_failure: Remove unused trapno from memory_failure")

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/powerpc/kernel/mce.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
index 742e4658c5dc..71e8a1b8c86e 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -273,7 +273,7 @@ static void machine_process_ue_event(struct work_struct *work)
 
 				pfn = evt->u.ue_error.physical_address >>
 					PAGE_SHIFT;
-				memory_failure(pfn, SIGBUS, 0);
+				memory_failure(pfn, 0);
 			} else
 				pr_warn("Failed to identify bad address from "
 					"where the uncorrectable error (UE) "
-- 
2.14.1
