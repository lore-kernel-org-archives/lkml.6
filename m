Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1235BC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4BAA2083D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:03:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4BAA2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbeH2TAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 15:00:54 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:42344 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728475AbeH2TAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 15:00:54 -0400
Received: from fsav305.sakura.ne.jp (fsav305.sakura.ne.jp [153.120.85.136])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w7TF2dhe032562;
        Thu, 30 Aug 2018 00:02:39 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav305.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp);
 Thu, 30 Aug 2018 00:02:39 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157066051.bbtec.net [60.157.66.51])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w7TF2XIa032510
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 30 Aug 2018 00:02:39 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v2] n_tty: Protect tty->disc_data using refcount.
To:     Jiri Slaby <jslaby@suse.cz>, gregkh@linuxfoundation.org,
        jslaby@suse.com
Cc:     syzbot <syzbot+3aa9784721dfb90e984d@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <001a113ed31a122ced0568cc6be1@google.com>
 <db45a090-593d-23d2-e6b2-ede5b308f02f@I-love.SAKURA.ne.jp>
 <35d649ce-0c22-f839-aa4d-19733bf31a9c@I-love.SAKURA.ne.jp>
 <83fdde07-2f8e-8d20-30a2-a8f0804a5044@I-love.SAKURA.ne.jp>
 <8e83cd9a-e28c-a9f4-5f47-98f2046a5dfb@I-love.SAKURA.ne.jp>
 <021343cd-dc28-9889-7656-e624861bc770@suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <ebe25c5d-34e2-1333-c34f-5f1e3dc3cac3@i-love.sakura.ne.jp>
Date:   Thu, 30 Aug 2018 00:02:30 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <021343cd-dc28-9889-7656-e624861bc770@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/08/29 22:53, Jiri Slaby wrote:
> On 07/24/2018, 05:22 PM, Tetsuo Handa wrote:
>> From 118c64e86641a97d44dec39e313a95b12d9bc3b2 Mon Sep 17 00:00:00 2001
>> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>> Date: Wed, 25 Jul 2018 00:15:18 +0900
>> Subject: [PATCH v2] n_tty: Protect tty->disc_data using refcount.
>>
>> syzbot is reporting NULL pointer dereference at n_tty_set_termios() [1].
>> This is because ioctl(TIOCVHANGUP) versus ioctl(TCSETS) can race.
>>
>> Since we don't want to introduce new locking dependency, this patch
>> converts "struct n_tty_data *ldata = tty->disc_data;" in individual
>> function into a function argument which follows "struct tty *", and
>> holds tty->disc_data at each "struct tty_ldisc_ops" hook using refcount
>> in order to ensure that memory which contains "struct n_tty_data" will
>> not be released while processing individual function.
> 
> This does not look correct and is way too complicated. ioctls should not
> be called while changing/killing/hanging/whatever a ldisc. But there is
> one missing lock in tty_reopen.
> 
> So does the attached patch helps instead?
> 
> thanks,
> 

That patch seems to help avoiding crashes. (You can use #syz test: command.)
But I think you need to check tty_ldisc_lock() return value...
