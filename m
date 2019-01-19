Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B6AC61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 19:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB6992086D
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 19:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbfASTpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 14:45:12 -0500
Received: from smtprelay0220.hostedemail.com ([216.40.44.220]:47963 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728981AbfASTpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 14:45:11 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 2EF2618031DBF;
        Sat, 19 Jan 2019 19:45:10 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: ball28_fe4dca09443e
X-Filterd-Recvd-Size: 2597
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Sat, 19 Jan 2019 19:45:09 +0000 (UTC)
Message-ID: <2324fe307d1e077225171e7436ff1a4fc96292f5.camel@perches.com>
Subject: Re: [PATCH] clang-format: Update .clang-format with the latest
 for_each macro list
From:   Joe Perches <joe@perches.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Sat, 19 Jan 2019 11:45:07 -0800
In-Reply-To: <CANiq72nAX=UjAZnmh7zk+0PUnGBfAjTUfZ1YsXmkeVZ+eMJuHQ@mail.gmail.com>
References: <20190118225658.GA28312@ziepe.ca>
         <CANiq72=o_7d63MXJJn6dEnt76viF0YV4svp-5VBHk7JKyjXJDw@mail.gmail.com>
         <a5eab6ca68ee1eb837c8c86b69b4696846af719b.camel@perches.com>
         <CANiq72nAX=UjAZnmh7zk+0PUnGBfAjTUfZ1YsXmkeVZ+eMJuHQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-01-19 at 20:32 +0100, Miguel Ojeda wrote:
> Hi Joe,
> 
> On Sat, Jan 19, 2019 at 8:06 PM Joe Perches <joe@perches.com> wrote:
> > This misses all the directory/file specific #defines
> > outside of include/ with for_each
> 
> Indeed, the command only searches the include/ directory, but when
> searching for the entire tree, it returns ~500 more entries (vs. the
> ~300 original ones). I cannot recall if there was a reason to search
> only inside include/, though.
> 
> > $ git grep "#define.*for_each" | grep -v '^include' | wc -l
> > 619
> > 
> > Is it possible to make this generic somehow instead?
> > Perhaps extend .clang_format with regexes?
> > 
> > (?:[a-z0-9_]+_)?for_each(?:_[a-z_]+)
> > [a-z0-9_]+_for_each
> 
> What do you mean?

Documentation for .clang-format shows
https://clang.llvm.org/docs/ClangFormatStyleOptions.html

   ForEachMacros (std::vector<std::string>)

       A vector of macros that should be interpreted as foreach loops instead of as function calls.

       These are expected to be macros of the form:

       FOREACH(<variable-declaration>, ...)
         <loop-body>

       In the .clang-format configuration file, this can be configured like:

       ForEachMacros: ['RANGES_FOR', 'FOREACH']

       For example: BOOST_FOREACH.

I suggest clang-format's ForEachMacros statement vector
be expanded to support regexes ala

ForEachMacros:
  - Regex:           '\b(?:(?:[a-z0-9_]+_)?for_each(?:_[a-z_]+)|[a-z0-9_]+_for_each)\b'


