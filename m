Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDF0C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E0DA20684
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:05:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E0DA20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbeIZCOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 22:14:25 -0400
Received: from smtprelay0222.hostedemail.com ([216.40.44.222]:34399 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726026AbeIZCOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 22:14:23 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 289A7180202FC;
        Tue, 25 Sep 2018 20:05:10 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bun38_8431ff521cb07
X-Filterd-Recvd-Size: 2403
Received: from XPS-9350 (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Tue, 25 Sep 2018 20:05:08 +0000 (UTC)
Message-ID: <748429eee2fc77afd01630c24bd2cf66a545aec5.camel@perches.com>
Subject: Re: [PATCH net-next v6 02/23] zinc: introduce minimal cryptography
 library
From:   Joe Perches <joe@perches.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andrew Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Date:   Tue, 25 Sep 2018 13:05:06 -0700
In-Reply-To: <CAHmME9qLzFHPm2aaEKOmjBA95-c3CZuT+kQiuksLRRWQ_ad2sw@mail.gmail.com>
References: <20180925145622.29959-1-Jason@zx2c4.com>
         <20180925145622.29959-3-Jason@zx2c4.com>
         <2b5f2df2f1278c118a913259a44efdf589719293.camel@perches.com>
         <CAHmME9qLzFHPm2aaEKOmjBA95-c3CZuT+kQiuksLRRWQ_ad2sw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-09-25 at 21:43 +0200, Jason A. Donenfeld wrote:
> On Tue, Sep 25, 2018 at 8:33 PM Joe Perches <joe@perches.com> wrote:
> > I think the -Dpr_fmt is especially odd and not
> > really acceptable as it not used anywhere else
> > in the kernel.
> 
> There are about 2000 cases in the kernel of the same '#define
> pr_fmt...' being pasted into the top of the file, which seems a bit
> cumbersome. Rather than having to paste that into each and every file
> that I pr_err from,

As far as I can tell, zinc doesn't use pr_err, just
pr_info in all the selftest blocks which are only
used when DEBUG is #defined.

Perhaps all the pr_info uses should use pr_debug
instead as well as dynamic debugging which already
optionally adds KBUILD_MODINFO.

>  why can't I just do this from the makefile, since
> I want that same pr_fmt to copy the whole directory?

Ideally all of those

#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

uses will be removed one day soon and the default
will change.

https://lore.kernel.org/patchwork/cover/904507/

This slightly odd use might complicate that.


