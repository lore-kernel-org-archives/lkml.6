Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11E0C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 11:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E928206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 11:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbfAJLih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 06:38:37 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:36154 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727938AbfAJLih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 06:38:37 -0500
Received: from fsav107.sakura.ne.jp (fsav107.sakura.ne.jp [27.133.134.234])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x0ABcaIM098348;
        Thu, 10 Jan 2019 20:38:36 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav107.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav107.sakura.ne.jp);
 Thu, 10 Jan 2019 20:38:36 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav107.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x0ABcZD5098308
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 10 Jan 2019 20:38:35 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] tty/n_hdlc: fix __might_sleep warning
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, jslaby@suse.com
Cc:     Paul Fulghum <paulkf@microgate.com>,
        "linux-kernel@vger.kernel.org Mailing List" 
        <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        syzbot <syzbot+c244af085a0159d22879@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com
References: <000000000000449587057e1e6f8b@google.com>
 <49b3b189-a51f-6a97-0e1f-bc3f2c305299@I-love.SAKURA.ne.jp>
 <62FAC6A3-AC41-44CD-8ABC-79F404BF8CB1@microgate.com>
 <F23DE81F-C976-4AED-8990-84A6ADC1BF1F@microgate.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <d351e662-0087-9cd7-46b2-ef49134c639c@i-love.sakura.ne.jp>
Date:   Thu, 10 Jan 2019 20:38:33 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <F23DE81F-C976-4AED-8990-84A6ADC1BF1F@microgate.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Greg.

We attempted a cleanup but we failed. Thus, will you apply this patch for now?

On 2019/01/02 5:28, Paul Fulghum wrote:
> Fix __might_sleep warning in tty/n_hdlc.c read due to copy_to_user call while current is TASK_INTERRUPTIBLE.
> This is a false positive since the code path does not depend on current state remaining TASK_INTERRUPTIBLE.
> The loop breaks out and sets TASK_RUNNING after calling copy_to_user. 
> This patch supresses the warning by setting TASK_RUNNING before calling copy_to_user.
> 
> [1] https://syzkaller.appspot.com/bug?id=17d5de7f1fcab794cb8c40032f893f52de899324
> 
> Signed-off-by: Paul Fulghum <paulkf@microgate.com>
> Reported-by: syzbot <syzbot+c244af085a0159d22879@syzkaller.appspotmail.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> —
> --- a/drivers/tty/n_hdlc.c	2018-12-23 15:55:59.000000000 -0800
> +++ b/drivers/tty/n_hdlc.c	2019-01-01 11:44:47.148153954 -0800
> @@ -597,6 +597,7 @@ static ssize_t n_hdlc_tty_read(struct tt
>  				/* too large for caller's buffer */
>  				ret = -EOVERFLOW;
>  			} else {
> +				__set_current_state(TASK_RUNNING);
>  				if (copy_to_user(buf, rbuf->buf, rbuf->count))
>  					ret = -EFAULT;
>  				else
