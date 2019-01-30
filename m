Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F16C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB38820882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729692AbfA3LLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 06:11:55 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:61821 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfA3LLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 06:11:55 -0500
Received: from fsav301.sakura.ne.jp (fsav301.sakura.ne.jp [153.120.85.132])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x0UBBMcI004858;
        Wed, 30 Jan 2019 20:11:22 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav301.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp);
 Wed, 30 Jan 2019 20:11:21 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x0UBBK0R004849
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Wed, 30 Jan 2019 20:11:21 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: BUG: unable to handle kernel paging request in dput (2)
To:     Omar Sandoval <osandov@fb.com>
References: <00000000000081e6cc0580aa76a2@google.com>
Cc:     syzbot <syzbot+b382ba6a802a3d242790@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@fb.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <80e90ecd-77f5-00a3-4e91-5e9eea2aa117@I-love.SAKURA.ne.jp>
Date:   Wed, 30 Jan 2019 20:11:17 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <00000000000081e6cc0580aa76a2@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Omar.

syzbot is reporting a crash due to dput(-EINVAL) [1]. I think the location is

        dir = debugfs_lookup(buts->name, blk_debugfs_root);
        if (!dir)
                bt->dir = dir = debugfs_create_dir(buts->name, blk_debugfs_root);

added by commit 6ac93117ab009d39 ("blktrace: use existing disk debugfs directory").

Currently, Greg Kroah-Hartman is posting patches:

  When calling debugfs functions, there is no need to ever check the
  return value.  The function can work or not, but the code logic should
  never do something different based on this.

Omar, what do you want to do for this case?

[1] https://syzkaller.appspot.com/bug?extid=b382ba6a802a3d242790

