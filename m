Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6729FC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 11:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 237B720843
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 11:11:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 237B720843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbeIYRSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 13:18:44 -0400
Received: from smtprelay0078.hostedemail.com ([216.40.44.78]:52195 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727114AbeIYRSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 13:18:43 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 18E7B181D337B;
        Tue, 25 Sep 2018 11:11:41 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: paint45_82f30a4c65031
X-Filterd-Recvd-Size: 3365
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Tue, 25 Sep 2018 11:11:39 +0000 (UTC)
Message-ID: <086cc82aed26b082fbe5eefc0eeae2ec634e4a1a.camel@perches.com>
Subject: Re: [PATCH 3.18 104/105] IB/nes: Fix a compiler warning
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Date:   Tue, 25 Sep 2018 04:11:38 -0700
In-Reply-To: <20180925085558.GA22609@kroah.com>
References: <20180924113113.268650190@linuxfoundation.org>
         <20180924113123.002918395@linuxfoundation.org>
         <6f7ca3c205bada768c3918b1feacbbd5ce23a64d.camel@perches.com>
         <20180924175902.GB19402@kroah.com>
         <6d6f31c87b0c9b1a551d352439183c8c9c4df04c.camel@perches.com>
         <20180924223952.GA9157@sasha-vm> <20180925085558.GA22609@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-09-25 at 10:55 +0200, Greg Kroah-Hartman wrote:
> On Mon, Sep 24, 2018 at 10:39:53PM +0000, Sasha Levin wrote:
> > On Mon, Sep 24, 2018 at 11:03:25AM -0700, Joe Perches wrote:
> > > On Mon, 2018-09-24 at 19:59 +0200, Greg Kroah-Hartman wrote:
> > > > On Mon, Sep 24, 2018 at 09:38:26AM -0700, Joe Perches wrote:
> > > > > On Mon, 2018-09-24 at 13:34 +0200, Greg Kroah-Hartman wrote:
> > > > > > 3.18-stable review patch.  If anyone has any objections, please let me know.
> > > > > 
> > > > > Why should this sort of change be applied to a stable release?
> > > > 
> > > > Originally I was just going to drop this as it's not fixing something.
> > > > 
> > > > But it might be, if that macro is used in a if() statement, or something
> > > > like that, it could be doing something unintended.
> > > 
> > > No it couldn't.
> > > An empty macro is equivalent to a single statement.
> > > 
> > > > So I don't feel like auditing all 500+ instances where this is used,
> > > > it's easier to just accept the patch.
> > > 
> > > It's not a bug fix.
> > 
> > This question came up a few months ago. Greg suggested that we should be
> > pulling in warning fixes to get the stable kernels warning-free similar
> > to upstream.
> > 
> > The reasoning behind it was similar to the "no warnings" reasoning of
> > upstream: there might be real issues hiding in the sea of "harmless"
> > warnings, so we want to get rid of all of them to catch real issues.
> 
> No warnings is great,

I believe that is not necessarily true.

Change to a new compiler version and new warnings could be
added somewhat arbitrarily.

-stable changes should be limited to things that actually
fix somewhat important code defects, and should not accept
the equivalent of whitespace changes unless those changes
also make backporting actual defect changes easier.

> > but not when you add the "W=1" option.  That way
> lies madness and is not something anyone does on stable kernels.  They
> do it on mainline when they want to try to find something to clean up
> and get a coding style fix merged :)

