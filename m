Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A89DC67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16EA72086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:14:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16EA72086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbeLLSOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 13:14:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38210 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727799AbeLLSOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 13:14:14 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7C4B3C0C5A4E;
        Wed, 12 Dec 2018 18:14:13 +0000 (UTC)
Received: from laptop.jcline.org (ovpn-121-97.rdu2.redhat.com [10.10.121.97])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F2F260142;
        Wed, 12 Dec 2018 18:14:13 +0000 (UTC)
Received: from laptop.jcline.org (localhost [IPv6:::1])
        by laptop.jcline.org (Postfix) with ESMTPS id 1B933468ED5C;
        Wed, 12 Dec 2018 13:14:12 -0500 (EST)
Date:   Wed, 12 Dec 2018 13:14:10 -0500
From:   Jeremy Cline <jcline@redhat.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Joe Perches <joe@perches.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] scripts/spdxcheck.py: Always open files in binary
 mode
Message-ID: <20181212181410.GC2352@laptop.jcline.org>
References: <20181212131210.28024-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212131210.28024-1-thierry.reding@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 12 Dec 2018 18:14:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Dec 12, 2018 at 02:12:09PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The spdxcheck script currently falls over when confronted with a binary
> file (such as Documentation/logo.gif). To avoid that, always open files
> in binary mode and decode line-by-line, ignoring encoding errors.
> 
> One tricky case is when piping data into the script and reading it from
> standard input. By default, standard input will be opened in text mode,
> so we need to reopen it in binary mode.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  scripts/spdxcheck.py | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/spdxcheck.py b/scripts/spdxcheck.py
> index 5056fb3b897d..e559c6294c39 100755
> --- a/scripts/spdxcheck.py
> +++ b/scripts/spdxcheck.py
> @@ -168,6 +168,7 @@ class id_parser(object):
>          self.curline = 0
>          try:
>              for line in fd:
> +                line = line.decode(locale.getpreferredencoding(False), errors='ignore')
>                  self.curline += 1
>                  if self.curline > maxlines:
>                      break
> @@ -249,12 +250,13 @@ if __name__ == '__main__':
>  
>      try:
>          if len(args.path) and args.path[0] == '-':
> -            parser.parse_lines(sys.stdin, args.maxlines, '-')
> +            stdin = os.fdopen(sys.stdin.fileno(), 'rb')
> +            parser.parse_lines(stdin, args.maxlines, '-')
>          else:
>              if args.path:
>                  for p in args.path:
>                      if os.path.isfile(p):
> -                        parser.parse_lines(open(p), args.maxlines, p)
> +                        parser.parse_lines(open(p, 'rb'), args.maxlines, p)
>                      elif os.path.isdir(p):
>                          scan_git_subtree(repo.head.reference.commit.tree, p)
>                      else:
> -- 
> 2.19.1
> 

It might be worth noting this fixes commit 6f4d29df66ac
("scripts/spdxcheck.py: make python3 compliant") and also Cc this for
stable since 6f4d29df66ac got backported to v4.19. While that commit
did indeed make the script work with Python 3 for piping data, it broke
Python 2 and made its way to stable.

Reviewed-by: Jeremy Cline <jcline@redhat.com>

Regards,
Jeremy
