Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D750C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 07:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69FC320873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 07:37:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69FC320873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbeLMHhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 02:37:18 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50665 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbeLMHhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 02:37:17 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gXLYU-0001kV-Hr; Thu, 13 Dec 2018 08:37:10 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gXLYS-0008KV-Ir; Thu, 13 Dec 2018 08:37:08 +0100
Date:   Thu, 13 Dec 2018 08:37:08 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jeremy Cline <jcline@redhat.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] scripts/spdxcheck.py: Always open files in binary
 mode
Message-ID: <20181213073708.nwj4nmnccuugvrhc@pengutronix.de>
References: <20181212131210.28024-1-thierry.reding@gmail.com>
 <20181212181410.GC2352@laptop.jcline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181212181410.GC2352@laptop.jcline.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 01:14:10PM -0500, Jeremy Cline wrote:
> Hi,
> 
> On Wed, Dec 12, 2018 at 02:12:09PM +0100, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> > 
> > The spdxcheck script currently falls over when confronted with a binary
> > file (such as Documentation/logo.gif). To avoid that, always open files
> > in binary mode and decode line-by-line, ignoring encoding errors.

I suggest pointing out that the breakage only happens with python3 and
results in a UnicodeDecodeError.

> > One tricky case is when piping data into the script and reading it from
> > standard input. By default, standard input will be opened in text mode,
> > so we need to reopen it in binary mode.
> > 
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >  scripts/spdxcheck.py | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/scripts/spdxcheck.py b/scripts/spdxcheck.py
> > index 5056fb3b897d..e559c6294c39 100755
> > --- a/scripts/spdxcheck.py
> > +++ b/scripts/spdxcheck.py
> > @@ -168,6 +168,7 @@ class id_parser(object):
> >          self.curline = 0
> >          try:
> >              for line in fd:
> > +                line = line.decode(locale.getpreferredencoding(False), errors='ignore')
> >                  self.curline += 1
> >                  if self.curline > maxlines:
> >                      break
> > @@ -249,12 +250,13 @@ if __name__ == '__main__':
> >  
> >      try:
> >          if len(args.path) and args.path[0] == '-':
> > -            parser.parse_lines(sys.stdin, args.maxlines, '-')
> > +            stdin = os.fdopen(sys.stdin.fileno(), 'rb')
> > +            parser.parse_lines(stdin, args.maxlines, '-')
> >          else:
> >              if args.path:
> >                  for p in args.path:
> >                      if os.path.isfile(p):
> > -                        parser.parse_lines(open(p), args.maxlines, p)
> > +                        parser.parse_lines(open(p, 'rb'), args.maxlines, p)
> >                      elif os.path.isdir(p):
> >                          scan_git_subtree(repo.head.reference.commit.tree, p)
> >                      else:
> > -- 
> > 2.19.1
> > 
> 
> It might be worth noting this fixes commit 6f4d29df66ac
> ("scripts/spdxcheck.py: make python3 compliant") and also Cc this for
> stable since 6f4d29df66ac got backported to v4.19. While that commit
> did indeed make the script work with Python 3 for piping data, it broke
> Python 2 and made its way to stable.

It didn't break for me. Can you provide details about how and when it
broke for you?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
