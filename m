Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33279C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 012A0218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732289AbfAaL3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 06:29:44 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:19552 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbfAaL3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 06:29:44 -0500
Received: from fsav109.sakura.ne.jp (fsav109.sakura.ne.jp [27.133.134.236])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x0VBTgOk058633;
        Thu, 31 Jan 2019 20:29:42 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav109.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav109.sakura.ne.jp);
 Thu, 31 Jan 2019 20:29:42 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav109.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x0VBTgJD058624
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 31 Jan 2019 20:29:42 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: general protection fault in relay_open_buf
To:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+16c3a70e1e9b29346c43@syzkaller.appspotmail.com>,
        Eric Biggers <ebiggers@google.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        David Rientjes <rientjes@google.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Newsgroups: gmane.linux.kernel
References: <00000000000074cbc30580b16bc3@google.com>
 <CAGXu5j+UzHKQk81RKsk39vx5WHi_CONzP4rU2fyuH-z_YB7CKw@mail.gmail.com>
 <20190131105152.GB13686@kroah.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <f3347711-fc72-a356-0802-4c9c3ce5eb9c@I-love.SAKURA.ne.jp>
Date:   Thu, 31 Jan 2019 20:29:37 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190131105152.GB13686@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/01/31 19:51, Greg KH wrote:
> Can you test the patch below?

You can ask syzbot to test the patch. But

> @@ -461,7 +463,7 @@ static struct rchan_buf *relay_open_buf(struct rchan *chan, unsigned int cpu)
>  		dentry = chan->cb->create_buf_file(NULL, NULL,
>  						   S_IRUSR, buf,
>  						   &chan->is_global);
> -		if (WARN_ON(dentry))
> +		if (IS_ERR_OR_NULL(dentry))
>  			goto free_buf;

are you trying to fix a different bug together that old code was by error bailing
out when chan->cb->create_buf_file() returned a valid "struct dentry *" ?
I don't know what WARN_ON() due to a valid "struct dentry *" means...

>  	}
>  
> 

