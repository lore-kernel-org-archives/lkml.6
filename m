Return-Path: <dan.j.williams@intel.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518705554; cv=none;
        d=google.com; s=arc-20160816;
        b=gs6oHErvZs1fPEjj30qbBaUmM4ZKp5cz4lcTFPup1GvJKz78+LymVCKnVyesS7Aq06
         J5O6nNIU73eHSAYwmr94YWWP41kEHPgVmxmbV3PkFJuX4SmzbpXTGkdE3r0yadw/wZsN
         dVfCRj6E2jUJdI/JrH+cJCsa6U7QDGIz43d174l6CoL2+u5ZTZ+R9uEgBCVVOJ90HkVw
         LW5n2E5TJAdESyHDsvfUOyjMKm5AoR56a9yHXvbuE8oTuAQ/dgqqtG3ikBE9lohV34e0
         8euvNTNG/8tkeizvPJ11pbDnM+Ftjxdxo9X/s37VmFXTIijzNduFL+747j0p3nHigCVe
         bg+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=VIN0lqIF8D0HC+3oORSavC1GNSgPZkQ5GYacyHGYcdA=;
        b=yKptOXVt9PYwcc+Pef7WBYVvfhmBJrsYxc7ayUhh1M0MAC19JxGxEnUAsFh5EzHcV/
         JrDTnQvCVw1Nv8NUvzuqVSmnpZrP1JVMkfwyvRfCzOtFrGb6oQSaWwMt4UrgsumUWXbq
         lanNIaDGFYfxotuOen/irnRg9jhrnooe1rLbALNjsuE9uv9l3QeDabwYc1ofn+TAYU5X
         9M5Lil4vHSYEiOfnYXnpu6+6euIvikgnJMwPoBJ9R3wOvi81SyHPxE3ZS9ukjMinJyga
         HYmLDdlFOVucZiwEakOK2Gz2BBy8143s/LYXqxX/6NB4ZUVVyZi2rjPhvGKG9sP2nrad
         Hv2g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@intel-com.20150623.gappssmtp.com header.s=20150623 header.b=CBQjQINo;
       spf=pass (google.com: domain of dan.j.williams@intel.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=dan.j.williams@intel.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@intel-com.20150623.gappssmtp.com header.s=20150623 header.b=CBQjQINo;
       spf=pass (google.com: domain of dan.j.williams@intel.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=dan.j.williams@intel.com
X-Google-Smtp-Source: AH8x224QaVZZ3XjSPj1jEv81qpRhkXlqaS3yqluq4fPj1y08A2LMe/yHDuxsajhTOrbJrg83XUv9J90rlK7OnIV0Cn4=
MIME-Version: 1.0
In-Reply-To: <45f8dece-e235-0831-4fe5-89ee7d27b959@prevas.dk>
References: <alpine.DEB.2.21.1802151424490.1296@nanos.tec.linutronix.de> <45f8dece-e235-0831-4fe5-89ee7d27b959@prevas.dk>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 15 Feb 2018 06:39:13 -0800
Message-ID: <CAPcyv4i-bULZp1WTUgUVtdEY5i_fTGkFWKBsVLDu6dsuxUwoug@mail.gmail.com>
Subject: Re: [PATCH] posix-timers: Protect posix clock array access against speculation
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>,
	David Woodhouse <dwmw@amazon.co.uk>, Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592473683460033132?=
X-GMAIL-MSGID: =?utf-8?q?1592478195334066385?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 15, 2018 at 6:05 AM, Rasmus Villemoes
<rasmus.villemoes@prevas.dk> wrote:
> On 2018-02-15 14:27, Thomas Gleixner wrote:
>> The (clock) id argument of clockid_to_kclock() comes straight from user
>> space via various syscalls and is used as index into the posix_clocks
>> array.
>>
>> Protect it against spectre v1 array out of bounds speculation.
>>
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> Cc: stable@vger.kernel.org
>> ---
>>  kernel/time/posix-timers.c |    6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> --- a/kernel/time/posix-timers.c
>> +++ b/kernel/time/posix-timers.c
>> @@ -50,6 +50,7 @@
>>  #include <linux/export.h>
>>  #include <linux/hashtable.h>
>>  #include <linux/compat.h>
>> +#include <linux/nospec.h>
>>
>>  #include "timekeeping.h"
>>  #include "posix-timers.h"
>> @@ -1346,11 +1347,14 @@ static const struct k_clock * const posi
>>
>>  static const struct k_clock *clockid_to_kclock(const clockid_t id)
>>  {
>> +     clockid_t idx = id;
>> +
>>       if (id < 0)
>>               return (id & CLOCKFD_MASK) == CLOCKFD ?
>>                       &clock_posix_dynamic : &clock_posix_cpu;
>>
>>       if (id >= ARRAY_SIZE(posix_clocks) || !posix_clocks[id])
>>               return NULL;
>> -     return posix_clocks[id];
>> +
>> +     return posix_clocks[array_index_nospec(idx, ARRAY_SIZE(posix_clocks))];
>>  }
>>
>
> Stupid questions from someone trying to learn what the rules for when
> and how to apply these _nospec macros:
>
> (1) why introduce the idx var? There's no assignment to it other than
> the initialization. Is it some magic in array_index_nospec that prevents
> the use of a const-qualified expression?

It does currently, but perhaps it can be fixed.

>
> (2) The line "if (id >= ARRAY_SIZE(posix_clocks) || !posix_clocks[id])"
> still seems to allow speculatively accessing posix_clocks[id]. Is that
> ok, and even if so, wouldn't it be cleaner to elide the
> !posix_clocks[id] check and just return the NULL safely fetched from the
> array in the following line?

Right, this looks broken. I would expect:

        if (id >= ARRAY_SIZE(posix_clocks))
                return NULL;
        idx = array_index_nospec(idx, ARRAY_SIZE(posix_clocks));
        if (!posix_clocks[idx])
                return NULL;
        return posix_clocks[idx];
