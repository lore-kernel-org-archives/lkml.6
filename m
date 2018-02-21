Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519232239; cv=none;
        d=google.com; s=arc-20160816;
        b=IyUxnYUVBo2AYq4b8q3Hle6jEbEFWfiyEcWf+ecdlEIMjQ4fpd9y/1CuVVSPMWo/uN
         rW2Es3B+umn6WwVtYfMiN6SCtOSWenAgxfCTnasEoja05zHBioG6nW7vxyUHBPkbhyPn
         qN85+/ql7VHHlZCriFZJ4OF3X2n+O1AsGhRDhHDQF7DHyEi3/h81KIctjsGJ+jLJNm6I
         lu46+ulSEztv4E6uWGUTjTOUiACpOT1I9aNlHoS79m/H3j0Jp27KHzfBOkZW7WooiAWU
         wwND3KvCwPvWJDVUMe7oBwtwCERsR5h0H7CD+cbuFZeKyGvUqBjmnkrNDB6XxjtvvqAS
         w5Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=d90Nr9sGDZQ39hAOT/3WbIXuqjIKRqDePLSdPIgkjxA=;
        b=gV6hj3LR1wsDDgpjmTtwMx0beEcYPpD/5fYYJ0eF4bS0uemmZJvNwlkAOC4032QBRZ
         Pr62FeMS8j2X9+wvGd7s2FlK6bV9g3nHppBJCTNIn0aCEzUQZXLkLYaHMslQMJy7TlH0
         O5YjAoQFjfAWY4wOpKOtSDtlV+eQaihqzS3b5M1I4UEq/qCVzzSH49Mll1cl1HVUS00R
         n/rxgWRJzskVTyuip6QJD1Vf1Bw9Fj66ekFK3nR0Dyk/ybb2mkfmyUX5xQPJ/ti7OXzo
         P7jSEUJkPYJwXdaKaY6eVtfZ+8lXT6UVygCwAwRVYzLqbHga3nyjloR0ae2grqKnRKde
         STng==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=DNQ/ixjf;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=DNQ/ixjf;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AH8x2248V35HakyFqAiE4uZngNs/E5Yep1Ge6Llzm32JgIF3dej3sAUd9AgSJKWKtV//BfXeg1EChsBP4vU3svdYuTI=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <CAK7LNAR2GO21TMP=viR1sni_17zFZ+03TUh8pak1etVYEF8kTQ@mail.gmail.com>
References: <20180216214117.1947175-1-arnd@arndb.de> <20180216214117.1947175-3-arnd@arndb.de>
 <CAK7LNARvbsMc3JpcxZjvmc3UjvACx3t66cLM_aSDcADiPA0V7g@mail.gmail.com>
 <CAK8P3a0DAu1q3jLMN=JjrNAd4a4UVFcEcLF2h1VgSvXjZsU++g@mail.gmail.com> <CAK7LNAR2GO21TMP=viR1sni_17zFZ+03TUh8pak1etVYEF8kTQ@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 21 Feb 2018 17:57:18 +0100
X-Google-Sender-Auth: 4k3nA5FKGoeemLV7P-BYCciHvpg
Message-ID: <CAK8P3a1bRC5EwXJ8=xcaZqf5c7=8h12spJ1XCf1NFvCS-7qDnw@mail.gmail.com>
Subject: Re: [PATCH 2/3] Kconfig: improve handling for all{rand,yes,no,}.config
 fragments
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, "Yann E. MORIN" <yann.morin.1998@free.fr>,
	Michal Marek <mmarek@suse.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592595410017482900?=
X-GMAIL-MSGID: =?utf-8?q?1593030464703191388?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 20, 2018 at 6:04 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> 2018-02-20 18:59 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
>> On Tue, Feb 20, 2018 at 10:26 AM, Masahiro Yamada
>> <yamada.masahiro@socionext.com> wrote:
>>> 2018-02-17 6:41 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
>>
>>>> @@ -621,14 +622,24 @@ int main(int ac, char **av)
>>>>                 case randconfig:        name = "allrandom.config"; break;
>>>>                 default: break;
>>>>                 }
>>>> -               if (conf_read_simple(name, S_DEF_USER) &&
>>>> -                   conf_read_simple("all.config", S_DEF_USER)) {
>>>> -                       fprintf(stderr,
>>>> -                               _("*** KCONFIG_ALLCONFIG set, but no \"%s\" or \"all.config\" file found\n"),
>>>> -                               name);
>>>> -                       exit(1);
>>>> +               /* try ./name, arch/$(ARCH)/configs/name and kernel/config/name */
>>>> +               if (!conf_read_simple(name, S_DEF_USER))
>>>> +                       break;
>>>> +               arch = getenv("ARCH");
>>>> +               if (arch) {
>>>> +                       snprintf(fullname, sizeof(fullname), "arch/%s/configs/%s",
>>>> +                                arch, name);
>>>> +                       if (!conf_read_simple(fullname, S_DEF_USER))
>>>> +                               break;
>>>>                 }
>>>
>>>
>>> I am not a big fan of hard-coding the kernel directory structure.
>>>
>>> We already do this [1], but I am thinking of kicking this out.
>>> [1] https://github.com/torvalds/linux/blob/v4.16-rc1/scripts/kconfig/confdata.c#L33
>>
>> Ok, I see. How about adding a way to detect that we are build-testing
>> with randconfig instead?
>
>
> How about implementing something in scripts/kconfig/Makefile?
>
> merge_config collects config fragments into 'configfiles'
>
> I was thinking of a similar thing.
>
>
> If KCONFIG_ALLCONFIG is 1,
> scripts/kconfig/Makefile searches
> './', '$srctree/', 'arch/$(SRCARCH)/configs/', 'kernel/configs/'
> and sets the found file in it,
>
> If KCONFIG_ALLCONFIG already contains a file name, it is used as-is.
>
> scripts/kconfig/conf.c will be simplified.

Yes, good idea. I'm struggling a bit with the implementation (fitting
it into the
simple-tagets rule), can you come up with a prototype?

We also need to decide what happens when e.g. both a ./all.config and
arch/${SRCARCH}/configs/allrand.config file exist, should the first path
take precedence or the more specific file?

     Arnd
