Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AIpwx4/hzAnHSB/ZVkvF9P+8R/Q/Ik8FWLn0at+RvEQfsHy+DnTaOZ5zpD/RYx6yAyKUOBf3gc2D
ARC-Seal: i=1; a=rsa-sha256; t=1522387910; cv=none;
        d=google.com; s=arc-20160816;
        b=pb6DURvcIIP8rso6Zd4rGF9LpPBZmNcQqPf8aJfZszr2IuPenoeaX3RSxeZTe5DU+L
         BMQO0W6s6aeH0h5twgeMmUOBbzlBp2xDvCfMztmZ+qw3Q+ayaHsPFpLe+VOu3kaP4M6w
         GIOULa/oDmhHVUlRmpxZ20IS6qSX5EhsUVXOQkrMKOZfAR9RLvS6EfozOVZiC0vgRn+B
         ko5vOaLlP5bSGgur26J4DI9T+eEa8rkoXuQIQWmoXsWzPlgXzbo+S4g2JPJTkA/UP3vC
         N49ozJTTVlq7jrOqC/Tl2HfiRNKpHI5a4Bd+2crK02xfemHrEGGmvICvDISQgYbNxqcq
         Vtqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:dkim-filter:arc-authentication-results;
        bh=ymri/fHgp8mKtbJXGZdQg7QOppsaa+cCWkZ7CsPFayk=;
        b=ZffVaZ2UhABPfuYulLDl494c2nTOvR0PD888MfYohEFdyyTNKD5jkglEFOVXl2lLJo
         /05xJpi9ygritK0OdWhXsFe0mkY8SIIQa7jRMqWtpB5Zo5Juq3+NRH3Qsvpzy9nQMV5J
         KGT+JKzCFkSOft9QH9iKhDktdkHlVS8BLzfYdIDIvpCkIQQejiKERYKenwJWYdLgFWBr
         Wg35U3eOd8y4BppdkBQ6ftBeRwSUVNmtL71nTM50JINvMQxHr9htQSEk1tnOziQbEWay
         4N6Z6EG406g77Zpu0UG2JJ/miBk9zY2ghC39eriPUB2WI9gMhP4kQhoIb4To73Arlphr
         QL9Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=NQ1LRZzY;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.91 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=NQ1LRZzY;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.91 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w2U5VUrE029272
X-Nifty-SrcIP: [209.85.217.171]
MIME-Version: 1.0
In-Reply-To: <CAFkk2KT4_08348-3ecumBxBQqyCAyZEPgcNou5Le1hOtVk2aAA@mail.gmail.com>
References: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com>
 <1522128575-5326-5-git-send-email-yamada.masahiro@socionext.com> <CAFkk2KT4_08348-3ecumBxBQqyCAyZEPgcNou5Le1hOtVk2aAA@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 30 Mar 2018 14:30:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ2nTa28zmMdpYZnNkLa5uFnq=4WeCinCrNa=3fcHenoA@mail.gmail.com>
Message-ID: <CAK7LNAQ2nTa28zmMdpYZnNkLa5uFnq=4WeCinCrNa=3fcHenoA@mail.gmail.com>
Subject: Re: [PATCH v2 04/21] kconfig: reference environments directly and
 remove 'option env=' syntax
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Nicolas Pitre <nico@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596067538224428128?=
X-GMAIL-MSGID: =?utf-8?q?1596339425579643513?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-03-29 11:19 GMT+09:00 Ulf Magnusson <ulfalizer@gmail.com>:.

>>  %%
>> +static void expand_string(const char *in)
>> +{
>> +       char *p, *q;
>> +
>> +       p = expand_string_value(in);
>> +
>> +       q = p + strlen(p);
>> +       while (q > p)
>> +               unput(*--q);
>> +
>> +       free(p);
>> +}
>> +
>
> I like the simplicity of this approach, but I suspect it might be too simple.
>
> For example, the following breaks with a syntax error if $ENV has any
> double quotes in its value:
>
>     config FOO
>         string "foo"
>         default "$ENV"
>
> The following will only work as expected if $ENV expands to a valid
> Kconfig symbol name. If it doesn't, random stuff will happen (most
> likely a syntax error).
>
>     config FOO
>         string "foo"
>         default $ENV
>
> The reason it works if $ENV expands to a valid symbol name is that
> undefined symbols get their name as their (string) value. If the
> symbol happens to be defined, it will be referenced, which seems
> confusing too.
>
> In general, that reinterpretation of expanded values feels a bit icky
> to me, and as something that might add complexity to Kconfig for
> little value. If $ENV outside of quotes absolutely must be supported,
> I think it should be a shorthand for "$ENV" (which means "constant
> value" in Kconfig speak).
>

You are right.  This implementation is too lazy, and bad.
I will change the implementation.

Thanks.




-- 
Best Regards
Masahiro Yamada
