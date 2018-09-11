Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670D4C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 11:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0780720866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 11:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oF7Hh/tx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0780720866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbeIKQkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 12:40:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59368 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbeIKQkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 12:40:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1ZsO7SKBqI5QaDuFbOuMPbxnyoB3l5ADrwEIywG/Dl8=; b=oF7Hh/txgX931uVtJuJt8P9G9
        BSPp0Cl1Vs4u9uSGQjv9i1qlObZRU0eR7lh1jLYYINJEQJ1ZBm3Yi026Uedy5vLsZme3YXJnePUr5
        vhbCuMBrgUhBHc3gDOxKa3u6E+XDD1YNLEKN+UwMgX1j1qA/9DZf0D/Z3njRpcSFgzt4lTwpn4k9z
        NC87LbpA0bO7CfWe37YnFGoOVPSCaGJFg8eze8dlCkj2JVMiTE18zduI1cxqIRY7wQQQNCLOF6UwD
        jJXiPhZ4FBn/3UxgHq4lJIkrNGq0wX6X17GHfKmZXcpUG0OD7SQlOPgbkqdiiF++KsFAkCMI0d9EZ
        sjnzgnZyw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fzh2E-0007Qw-27; Tue, 11 Sep 2018 11:40:46 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7F8292057F833; Tue, 11 Sep 2018 13:40:43 +0200 (CEST)
Date:   Tue, 11 Sep 2018 13:40:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Daniel Axtens <dja@axtens.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Neuling <mikey@neuling.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Nathan March <nathan@gt.net>,
        Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>,
        Peter Hurley <peter@hurleysoftware.com>,
        "Rong, Chen" <rong.a.chen@intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCHv3 2/6] tty/ldsem: Update waiter->task before waking up
 reader
Message-ID: <20180911114043.GR24106@hirez.programming.kicks-ass.net>
References: <20180911014821.26286-1-dima@arista.com>
 <20180911014821.26286-3-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911014821.26286-3-dima@arista.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 02:48:17AM +0100, Dmitry Safonov wrote:
> There is a couple of reports about lockup in ldsem_down_read() without
> anyone holding write end of ldisc semaphore:
> lkml.kernel.org/r/<20171121132855.ajdv4k6swzhvktl6@wfg-t540p.sh.intel.com>
> lkml.kernel.org/r/<20180907045041.GF1110@shao2-debian>
> 
> They all looked like a missed wake up.
> I wasn't lucky enough to reproduce it, but it seems like reader on
> another CPU can miss waiter->task update and schedule again, resulting
> in indefinite (MAX_SCHEDULE_TIMEOUT) sleep.
> 
> Make sure waked up reader will see waiter->task == NULL.

> --- a/drivers/tty/tty_ldsem.c
> +++ b/drivers/tty/tty_ldsem.c
> @@ -118,6 +118,8 @@ static void __ldsem_wake_readers(struct ld_semaphore *sem)
>  		tsk = waiter->task;
>  		smp_mb();
>  		waiter->task = NULL;
> +		/* Make sure down_read_failed() will see !waiter->task update */
> +		smp_wmb();
>  		wake_up_process(tsk);

This is 'wrong', wake_up_process() should imply sufficient for this to
already be true. 

>  		put_task_struct(tsk);
>  	}
