Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752982AbeE3Oe2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 10:34:28 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50593 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753121AbeE3OeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 10:34:20 -0400
X-Google-Smtp-Source: ADUXVKIKl802QTOdsrsKaaGszkU9vjAeTIfSeTOPidIVFe3Ifb0bmlfxzzrezB8u3im/2BIUdTn3bw==
Date: Wed, 30 May 2018 15:34:15 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Nick Desaulniers <nick.desaulniers@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Jason Wessel <jason.wessel@windriver.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ebiggers@google.com
Subject: Re: [PATCH] kdb: prefer strlcpy to strncpy
Message-ID: <20180530143415.ksc6fb4zo6m7xb25@holly.lan>
References: <1527573427-16569-1-git-send-email-nick.desaulniers@gmail.com>
 <CAK8P3a2=THd7YL6sB4=xXZShD=wOjk_taM1L-E5VPH77TiQK0w@mail.gmail.com>
 <CAH7mPvhQo5S5EbgvkteoL1xftLWjWBqkfoanG0dTLzaa=FtTgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH7mPvhQo5S5EbgvkteoL1xftLWjWBqkfoanG0dTLzaa=FtTgw@mail.gmail.com>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 07:01:35PM -0700, Nick Desaulniers wrote:
> On Tue, May 29, 2018 at 12:57 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tue, May 29, 2018 at 7:57 AM, Nick Desaulniers
> > <nick.desaulniers@gmail.com> wrote:
> >> Fixes stringop-truncation and stringop-overflow warnings from gcc-8.
> >
> > That patch description should really explain whether gcc is right or not. What's
> > the worst thing that could happen here?
> >
> > I would also recommend citing the exact warning you got.
> >
> >> diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> >> index ed5d349..b5dfff1 100644
> >> --- a/kernel/debug/kdb/kdb_io.c
> >> +++ b/kernel/debug/kdb/kdb_io.c
> >> @@ -443,7 +443,7 @@ static char *kdb_read(char *buffer, size_t bufsize)
> >>  char *kdb_getstr(char *buffer, size_t bufsize, const char *prompt)
> >>  {
> >>         if (prompt && kdb_prompt_str != prompt)
> >> -               strncpy(kdb_prompt_str, prompt, CMD_BUFLEN);
> >> +               strlcpy(kdb_prompt_str, prompt, CMD_BUFLEN);
> >>         kdb_printf(kdb_prompt_str);
> >>         kdb_nextline = 1;       /* Prompt and input resets line number */
> >>         return kdb_read(buffer, bufsize);
> >> diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> >> index e405677..c30a0d8 100644
> >> --- a/kernel/debug/kdb/kdb_main.c
> >> +++ b/kernel/debug/kdb/kdb_main.c
> >> @@ -1103,12 +1103,12 @@ static int handle_ctrl_cmd(char *cmd)
> >>         case CTRL_P:
> >>                 if (cmdptr != cmd_tail)
> >>                         cmdptr = (cmdptr-1) % KDB_CMD_HISTORY_COUNT;
> >> -               strncpy(cmd_cur, cmd_hist[cmdptr], CMD_BUFLEN);
> >> +               strlcpy(cmd_cur, cmd_hist[cmdptr], CMD_BUFLEN);
> >>                 return 1;
> >>         case CTRL_N:
> >>                 if (cmdptr != cmd_head)
> >>                         cmdptr = (cmdptr+1) % KDB_CMD_HISTORY_COUNT;
> >> -               strncpy(cmd_cur, cmd_hist[cmdptr], CMD_BUFLEN);
> >> +               strlcpy(cmd_cur, cmd_hist[cmdptr], CMD_BUFLEN);
> >>                 return 1;
> >>         }
> >>         return 0;
> >
> > Those three all look good.
> >
> >> diff --git a/kernel/debug/kdb/kdb_support.c b/kernel/debug/kdb/kdb_support.c
> >> index 990b3cc..dcfbf8f 100644
> >> --- a/kernel/debug/kdb/kdb_support.c
> >> +++ b/kernel/debug/kdb/kdb_support.c
> >> @@ -236,7 +236,7 @@ int kallsyms_symbol_next(char *prefix_name, int flag)
> >>
> >>         while ((name = kdb_walk_kallsyms(&pos))) {
> >>                 if (strncmp(name, prefix_name, prefix_len) == 0) {
> >> -                       strncpy(prefix_name, name, strlen(name)+1);
> >> +                       strlcpy(prefix_name, name, prefix_len);
> >>                         return 1;
> >>                 }
> >
> > I don't know what this does, but you are changing the behavior: the previous
> > 'strlen(name)+1' argument was the size of the source string (which makes
> > the strncpy() behave the same as a plain strcpy()), the new one means
> > we only copy at most as many bytes as the previous length of the destination
> > string.
> >
> > Is that intended? If yes, better explain it in the patch description.
> >
> >         Arnd
> 
> Eric points out that this will leak kernel memory if size is less than
> sizeof src.

Don't quite understand what this means (there's no allocation here, how
can there be a leak?) but the symbol completion certainly won't work if
we truncate the copy here.

My understanding is that the only way to make this overflow safe is to
change the signature of kallsyms_symbol_next() so it takes a max_len
argument similar to what is done for kallsyms_symbol_complete().

It might even be worth using strscpy() here and propagating the -E2BIG
to the caller. That allows the caller to print the partial symbol and
an elipsis to show the user that the symbol has been truncated.


Daniel.
