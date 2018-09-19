Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26805ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3FE82150E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:03:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3FE82150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732466AbeITBnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 21:43:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57202 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731368AbeITBnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 21:43:18 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6B7F31E2D5;
        Wed, 19 Sep 2018 20:03:47 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 318A1176DC;
        Wed, 19 Sep 2018 20:03:46 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id w8JK3jZP016713;
        Wed, 19 Sep 2018 16:03:45 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id w8JK3fWo016709;
        Wed, 19 Sep 2018 16:03:41 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Wed, 19 Sep 2018 16:03:41 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Dmitry Safonov <dima@arista.com>
cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Daniel Axtens <dja@axtens.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Neuling <mikey@neuling.org>,
        Nathan March <nathan@gt.net>,
        =?ISO-8859-15?Q?Pasi_K=E4rkk=E4inen?= <pasik@iki.fi>,
        Peter Hurley <peter@hurleysoftware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rong, Chen" <rong.a.chen@intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Jiri Slaby <jslaby@suse.cz>,
        syzbot+3aa9784721dfb90e984d@syzkaller.appspotmail.com
Subject: Re: [PATCHv5 0/7] tty: Hold write ldisc sem in tty_reopen()
In-Reply-To: <1537379148.21380.16.camel@arista.com>
Message-ID: <alpine.LRH.2.02.1809191602230.16174@file01.intranet.prod.int.rdu2.redhat.com>
References: <20180917235258.5719-1-dima@arista.com>  <alpine.LRH.2.02.1809191256060.9689@file01.intranet.prod.int.rdu2.redhat.com>  <alpine.LRH.2.02.1809191330590.19146@file01.intranet.prod.int.rdu2.redhat.com> <1537379148.21380.16.camel@arista.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 19 Sep 2018 20:03:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 19 Sep 2018, Dmitry Safonov wrote:

> On Wed, 2018-09-19 at 13:35 -0400, Mikulas Patocka wrote:
> > 
> > On Wed, 19 Sep 2018, Mikulas Patocka wrote:
> > 
> > > 
> > > 
> > > On Tue, 18 Sep 2018, Dmitry Safonov wrote:
> > > 
> > > > Hi all,
> > > > 
> > > > Three fixes that worth to have in the @stable, as they were hit
> > by
> > > > different people, including Arista on v4.9 stable.
> > > > 
> > > > And for linux-next - adding lockdep asserts for line discipline
> > changing
> > > > code, verifying that write ldisc sem will be held forthwith.
> > > > 
> > > > The last patch is an optional and probably, timeout can be
> > dropped for
> > > > read_lock(). I'll do it if everyone agrees.
> > > > (Or as per discussion with Peter in v3, just convert ldisc to
> > > > a regular rwsem).
> > > > 
> > > > Thanks,
> > > > Dima
> > > 
> > > I confirm that this patch series fixes the crash for me.
> > > 
> > > Tested-by: Mikulas Patocka <mpatocka@redhat.com>
> > 
> > I was too quick to acknowledge this patchset. It doesn't work.
> > 
> > This patchset fixes the crash, but it introduces another bug - when I
> > type 
> > 'reboot' on the console, it prints 'INIT: Switching to runlevel: 6'
> > and 
> > then it gets stuck for 80 seconds before proceeding with the reboot.
> > When 
> > I revert this patchset 'reboot' reboots the machine without any
> > delay. 
> > This bug was reproduced on Debian 5 userspace on pa-risc.
> 
> Thanks much for the testing, Mikulas.
> Could you try to bisect which of the patches causes it?
> The most important are 1,2,3 - probably, one of them caused it..
> I'll stare a bit into the code.

The patch 3 causes it.

The hangs during reboot take either 80 seconds, 3 minutes or 3:25.

Mikulas
