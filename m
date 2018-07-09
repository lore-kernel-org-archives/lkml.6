Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D549C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 23:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 728CF208A2
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 23:44:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 728CF208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933375AbeGIXow (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 19:44:52 -0400
Received: from gate.crashing.org ([63.228.1.57]:58096 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932847AbeGIXou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 19:44:50 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w69NiXMK024595;
        Mon, 9 Jul 2018 18:44:34 -0500
Message-ID: <c105fb1ff12533b4980098ecd411089e0630b6bf.camel@kernel.crashing.org>
Subject: Re: [PATCH 1/2] drivers: core: Don't try to use a dead glue_dir
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Joel Stanley <joel@jms.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 10 Jul 2018 09:44:33 +1000
In-Reply-To: <20180707164838.GC16279@kroah.com>
References: <c40fe912fe008b1b531a3867e8784ed79d68023e.camel@kernel.crashing.org>
         <CA+55aFxR0qg0yY-NWnH0DDruVWw8qRqp8=CRLq13p=TyxosJKw@mail.gmail.com>
         <828fb935c0cd04e74a09b8ed2b78aca405d7c5b2.camel@kernel.crashing.org>
         <CA+55aFwg+j60ZFi7t7kVXbobCT4XHoiZP_w6+Cbm+AeU1ytfNQ@mail.gmail.com>
         <20180707164838.GC16279@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-07-07 at 18:48 +0200, Greg Kroah-Hartman wrote:
> No, kobject_get() should never happen on a 0 refcount object.  That
> being said, the code does allow it, so if things are messed up, it will
> happen.  I think that change happened when the switch to refcount_t
> occured, before then we would WARN_ON() if that ever happened.  I should
> go fix that up, and restore that old behavior, so that syzbot starts
> complaining loudly when stuff like that hits.
> 
> So I hate using kobject_get_unless_zero(), and resisted ever adding it
> to the tree as it shows a bad locking/tree situation as you point out
> here.  But for some reason, the block developers seemed to insist they
> needed it, and so it is in the tree for them.  I don't want it to spread
> if at all possible, which makes me want to reject this patch as this
> should be "a case that can never be hit".

Except it can in that situation... at least unless you get my patch 2/2
(or the newer one I'm about to send that avoids adding a child counter
and uses the one in kernfs instead).

Ben.

