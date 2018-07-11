Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F763C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 020B420C0F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:24:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 020B420C0F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390149AbeGKR3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 13:29:45 -0400
Received: from smtprelay0004.hostedemail.com ([216.40.44.4]:58599 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732594AbeGKR3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 13:29:45 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 6143A9079;
        Wed, 11 Jul 2018 17:24:26 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: jam61_7dc216d49445f
X-Filterd-Recvd-Size: 3813
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Wed, 11 Jul 2018 17:24:24 +0000 (UTC)
Message-ID: <2fe72b18d3a3aa782529e112e07a0eb8d7cf2cc1.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: Warn if missing author Signed-off-by
From:   Joe Perches <joe@perches.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Andy Whitcroft <apw@canonical.com>, jgg@mellanox.com,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linus Walleij <linus.walleij@linaro.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Pavel Machek <pavel@ucw.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 11 Jul 2018 10:24:22 -0700
In-Reply-To: <CAMuHMdXJeeaZQHqYp+q+L4FSRNusavDjtN8A_K-koiHGGGEFXw@mail.gmail.com>
References: <20180711151003.6768-1-geert+renesas@glider.be>
         <cd7a7d241252bbb6588448ed7f27d51811025c63.camel@perches.com>
         <CAMuHMdXJeeaZQHqYp+q+L4FSRNusavDjtN8A_K-koiHGGGEFXw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-11 at 19:07 +0200, Geert Uytterhoeven wrote:
> Hi Joe,

Rehi Geert.

> On Wed, Jul 11, 2018 at 6:20 PM Joe Perches <joe@perches.com> wrote:
> > On Wed, 2018-07-11 at 17:10 +0200, Geert Uytterhoeven wrote:
> > > Print a warning if none of the Signed-off-by lines cover the patch
> > > author.
> > > 
> > > Non-ASCII quoted printable encoding in From: headers and (lack of)
> > > double quotes are handled.
> > > Split From: headers are not fully handled: only the first part is
> > > compared.
> > 
> > []
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > 
> > []
> > > +# Check the patch for a From:
> > > +             if (decode("MIME-Header", $line) =~ /^From:\s*(.*)/) {
> > > +                     $author = encode("utf8", $1);
> > > +                     $author =~ s/"//g;
> > > +             }
> > > +
> > >  # Check the patch for a signoff:
> > >               if ($line =~ /^\s*signed-off-by:/i) {
> > >                       $signoff++;
> > >                       $in_commit_log = 0;
> > > +                     if ($author ne '') {
> > > +                             my $l = $line;
> > > +                             $l =~ s/"//g;
> > > +                             if ($l =~ /^\s*signed-off-by: \Q$author\E/i) {

	if (/^\s*signed-off-by:\s*\Q$author\E/i)

> > > +                                 $authorsignoff = 1;
> > > +                             }
> > > +                     }
> > >               }
> > 
> > I don't see the point of removing the quotes.
> 
> If the name contains a dot (e.g. "David S. Miller"), it must be protected
> by double quotes in the From: email header, but that is usually not the case
> in the Sob line.

Right.
It seems it's unusual for SOBs to use quotes around names.

> > Another somewhat frequent Signed-off-by: defect pattern
> > is to have a lower-case name or no name at all used.
> > 
> > Perhaps it'd be useful to add some checks like
> > a single word for a name and all lower-case names:
> > 
> > e.g.:
> >         Signed-off-by: joe perches <joe@perches.com>
> > 
> > emits
> > 
> > Unusual lower case name: 'joe perches <joe@perches.com>'
> > 
> > and
> >         Signed-off-by: root <root@mydomain.net>
> > and
> >         Signed-off-by: Root <root@mydomain.net>
> > and
> >         Signed-off-by: root@mydomain.net
> > 
> > all emit that a single or missing name is unusual.
> 
> Perhaps. But adding email addresses is not the topic of this patch.

Just another possible improvement if you're feeling energetic.

cheers, Joe
