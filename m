Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750941AbeBHGvW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 01:51:22 -0500
Received: from mail-vk0-f67.google.com ([209.85.213.67]:36762 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750766AbeBHGvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 01:51:20 -0500
X-Google-Smtp-Source: AH8x227fJoiop7reashHliFIvnLARYyBps33RWTpfmj00Wtjx+ArsU4lIF5eYjxHtKHx0C+2i2gdXm19yjTr1XahLxE=
MIME-Version: 1.0
In-Reply-To: <CAFkk2KQC6GbfkXETFdKEhy-rTfuuH7zeuXvezGzwMy_=2V03Dg@mail.gmail.com>
References: <1518069400-7037-1-git-send-email-yamada.masahiro@socionext.com>
 <1518069400-7037-2-git-send-email-yamada.masahiro@socionext.com> <CAFkk2KQC6GbfkXETFdKEhy-rTfuuH7zeuXvezGzwMy_=2V03Dg@mail.gmail.com>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Thu, 8 Feb 2018 07:51:19 +0100
Message-ID: <CAFkk2KSstFf2+w2gbm0AGk+Kdy2Kcxhdq74rv7djGOYqdm1+Zw@mail.gmail.com>
Subject: Re: [PATCH 2/2] kconfig: echo stdin to stdout if either is redirected
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marc Herbert <marc.herbert@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 8, 2018 at 7:35 AM, Ulf Magnusson <ulfalizer@gmail.com> wrote:
> On Thu, Feb 8, 2018 at 6:56 AM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> If stdio is not tty, conf_askvalue() puts additional new line to
>> prevent prompts are all concatenated into a single line.  This care
>> is missing in conf_choice(), so a 'choice' prompt and the next prompt
>> are shown in the same line.
>>
>> Move the code into xfgets() to take care of all cases.  To improve
>> this more, echo stdin to stdout.  This clarifies what keys were input
>> from stdio and the stdout looks like as if it were from tty.
>>
>> I removed the isatty(2) check since stderr is unrelated here.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>>
>>  scripts/kconfig/conf.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
>> index 358e2e4..c5318d3 100644
>> --- a/scripts/kconfig/conf.c
>> +++ b/scripts/kconfig/conf.c
>> @@ -76,6 +76,9 @@ static void xfgets(char *str, int size, FILE *in)
>>  {
>>         if (!fgets(str, size, in))
>>                 fprintf(stderr, "\nError in reading or end of file.\n");
>> +
>> +       if (!tty_stdio)
>> +               printf("%s", str);
>>  }
>>
>>  static int conf_askvalue(struct symbol *sym, const char *def)
>> @@ -106,8 +109,6 @@ static int conf_askvalue(struct symbol *sym, const char *def)
>>         case oldaskconfig:
>>                 fflush(stdout);
>>                 xfgets(line, sizeof(line), stdin);
>> -               if (!tty_stdio)
>> -                       printf("\n");
>>                 return 1;
>>         default:
>>                 break;
>> @@ -495,7 +496,7 @@ int main(int ac, char **av)
>>         bindtextdomain(PACKAGE, LOCALEDIR);
>>         textdomain(PACKAGE);
>>
>> -       tty_stdio = isatty(0) && isatty(1) && isatty(2);
>> +       tty_stdio = isatty(0) && isatty(1);
>>
>>         while ((opt = getopt_long(ac, av, "s", long_opts, NULL)) != -1) {
>>                 if (opt == 's') {
>> --
>> 2.7.4
>>
>
> Reviewed-by: Ulf Magnusson <ulfalizer@gmail.com>
>
> Might be some case I'm not thinking of, but wouldn't it make sense to
> just check isatty(1) as well? If stdout is a regular file, it seems
> it'd be nice to have the input appear there, regardless of where stdin
> is from.
>
> Maybe the tty_stdio variable could be removed then as well, replaced
> with just 'if (!isatty(1))'.
>
> Cheers,
> Ulf

Hmm... if stdout is a tty and stdin isn't, this would prevent the
input from showing up on the terminal though, so I guess it makes
sense. That case seems more important than the weird
stdin=tty/stdout=file case.

Tricky stuff. :)

Cheers,
Ulf
