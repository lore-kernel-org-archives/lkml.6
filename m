Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B444CC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76B5D20851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:10:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76B5D20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbeLMPK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 10:10:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38750 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727618AbeLMPK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 10:10:56 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 723548831D;
        Thu, 13 Dec 2018 15:10:55 +0000 (UTC)
Received: from laptop.jcline.org (ovpn-122-11.rdu2.redhat.com [10.10.122.11])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DD5F55C221;
        Thu, 13 Dec 2018 15:10:54 +0000 (UTC)
Received: from laptop.jcline.org (localhost [IPv6:::1])
        by laptop.jcline.org (Postfix) with ESMTPS id 0B53F468ED5E;
        Thu, 13 Dec 2018 10:10:54 -0500 (EST)
Date:   Thu, 13 Dec 2018 10:10:52 -0500
From:   Jeremy Cline <jcline@redhat.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] scripts/spdxcheck.py: Always open files in binary
 mode
Message-ID: <20181213151052.GA13313@laptop.jcline.org>
References: <20181212131210.28024-1-thierry.reding@gmail.com>
 <20181212181410.GC2352@laptop.jcline.org>
 <20181213073708.nwj4nmnccuugvrhc@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181213073708.nwj4nmnccuugvrhc@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 13 Dec 2018 15:10:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 08:37:08AM +0100, Uwe Kleine-König wrote:
> On Wed, Dec 12, 2018 at 01:14:10PM -0500, Jeremy Cline wrote:
> > Hi,
> > 
> > On Wed, Dec 12, 2018 at 02:12:09PM +0100, Thierry Reding wrote:
> > > From: Thierry Reding <treding@nvidia.com>
> > > 
> > > The spdxcheck script currently falls over when confronted with a binary
> > > file (such as Documentation/logo.gif). To avoid that, always open files
> > > in binary mode and decode line-by-line, ignoring encoding errors.
> 
> I suggest pointing out that the breakage only happens with python3 and
> results in a UnicodeDecodeError.
> 
> > > One tricky case is when piping data into the script and reading it from
> > > standard input. By default, standard input will be opened in text mode,
> > > so we need to reopen it in binary mode.
> > > 
> > > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > > ---
> > >  scripts/spdxcheck.py | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/scripts/spdxcheck.py b/scripts/spdxcheck.py
> > > index 5056fb3b897d..e559c6294c39 100755
> > > --- a/scripts/spdxcheck.py
> > > +++ b/scripts/spdxcheck.py
> > > @@ -168,6 +168,7 @@ class id_parser(object):
> > >          self.curline = 0
> > >          try:
> > >              for line in fd:
> > > +                line = line.decode(locale.getpreferredencoding(False), errors='ignore')
> > >                  self.curline += 1
> > >                  if self.curline > maxlines:
> > >                      break
> > > @@ -249,12 +250,13 @@ if __name__ == '__main__':
> > >  
> > >      try:
> > >          if len(args.path) and args.path[0] == '-':
> > > -            parser.parse_lines(sys.stdin, args.maxlines, '-')
> > > +            stdin = os.fdopen(sys.stdin.fileno(), 'rb')
> > > +            parser.parse_lines(stdin, args.maxlines, '-')
> > >          else:
> > >              if args.path:
> > >                  for p in args.path:
> > >                      if os.path.isfile(p):
> > > -                        parser.parse_lines(open(p), args.maxlines, p)
> > > +                        parser.parse_lines(open(p, 'rb'), args.maxlines, p)
> > >                      elif os.path.isdir(p):
> > >                          scan_git_subtree(repo.head.reference.commit.tree, p)
> > >                      else:
> > > -- 
> > > 2.19.1
> > > 
> > 
> > It might be worth noting this fixes commit 6f4d29df66ac
> > ("scripts/spdxcheck.py: make python3 compliant") and also Cc this for
> > stable since 6f4d29df66ac got backported to v4.19. While that commit
> > did indeed make the script work with Python 3 for piping data, it broke
> > Python 2 and made its way to stable.
> 
> It didn't break for me. Can you provide details about how and when it
> broke for you?

I was wrong about it being Python 2 that broke, sorry about that.
6f4d29df66ac broke Python 3 when you run it against a sub-tree because
scan_git_tree() opens the files in binary mode, but then find is run
with a text string:

$ python3 scripts/spdxcheck.py net/
FAIL: argument should be integer or bytes-like object, not 'str'
Traceback (most recent call last):
  File "scripts/spdxcheck.py", line 259, in <module>
    scan_git_subtree(repo.head.reference.commit.tree, p)
  File "scripts/spdxcheck.py", line 211, in scan_git_subtree
    scan_git_tree(tree)
  File "scripts/spdxcheck.py", line 206, in scan_git_tree
    parser.parse_lines(fd, args.maxlines, el.path)
  File "scripts/spdxcheck.py", line 175, in parse_lines
    if line.find("SPDX-License-Identifier:") < 0:
TypeError: argument should be integer or bytes-like object, not 'str'

The reason I opened things in binary mode when I started adding Python 3
support was because not all files were valid UTF-8 (and some were
binary) so I decoded the text line-by-line and ignored any decoding
errors for simplicity's sake.

Regards,
Jeremy
