Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAACFC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBC25206A2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqXRPDve"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbeLNPOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 10:14:53 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40724 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730146AbeLNPOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 10:14:53 -0500
Received: by mail-wr1-f68.google.com with SMTP id p4so5764083wrt.7;
        Fri, 14 Dec 2018 07:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GroZnHYhK5WEaFeYsY94az07FFzLHHGVeLFkYbxLmHU=;
        b=VqXRPDvevXzVtF+p1EVB05JV7QYlAIxj41j3xxEL0x0g42FMUGwwZudkaZJdmu2qcV
         +djISuS2H9AZYEvRqmCmX1p+kQrtIEgwpIYvCC2qjVDAOwr6jUSNM8gPtjSv3I3OH+qb
         doh/71JXynKKYr2vhmIiYcnVlVa7dDhsqRccQJr5cVdk6Z5RD4ylRS85v1tSK27+jx8p
         rOMd2uaTxewNPYFL7cJx1QputZl5/xM3RnEhG92g7MFBlmVFJjpELb9PWS6OHQr8rWBS
         0fpRHhS/lPGhN57rsc0fWvAgrDxGya3jscZIszf1eWOl07dJcDnDVbrT6xJqcS7Po0XH
         ObVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GroZnHYhK5WEaFeYsY94az07FFzLHHGVeLFkYbxLmHU=;
        b=Fu5kFpmgoUNyvtTIUcOgcQfzGnpAAGGOpzNIMfo9OVkcKB8RDdSzsBQcb4Tzateedc
         bcNTYK2TwlCkSHPVJzaaUr7IhH2YqU2acEz0XII27w1fDFTWQQcUwpHk6CQ91PAfFuWr
         JWNeYCUxNPsR3kEzZw+TW5f6KZqUx8Drutw/1l0A4M6N+6VDbtukJZJnqWxcCyZFfIsn
         A4SB4r9q00F5t3MkqFIa2i1jyf1hwsSpZ62KUvWWOgj4sRLGFLtS2PxQiJnmsG6t8vsK
         0XTdoWBCZSNOVM3CvBV1dojnRqYnnrEkno4/MzUiULl4RiAMlNxqdkjG4MD6I/tIy6sl
         mR/Q==
X-Gm-Message-State: AA+aEWbggxemnGN1CMSHth3plNfUnlwnuq8h1jBxF2+vG2Rae5myKHwO
        r6K6Zu9P25JNnkSBFjmxwCY=
X-Google-Smtp-Source: AFSGD/UYHWARi3mbo6IYbyAczwjU1HGqq06c9g0aOBaOGdJN9ObSaAdVgq4EP0dJeMlvoDZa7InUIg==
X-Received: by 2002:adf:8506:: with SMTP id 6mr3083464wrh.128.1544800490834;
        Fri, 14 Dec 2018 07:14:50 -0800 (PST)
Received: from [192.168.8.147] (225.83.136.77.rev.sfr.net. [77.136.83.225])
        by smtp.gmail.com with ESMTPSA id x76sm10670915wmd.27.2018.12.14.07.14.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 07:14:49 -0800 (PST)
Subject: Re: KMSAN: uninit-value in __inet6_bind
To:     Jon Maloy <jon.maloy@ericsson.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     "syzbot+c56449ed3652e6720f30@syzkaller.appspotmail.com" 
        <syzbot+c56449ed3652e6720f30@syzkaller.appspotmail.com>,
        Ying Xue <ying.xue@windriver.com>,
        "tipc-discussion@lists.sourceforge.net" 
        <tipc-discussion@lists.sourceforge.net>,
        David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
References: <0000000000001568af057cb456a8@google.com>
 <CACT4Y+ZtAP4AVX9nARw+3PEdFL_WX3r37TAPuy=zBdZkg-0pRg@mail.gmail.com>
 <CAM_iQpUZmbsEPAz9s1bDVHbm08+h4WE4mvoxitttDCsXMQvQ4g@mail.gmail.com>
 <DM5PR15MB15135725A063E5370876EBA69AA10@DM5PR15MB1513.namprd15.prod.outlook.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <2b0f7497-7842-e9c3-c7b0-1b2bf2d5ea59@gmail.com>
Date:   Fri, 14 Dec 2018 07:14:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <DM5PR15MB15135725A063E5370876EBA69AA10@DM5PR15MB1513.namprd15.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/14/2018 07:04 AM, Jon Maloy wrote:
> 
> 
>> -----Original Message-----
>> From: Cong Wang <xiyou.wangcong@gmail.com>
>> Sent: 12-Dec-18 01:17
>> To: Dmitry Vyukov <dvyukov@google.com>
>> Cc: syzbot+c56449ed3652e6720f30@syzkaller.appspotmail.com; Jon Maloy
>> <jon.maloy@ericsson.com>; Ying Xue <ying.xue@windriver.com>; tipc-
>> discussion@lists.sourceforge.net; David Miller <davem@davemloft.net>;
>> Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>; LKML <linux-
>> kernel@vger.kernel.org>; Linux Kernel Network Developers
>> <netdev@vger.kernel.org>; syzkaller-bugs@googlegroups.com; Hideaki
>> YOSHIFUJI <yoshfuji@linux-ipv6.org>
>> Subject: Re: KMSAN: uninit-value in __inet6_bind
>>
>> On Tue, Dec 11, 2018 at 1:04 AM Dmitry Vyukov <dvyukov@google.com>
>> wrote:
>>>
>>> On Tue, Dec 11, 2018 at 1:41 AM syzbot
>>> <syzbot+c56449ed3652e6720f30@syzkaller.appspotmail.com> wrote:
>>>>
>>>> Hello,
>>>>
>>>> syzbot found the following crash on:
>>>>
>>>> HEAD commit:    3f06bda61398 kmsan: remove excessive KMSAN
>> wrappers from a..
>>>> git tree:       https://github.com/google/kmsan.git/master
>>>> console output:
>>>> https://syzkaller.appspot.com/x/log.txt?x=13ca6b05400000
>>>> kernel config:
>>>> https://syzkaller.appspot.com/x/.config?x=9b071100dcf8e641
>>>> dashboard link:
>> https://syzkaller.appspot.com/bug?extid=c56449ed3652e6720f30
>>>> compiler:       clang version 8.0.0 (trunk 348261)
>>>>
>>>> Unfortunately, I don't have any reproducer for this crash yet.
>>>>
>>>> IMPORTANT: if you fix the bug, please add the following tag to the
>> commit:
>>>> Reported-by: syzbot+c56449ed3652e6720f30@syzkaller.appspotmail.com
>>>
>>> This looks like a bug in TIPC, +TIPC maintainers.
>>>
>>
>> It looks more like udp_sock_create6() doesn't initialize
>> udp6_addr.sin6_scope_id.
> 
> Unfortunately udp_sock_create6() has no way of knowing this value, because struct udp_port_cfg is missing a field sin6_scope_id.
> So this has to be fixed first by adding this field to the struct, and then setting it correctly in all current users.
> 

Do we reasons to believe values other than 0 are needed ?


