Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826E4C43382
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 23:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3262E20989
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 23:30:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3262E20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lxorguk.ukuu.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbeIYFf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 01:35:27 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:41116 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbeIYFf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 01:35:26 -0400
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id w8ONUiac018122;
        Tue, 25 Sep 2018 00:30:45 +0100
Date:   Tue, 25 Sep 2018 00:30:44 +0100
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     Jeff Layton <jlayton@redhat.com>
Cc:     =?UTF-8?B?54Sm5pmT5Yas?= <milestonejxd@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rogier Wolff <R.E.Wolff@BitWizard.nl>
Subject: Re: POSIX violation by writeback error
Message-ID: <20180925003044.239531c7@alans-desktop>
In-Reply-To: <486f6105fd4076c1af67dae7fdfe6826019f7ff4.camel@redhat.com>
References: <CAJDTihx2yaR-_-9Ks1PoFcrKNZgUOoLdN-wRTTMV76Jg_dCLrw@mail.gmail.com>
        <486f6105fd4076c1af67dae7fdfe6826019f7ff4.camel@redhat.com>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> write()
> kernel attempts to write back page and fails
> page is marked clean and evicted from the cache
> read()
> 
> Now your write is gone and there were no calls between the write and
> read.
> 
> The question we still need to answer is this:
> 
> When we attempt to write back some data from the cache and that fails,
> what should happen to the dirty pages?

Why do you care about the content of the pages at that point. The only
options are to use the data (todays model), or to report that you are on
fire.

If you are going to error you don't need to use the data so you could in
fact compress dramatically the amount of stuff you need to save
somewhere. You need the page information so you can realize what page
this is, but you can point the data into oblivion somewhere because you
are no longer going to give it to anyone (assuming you can successfully
force unmap it from everyone once it's not locked by a DMA or similar).

In the real world though it's fairly unusual to just lose a bit of I/O.
Flash devices in particular have a nasty tendancy to simply go *poof* and
the first you know about an I/O error is the last data the drive ever
gives you short of jtag. NFS is an exception and NFS soft timeouts are
nasty.

Alan
