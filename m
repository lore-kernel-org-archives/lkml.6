Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FE8ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFB3B20645
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:11:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFB3B20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbeJSURN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 16:17:13 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:60350 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbeJSURN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 16:17:13 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 7299572CC59;
        Fri, 19 Oct 2018 15:11:21 +0300 (MSK)
Received: from sole.flsd.net (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 5D8D74A4A16;
        Fri, 19 Oct 2018 15:11:21 +0300 (MSK)
Date:   Fri, 19 Oct 2018 15:11:21 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Jonathan Corbet <corbet@lwn.net>, Shaohua Li <shli@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org
Subject: Re: [dm-devel] [PATCH] dm: add secdel target
Message-ID: <20181019121121.k6nv6we37y52ymuc@sole.flsd.net>
References: <20181014112439.8119-1-vt@altlinux.org>
 <20181019061945.GA7403@infradead.org>
 <20181019114944.syemvziebwfuruof@sole.flsd.net>
 <20181019120033.GA7869@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20181019120033.GA7869@infradead.org>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 05:00:33AM -0700, Christoph Hellwig wrote:
> On Fri, Oct 19, 2018 at 02:49:44PM +0300, Vitaly Chikunov wrote:
> > On Thu, Oct 18, 2018 at 11:19:45PM -0700, Christoph Hellwig wrote:
> > > Just as a note:  the name is a complete misowner, a couple overwrite
> > > are not in any way secure deletion.  So naming it this way and exposing
> > > this as erase is a problem that is going to get back to bite us.
> > 
> > In what way it's not secure deletion?
> > 
> > It's secure deletion by overwriting discarded data instead of leaving it
> > as is.
> 
> Overwriting data does not delete data.  Most certainly not in Flash based
> SSDs, but also not in many storage arrays, or for that matter many modern
> disks that have sectore remapping and various kinds of non-volatile
> caches.  There is a reason why devices tend to have special commands to
> perform secure erase - depending on the media they might or might not
> overwrite internally, but at least they do it in a way that actually
> works for the given media and device configuration.

I know that. This is why it says "The target does not try to determine
if the underlying drive reliably support data overwrites, this decision
is solely on the discretion of a user. Please note that not all drivers
support this ability."


> > dm-erase or dm-wipe? dm-discerase?
> 
> dm-overwrite?

These are all good to me.

> 
> > But still provide REQ_OP_SECURE_ERASE support?
> 
> On the one hand that is highly misleading and would warrant a warning
> (see above), on the other hand discard is purely advisory and can be
> skipped any time, including by intermediate layers.  So I don't think
> you can actually do what you want without major changes to the whole
> I/O stack.

Probably, a concerned user should test his setup to be sure discards
reach dm-secdel (after that they go as writes), and data he thinks
should be erased is erased.
