Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F3FC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8DA123EF9
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:41:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8DA123EF9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933272AbeGFPlk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 11:41:40 -0400
Received: from smtprelay0046.hostedemail.com ([216.40.44.46]:37069 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932598AbeGFPlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 11:41:39 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 66687837F252;
        Fri,  6 Jul 2018 15:41:38 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: wren80_6568795dfd700
X-Filterd-Recvd-Size: 2685
Received: from XPS-9350 (unknown [172.56.31.78])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Fri,  6 Jul 2018 15:41:36 +0000 (UTC)
Message-ID: <6aad533106ce750ee7a7ce3e507d7de37d132dc0.camel@perches.com>
Subject: Re: [PATCH 2/6] device: Add #define dev_fmt similar to #define
 pr_fmt
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 06 Jul 2018 08:41:34 -0700
In-Reply-To: <20180706153028.GA6838@kroah.com>
References: <cover.1525878372.git.joe@perches.com>
         <3f213f4f9ee604c1797af67360d8da1836b34271.1525878372.git.joe@perches.com>
         <20180706153028.GA6838@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-07-06 at 17:30 +0200, Greg Kroah-Hartman wrote:
> On Wed, May 09, 2018 at 08:15:46AM -0700, Joe Perches wrote:
> > Add a prefixing macro to dev_<level> uses similar to the pr_fmt
> > prefixing macro used in pr_<level> calls.
> > 
> > This can help avoid some string duplication in dev_<level> uses.
> > 
> > The default, like pr_fmt, is an empty #define dev_fmt(fmt) fmt
> > 
> > Rename the existing dev_<level> functions to _dev_<level> and
> > introduce #define dev_<level> _dev_<level> macros that use the
> > new #define dev_fmt
> > 
> > Miscellanea:
> > 
> > o Consistently use #defines with fmt, ... and ##__VA_ARGS__
> > o Remove unnecessary externs
> 
> SHouldn't these be separate patches please?

Multiple patches touching the same lines are unnecessary work.

So I don't think so as it's just touching bits that need change
anyway.  

> > Signed-off-by: Joe Perches <joe@perches.com>
> > ---
> >  drivers/base/core.c    |  12 +++---
> >  include/linux/device.h | 103 ++++++++++++++++++++++++++++---------------------
> >  2 files changed, 64 insertions(+), 51 deletions(-)
> 
> Ok this seems like a lot of churn for no real apparent gain.  What is
> all of this getting us?
>
> What is the benifit, you have more code now,
> why is that good?

IPMI and a few other subsystems prefix all their output
dev_<level> with specific duplicated content.

This centralizes those prefixes just like pr_fmt.

The IPMI changes are already in mainline and now
need this mechanism to maintain their output content.

IPMI and a few other subsystems prefix all their output
dev_<level> with specific duplicated content.

This centralizes those prefixes just like pr_fmt.

commit a2d70dfdda6f ("ipmi: msghandler: Add and use pr_fmt and dev_fmt,
remove PFX")


