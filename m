Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86591C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DF4920869
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbfA3L0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 06:26:47 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:48549 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbfA3L0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 06:26:47 -0500
Received: from fsav104.sakura.ne.jp (fsav104.sakura.ne.jp [27.133.134.231])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x0UBQR7L018537;
        Wed, 30 Jan 2019 20:26:27 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav104.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp);
 Wed, 30 Jan 2019 20:26:27 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x0UBQRCg018534
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Wed, 30 Jan 2019 20:26:27 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: BUG: unable to handle kernel paging request in dput (2)
To:     Omar Sandoval <osandov@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     syzbot <syzbot+b382ba6a802a3d242790@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        Jens Axboe <axboe@fb.com>
References: <00000000000081e6cc0580aa76a2@google.com>
 <80e90ecd-77f5-00a3-4e91-5e9eea2aa117@I-love.SAKURA.ne.jp>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <27008e5f-9dfc-a09a-cdb9-824d470fb9dd@I-love.SAKURA.ne.jp>
Date:   Wed, 30 Jan 2019 20:26:24 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <80e90ecd-77f5-00a3-4e91-5e9eea2aa117@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/01/30 20:11, Tetsuo Handa wrote:
> Hello, Omar.
> 
> syzbot is reporting a crash due to dput(-EINVAL) [1]. I think the location is
> 
>         dir = debugfs_lookup(buts->name, blk_debugfs_root);
>         if (!dir)
>                 bt->dir = dir = debugfs_create_dir(buts->name, blk_debugfs_root);
> 
> added by commit 6ac93117ab009d39 ("blktrace: use existing disk debugfs directory").
> 
> Currently, Greg Kroah-Hartman is posting patches:
> 
>   When calling debugfs functions, there is no need to ever check the
>   return value.  The function can work or not, but the code logic should
>   never do something different based on this.
> 
> Omar, what do you want to do for this case?
> 
> [1] https://syzkaller.appspot.com/bug?extid=b382ba6a802a3d242790
> 

The function which returned -EINVAL instead of NULL seems to be debugfs_lookup()
modified by commit ff9fb72bc07705c0 ("debugfs: return error values, not NULL").
