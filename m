Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519120790; cv=none;
        d=google.com; s=arc-20160816;
        b=Kde1MttcpN1+eB39W2Jzx3WMxb1vqviLpaX0xjfQb0E3GiDI82FHQNHYkRuWHj33X1
         rgQ5KDH8POePqxxHp9F9GrTNArkdE0ObJORFPvxTJCFhELdujAnWgkmGkFBRLd6AEWAZ
         aLY3fc/wkPOfbr7yXNm6p2sOnC2lreJLUSeEZlYLR13fnAn6gwYT2L4eghAqVs85jE/C
         4dd41xzVQjxwhcKUDzka5EDIw4oWVpbY+gaBq6KQtsMMVXzfFI7uoIqcv2Gl8rxmKqwd
         cSCHeLWAvL7VQPhASzSGYeSfkX4H8hBDK0GuWqKhJRXnchNJ1Z8YlXTR7IN1J2TZZF86
         91FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=aC3cbENpQIjRgLw7r5dCKmRadopDjPWYvmDDOc/f+UE=;
        b=tpmS5/g7cQ/mk28Bdytj8IJ0Tkr0K7XQNURfVuRsYq3AK6kwTuUU8gIP+XVbzzCPlw
         CCS3FR81D0tkxCbBwy1N9SSLt6lI2vEOI+9EgOiq4ijbbyulAjceLacwj8Tw4/QXbs3Z
         fp72orGLii4+XqHhT7rRIPYYCkUf8r5+4QCBh4VEtyByad7JxgU0Xe1weByFwOcK+sNf
         Yw2j6Jl/2ejrYirXwiNHASDTC1aRsL4d/ssoEUOhQU6Xv4iI4KIlnzf1DXwlv2jN3sQL
         4ZRPJg4JToYmQ9ftf9Tamh+fIx/+JIHxx3IT7r32BJqWz/mntuQNBrcZawmCkTMgiSWp
         PT+A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=eFNrApoT;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=eFNrApoT;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AH8x227zKo0I+VOcW7wWDbotGMfNuh8FgtLmeLK36j9V5UuLbYf3UJiewplAkMHm+NeYgcd+yLhDwtiSA1Ss5uywIPM=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <CAK7LNARvbsMc3JpcxZjvmc3UjvACx3t66cLM_aSDcADiPA0V7g@mail.gmail.com>
References: <20180216214117.1947175-1-arnd@arndb.de> <20180216214117.1947175-3-arnd@arndb.de>
 <CAK7LNARvbsMc3JpcxZjvmc3UjvACx3t66cLM_aSDcADiPA0V7g@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 20 Feb 2018 10:59:49 +0100
X-Google-Sender-Auth: UOQ797fFjlQxmaqviRpC6oVn66w
Message-ID: <CAK8P3a0DAu1q3jLMN=JjrNAd4a4UVFcEcLF2h1VgSvXjZsU++g@mail.gmail.com>
Subject: Re: [PATCH 2/3] Kconfig: improve handling for all{rand,yes,no,}.config
 fragments
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, "Yann E. MORIN" <yann.morin.1998@free.fr>,
	Michal Marek <mmarek@suse.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592595410017482900?=
X-GMAIL-MSGID: =?utf-8?q?1592913601937364717?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 20, 2018 at 10:26 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> 2018-02-17 6:41 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:

>> @@ -621,14 +622,24 @@ int main(int ac, char **av)
>>                 case randconfig:        name = "allrandom.config"; break;
>>                 default: break;
>>                 }
>> -               if (conf_read_simple(name, S_DEF_USER) &&
>> -                   conf_read_simple("all.config", S_DEF_USER)) {
>> -                       fprintf(stderr,
>> -                               _("*** KCONFIG_ALLCONFIG set, but no \"%s\" or \"all.config\" file found\n"),
>> -                               name);
>> -                       exit(1);
>> +               /* try ./name, arch/$(ARCH)/configs/name and kernel/config/name */
>> +               if (!conf_read_simple(name, S_DEF_USER))
>> +                       break;
>> +               arch = getenv("ARCH");
>> +               if (arch) {
>> +                       snprintf(fullname, sizeof(fullname), "arch/%s/configs/%s",
>> +                                arch, name);
>> +                       if (!conf_read_simple(fullname, S_DEF_USER))
>> +                               break;
>>                 }
>
>
> I am not a big fan of hard-coding the kernel directory structure.
>
> We already do this [1], but I am thinking of kicking this out.
> [1] https://github.com/torvalds/linux/blob/v4.16-rc1/scripts/kconfig/confdata.c#L33

Ok, I see. How about adding a way to detect that we are build-testing
with randconfig instead?

> BTW, I am trying to compiler capability check to Kconfig.
> If this work is done, I hope some "depends on !COMPILE_TEST" will go
> away (but not all?)
> https://patchwork.kernel.org/patch/10225375/

I think most of the 'depends on !COMPILE_TEST' are for cases that
impact compile-testing in some way (more false-positive warnings,
fewer real warnings, much slower compile speed), rather than a lack
of check for a specific compiler version.

We might be able to replace the CONFIG_STANDALONE and
CONFIG_PREVENT_FIRMWARE_BUILD with Kconfig $(shell)
checks if you think that leads to an improvement.

        Arnd
