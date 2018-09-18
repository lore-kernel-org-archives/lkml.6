Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8725ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C7E0214C5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:45:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C7E0214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729804AbeIRTRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 15:17:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41772 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbeIRTRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 15:17:50 -0400
Received: from localhost (unknown [147.67.4.98])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D244FD2A;
        Tue, 18 Sep 2018 13:43:49 +0000 (UTC)
Date:   Tue, 18 Sep 2018 15:43:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Daniel Axtens <dja@axtens.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Neuling <mikey@neuling.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Nathan March <nathan@gt.net>,
        Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>,
        Peter Hurley <peter@hurleysoftware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rong, Chen" <rong.a.chen@intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCHv5 2/7] tty/ldsem: Wake up readers after timed out
 down_write()
Message-ID: <20180918134347.GD23431@kroah.com>
References: <20180917235258.5719-1-dima@arista.com>
 <20180917235258.5719-3-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180917235258.5719-3-dima@arista.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 12:52:53AM +0100, Dmitry Safonov wrote:
> ldsem_down_read() will sleep if there is pending writer in the queue.
> If the writer times out, readers in the queue should be woken up,
> otherwise they may miss a chance to acquire the semaphore until the last
> active reader will do ldsem_up_read().
> 
> There was a couple of reports where there was one active reader and
> other readers soft locked up:
>   Showing all locks held in the system:
>   2 locks held by khungtaskd/17:
>    #0:  (rcu_read_lock){......}, at: watchdog+0x124/0x6d1
>    #1:  (tasklist_lock){.+.+..}, at: debug_show_all_locks+0x72/0x2d3
>   2 locks held by askfirst/123:
>    #0:  (&tty->ldisc_sem){.+.+.+}, at: ldsem_down_read+0x46/0x58
>    #1:  (&ldata->atomic_read_lock){+.+...}, at: n_tty_read+0x115/0xbe4
> 
> Prevent readers wait for active readers to release ldisc semaphore.
> 
> Link: lkml.kernel.org/r/<20171121132855.ajdv4k6swzhvktl6@wfg-t540p.sh.intel.com>
> Link: lkml.kernel.org/r/<20180907045041.GF1110@shao2-debian>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---

Why isn't this ok for the stable trees?

thanks,

greg k-h
