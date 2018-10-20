Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308DCC67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 12:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D90D82145D
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 12:27:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D90D82145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbeJTUhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 16:37:21 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50874 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727289AbeJTUhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 16:37:21 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gDqLK-0004xv-5e; Sat, 20 Oct 2018 12:26:58 +0000
Date:   Sat, 20 Oct 2018 13:26:58 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Alan Jenkins <alan.christopher.jenkins@gmail.com>
Cc:     David Howells <dhowells@redhat.com>, torvalds@linux-foundation.org,
        ebiederm@xmission.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mszeredi@redhat.com
Subject: Re: [PATCH 03/34] teach move_mount(2) to work with OPEN_TREE_CLONE
 [ver #12]
Message-ID: <20181020122658.GN32577@ZenIV.linux.org.uk>
References: <97872123-70be-2833-ea7a-a463ce204b53@gmail.com>
 <862e36a2-2a6f-4e26-3228-8cab4b4cf230@gmail.com>
 <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
 <153754743491.17872.12115848333103740766.stgit@warthog.procyon.org.uk>
 <de050902-f3d0-b2db-2627-983a36c87b3c@gmail.com>
 <6518.1539956277@warthog.procyon.org.uk>
 <29902.1539988579@warthog.procyon.org.uk>
 <209e8c35-d26e-0a29-84d7-b8b1d0ecbebc@gmail.com>
 <20181020114826.GM32577@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181020114826.GM32577@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 20, 2018 at 12:48:26PM +0100, Al Viro wrote:

> Not just refcounting; it's that fs_pin is really intended to have ->kill()
> triggered only once.  If you look at the pin_kill() (which is where the
> livelock happened)

More specifically, it's group_pin_kill() assuming that by the time pin_kill()
returns it either will have called to pin_remove() or will have waited for
one to complete.  Either way, the object will be gone from the list, so we
do get progress.  Livelock comes since the object has already been through
pin_remove() once and then got reinserted into the list.  Now pin_kill()
returns immediately and we keep spinning on the element that doesn't go
away.
