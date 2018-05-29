Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936548AbeE2PBG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 11:01:06 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:57534 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935244AbeE2PBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 11:01:00 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rich Felker <dalias@libc.org>, Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux-sh list <linux-sh@vger.kernel.org>
References: <87604mhrnb.fsf@xmission.com>
        <20180420143811.9994-16-ebiederm@xmission.com>
        <20180420145514.GP3094@brightrain.aerifal.cx>
        <CAMuHMdXxL+k_SitLXV1LJDHJmCY1HiUnZSk7MM64rcgs75nLiw@mail.gmail.com>
Date: Tue, 29 May 2018 10:00:42 -0500
In-Reply-To: <CAMuHMdXxL+k_SitLXV1LJDHJmCY1HiUnZSk7MM64rcgs75nLiw@mail.gmail.com>
        (Geert Uytterhoeven's message of "Mon, 28 May 2018 11:19:55 +0200")
Message-ID: <87h8mqo6at.fsf_-_@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fNg7M-0005BO-4e;;;mid=<87h8mqo6at.fsf_-_@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+IzCyZ7sfx9HjChTQEsrHLohqqvtTCE7s=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4934]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Geert Uytterhoeven <geert@linux-m68k.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1062 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.8 (0.3%), b_tie_ro: 1.97 (0.2%), parse: 1.15 (0.1%),
        extract_message_metadata: 19 (1.8%), get_uri_detail_list: 1.73 (0.2%),
        tests_pri_-1000: 10 (1.0%), tests_pri_-950: 1.71 (0.2%), tests_pri_-900: 1.45
        (0.1%), tests_pri_-400: 24 (2.3%), check_bayes: 22 (2.1%), b_tokenize: 10
        (0.9%), b_tok_get_all: 6 (0.5%), b_comp_prob: 2.8 (0.3%), b_tok_touch_all:
        2.2 (0.2%), b_finish: 0.63 (0.1%), tests_pri_0: 177 (16.7%),
        check_dkim_signature: 0.71 (0.1%), check_dkim_adsp: 3.2 (0.3%),
        tests_pri_500: 820 (77.3%), poll_dns_idle: 816 (76.8%), rewrite_mail: 0.00
        (0.0%)
Subject: [PATCH] signal/sh: Stop gcc warning about an impossible case in do_divide_error
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Geert Uytterhoeven <geert@linux-m68k.org> reported:
>   HOSTLD  scripts/mod/modpost
>   CC      arch/sh/kernel/traps_32.o
> arch/sh/kernel/traps_32.c: In function 'do_divide_error':
> arch/sh/kernel/traps_32.c:606:17: error: 'code' may be used uninitialized in this function [-Werror=uninitialized]
> cc1: all warnings being treated as errors

It is clear from inspection that do_divide_error is only called with
TRAP_DIVZERO_ERROR or TRAP_DIVOVF_ERROR, as that is the way
set_exception_table_vec is called.  So let gcc know the other cases
should not be considered by returning in all other cases.

This removes the warning and let's the code continue to build.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Fixes: c65626c0cd4d ("signal/sh: Use force_sig_fault where appropriate")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---

I am adding this fix to my tree to at least let the code build.

 arch/sh/kernel/traps_32.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/sh/kernel/traps_32.c b/arch/sh/kernel/traps_32.c
index 660a4bc17698..60709ad17fc7 100644
--- a/arch/sh/kernel/traps_32.c
+++ b/arch/sh/kernel/traps_32.c
@@ -602,6 +602,9 @@ asmlinkage void do_divide_error(unsigned long r4)
 	case TRAP_DIVOVF_ERROR:
 		code = FPE_INTOVF;
 		break;
+	default:
+		/* Let gcc know unhandled cases don't make it past here */
+		return;
 	}
 	force_sig_fault(SIGFPE, code, NULL, current);
 }
-- 
2.14.1
