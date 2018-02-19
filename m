Return-Path: <miguel.ojeda.sandonis@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518998531; cv=none;
        d=google.com; s=arc-20160816;
        b=LTTDhxmqRW5kSLSNzWEI/gACRCPM0lFEUrggHBB4AmyxEImQO4LzdcclZZiCuF+eWP
         apn34Wv7R7qjcQlpn+oCbmDxAMms9fuUxRaYod8/HnD5475B5jcnAN+lwWOYKZ/eOmRW
         wbqN4q9pYAsEaPTHo1ZnGvsGcqCtQ1Sempu9RT0HpAnMEp2mc6cVTUO87Ax2T7RxyD9z
         QEsdV1dKFWz4/uYMvmRT5fvWPx+MoBVBbt5qyRPMBht8bcb0qLNDRJiUMbkUqql2M1Ca
         uhyY4urt1vmn4t5MgmuiLcED/Mjq2yb3E6lIjXEY2R7o9bWQZBWV6m3J4S4gyv+HmbM9
         rmEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=tbXZOFa9IEQ6K6z3Yxsyb1sIM/BVA6Qe2xJNYiedYC0=;
        b=CbprTMGJ55281HdP0PIW1IwCoxCXKI1n4VUQ3aqaZPMOjAtrx/C1uZh508DtdhXI0q
         kZTHeDTqCflISTB6qllqasMdzQvUDGKvg+FpRDlHZj32IC+fYsvuRoZIL0eo/+A5gZ9D
         ecbgTdcO4B7jt7T8tN0UpEVmeGv1YTwUtGr6gzyWQkNAQ/MD8wAKMBAkkWxnu8mHjVUf
         up2cutpA+0Ibz6Ma/qZ6rWkV9L068wXWzSHwQvsXf7c0SwXsSA+iV89VOLSjEf32N1d/
         +z0QBbsHvm0pJYmpdeWnPTLL3LfHpYb/oi8F/wSkLbQQAUwo8xc2h15jdx/PBlbs5bRt
         PnoA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=NKQYiGL5;
       spf=pass (google.com: domain of miguel.ojeda.sandonis@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=miguel.ojeda.sandonis@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=NKQYiGL5;
       spf=pass (google.com: domain of miguel.ojeda.sandonis@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=miguel.ojeda.sandonis@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x226ven7cwKfawnjC8hkpnS4oAZslkolkpGAbXzDhj5TRw3qzSZIYi3/K4z7t9yc7+IK8Bhz8sgcqo8VQIkxu8t4=
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1802181519400.205822@chino.kir.corp.google.com>
References: <20180217191035.gol4woxsgzpo4bfq@gmail.com> <alpine.DEB.2.10.1802181519400.205822@chino.kir.corp.google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 19 Feb 2018 01:01:50 +0100
Message-ID: <CANiq72=jgAzCDoU2Vkq0zVKNCDvwhPT7Eqpy5Af6W3=XacQnRA@mail.gmail.com>
Subject: Re: [PATCH] Support the nonstring variable attribute (gcc >= 8)
To: David Rientjes <rientjes@google.com>
Cc: mingo@kernel.org, jpoimboe@redhat.com, Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>, Greg KH <gregkh@linuxfoundation.org>,
	thomas.lendacky@amd.com, will.deacon@arm.com,
	linux-kernel <linux-kernel@vger.kernel.org>, Willy Tarreau <w@1wt.eu>,
	Xiongfeng Wang <wangxiongfeng2@huawei.com>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592676488865934389?=
X-GMAIL-MSGID: =?utf-8?q?1592785403859045995?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 19, 2018 at 12:20 AM, David Rientjes <rientjes@google.com> wrote:
> On Sat, 17 Feb 2018, Miguel Ojeda wrote:
>
>> From the GCC manual:
>>
>> The nonstring variable attribute specifies that an object or member
>> declaration with type array of char or pointer to char is intended to
>> store character arrays that do not necessarily contain a terminating NUL
>> character. This is useful in detecting uses of such arrays or pointers
>> with functions that expect NUL-terminated strings, and to avoid warnings
>> when such an array or pointer is used as an argument to a bounded string
>> manipulation function such as strncpy.
>>
>>   https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html
>>
>> Some reports are already coming to the LKML regarding these
>> warnings. When they are false positives, we can use __nonstring to let
>> gcc know a NUL character is not required; like in this case:
>>
>>   https://lkml.org/lkml/2018/1/16/135
>>
>> Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
>> Cc: Ingo Molnar <mingo@kernel.org>
>> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: David Rientjes <rientjes@google.com>
>
> I would have expected to have seen __nonstring used somewhere as part of
> this patch.

Do you mean to expand the commit message with an actual code example
instead of the links to the docs and the discussion about the report?
Otherwise, if you mean in the actual commit, I think in that case it
should be a patch series, not a single commit.

In any case, the key point here is to agree on the short-term policy:
i.e. whether we want to disable the upcoming warning or try to take
advantage of it (which not *necessarily* implies using __nonstring,
there are other workarounds; though where applicable, __nonstring is
probably the right thing to use).

[By the way, CC'ing Xiongfeng, Willy and Arnd, since they were
involved in the example report; sorry guys!].

Cheers,
Miguel
