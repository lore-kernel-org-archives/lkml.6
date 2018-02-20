Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751467AbeBTUjL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 15:39:11 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:43953 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750799AbeBTUjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 15:39:10 -0500
Date: Tue, 20 Feb 2018 21:39:04 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kconfig: Don't leak choice names during parsing
Message-ID: <20180220203904.GA14220@ravnborg.org>
References: <1519126829-7257-1-git-send-email-yamada.masahiro@socionext.com>
 <CAFkk2KRbErqLGspp9Th9J+nGzJffxpmiZ81b6jqe-dNH9SJ3ig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFkk2KRbErqLGspp9Th9J+nGzJffxpmiZ81b6jqe-dNH9SJ3ig@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=X9181lbe c=1 sm=1 tr=0
        a=ddpE2eP9Sid01c7MzoqXPA==:117 a=ddpE2eP9Sid01c7MzoqXPA==:17
        a=kj9zAlcOel0A:10 a=c-n4J4-pAAAA:8 a=pGLkceISAAAA:8
        a=qf30I_xW-sYhqbVFvz8A:9 a=CjuIK1q_8ugA:10 a=L0NDqeB7ZLmQzAogN4cw:22
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 08:54:58PM +0100, Ulf Magnusson wrote:
> On Tue, Feb 20, 2018 at 12:40 PM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> > The named choice is not used in the kernel tree, but if it were used,
> > it would not be freed.
> >
> > The intention of the named choice can be seen in the log of
> > commit 5a1aa8a1aff6 ("kconfig: add named choice group").
> >
> > There is room for argument if this is useful in practice, but anyway
> > I am fixing the memory leak.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> >
> >  scripts/kconfig/zconf.y | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/scripts/kconfig/zconf.y b/scripts/kconfig/zconf.y
> > index 4be9805..4893676 100644
> > --- a/scripts/kconfig/zconf.y
> > +++ b/scripts/kconfig/zconf.y
> > @@ -276,6 +276,7 @@ choice: T_CHOICE word_opt T_EOL
> >         sym->flags |= SYMBOL_AUTO;
> >         menu_add_entry(sym);
> >         menu_add_expr(P_CHOICE, NULL, NULL);
> > +       free($2);
> >         printd(DEBUG_PARSE, "%s:%d:choice\n", zconf_curname(), zconf_lineno());
> >  };
> >
> > --
> > 2.7.4
> >
> 
> Reviewed-by: Ulf Magnusson <ulfalizer@gmail.com>
> 
> Only place I've seen named choices in practice is in the esp-idf
> project. Not sure what they're using them for.

The plan with named choices was that it should
allow one to do something like this:

# in one file the choice was defined:
choice FOOBAR
prompt "foobar"

config SAMBAR
bool "bar"

endchoice


# and in another file the choice was extended:
choice FOOBAR

config SAMFOO
bool "foo"

endchoice

The user was then presented only with a single list of choices.

The idea was that this would allow better support for a base
configuration that could be extended in another file.
Think arch/Kconfig versus an arch specific Kconfig file.

But Roman nor I never got around to actually implement this.
Most likely because the need was not big enough.

	Sam
