Return-Path: <ulfalizer@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519924308; cv=none;
        d=google.com; s=arc-20160816;
        b=eQkftMrjSfn7wDtU7p6Qa26n1C/cVIm12DSa2yS5HSYkVJY+C1/noVhQedm9teXCN1
         3b4hFMxFelD+XPjG73aN6hYvpBHqIf7fsR6SKDBmDDDiNFZOnyQftH4gLljBHr8+IEdZ
         vyCz64RVQG5cPqNXxmdnSan71gkBjkqpryyKJ8ejQ9GIjJthHIQyatR5t6F9Ve9132Ov
         IZZ5XGqTzoYwNfTlWtA2mtR5GScuac/+GT1h4HJeiU4Md01PH3f9C22qegfP+3nhEH4p
         8+No103PMmmFNeANmZ6Vbxo5bh6IgRKwIJbZ6Ziwpd/9/dUkwFgqmRKVgggyAEaUdZMi
         S6/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=2NQYbm9/uRxSTfdPLko4ufZaQL1131GjecIvede2KHo=;
        b=QHGBnvugh+EXqKOEkdmPy9U1poV+AlfD9XPcn3MKkg6CVH96VpZ09ZuYdRNmRrn+pY
         MEc+GgPwe4IALHGb8ADjlW9ilhQmufyAJ7ktIUNHLbSbQMD3k4hxTKLzFzONuMW6l/jI
         ZoSmo9k7Nmvch9AkCnhnrhhWNx1vT6Yhj2E8xWNvZwITJUrP2KIsq8OT8Pl72ua/3ooW
         nwXdXdLrSS9te18vdN0zwfYJtuLTHHV22OTunso828p0cUsHPQz211ZHsGsMH1Ys8wor
         ioCyYEVkGkB1zjnQm823gG2tRaUojOKkH/QxBi52F039oqDdmGL1YCI0bp8DB7DQ7r5J
         ob/Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=EAKg1Jm9;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=EAKg1Jm9;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELt84OWYLWYMEyCkYBQriORuZbUfZ4eqNsnka04J3Fn4PiU+W6bAHdQ2vICl/Mft/MKE+P8+NOWhutVFQU40kA8=
MIME-Version: 1.0
In-Reply-To: <CAK7LNARjgqCbTO7x_8kzzfCdU6HWNyFLNZzwfU2hYRZmWHT_kw@mail.gmail.com>
References: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com>
 <1518806331-7101-5-git-send-email-yamada.masahiro@socionext.com> <CAK7LNARjgqCbTO7x_8kzzfCdU6HWNyFLNZzwfU2hYRZmWHT_kw@mail.gmail.com>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Thu, 1 Mar 2018 18:11:47 +0100
Message-ID: <CAFkk2KQaOF3UijN5164G9wyJnym6QHoGSPKMtB8jsS9FRtRdAQ@mail.gmail.com>
Subject: Re: [PATCH 04/23] kconfig: set SYMBOL_AUTO to the symbol marked with defconfig_list
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>,
	Kees Cook <keescook@chromium.org>, Randy Dunlap <rdunlap@infradead.org>,
	Sam Ravnborg <sam@ravnborg.org>, Michal Marek <michal.lkml@markovi.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592583925561685060?=
X-GMAIL-MSGID: =?utf-8?q?1593756151321736067?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 1, 2018 at 4:05 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> 2018-02-17 3:38 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
>> The 'defconfig_list' is a weird attribute.  If the '.config' is
>> missing, conf_read_simple() iterates over all visible defaults,
>> then it uses the first one for which fopen() succeeds.
>>
>> config DEFCONFIG_LIST
>>         string
>>         depends on !UML
>>         option defconfig_list
>>         default "/lib/modules/$UNAME_RELEASE/.config"
>>         default "/etc/kernel-config"
>>         default "/boot/config-$UNAME_RELEASE"
>>         default "$ARCH_DEFCONFIG"
>>         default "arch/$ARCH/defconfig"
>>
>> However, like other symbols, the first visible default is always
>> written out to the .config file.  This might be different from what
>> has been actually used.
>>
>> For example, on my machine, the third one "/boot/config-$UNAME_RELEASE"
>> is opened, like follows:
>>
>>   $ rm .config
>>   $ make oldconfig 2>/dev/null
>>   scripts/kconfig/conf  --oldconfig Kconfig
>>   #
>>   # using defaults found in /boot/config-4.4.0-112-generic
>>   #
>>   *
>>   * Restart config...
>>   *
>>   *
>>   * IRQ subsystem
>>   *
>>   Expose irq internals in debugfs (GENERIC_IRQ_DEBUGFS) [N/y/?] (NEW)
>>
>> However, the resulted .config file contains the first one since it is
>> visible:
>>
>>   $ grep CONFIG_DEFCONFIG_LIST .config
>>   CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
>>
>> In order to stop confusing people, prevent this CONFIG option from
>> being written to the .config file.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>
>
> This one is almost trivial, so I will pick it up now.
>
> Ulf, do you have any comment about this one?
>
>
>
>
>> I'd like to fix the root case of this weirdness later.
>> (and other 'option' attributes as well)
>>
>> But, this series is focusing a more important work in a bigger picture.
>>
>> For now, I decided to just hide CONFIG_DEFCONFIG_LIST
>> from the .config file.
>>
>>
>>  scripts/kconfig/menu.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/scripts/kconfig/menu.c b/scripts/kconfig/menu.c
>> index 9922285..36cd3e1 100644
>> --- a/scripts/kconfig/menu.c
>> +++ b/scripts/kconfig/menu.c
>> @@ -212,6 +212,7 @@ void menu_add_option(int token, char *arg)
>>                         sym_defconfig_list = current_entry->sym;
>>                 else if (sym_defconfig_list != current_entry->sym)
>>                         zconf_error("trying to redefine defconfig symbol");
>> +               sym_defconfig_list->flags |= SYMBOL_AUTO;
>>                 break;
>>         case T_OPT_ENV:
>>                 prop_add_env(arg);
>> --
>> 2.7.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Best Regards
> Masahiro Yamada

Seems reasonable to me.

Reviewed-by: Ulf Magnusson <ulfalizer@gmail.com>

Cheers,
Ulf
