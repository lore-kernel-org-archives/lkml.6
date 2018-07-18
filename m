Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACEF1ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E1AC2075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:55:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E1AC2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730329AbeGRWfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 18:35:08 -0400
Received: from smtprelay0133.hostedemail.com ([216.40.44.133]:36695 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727131AbeGRWfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 18:35:08 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id A5EA4180A8122;
        Wed, 18 Jul 2018 21:55:15 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cause81_8515f7cf95d0c
X-Filterd-Recvd-Size: 3914
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Wed, 18 Jul 2018 21:55:14 +0000 (UTC)
Message-ID: <cf3a1d6b64050bb51328305dd8a3bd01abffa9c9.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: Only encode UTF-8 quoted printable mail
 headers
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Andy Whitcroft <apw@canonical.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org
Date:   Wed, 18 Jul 2018 14:55:13 -0700
In-Reply-To: <20180718144222.fc567d972447348b419edcd9@linux-foundation.org>
References: <20180718145254.4770-1-geert+renesas@glider.be>
         <20180718144222.fc567d972447348b419edcd9@linux-foundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-18 at 14:42 -0700, Andrew Morton wrote:
> On Wed, 18 Jul 2018 16:52:54 +0200 Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> 
> > As PERL uses its own internal character encoding, always calling
> > encode("utf8", ...) on the author name may cause corruption, leading to
> > an author signoff mismatch.
> > 
> > This happens in the following cases:
> >   - If a patch is in ISO-8859, and contains a non-ASCII author name in
> >     the From: line, it is converted to UTF-8, while the Signed-off-by
> >     line will still be in ISO-8859.
> >   - If a patch is in UTF-8, and contains a non-ASCII author name in the
> >     body (not header) From: line, it is assumed to be encoded in PERL's
> >     internal character encoding, and converted to UTF-8 incorrectly,
> >     while the Signed-off-by line will be in real UTF-8.
> > 
> > Fix this by only doing the encode step if the From: line used UTF-8
> > quoted printable encoding.
> 
> Works for me, thanks.

Me too so far, but I've more testing I'd like to do.

> Relatedly, would it be worth adding a checkpatch warning if a patch
> contains anything other than ASCII or UTF-8?
> 
> I added this to my little local patch-checking script.
> 
> 	if ! file $p | grep -q -P "ASCII text|Unicode text"
> 	then
> 		echo $p: weird charset
> 	fi

Might be hard to be effective.

For instance, the lkml mail I've kept so far this year
has a mixture of ascii/utf-8/iso-8859/windows-1252 and
some others with a few different encodings used too.

$ grep -Poh "\bcharset=\S+" ~/.local/share/evolution/mail/local/.MailingLists.Linux-Kernel/cur/*|cut -f3- -d:|sort|uniq -c|sort -rn
    821 charset=us-ascii
    469 charset="UTF-8"
    394 charset="ISO-8859-1"
    252 charset=US-ASCII
    221 charset=utf-8
    118 charset=utf-8;
     97 charset="utf-8"
     66 charset=UTF-8
     60 charset="us-ascii"
     33 charset=ISO-8859-15
     24 charset=iso-8859-1
     18 charset=US-ASCII;
     11 charset=us-ascii;
      7 charset=windows-1252;
      7 charset="utf-8";
      6 charset="UTF-8";
      5 charset=windows-1252
      5 charset="iso-8859-1"
      4 charset="windows-1252"
      3 charset=UTF-8;
      3 charset="US-ASCII"
      2 charset="iso-2022-jp"
      2 charset=gbk;
      2 charset="gb2312"
      1 charset="utf-7"
      1 charset="iso-8859-15"
      1 charset=ISO-8859-1
      1 charset="gbk";

And

$ grep "^Content-Transfer-Encoding:" ~/.local/share/evolution/mail/local/.MailingLists.Linux-Kernel/cur/*|cut -f3- -d:|sort|uniq -c|sort -rn
    873 Content-Transfer-Encoding: 7bit
    212 Content-Transfer-Encoding: 8bit
     97 Content-Transfer-Encoding: quoted-printable
     63 Content-Transfer-Encoding: base64
     56 Content-Transfer-Encoding: 8BIT
     24 Content-Transfer-Encoding: 7Bit
      3 Content-Transfer-Encoding: 7BIT
      2 Content-Transfer-Encoding: QUOTED-PRINTABLE

