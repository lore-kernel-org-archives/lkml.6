Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E0BC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0079205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:19:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0079205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbeH2TQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 15:16:35 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:29445 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728701AbeH2TQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 15:16:35 -0400
Received: from fsav301.sakura.ne.jp (fsav301.sakura.ne.jp [153.120.85.132])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w7TFJ8Q1046750;
        Thu, 30 Aug 2018 00:19:08 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav301.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp);
 Thu, 30 Aug 2018 00:19:08 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157066051.bbtec.net [60.157.66.51])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w7TFJ8Am046742
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 30 Aug 2018 00:19:08 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: [PATCH 2/4] tty: Hold tty_ldisc_lock() during tty_reopen()
To:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Daniel Axtens <dja@axtens.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Neuling <mikey@neuling.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        =?UTF-8?B?UGFzaSBLw6Rya2vDpGluZW4=?= <pasik@iki.fi>,
        Peter Hurley <peter@hurleysoftware.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, stable@vger.kernel.org
References: <20180829022353.23568-1-dima@arista.com>
 <20180829022353.23568-3-dima@arista.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <0cb6bb7c-776b-28d6-65a6-f5b496e32344@I-love.SAKURA.ne.jp>
Date:   Thu, 30 Aug 2018 00:19:04 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180829022353.23568-3-dima@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/08/29 11:23, Dmitry Safonov wrote:
> tty_ldisc_reinit() doesn't race with neither tty_ldisc_hangup()
> nor set_ldisc() nor tty_ldisc_release() as they use tty lock.
> But it races with anyone who expects line discipline to be the same
> after hoding read semaphore in tty_ldisc_ref().
> 
> We've seen the following crash on v4.9.108 stable:
> 
> BUG: unable to handle kernel paging request at 0000000000002260
> IP: [..] n_tty_receive_buf_common+0x5f/0x86d
> Workqueue: events_unbound flush_to_ldisc
> Call Trace:
>  [..] n_tty_receive_buf2
>  [..] tty_ldisc_receive_buf
>  [..] flush_to_ldisc
>  [..] process_one_work
>  [..] worker_thread
>  [..] kthread
>  [..] ret_from_fork
> 
> I think, tty_ldisc_reinit() should be called with ldisc_sem hold for
> writing, which will protect any reader against line discipline changes.
> 
> Note: I failed to reproduce the described crash, so obiviously can't
> guarantee that this is the place where line discipline was switched.

This will be same with a report at
https://syzkaller.appspot.com/bug?id=f08670354701fa64cc0dd3c0128a491bdb16adcc .

syzbot is now testing a patch from Jiri Slaby.
