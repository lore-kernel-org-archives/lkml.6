Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752559AbeEOIQJ convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 04:16:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:47142 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752482AbeEOIQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 04:16:07 -0400
Date: Tue, 15 May 2018 10:16:02 +0200
From: Jean Delvare <jdelvare@suse.de>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Anders Roxell <anders.roxell@linaro.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] i2c: i801: fix unused-function warning
Message-ID: <20180515101602.79ff49cf@endymion>
In-Reply-To: <CAHp75VdJEzDsvJmv812wvc5p=frqc3KU8HW=y4cGULYEp4=SKQ@mail.gmail.com>
References: <20180510152719.6e37b10e@endymion>
        <20180514093326.30314-1-anders.roxell@linaro.org>
        <CAHp75VdJEzDsvJmv812wvc5p=frqc3KU8HW=y4cGULYEp4=SKQ@mail.gmail.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Mon, 14 May 2018 20:18:37 +0300, Andy Shevchenko wrote:
> On Mon, May 14, 2018 at 12:33 PM, Anders Roxell
> <anders.roxell@linaro.org> wrote:
> > With CONFIG_PM, we get a harmless build warning:
> > drivers/i2c/busses/i2c-i801.c:1723:12: warning: ‘i801_resume’ defined but not used [-Wunused-function]
> >  static int i801_resume(struct device *dev)
> >             ^~~~~~~~~~~
> > drivers/i2c/busses/i2c-i801.c:1714:12: warning: ‘i801_suspend’ defined but not used [-Wunused-function]
> >  static int i801_suspend(struct device *dev)
> >             ^~~~~~~~~~~~  
> 
> > -#ifdef CONFIG_PM
> > +#ifdef CONFIG_PM_SLEEP
> >  static int i801_suspend(struct device *dev)  
> 
> The better pattern is to get rid of ugly ifdef and supply
> __maybe_unused annotation to each function in question.

That was Anders' first proposal, but it was declined by the driver
maintainer (me.) See:

https://marc.info/?l=linux-kernel&m=152588526520326&w=2

__maybe_unused is just a way to prevent the compiler from doing its
job. If it's really what you want, you might as well build with
-Wno-unused, instead of crippling the code with yet another annotation.

I can't see how building unused code only to discard it later can be
better than a proper #ifdef which will only build the code when we
actually need it.

Maybe there are cases where __maybe_unused is actually needed, but in
my opinion that should be the last resort option. That's not the case
here.

-- 
Jean Delvare
SUSE L3 Support
