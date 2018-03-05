Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752460AbeCEPZQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 10:25:16 -0500
Received: from mga17.intel.com ([192.55.52.151]:33971 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751881AbeCEPZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 10:25:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,427,1515484800";
   d="scan'208";a="34745963"
Message-ID: <1520263504.10722.399.camel@linux.intel.com>
Subject: Re: [PATCH] vsprintf: Make "null" pointer dereference more robust
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Petr Mladek <pmladek@suse.com>
Cc: "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>
Date: Mon, 05 Mar 2018 17:25:04 +0200
In-Reply-To: <CAKwiHFgTbFof34oc59OU3M1=-PTzstv0uxSmoiRc8TJPJPMHVw@mail.gmail.com>
References: <20180216210711.79901-1-andriy.shevchenko@linux.intel.com>
         <20180216210711.79901-8-andriy.shevchenko@linux.intel.com>
         <20180227155047.o74ohmoyj56up6pa@pathway.suse.cz>
         <1519752950.10722.231.camel@linux.intel.com>
         <20180228100437.o4juwxbzomkqjvjx@pathway.suse.cz>
         <1519814544.10722.266.camel@linux.intel.com>
         <20180302125118.bjd3tbuu72vgfczo@pathway.suse.cz>
         <20180302125359.szbin2kznxvoq7sc@pathway.suse.cz>
         <CAKwiHFgTbFof34oc59OU3M1=-PTzstv0uxSmoiRc8TJPJPMHVw@mail.gmail.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-03-05 at 16:16 +0100, Rasmus Villemoes wrote:
> On 2 March 2018 at 13:53, Petr Mladek <pmladek@suse.com> wrote:

> > -       if (!ptr && *fmt != 'K' && *fmt != 'x') {
> > +       if ((unsigned long)ptr < PAGE_SIZE && *fmt != 'K' && *fmt !=
> > 'x') {
> 
> ISTM that accidentally passing an ERR_PTR would be just as likely as
> passing a NULL pointer (or some small offset from one), so if we do
> this, shouldn't the test also cover IS_ERR values?

We (will) have such check in two places, perhaps a helper

static bool is_pointer_valid(void *ptr)
{
  return !IS_ERR(ptr) && (unsigned long)ptr >= PAGE_SIZE;
}

?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
