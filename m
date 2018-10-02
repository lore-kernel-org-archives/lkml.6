Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153D9C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 16:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C24E92089C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 16:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cpXe6EzF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C24E92089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbeJBX0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 19:26:48 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35643 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbeJBX0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 19:26:47 -0400
Received: by mail-io1-f66.google.com with SMTP id w11-v6so2630601iob.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 09:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4xOaYnd5n4IJUphuMI1FzONIXJrbncHGHrlrPgb5RxY=;
        b=cpXe6EzFBkGwUPT9vj3efcqFQ08ZyKLC0497MgmBdkUDRwa9CV94B3/pQVbEgRHB9C
         dKVr4EP9bODanduSu/d1+juGwmarbDDtrlsf0CiMZw0vpOpELDMnxX0xHPJrg0K2HgGG
         ApEIGWZaqQKukisEnke7U8ky970N53HZyC/UKquRQKOzQvbsPnfRqQ370rrmlUS+KwXd
         ELmwv/8l8Jnb4FxInBM8XUgQqcViQnBtEYHQpK6ucY9sYTMccOf+fEe1Pk27g3ZrJlEk
         FaJJS3YeNWBgqWfEudsJZezP6eee3sBbZv5dwm5V8WuDGZZnTYYm6T9rl8UtY9sT/xdk
         9p4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4xOaYnd5n4IJUphuMI1FzONIXJrbncHGHrlrPgb5RxY=;
        b=kNSt7R8XBNSordu7KgjUMp4kOP540PqSP9lSve/l/oVKgqA1o8fWmve6cqYTH4PhiU
         x/+WwDU2FyVTNU4fMQhdM8KOyxRjBbFtrAX9s6jZfRl8JeBvJ19gR55EVIDnLNv0kM8M
         zhkr1MqbOFm7Id2T5ugJUX9+cH5h2OxQo2l/Y3Y1WRPDCjTZYMhL9C9MCh2WntXbnmLT
         CKpBQx91S3QrozKYNNOCQSLPgCYvQi4WvRmCJ/w6K63T7roFENhRJghEePnMeJhf0cbG
         cq07Zi2StiNc7zkOBFT4KoS4KdokhQPJrOiKpPh7O4+RfTdCP3N2zmhjDB7SL5y9L3qE
         m/Sw==
X-Gm-Message-State: ABuFfoi9xWpuW4Z74Q5PyprVQAznzriOP/VkqOTdoutSsUj1djVe+0h7
        iKdQx6XKAwi5XF4lvW18RlySeCaivQksZ1mNNhauaA==
X-Google-Smtp-Source: ACcGV63417boH5d2I3SPLgd/JYQol5dbVebTb/LK5JcRSIGlcsoHte9MKcbTT3k4GHzkzdWZLYs/4zltsXugqjmgt0M=
X-Received: by 2002:a6b:9885:: with SMTP id a127-v6mr10241038ioe.282.1538498550277;
 Tue, 02 Oct 2018 09:42:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:ab8c:0:0:0:0:0 with HTTP; Tue, 2 Oct 2018 09:42:09 -0700 (PDT)
In-Reply-To: <62457d9f-0732-3886-0381-bbf5df738467@kernel.org>
References: <0000000000004643360575102706@google.com> <62457d9f-0732-3886-0381-bbf5df738467@kernel.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 2 Oct 2018 18:42:09 +0200
Message-ID: <CACT4Y+bycsbrkeT8PHYxfooTkw2VyCAONY_BH2dTuZKtvCj3pg@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Read in vhci_hub_control
To:     Shuah Khan <shuah@kernel.org>
Cc:     syzbot <syzbot+bccc1fe10b70fadc78d0@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Valentina Manea <valentina.manea.m@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 2, 2018 at 6:04 PM, Shuah Khan <shuah@kernel.org> wrote:
> On 09/04/2018 12:52 PM, syzbot wrote:
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    420f51f4ab6b Merge tag 'arm64-fixes' of git://git.kernel.o..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=126a6f0e400000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=531a917630d2a492
>> dashboard link: https://syzkaller.appspot.com/bug?extid=bccc1fe10b70fadc78d0
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=121caa46400000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14ed8ab6400000
>
> C producer doesn't reproduce the problem on 4.19-rc5. Does this C producer
> depend on state of the machine? i.e what is the status of vhci_hcd - are
> there any devices attached?

Hi Shuah,

syzbot always runs tests reproducers on a clean machine. There is some
state are running a Debian wheezy init, but no test/fuzz/stress
workload is run before the reproducer.
syzbot also uses VMs, so there are no real devices attached. And it's
GCE VMs (not qemu), and I think GCE does not even emulate any USB
devices.

An obvious thing to try would be to use the exact commit and config
syzbot gave (rather than 4.19-rc5).
You can also take the image syzbot uses here:
https://github.com/google/syzkaller/blob/master/docs/syzbot.md#crash-does-not-reproduce


> I can see the problem looking at the code and fix is easy. However, I would
> like be able to reproduce it and verify the fix works. Also this would be a
> good regression for the driver I could consider adding to selftests.

syzbot can test fixes for bugs with reproducers:
https://github.com/google/syzkaller/blob/master/docs/syzbot.md#testing-patches
So it can test your fix. But this obviously won't help with a test.
