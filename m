Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2677CC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC2FA208EB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:28:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC2FA208EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934222AbeGJP2A (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:28:00 -0400
Received: from smtprelay0074.hostedemail.com ([216.40.44.74]:48766 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933374AbeGJP17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:27:59 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 04C3283F8;
        Tue, 10 Jul 2018 15:27:59 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: songs83_457b17684db3f
X-Filterd-Recvd-Size: 2744
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Tue, 10 Jul 2018 15:27:57 +0000 (UTC)
Message-ID: <9c95ae2b06524a6638f26d61d7efe4afc86f877b.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Require author Signed-off-by
From:   Joe Perches <joe@perches.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Andy Whitcroft <apw@canonical.com>, jgg@mellanox.com,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linus Walleij <linus.walleij@linaro.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 10 Jul 2018 08:27:56 -0700
In-Reply-To: <CAMuHMdV34P+2=-Myfzdv1-+4m2_cTHQcQO80fZ5Ai+G9J6X0kA@mail.gmail.com>
References: <20180710121014.31119-1-geert+renesas@glider.be>
         <e4e25250dbea658f25dcf10504f3147731b5d2e9.camel@perches.com>
         <CAMuHMdV34P+2=-Myfzdv1-+4m2_cTHQcQO80fZ5Ai+G9J6X0kA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-10 at 17:07 +0200, Geert Uytterhoeven wrote:
> Hi Joe,

Hi Geert

> On Tue, Jul 10, 2018 at 4:34 PM Joe Perches <joe@perches.com> wrote:
> > On Tue, 2018-07-10 at 14:10 +0200, Geert Uytterhoeven wrote:
> > > Print an error if none of the Signed-off-by lines cover the patch
> > > author.
> > 
> > []
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > 
> > []
> > > @@ -13,6 +13,7 @@ use POSIX;
> > >  use File::Basename;
> > >  use Cwd 'abs_path';
> > >  use Term::ANSIColor qw(:constants);
> > > +use MIME::Words 'decode_mimewords';
> > 
> > Is this a typically installed perl module?
> > If so, what perl version installed it by default?
> 
> I don't know. At least my Ubuntu 16.04LTS and 18.04LTS systems had it
> installed.
> It does not seem to be part of the core modules, cfr.
> https://perldoc.perl.org/index-modules-M.html
> 
> I've tried using MIME::QuotedPrint instead, but then we need to parse
> =?UTF-8?q? ourselves, as decode_qp() only transforms the actual
> quoted printable bits in side the encoded From: address.

I'd looked too and couldn't find it from 5.10 forward,
so I'd prefer not requiring that module.

Also, the From: line is also an email header and I don't
believe it should be used author information in the
same way as a patch From: line.

So likely the

+# Check the patch for a From:
+               if ($line =~ /^\s*From: (.*)/i) {

should be "if ($in_commit_log && $line =~ /^\s*From: (.*)/) {

with some regex or function to remove the MIME encoded word.
