Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E22C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3F9F21531
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:25:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3F9F21531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732857AbeITUIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 16:08:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35028 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731135AbeITUIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 16:08:50 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5A23D308FF2F;
        Thu, 20 Sep 2018 14:25:06 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 68BA7600C8;
        Thu, 20 Sep 2018 14:25:05 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id w8KEP4BU021815;
        Thu, 20 Sep 2018 10:25:04 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id w8KEP1jR021811;
        Thu, 20 Sep 2018 10:25:02 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Thu, 20 Sep 2018 10:25:01 -0400 (EDT)
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
In-Reply-To: <1537388512.21380.44.camel@arista.com>
Message-ID: <alpine.LRH.2.02.1809201024520.21787@file01.intranet.prod.int.rdu2.redhat.com>
References: <20180917235258.5719-1-dima@arista.com>   <alpine.LRH.2.02.1809191256060.9689@file01.intranet.prod.int.rdu2.redhat.com>   <alpine.LRH.2.02.1809191330590.19146@file01.intranet.prod.int.rdu2.redhat.com>  <1537379148.21380.16.camel@arista.com> 
 <alpine.LRH.2.02.1809191602230.16174@file01.intranet.prod.int.rdu2.redhat.com> <1537388512.21380.44.camel@arista.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 20 Sep 2018 14:25:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 19 Sep 2018, Dmitry Safonov wrote:

> On Wed, 2018-09-19 at 16:03 -0400, Mikulas Patocka wrote:
> > 
> > On Wed, 19 Sep 2018, Dmitry Safonov wrote:
> > > Thanks much for the testing, Mikulas.
> > > Could you try to bisect which of the patches causes it?
> > > The most important are 1,2,3 - probably, one of them caused it..
> > > I'll stare a bit into the code.
> > 
> > The patch 3 causes it.
> > 
> > The hangs during reboot take either 80 seconds, 3 minutes or 3:25.
> 
> Thanks much for that again.
> Any chance you have sysrq enabled and could print: locks held in system
> and kernel backtraces for applications?

Stacktrace doesn't work on parisc. It used to work on 4.18, but the kernel
4.19 reportedly requires patched binutils.

Mikulas

> I suppose, userspace hangs in n_tty_receive_buf_common(), which is
> better of cause than null-ptr dereference, but I believe we can improve
> it by stopping a reader earlier if there is any writer pending.
> 
> -- 
> Thanks,
>              Dmitry
> 
