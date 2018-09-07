Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C0CC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4BA2206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:03:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4BA2206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbeIGMnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 08:43:01 -0400
Received: from smtprelay0172.hostedemail.com ([216.40.44.172]:53151 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727093AbeIGMnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 08:43:01 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 3767E837F243;
        Fri,  7 Sep 2018 08:03:15 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bed26_395bbcbd78805
X-Filterd-Recvd-Size: 3186
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Fri,  7 Sep 2018 08:03:14 +0000 (UTC)
Message-ID: <bc10850410b2c58c2bfbfa4f412403db7c82b535.camel@perches.com>
Subject: Re: [PATCH] ttyprintk: make the printk log level configurable
From:   Joe Perches <joe@perches.com>
To:     Peter Korsgaard <peter@korsgaard.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Date:   Fri, 07 Sep 2018 01:03:12 -0700
In-Reply-To: <CACXmViaj6XWUXmdFov_1-exCd5idDx2s-2_kfmDFydN75wUNNQ@mail.gmail.com>
References: <20180821172822.30975-1-peter@korsgaard.com>
         <CACXmViaj6XWUXmdFov_1-exCd5idDx2s-2_kfmDFydN75wUNNQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-09-07 at 09:50 +0200, Peter Korsgaard wrote:
> On Tue, Aug 21, 2018 at 7:28 PM Peter Korsgaard <peter@korsgaard.com> wrote:
> > 
> > For some use cases it is handy to use a different printk log level than the
> > default (info) for the messages written to ttyprintk, so add a Kconfig
> > option similar to what we have for default console loglevel.
> 
> Ping? Feedback, comments?

I think it is moving "[U]" into TPK_LEVEL is an
unnecessary and a tad obfuscating change.

This also adds a leading space for unknown reasons
after the KERN_SOH <level>.

> > diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
> > index ce277ee0a28a..14a7f023f20b 100644
> > --- a/drivers/char/Kconfig
> > +++ b/drivers/char/Kconfig
> > @@ -66,6 +66,14 @@ config TTY_PRINTK
> > 
> >           If unsure, say N.
> > 
> > +config TTY_PRINTK_LEVEL
> > +       depends on TTY_PRINTK
> > +       int "ttyprintk log level (1-7)"
> > +       range 1 7
> > +       default "6"
> > +       help
> > +         Printk log level to use for ttyprintk messages.
> > +
> >  config PRINTER
> >         tristate "Parallel printer support"
> >         depends on PARPORT
> > diff --git a/drivers/char/ttyprintk.c b/drivers/char/ttyprintk.c
> > index 67549ce88cc9..22fbd483b5dc 100644
> > --- a/drivers/char/ttyprintk.c
> > +++ b/drivers/char/ttyprintk.c
> > @@ -37,6 +37,8 @@ static struct ttyprintk_port tpk_port;
> >   */
> >  #define TPK_STR_SIZE 508 /* should be bigger then max expected line length */
> >  #define TPK_MAX_ROOM 4096 /* we could assume 4K for instance */
> > +#define TPK_PREFIX KERN_SOH __stringify(CONFIG_TTY_PRINTK_LEVEL) " [U]"

I think this should be

#define TPK_PREFIX KERN_SOH __stringify(CONFIG_TTY_PRINTK_LEVEL)

> > +
> >  static int tpk_curr;
> > 
> >  static char tpk_buffer[TPK_STR_SIZE + 4];
> > @@ -45,7 +47,7 @@ static void tpk_flush(void)
> >  {
> >         if (tpk_curr > 0) {
> >                 tpk_buffer[tpk_curr] = '\0';
> > -               pr_info("[U] %s\n", tpk_buffer);
> > +               printk(TPK_PREFIX " %s\n", tpk_buffer);

and this

		printk(TPK_PREFIX "[U] %s\n", tpk_buffer);

> >                 tpk_curr = 0;
> >         }
> >  }
> > --
> > 2.11.0
> > 
> 
> 
