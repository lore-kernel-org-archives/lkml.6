Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965615AbeBMTqX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 14:46:23 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:53341 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965313AbeBMTqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 14:46:22 -0500
X-ME-Sender: <xms:jUCDWpFAskPqfQFoShaIM78SxfbgZ1X5Y1zy2qgtAEgW-vOcLf4Zxw>
Date: Wed, 14 Feb 2018 06:46:18 +1100
From: "Tobin C. Harding" <me@tobin.cc>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Shunyong Yang <shunyong.yang@hxt-semitech.com>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joey Zheng <yu.zheng@hxt-semitech.com>
Subject: Re: [PATCH] vsprintf: replace space with readable '=' before crng is
 ready
Message-ID: <20180213194618.GA2999@eros>
References: <1518502848-7694-1-git-send-email-shunyong.yang@hxt-semitech.com>
 <CAKwiHFiLQjFc3x9Q9=GEgnuiDPH_aBf7P1-=wPB7WtTo2ExDaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwiHFiLQjFc3x9Q9=GEgnuiDPH_aBf7P1-=wPB7WtTo2ExDaA@mail.gmail.com>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 08:16:57AM +0100, Rasmus Villemoes wrote:
> On 13 February 2018 at 07:20, Shunyong Yang
> <shunyong.yang@hxt-semitech.com> wrote:
> 
> >
> > This patch replaces space with readable "=" when output needs padding.
> > Following is the output after applying the patch,
> 
> > Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> >
> >         if (unlikely(!have_filled_random_ptr_key)) {
> > +               char *ptrval_str = "(ptrval)";
> > +               char str[default_width + 1];
> > +               int len = strlen(ptrval_str);
> > +
> > +               if (default_width > len) {
> > +                       int pos;
> > +
> > +                       pos = (default_width - len) / 2;
> > +                       memset(str, '=', default_width);
> > +                       memcpy(str + pos + 1, ptrval_str + 1, len - 2);
> > +                       str[0] = '(';
> > +                       str[default_width - 1] = ')';
> > +                       str[default_width] = 0;
> > +                       ptrval_str = str;
> > +               }
> > +
> 
> I'm sorry, but that's way too convoluted.
> 
> >                 spec.field_width = default_width;
> >                 /* string length must be less than default_width */
> > -               return string(buf, end, "(ptrval)", spec);
> > +               return string(buf, end, ptrval_str, spec);
> >         }
> 
> I was thinking of just doing something like
> 
> -               return string(buf, end, "(ptrval)", spec);
> +               return string(buf, end, sizeof(void *) == 8 ?
> "(====ptrval====)" : "(ptrval)", spec);

Awesome.
