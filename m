Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43292C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05C0920663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="MV0UOfLZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05C0920663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbeK0Bsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 20:48:35 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:35743 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbeK0Bsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 20:48:35 -0500
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id wAQEs7o1021624;
        Mon, 26 Nov 2018 23:54:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com wAQEs7o1021624
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1543244048;
        bh=F3GmQsado+aP7mYIIudxuKv6hyfoo9G6RoAPe6e82Yg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MV0UOfLZfp79YT+XKrWDyKmwPedPlaHZc5Xrgoz4okbWv0wBNwP2vRLoVpZcY64T/
         tZ0+L6UnTdq0V8lpt6rZOI57qfhyEBW9S6aof3kM1hFMwYu4YFf1oyZSOpcNlyrwqO
         kA3n2XUijI4vmPvzVVWse3+X2VdJJwl7XymQ0VWm7sXIi6JbeJRiMAWiMwQLala/DA
         DcS7KAejzs3bAcgBJaLudxGTjApShi9Gn9tj1fDJ449PtFpbjY5o7FezFHb68FOmKU
         em+gdp0xBl5oAKYkjeREAeNi+Hlz4i9vHHDWCmuFYbmCoOeTK7OnHRKIJ+P3lrDX+M
         CFNcUUEuTFBsg==
X-Nifty-SrcIP: [209.85.217.46]
Received: by mail-vs1-f46.google.com with SMTP id p74so11490729vsc.0;
        Mon, 26 Nov 2018 06:54:07 -0800 (PST)
X-Gm-Message-State: AGRZ1gL1eS4Bq2Y1YJL0copjZCva/bSyP6Ut3hknmsGi1IOX9FV/MJdv
        kaoXoYkIf3q0IB1R0e0Y1uFj1GuFKycksxlJlU8=
X-Google-Smtp-Source: AJdET5d9dMakOlFR0YtINR0qbQBfYH2Zq8jIBYQ+r+oJ52E1qxwzObth5ZwMQJw4G0fOMOlGYWRhbKV6jLmGpJgwgFg=
X-Received: by 2002:a67:a858:: with SMTP id r85mr11474395vse.215.1543244046411;
 Mon, 26 Nov 2018 06:54:06 -0800 (PST)
MIME-Version: 1.0
References: <1542860922-9730-1-git-send-email-yamada.masahiro@socionext.com> <1542860922-9730-2-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1542860922-9730-2-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 26 Nov 2018 23:53:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR7vGAjHbXSeE6yh4u8Dcr+ZZpADmxvBN9Co2=42=gXzg@mail.gmail.com>
Message-ID: <CAK7LNAR7vGAjHbXSeE6yh4u8Dcr+ZZpADmxvBN9Co2=42=gXzg@mail.gmail.com>
Subject: Re: [PATCH 2/2] modpost: file2alias: check prototype of handler
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Jessica Yu <jeyu@kernel.org>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Mathieu Malaterre <malat@debian.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 1:51 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Use specific prototype instead of an opaque pointer so that the
> compiler can catch incompatible pointer type.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Applied to linux-kbuild.



>  scripts/mod/file2alias.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
> index 7e4aede..a37af7d 100644
> --- a/scripts/mod/file2alias.c
> +++ b/scripts/mod/file2alias.c
> @@ -47,7 +47,7 @@ typedef struct {
>  struct devtable {
>         const char *device_id; /* name of table, __mod_<name>__*_device_table. */
>         unsigned long id_size;
> -       void *function;
> +       int (*do_entry)(const char *filename, void *symval, char *alias);
>  };
>
>  /* Define a variable f that holds the value of field f of struct devid
> @@ -1299,12 +1299,11 @@ static bool sym_is(const char *name, unsigned namelen, const char *symbol)
>  static void do_table(void *symval, unsigned long size,
>                      unsigned long id_size,
>                      const char *device_id,
> -                    void *function,
> +                    int (*do_entry)(const char *filename, void *symval, char *alias),
>                      struct module *mod)
>  {
>         unsigned int i;
>         char alias[500];
> -       int (*do_entry)(const char *, void *entry, char *alias) = function;
>
>         device_id_check(mod->name, device_id, size, id_size, symval);
>         /* Leave last one: it's the terminator. */
> @@ -1420,7 +1419,7 @@ void handle_moddevtable(struct module *mod, struct elf_info *info,
>
>                         if (sym_is(name, namelen, p->device_id)) {
>                                 do_table(symval, sym->st_size, p->id_size,
> -                                        p->device_id, p->function, mod);
> +                                        p->device_id, p->do_entry, mod);
>                                 break;
>                         }
>                 }
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
