Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751447AbeDEQPR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 12:15:17 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:55949 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbeDEQPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 12:15:15 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>
Date: Thu, 05 Apr 2018 11:14:03 -0500
Message-ID: <87sh898wc4.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1f47Xd-0001V9-Mu;;;mid=<87sh898wc4.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.140.30;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18Z0ySlZ1YJfPyjfdiXGrSh6p3TU2rMNQo=
X-SA-Exim-Connect-IP: 97.119.140.30
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 280 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.7 (1.0%), b_tie_ro: 1.86 (0.7%), parse: 0.85 (0.3%),
        extract_message_metadata: 3.7 (1.3%), get_uri_detail_list: 1.73 (0.6%),
        tests_pri_-1000: 6 (2.0%), tests_pri_-950: 1.77 (0.6%), tests_pri_-900: 1.57
        (0.6%), tests_pri_-400: 27 (9.8%), check_bayes: 26 (9.2%), b_tokenize: 11
        (4.0%), b_tok_get_all: 7 (2.4%), b_comp_prob: 3.5 (1.3%), b_tok_touch_all:
        2.3 (0.8%), b_finish: 0.66 (0.2%), tests_pri_0: 221 (78.7%),
        check_dkim_signature: 1.09 (0.4%), check_dkim_adsp: 3.2 (1.2%),
        tests_pri_500: 6 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: [GIT PULL] siginfo updares for 4.17-rc1
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull the siginfo-linus branch from the git tree:

   git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git siginfo-linus

   HEAD: 4be33329d46f80e87afe7db61271d1370607260a m68k: Verify the offsets in struct siginfo never change.

The work on cleaning up and getting the bugs out of siginfo generation
was largely stalled this round.  The progress that was made was the
definition of FPE_FLTUNK.  Which is usable to fix many of the cases
where siginfo generation is erroneously generating SI_USER by setting
si_code to 0, that has recently been tagged as FPE_FIXME.

You already have the change by way of the arm64 tree as that definition
was pulled into the arm64 tree to allow fixing the problem there.

What remains is the second round of fixing for what I thought was a
trivial change to the struct siginfo when put the union in _sigfault
where it belongs.  Do to historical reasons 32bit m68k only ensures that
pointers are 2 byte aligned.  So I have added a m68k test case made of
BUILD_BUG_ONs to verify I have this fix correct and possibly catch
problems, and I have computed the number of bytes of padding needed for
the _addr_bnd and _addr_pkey cases and just use an array of characters
that size.

For pure paranoia I have written the code so if there is an architecture
out there that does not perform any alignment of structures it should
still work.

With the removal of all of the stale arechitectures this cycle future
work on cleaning up struct siginfo should be much easier.  Almost all
of the conflicting si_code definitions have been removed with
the removal of (blackfin, tile, and frv).   Plus some of the most
difficult to test cases have simply been removed from the tree.

Which means that with a little luck copy_siginfo_to_user can
become a light weight wrapper around copy_to_user in the next
cycle.

Dave Martin (1):
      signal: Add FPE_FLTUNK si_code for undiagnosable fp exceptions

Eric W. Biederman (2):
      signal: Correct the offset of si_pkey and si_lower in struct siginfo on m68k
      m68k: Verify the offsets in struct siginfo never change.

 arch/m68k/kernel/signal.c          | 62 ++++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/signal_compat.c    |  2 +-
 include/linux/compat.h             |  6 ++--
 include/uapi/asm-generic/siginfo.h | 10 ++++--
 4 files changed, 74 insertions(+), 6 deletions(-)

Eric
