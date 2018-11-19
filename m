Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E7EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9DBB20823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:52:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9DBB20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbeKSXPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 18:15:47 -0500
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:58402 "EHLO
        emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728831AbeKSXPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 18:15:46 -0500
Received: from ydin.reaktio.net (reaktio.net [85.76.255.15])
        by emh01.mail.saunalahti.fi (Postfix) with ESMTP id 53B20200A7;
        Mon, 19 Nov 2018 14:52:08 +0200 (EET)
Received: by ydin.reaktio.net (Postfix, from userid 1001)
        id D343436C0F8; Mon, 19 Nov 2018 14:52:08 +0200 (EET)
Date:   Mon, 19 Nov 2018 14:52:08 +0200
From:   Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, stable@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        syzbot+3aa9784721dfb90e984d@syzkaller.appspotmail.com
Subject: Re: [PATCHv6 0/7] tty: Hold write ldisc sem in tty_reopen()
Message-ID: <20181119125208.GC15229@reaktio.net>
References: <20181101002452.5483-1-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181101002452.5483-1-dima@arista.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mikulas,

Any chance you could re-test these v6 patches? It seems you're able to relatively easily trigger the bug on your (pa-risc) environment.. I'd be good to have this series finally acked/merged!


Thanks a lot,

-- Pasi

On Thu, Nov 01, 2018 at 12:24:45AM +0000, Dmitry Safonov wrote:
> Hi all,
> 
> Here are fixes that worth to have in the @stable, as they were hit by
> different people, including Arista on v4.9 stable.
> 
> And for linux-next - adding lockdep asserts for line discipline changing
> code, verifying that write ldisc sem will be held forthwith.
> 
> Mikulas, can you add your tested-by on this patches set again, please?
> I tried to reproduce reboot issue on qemu-hppa and even built
> cross-compiler for pa-risc.. but was unlucky in reproducing.
> 
> Thanks,
> Dima
> 
> Changes since v5:
> - Better commit tags
> - Hopefully fixed issue with reboot on pa-risc with Debian 5
> 
> Changes since v4:
> - back to lock ldisc with (5*HZ) timeout in tty_reopen()
>   (LKP report link: lkml.kernel.org/r/<1536940609.3185.29.camel@arista.com>)
> - reordered 3/7 with 2/7 for LKP robot
> 
> Changes since v3:
> - Added tested-by Mark Rutland (thanks!)
> - Dropped patch with smp_wmb() - wrong idea
> - lockdep_assert_held() should be actually lockdep_assert_held_exclusive()
> - Described why tty_ldisc_open() can be called without ldisc_sem held
>   for pty slave end (o_tty).
> - Added Peter's patch for dropping self-made lockdep annotations
> - Fix for a reader(s) of ldisc semaphore waiting for an active reader(s)
> 
> Changes since v2:
> - Added reviewed-by tags
> - Hopefully, fixed reported by 0-day issue.
> - Added optional fix for wait_readers decrement
> 
> Changes since v1:
> - Added tested-by/reported-by tags
> - Dropped 3/4 (locking tty pair for lockdep sake),
>   Because of that - not adding lockdep_assert_held() in tty_ldisc_open()
> - Added 4/4 cleanup to inc tty->count only on success of
>   tty_ldisc_reinit()
> - lock ldisc without (5*HZ) timeout in tty_reopen()
> 
> v1 link: lkml.kernel.org/r/<20180829022353.23568-1-dima@arista.com>
> v2 link: lkml.kernel.org/r/<20180903165257.29227-1-dima@arista.com>
> v3 link: lkml.kernel.org/r/<20180911014821.26286-1-dima@arista.com>
> v4 link: lkml.kernel.org/r/<20180912001702.18522-1-dima@arista.com>
> 
> Cc: Daniel Axtens <dja@axtens.net>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Michael Neuling <mikey@neuling.org>
> Cc: Mikulas Patocka <mpatocka@redhat.com>
> Cc: Nathan March <nathan@gt.net>
> Cc: Pasi Kärkkäinen <pasik@iki.fi>
> Cc: Peter Hurley <peter@hurleysoftware.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Rong, Chen" <rong.a.chen@intel.com>
> Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
> Cc: Tan Xiaojun <tanxiaojun@huawei.com>
> Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> (please, ignore if I Cc'ed you mistakenly)
> 
> Dmitry Safonov (6):
>   tty/ldsem: Wake up readers after timed out down_write()
>   tty: Hold tty_ldisc_lock() during tty_reopen()
>   tty: Don't block on IO when ldisc change is pending
>   tty: Simplify tty->count math in tty_reopen()
>   tty/ldsem: Add lockdep asserts for ldisc_sem
>   tty/ldsem: Decrement wait_readers on timeouted down_read()
> 
> Peter Zijlstra (1):
>   tty/ldsem: Convert to regular lockdep annotations
> 
>  drivers/tty/n_hdlc.c    |  4 +--
>  drivers/tty/n_r3964.c   |  2 +-
>  drivers/tty/n_tty.c     |  8 +++---
>  drivers/tty/tty_io.c    | 14 ++++++----
>  drivers/tty/tty_ldisc.c | 16 +++++++++++
>  drivers/tty/tty_ldsem.c | 62 +++++++++++++++++------------------------
>  include/linux/tty.h     |  7 +++++
>  7 files changed, 63 insertions(+), 50 deletions(-)
> 
> -- 
> 2.19.1
> 
