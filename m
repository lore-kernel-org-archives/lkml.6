Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132DDC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 07:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B268A20645
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 07:10:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B268A20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbeH3LLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 07:11:09 -0400
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:44612 "EHLO
        emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbeH3LLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 07:11:08 -0400
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Aug 2018 07:11:07 EDT
Received: from ydin.reaktio.net (reaktio.net [85.76.255.15])
        by emh04.mail.saunalahti.fi (Postfix) with ESMTP id F3D5F30088;
        Thu, 30 Aug 2018 10:03:16 +0300 (EEST)
Received: by ydin.reaktio.net (Postfix, from userid 1001)
        id 6771B36C0F6; Thu, 30 Aug 2018 10:03:16 +0300 (EEST)
Date:   Thu, 30 Aug 2018 10:03:16 +0300
From:   Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Daniel Axtens <dja@axtens.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Neuling <mikey@neuling.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Peter Hurley <peter@hurleysoftware.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, stable@vger.kernel.org,
        Nathan March <nathan@gt.net>, centos-virt@centos.org
Subject: Re: [PATCH 0/4] tty: Hold write ldisc sem in tty_reopen()
Message-ID: <20180830070316.GE9060@reaktio.net>
References: <20180829022353.23568-1-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180829022353.23568-1-dima@arista.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Wed, Aug 29, 2018 at 03:23:49AM +0100, Dmitry Safonov wrote:
> Two fixes for potential and real issues.
> Looks worth to have in stables as we've hit it on v4.9 stable.
> And for linux-next - adding lockdep asserts for line discipline changing
> code, verifying that write ldisc sem will be held forthwith.
> 
> I couldn't verify that holding write lock fixes the issue as we've hit
> it only once and I've failed in reproducing it.
> But searching in lkml, Cc'ing here people who probably had the same
> crash (and in hope someone of them could give tested-by):
> 

And thanks a lot for your work on fixing these issues!

I've added Nathan (and centos-virt) to CC, because earlier Nathan was able to reliably trigger ldisc related kernel crash in Xen dom0 when running Linux 4.9 kernel, which seems similar to what your patch 2/4 is trying to fix.

Nathan's kernel crash report: https://lists.centos.org/pipermail/centos-virt/2017-August/005610.html
Example ldisc kernel crash BUG in "n_tty_receive_buf_common": https://lists.centos.org/pipermail/centos-virt/attachments/20170823/45493276/attachment.txt

CentOS bug: https://bugs.centos.org/view.php?id=13713


Thanks,

-- Pasi

> Cc: Daniel Axtens <dja@axtens.net> 
> Cc: Dmitry Vyukov <dvyukov@google.com> 
> Cc: Michael Neuling <mikey@neuling.org>
> Cc: Mikulas Patocka <mpatocka@redhat.com>
> Cc: Pasi Kärkkäinen <pasik@iki.fi>
> Cc: Peter Hurley <peter@hurleysoftware.com>
> Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> 
> Cc: Tan Xiaojun <tanxiaojun@huawei.com>
> (please, ignore if I Cc'ed you mistakenly)
> 
> Dmitry Safonov (4):
>   tty: Drop tty->count on tty_reopen() failure
>   tty: Hold tty_ldisc_lock() during tty_reopen()
>   tty: Lock tty pair in tty_init_dev()
>   tty/lockdep: Add ldisc_sem asserts
> 
>  drivers/tty/tty_io.c    | 21 +++++++++++++++------
>  drivers/tty/tty_ldisc.c | 12 ++++++++----
>  include/linux/tty.h     |  4 ++++
>  3 files changed, 27 insertions(+), 10 deletions(-)
> 
> -- 
> 2.13.6
> 
