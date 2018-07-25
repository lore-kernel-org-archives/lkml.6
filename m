Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F83C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 12:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 861EC20893
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 12:35:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 861EC20893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbeGYNrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 09:47:01 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:58956 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728492AbeGYNrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 09:47:01 -0400
Received: from fsav302.sakura.ne.jp (fsav302.sakura.ne.jp [153.120.85.133])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w6PCZEEi036206;
        Wed, 25 Jul 2018 21:35:14 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav302.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav302.sakura.ne.jp);
 Wed, 25 Jul 2018 21:35:14 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav302.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w6PCZEaV036203
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 25 Jul 2018 21:35:14 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v2] n_tty: Protect tty->disc_data using refcount.
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jslaby@suse.com,
        syzbot <syzbot+3aa9784721dfb90e984d@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <001a113ed31a122ced0568cc6be1@google.com>
 <db45a090-593d-23d2-e6b2-ede5b308f02f@I-love.SAKURA.ne.jp>
 <35d649ce-0c22-f839-aa4d-19733bf31a9c@I-love.SAKURA.ne.jp>
 <83fdde07-2f8e-8d20-30a2-a8f0804a5044@I-love.SAKURA.ne.jp>
 <8e83cd9a-e28c-a9f4-5f47-98f2046a5dfb@I-love.SAKURA.ne.jp>
 <20180725080630.GA17932@kroah.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <e3a051f9-18b5-a8e9-e42c-67bbd00eda88@i-love.sakura.ne.jp>
Date:   Wed, 25 Jul 2018 21:35:10 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180725080630.GA17932@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/07/25 17:06, Greg KH wrote:
> On Wed, Jul 25, 2018 at 12:22:16AM +0900, Tetsuo Handa wrote:
>> >From 118c64e86641a97d44dec39e313a95b12d9bc3b2 Mon Sep 17 00:00:00 2001
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
>>
>> [1] https://syzkaller.appspot.com/bug?id=1e850009fca0b64ce49dc16499bda4f7de0ab1a5
>>
>> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>> ---
>>  drivers/tty/n_tty.c | 511 ++++++++++++++++++++++++++++++++--------------------
>>  1 file changed, 314 insertions(+), 197 deletions(-)
> 
> What changed from v1?  I haven't had the chance to review your first
> patch, sorry, it's still in my queue.  I was hoping that someone else
> would help out with that as well :)
> 

Just added a check in case I overlooked a subtle race condition that
n_tty_close() is _somehow_ called twice.

  25,26c20,21
  <  1 file changed, 308 insertions(+), 195 deletions(-)
  >  1 file changed, 314 insertions(+), 197 deletions(-)
  872,873c867,869
  <       struct n_tty_data *ldata = tty->disc_data;
  > -     struct n_tty_data *ldata = tty->disc_data;
  > +     struct n_tty_data *ldata = xchg(&tty->disc_data, NULL);
  >
  878,879c874,880
  <       tty->disc_data = NULL;
  < +     put_n_tty(ldata);
  > -     tty->disc_data = NULL;
  > +     /*
  > +      * The xchg() above and this NULL test are rather paranoid checks.
  > +      * Caller should not allow calling close() twice.
  > +      */
  > +     if (ldata)
  > +             put_n_tty(ldata);
  1194c1195
  < +     if (!ldata) /* What value is most appropriate for this case? */
  > +     if (!ldata)

If n_tty_close() is _somehow_ called twice, v1 patch will trigger NULL
pointer dereference. If you are sure that n_tty_close() is never called
twice, you can ignore v2.
