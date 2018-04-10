Return-Path: <mpe@ellerman.id.au>
X-Google-Smtp-Source: AIpwx49pTf1UrZiqQzELklDIJKECjlB0xagy+3xnRws3JRbhl+GI/dV82dHKRhPJH8EhL2yoPCGE
ARC-Seal: i=1; a=rsa-sha256; t=1523352883; cv=none;
        d=google.com; s=arc-20160816;
        b=AD4hrbEBD3wWeIE+moD/luZUODts8d69i16OQQVUfIMoYrPUziLyk5pAAuXCuoFxwI
         j6IFCZBvhfV9qu83dhcwywDb73mW3I1c0d82dgEZiJNniNDSoBbLrBJ0gsSVby57rRt3
         nQTWHlCDNllkldP0RNlSwqH+iM0AzxkZD8/iuJZEtDQVECbYLjUrpjVUH5x6IzTH1tWg
         PnEtdvDRcTnblel8NYM+qsE8qlkWo/6I3RUf2lnZ0QAp8fYAFsERuJ+VRv8seP6mixNC
         o/74Q0IGqsA3b+Q1a4aW83Dn4zdWd++zm1YSKGvKtVdcSej0a2f3XFJ4+Z827076NyPS
         mK9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:arc-authentication-results;
        bh=KYAk+PnOt/O3OIYCtB08cBLv/h/oB2dfvCql0VvRSvI=;
        b=YJ56V4Qblh0JGSGfIS+eIR9hUIZUQhSqXct4aHdX4C9o135f6ct/m0AakNbRMeKOkJ
         MFi6A6DcHFBmB6vySOgJLBgUwEB47bRQmqpPIvbftftXus8gA630wHyhu1H0tcKHriDg
         Rcstb30QAszB9zXGkKzc+phXFrybSh+stcznzS/lnbFj60mKySTtdHCwlY1Sv0BsnU2n
         Gy+ww6uHrndgyZQit1kShRKooLnTuQFf2NZEYFfsqGiXVXEhboefIl0RAAsecXZYEF7t
         hOjWdchqaOGKOrc3l0vqnkgcsm4/A1fIIFa/YsjkCK73mL7NcIisCkgNqckjVTuXEN6I
         o8AQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 203.11.71.1 is neither permitted nor denied by best guess record for domain of mpe@ellerman.id.au) smtp.mailfrom=mpe@ellerman.id.au
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 203.11.71.1 is neither permitted nor denied by best guess record for domain of mpe@ellerman.id.au) smtp.mailfrom=mpe@ellerman.id.au
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christian Brauner <christian.brauner@ubuntu.com>
Cc: viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, ebiederm@xmission.com, torvalds@linux-foundation.org, gregkh@linuxfoundation.org, containers@lists.linux-foundation.org
Subject: Re: [PATCH 4/4 v5 RESEND] selftests: add devpts selftests
In-Reply-To: <20180410084208.GA14520@mailbox.org>
References: <20180313165527.24038-1-christian.brauner@ubuntu.com> <20180313165527.24038-5-christian.brauner@ubuntu.com> <87efjnbn0j.fsf@concordia.ellerman.id.au> <20180410084208.GA14520@mailbox.org>
Date: Tue, 10 Apr 2018 19:34:36 +1000
Message-ID: <87bmerbe1f.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594842300602680139?=
X-GMAIL-MSGID: =?utf-8?q?1597351272896379876?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Christian Brauner <christian.brauner@ubuntu.com> writes:
> On Tue, Apr 10, 2018 at 04:20:44PM +1000, Michael Ellerman wrote:
>> Christian Brauner <christian.brauner@ubuntu.com> writes:
>> > diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
>> > index 7442dfb73b7f..dbda89c9d9b9 100644
>> > --- a/tools/testing/selftests/Makefile
>> > +++ b/tools/testing/selftests/Makefile
>> > @@ -7,6 +7,7 @@ TARGETS += cpufreq
>> >  TARGETS += cpu-hotplug
>> >  TARGETS += efivarfs
>> >  TARGETS += exec
>> > +TARGETS += filesystems
>>    ^ This, and ...
>> 
>> > diff --git a/tools/testing/selftests/filesystems/Makefile b/tools/testing/selftests/filesystems/Makefile
>> > index 13a73bf725b5..4e6d09fb166f 100644
>> > --- a/tools/testing/selftests/filesystems/Makefile
>> > +++ b/tools/testing/selftests/filesystems/Makefile
>> > @@ -1,5 +1,5 @@
>> >  # SPDX-License-Identifier: GPL-2.0
>> > -TEST_PROGS := dnotify_test
>> > +TEST_PROGS := dnotify_test devpts_pts
>>                  ^
>>                  this ...
>> 
>> Have the unfortunate effect of running dnotify_test as part of the
>> default selftest run.
>> 
>> dnotify_test boils down to:
>> 
>> 	while (1) {
>> 		pause();
>> 		printf("Got event on fd=%d\n", event_fd);
>> 	}
>> 
>> 
>> ie. an infinite loop :)
>
> Hi Michael,
>
> Ugh, didn't notice this before. Weird test.

No worries. It looks like it was copied from Documentation where it was
really just sample code, rather than a test.
 
>> I'll send a patch to fix it.
>
> Excellent, you can likely route it through Greg's tty tree.

I've sent it to the kselftest list as well as Greg, so whoever wants to
merge it is fine by me.

cheers
