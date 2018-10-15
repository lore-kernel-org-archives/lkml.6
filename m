Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6EEC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 13:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED9F2083C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 13:37:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ED9F2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbeJOVXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 17:23:17 -0400
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:48478 "EHLO
        emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbeJOVXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 17:23:17 -0400
Received: from ydin.reaktio.net (reaktio.net [85.76.255.15])
        by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 1B2A1B00B2;
        Mon, 15 Oct 2018 16:37:52 +0300 (EEST)
Received: by ydin.reaktio.net (Postfix, from userid 1001)
        id 03FD736C0F6; Mon, 15 Oct 2018 16:37:52 +0300 (EEST)
Date:   Mon, 15 Oct 2018 16:37:51 +0300
From:   Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Daniel Axtens <dja@axtens.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Neuling <mikey@neuling.org>,
        Nathan March <nathan@gt.net>,
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
Message-ID: <20181015133751.GO5318@reaktio.net>
References: <20180917235258.5719-1-dima@arista.com>
 <alpine.LRH.2.02.1809191256060.9689@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.1809191330590.19146@file01.intranet.prod.int.rdu2.redhat.com>
 <1537379148.21380.16.camel@arista.com>
 <alpine.LRH.2.02.1809191602230.16174@file01.intranet.prod.int.rdu2.redhat.com>
 <1537388512.21380.44.camel@arista.com>
 <alpine.LRH.2.02.1809201024520.21787@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.1809201024520.21787@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Sep 20, 2018 at 10:25:01AM -0400, Mikulas Patocka wrote:
> 
> 
> On Wed, 19 Sep 2018, Dmitry Safonov wrote:
> 
> > On Wed, 2018-09-19 at 16:03 -0400, Mikulas Patocka wrote:
> > > 
> > > On Wed, 19 Sep 2018, Dmitry Safonov wrote:
> > > > Thanks much for the testing, Mikulas.
> > > > Could you try to bisect which of the patches causes it?
> > > > The most important are 1,2,3 - probably, one of them caused it..
> > > > I'll stare a bit into the code.
> > > 
> > > The patch 3 causes it.
> > > 
> > > The hangs during reboot take either 80 seconds, 3 minutes or 3:25.
> > 
> > Thanks much for that again.
> > Any chance you have sysrq enabled and could print: locks held in system
> > and kernel backtraces for applications?
> 
> Stacktrace doesn't work on parisc. It used to work on 4.18, but the kernel
> 4.19 reportedly requires patched binutils.
> 
> Mikulas
> 
> > I suppose, userspace hangs in n_tty_receive_buf_common(), which is
> > better of cause than null-ptr dereference, but I believe we can improve
> > it by stopping a reader earlier if there is any writer pending.
> > 
> > -- 
> > Thanks,
> >              Dmitry
> > 

Any progress here? Or is more info/stacktrace needed about the hang?


Thanks,

-- Pasi

