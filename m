Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87423C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 585C52086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfARL6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 06:58:54 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:29414 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfARL6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 06:58:54 -0500
Received: from fsav107.sakura.ne.jp (fsav107.sakura.ne.jp [27.133.134.234])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x0IBwovq050151;
        Fri, 18 Jan 2019 20:58:50 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav107.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav107.sakura.ne.jp);
 Fri, 18 Jan 2019 20:58:50 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav107.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x0IBwnEs050146
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Fri, 18 Jan 2019 20:58:50 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
To:     Tejun Heo <tj@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: workqueue: Is flush_work() without INIT_WORK() OK?
Message-ID: <7d751e65-e695-e23b-9cec-ef3f44289a56@i-love.sakura.ne.jp>
Date:   Fri, 18 Jan 2019 20:58:49 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Tejun.

syzbot is reporting "INFO: trying to register non-static key in __flush_work"
at https://syzkaller.appspot.com/bug?id=a5954455fcfa51c29ca2ab55b203076337e1c770 ,
and I think that the caller is passing a work_struct allocated by kzalloc() to
flush_work().

But I can't judge which problem (the caller side or the WQ side) without knowing
the behavior of

	struct work_struct work;
	memset(&work, 0, sizeof(work));
	flush_work(&work);

. Is this behavior defined as "safe and no-op"? If this should be "safe and no-op",
we need to check whether INIT_WORK() was called before starting lockdep checks
at __flush_work(). If this is not "safe and no-op", I want to emit a warning if
INIT_WORK() was not called.
