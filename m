Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751681AbeCOLin (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 07:38:43 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:54241 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751467AbeCOLik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 07:38:40 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20180314143529.1456168-1-arnd@arndb.de>
        <20180314144614.1632190-1-arnd@arndb.de>
        <20180314144614.1632190-2-arnd@arndb.de> <87po45hcuy.fsf@xmission.com>
        <CAK8P3a1GL2N=emTbSgNGHxOrXtG6BxqRGMg00-tZqKg6-0O5=w@mail.gmail.com>
Date: Thu, 15 Mar 2018 06:37:49 -0500
In-Reply-To: <CAK8P3a1GL2N=emTbSgNGHxOrXtG6BxqRGMg00-tZqKg6-0O5=w@mail.gmail.com>
        (Arnd Bergmann's message of "Thu, 15 Mar 2018 11:48:12 +0100")
Message-ID: <87o9jpbmcy.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ewRDS-0003b0-16;;;mid=<87o9jpbmcy.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.121.173;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+Q1X9xGCxiu9plJxG8LXgr1Upd8YHwFiQ=
X-SA-Exim-Connect-IP: 97.119.121.173
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Arnd Bergmann <arnd@arndb.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 876 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 3.1 (0.4%), b_tie_ro: 2.1 (0.2%), parse: 1.35 (0.2%),
        extract_message_metadata: 31 (3.6%), get_uri_detail_list: 4.9 (0.6%),
        tests_pri_-1000: 13 (1.4%), tests_pri_-950: 2.2 (0.3%), tests_pri_-900: 1.79
        (0.2%), tests_pri_-400: 41 (4.7%), check_bayes: 39 (4.4%), b_tokenize: 16
        (1.8%), b_tok_get_all: 10 (1.1%), b_comp_prob: 6 (0.6%), b_tok_touch_all: 3.0
        (0.3%), b_finish: 0.85 (0.1%), tests_pri_0: 767 (87.6%),
        check_dkim_signature: 1.04 (0.1%), check_dkim_adsp: 5 (0.6%), tests_pri_500:
        10 (1.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 12/16] asm-generic: siginfo: remove obsolete #ifdefs
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Thu, Mar 15, 2018 at 11:06 AM, Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>> Arnd Bergmann <arnd@arndb.de> writes:
>>
>>> The frv, tile and blackfin architectures are being removed, so
>>> we can clean up this header by removing all the special cases
>>> except those for ia64.
>>>
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>> ---
>>>  include/uapi/asm-generic/siginfo.h | 36 ++----------------------------------
>>>  1 file changed, 2 insertions(+), 34 deletions(-)
>>>
>>
>> If I am reading siginfo.h correctly after this cleanup patch
>> we can perform another cleanup and unconditionally define
>> all of the ia64 si_codes except for __SEGV_PSTKOVF which
>> aliases SEGV_PKUERR.
>>
>> Which has the advantage that no one is tempted to define any further
>> aliased si_codes.
>
> Do you mean like this:
>
> diff --git a/include/uapi/asm-generic/siginfo.h
> b/include/uapi/asm-generic/siginfo.h
> index b2ebf16c391a..ff13ed50dde8 100644
> --- a/include/uapi/asm-generic/siginfo.h
> +++ b/include/uapi/asm-generic/siginfo.h
> @@ -186,11 +186,9 @@ typedef struct siginfo {
>  #define ILL_PRVREG     6       /* privileged register */
>  #define ILL_COPROC     7       /* coprocessor error */
>  #define ILL_BADSTK     8       /* internal stack error */
> -#ifdef __ia64__
> -# define ILL_BADIADDR  9       /* unimplemented instruction address */
> -# define __ILL_BREAK   10      /* illegal break */
> -# define __ILL_BNDMOD  11      /* bundle-update (modification) in progress */
> -#endif
> +#define ILL_BADIADDR   9       /* unimplemented instruction address */
> +#define __ILL_BREAK    10      /* illegal break */
> +#define __ILL_BNDMOD   11      /* bundle-update (modification) in progress */
>  #define NSIGILL                11
>
>  /*
> @@ -204,13 +202,11 @@ typedef struct siginfo {
>  #define FPE_FLTRES     6       /* floating point inexact result */
>  #define FPE_FLTINV     7       /* floating point invalid operation */
>  #define FPE_FLTSUB     8       /* subscript out of range */
> -#ifdef __ia64__
> -# define __FPE_DECOVF  9       /* decimal overflow */
> -# define __FPE_DECDIV  10      /* decimal division by zero */
> -# define __FPE_DECERR  11      /* packed decimal error */
> -# define __FPE_INVASC  12      /* invalid ASCII digit */
> -# define __FPE_INVDEC  13      /* invalid decimal digit */
> -#endif
> +#define __FPE_DECOVF   9       /* decimal overflow */
> +#define __FPE_DECDIV   10      /* decimal division by zero */
> +#define __FPE_DECERR   11      /* packed decimal error */
> +#define __FPE_INVASC   12      /* invalid ASCII digit */
> +#define __FPE_INVDEC   13      /* invalid decimal digit */
>  #define NSIGFPE                13
>
>  /*
>
> That seems reasonable. If you send me a patch with a proper
> changelog (I don't think I could explain this well enough), I'll
> add it to the series.

Yes.

I just realized you can also remove the #ifdefs for BUS_MCEERR_AR,
BUS_MCEERR_AO, and SEGV_BNDERR.  As those si_codes are now always
defined.  That description I expect you can handle.

For a description of the above change how does this sound?

Unlike system call numbers the assignment of si_codes has never had a
reason to be made per architecture.  Some architectures have had unique
conditions to report and reporting those conditions needed new si_codes.
Nothing has ever needed si_codes to have different values on different
architectures.  The si_code space is vast so even with defining all
si_codes on all architectures there is no danger in running out of
si_code values.

The history of the si_codes BUS_MCEERR_AR, BUS_MCEER_AO, SEGV_BNDERR,
and SEGV_PKUERR show that a need of one architecture frequently becomes
a need of another architecture which makes sharing si_codes between
architectures a positive benefit and something to be encouraged.

Where there are no conflicts with the historical ia64 arch specific
si_codes and any other si_codes make them generic si_codes.  We might
need them on another architecture someday.

This leaves only the good example of arch generic si_codes in the kernel
for future architectures and architecture enhancments to follow.
Without bad examples to follow it should be easy to avoid the mistakes
of the past.

Eric
