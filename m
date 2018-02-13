Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933670AbeBMH6P convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 02:58:15 -0500
Received: from mx01.hxt-semitech.com.96.203.223.in-addr.arpa ([223.203.96.7]:39567
        "EHLO barracuda.hxt-semitech.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S933550AbeBMH6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 02:58:14 -0500
X-ASG-Debug-ID: 1518508690-093b7e4b503eeb0001-xx1T2L
X-Barracuda-Envelope-From: shunyong.yang@hxt-semitech.com
From: "Yang, Shunyong" <shunyong.yang@hxt-semitech.com>
To: "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "andriy.shevchenko@linux.intel.com"
        <andriy.shevchenko@linux.intel.com>,
        "Zheng, Joey" <yu.zheng@hxt-semitech.com>, "me@tobin.cc" <me@tobin.cc>
Subject: Re: [PATCH] vsprintf: replace space with readable '=' before crng
 is ready
Thread-Topic: [PATCH] vsprintf: replace space with readable '=' before crng
 is ready
X-ASG-Orig-Subj: Re: [PATCH] vsprintf: replace space with readable '=' before crng
 is ready
Thread-Index: AQHTpJMy03PZ12s5rE2BmcmzlD2+sKOhZgCAgAALbQA=
Date: Tue, 13 Feb 2018 07:57:50 +0000
Message-ID: <1518508670.3326.6.camel@hxt-semitech.com>
References: <1518502848-7694-1-git-send-email-shunyong.yang@hxt-semitech.com>
         <CAKwiHFiLQjFc3x9Q9=GEgnuiDPH_aBf7P1-=wPB7WtTo2ExDaA@mail.gmail.com>
In-Reply-To: <CAKwiHFiLQjFc3x9Q9=GEgnuiDPH_aBf7P1-=wPB7WtTo2ExDaA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.64.6.28]
Content-Type: text/plain; charset="iso-8859-15"
Content-ID: <30E61B702F14C94588059CEB4C178DEA@hxt-semitech.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Barracuda-Connect: localhost[10.128.0.14]
X-Barracuda-Start-Time: 1518508690
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.4501 1.0000 0.0000
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.47867
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Rasmus,

On Tue, 2018-02-13 at 08:16 +0100, Rasmus Villemoes wrote:
> On 13 February 2018 at 07:20, Shunyong Yang
> <shunyong.yang@hxt-semitech.com> wrote:
> 
> > 
> > 
> > This patch replaces space with readable "=" when output needs
> > padding.
> > Following is the output after applying the patch,
> > 
> > Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > 
> >         if (unlikely(!have_filled_random_ptr_key)) {
> > +               char *ptrval_str = "(ptrval)";
> > +               char str[default_width + 1];
> > +               int len = strlen(ptrval_str);
> > +
> > +               if (default_width > len) {
> > +                       int pos;
> > +
> > +                       pos = (default_width - len) / 2;
> > +                       memset(str, '=', default_width);
> > +                       memcpy(str + pos + 1, ptrval_str + 1, len -
> > 2);
> > +                       str[0] = '(';
> > +                       str[default_width - 1] = ')';
> > +                       str[default_width] = 0;
> > +                       ptrval_str = str;
> > +               }
> > +
> I'm sorry, but that's way too convoluted.
> 
> > 
> >                 spec.field_width = default_width;
> >                 /* string length must be less than default_width */
> > -               return string(buf, end, "(ptrval)", spec);
> > +               return string(buf, end, ptrval_str, spec);
> >         }
> I was thinking of just doing something like
> 
> -               return string(buf, end, "(ptrval)", spec);
> +               return string(buf, end, sizeof(void *) == 8 ?
> "(====ptrval====)" : "(ptrval)", spec);
> 

Thanks a lot! It's more straightforward considering 32/64-bit system.

Thanks.
Shunyong.
