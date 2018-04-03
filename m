Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751397AbeDCO2b (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 10:28:31 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:58197 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750786AbeDCO21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 10:28:27 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Eugene Syromiatnikov <esyr@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Linux\/m68k" <linux-m68k@vger.kernel.org>
References: <87woypy8zc.fsf@xmission.com>
        <20180331105658.GA4332@asgard.redhat.com>
        <87woxpz7k9.fsf@xmission.com>
        <CAMuHMdVtbhGJ=nGbB21O73DcYM-4csyuJbx2NksN379ww6c1Gw@mail.gmail.com>
Date: Tue, 03 Apr 2018 09:27:18 -0500
In-Reply-To: <CAMuHMdVtbhGJ=nGbB21O73DcYM-4csyuJbx2NksN379ww6c1Gw@mail.gmail.com>
        (Geert Uytterhoeven's message of "Tue, 3 Apr 2018 09:30:36 +0200")
Message-ID: <87in98xt4p.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1f3MvB-00039X-75;;;mid=<87in98xt4p.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=67.3.145.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+ddgsCL4Dwtb/AD3nALiPHJriQZ2JzMRs=
X-SA-Exim-Connect-IP: 67.3.145.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Geert Uytterhoeven <geert@linux-m68k.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 401 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.7 (0.7%), b_tie_ro: 1.80 (0.4%), parse: 1.01 (0.3%),
        extract_message_metadata: 16 (4.1%), get_uri_detail_list: 4.1 (1.0%),
        tests_pri_-1000: 7 (1.7%), tests_pri_-950: 1.25 (0.3%), tests_pri_-900: 0.97
        (0.2%), tests_pri_-400: 36 (9.1%), check_bayes: 35 (8.8%), b_tokenize: 12
        (2.9%), b_tok_get_all: 13 (3.1%), b_comp_prob: 2.8 (0.7%), b_tok_touch_all: 5
        (1.3%), b_finish: 2.00 (0.5%), tests_pri_0: 326 (81.2%),
        check_dkim_signature: 0.57 (0.1%), check_dkim_adsp: 3.0 (0.7%),
        tests_pri_500: 7 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [GIT PULL] siginfo fix for v4.16-rc5
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> Hi Eric,
>
> On Mon, Apr 2, 2018 at 10:17 PM, Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>> Eugene Syromiatnikov <esyr@redhat.com> writes:
>>
>>> So, the offset of the si_lower field is 20 at the current HEAD and was 18 at
>>> commits v4.16-rc3~17^2 and v4.16-rc1~159^2~20.  I believe this is due to
>>> the fact that m68k uses 2-byte default alignment and not 4-byte.
>>
>> A 2-byte alignment for 4 byte pointers.  That is a new one to me.
>
> Not just for pointers, also for int and long.
> And m68k is not the only architecture having such alignment rules.

The smallest I have seen previously has been 64bit integers having
32bit alignment.  32bit entities having only 16bit alignment on a 32bit
arch was simply a surprise.  Even when it works there tend to be good
reasons not to do that by default.

>> Euguene can you test the patch below.  It should be fully robust against
>> this kind of craziness.  It certainly passes my BUILD_BUG_ON tests for
>> m68k.
>>
>> Eric
>>
>> From: "Eric W. Biederman" <ebiederm@xmission.com>
>> Date: Mon, 2 Apr 2018 14:45:42 -0500
>> Subject: [PATCH] signal: Correct the offset of si_pkey and si_lower in struct siginfo on m68k
>>
>> The change moving addr_lsb into the _sigfault union failed to take
>> into account that _sigfault._addr_bnd._lower being a pointer forced
>> the entire union to have pointer alignment.  The fix for
>> _sigfault._addr_bnd._lower having pointer alignment failed to take
>> into account that m68k has a pointer alignment less than the size
>> of a pointer.  So simply making the padding members pointers changed
>> the location of later members in the structure.
>>
>> Fix this by directly computing the needed size of the padding members,
>> and making the padding members char arrays of the needed size.  AKA
>> if __alignof__(void *) is 1 sizeof(short) otherwise __alignof__(void *).
>> Which should be exactly the same rules the compiler whould have
>> used when computing the padding.
>
> __alignof__(void *) is 2 not 1 on m68k.

I was not expecting __alignof__(void *) to be 1 on m68k.  I was testing
for anything crazier than m68k.  Since there used to be a short in the
hole.  If your alignment is less than sizeof(short) aka 2 we do need two
bytes of pad in there.

>> I have tested this change by adding BUILD_BUG_ONs to m68k to verify
>> the offset of every member of struct siginfo, and with those testing
>> that the offsets of the fields in struct siginfo is the same before
>> I changed the generic _sigfault member and after the correction
>> to the _sigfault member.
>>
>> I have also verified that the x86 with it's own BUILD_BUG_ONs to verify
>> the offsets of the siginfo members also compiles cleanly.
>>
>> Cc: stable@vger.kernel.org
>> Reported-by: Eugene Syromiatnikov <esyr@redhat.com>
>> Fixes: 859d880cf544 ("signal: Correct the offset of si_pkey in struct siginfo")
>> Fixes: b68a68d3dcc1 ("signal: Move addr_lsb into the _sigfault union for clarity")
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>> ---
>>  include/linux/compat.h             | 6 ++++--
>>  include/uapi/asm-generic/siginfo.h | 7 +++++--
>>  2 files changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/compat.h b/include/linux/compat.h
>> index e16d07eb08cf..d770e62632d7 100644
>> --- a/include/linux/compat.h
>> +++ b/include/linux/compat.h
>> @@ -221,6 +221,8 @@ typedef struct compat_siginfo {
>>  #ifdef __ARCH_SI_TRAPNO
>>                         int _trapno;    /* TRAP # which caused the signal */
>>  #endif
>> +#define __COMPAT_ADDR_BND_PKEY_PAD  (__alignof__(compat_uptr_t) < sizeof(short) ? \
>> +                                    sizeof(short) : __alignof__(compat_uptr_t))
>
> On m68k, __alignof__(compat_uptr_t) == 2, so it will use
> __alignof__(compat_uptr_t) padding bytes.
>
> Note that while the test is wrong, the end result is correct :-)
>
> Hence you could just use __alignof__(compat_uptr_t) padding bytes
> unconditionally?

Unless there is something crazier than m68k that only needs 1 byte
alignment for pointers.  In which case this code really needs 2 padding
bytes to avoid introducing a regression there as historically there was
a short in the padding hole.

So I don't see anything wrong with the test.

>>                         union {
>>                                 /*
>>                                  * used when si_code=BUS_MCEERR_AR or
>> @@ -229,13 +231,13 @@ typedef struct compat_siginfo {
>>                                 short int _addr_lsb;    /* Valid LSB of the reported address. */
>>                                 /* used when si_code=SEGV_BNDERR */
>>                                 struct {
>> -                                       compat_uptr_t _dummy_bnd;
>> +                                       char _dummy_bnd[__COMPAT_ADDR_BND_PKEY_PAD];
>>                                         compat_uptr_t _lower;
>>                                         compat_uptr_t _upper;
>>                                 } _addr_bnd;
>>                                 /* used when si_code=SEGV_PKUERR */
>>                                 struct {
>> -                                       compat_uptr_t _dummy_pkey;
>> +                                       char _dummy_pkey[__COMPAT_ADDR_BND_PKEY_PAD];
>>                                         u32 _pkey;
>>                                 } _addr_pkey;
>>                         };
>> diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
>> index 4b3520bf67ba..6d789648473d 100644
>> --- a/include/uapi/asm-generic/siginfo.h
>> +++ b/include/uapi/asm-generic/siginfo.h
>> @@ -94,6 +94,9 @@ typedef struct siginfo {
>>                         unsigned int _flags;    /* see ia64 si_flags */
>>                         unsigned long _isr;     /* isr */
>>  #endif
>> +
>> +#define __ADDR_BND_PKEY_PAD  (__alignof__(void *) < sizeof(short) ? \
>> +                             sizeof(short) : __alignof__(void *))
>
> Likewise.
>
>>                         union {
>>                                 /*
>>                                  * used when si_code=BUS_MCEERR_AR or
>> @@ -102,13 +105,13 @@ typedef struct siginfo {
>>                                 short _addr_lsb; /* LSB of the reported address */
>>                                 /* used when si_code=SEGV_BNDERR */
>>                                 struct {
>> -                                       void *_dummy_bnd;
>> +                                       char _dummy_bnd[__ADDR_BND_PKEY_PAD];
>>                                         void __user *_lower;
>>                                         void __user *_upper;
>>                                 } _addr_bnd;
>>                                 /* used when si_code=SEGV_PKUERR */
>>                                 struct {
>> -                                       void *_dummy_pkey;
>> +                                       char _dummy_pkey[__ADDR_BND_PKEY_PAD];
>>                                         __u32 _pkey;
>>                                 } _addr_pkey;
>>                         };
>
> Gr{oetje,eeting}s,
>
>                         Geert
