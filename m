Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96EDC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A24862084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKV/QcBp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A24862084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbeJECcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 22:32:53 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46571 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbeJECcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 22:32:53 -0400
Received: by mail-pf1-f194.google.com with SMTP id r64-v6so3852734pfb.13;
        Thu, 04 Oct 2018 12:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=XPVQB4kd5mn3ThSlhxyms94NTJzTyj9C96LKEJUkSXA=;
        b=WKV/QcBphpjFCearY14qC8TZNKJ/j+JMBDnPbZucSS8BDi6qNOFdIl9Wkz1U6Zd8hd
         FX+ldBX7aRiDfs5ofVpBjuN1gDOt8q0YGOBly92GRjq5/hWGIq7ZDLgLRzwKp0vixZGJ
         ZobigHnjozqpYpzrjDXJBNMvm/5PntFNT3ypAHBmy5V95ko3c85fadMVMwsvljGPcDUj
         2cSImtwBFRn/qxalpvCaw7HDNirEH1LTlsoZg9NadZL/KIi/OCXrXrozCPxAX4tJPlB1
         sTfBBPRGxx/17du42eUQGjeOxGmtJfludpYJStLvRwNPGzpKK9XOF5g8JAcc3XuYQ+z0
         ch4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=XPVQB4kd5mn3ThSlhxyms94NTJzTyj9C96LKEJUkSXA=;
        b=c2qZF0ZxbgaoqtvxScgnar5/og3K77+aoSQ+PlZ8XtfGtZJpXNS09OzB/dOymx1ye1
         xP+cq0wuGEXENJbR+GW4sIahzUSS7mOmoMJeaIyKOicnk0WSOA+C0/2JS3+uMTVbmXtA
         vm4XG2CeiANVv2wXPoIKIgh4K+SB8ru3AYe5wyBwjmhIawLMhfO06xmaleZJ0Y3RfmXr
         u0c8sLRzBscImhbHLMOQyI8qPCWzZL5qA8WqUBHFtBRzoqs3VqsXtr2I8HVhzq55U4Z5
         WjGKVLxPCLlfGVRKy3gt5N90TlDdBKHE3LT0GpoupQ13f+ZG86I79FuaEoaHSUVL8c6K
         umZw==
X-Gm-Message-State: ABuFfogV15++YhX1gR5n30LlVswPO7+5x/MGKDsRoBERHF2lnHLEBpIq
        JGhj4eN268CtZyExhTxciIbS4/8j
X-Google-Smtp-Source: ACcGV62MFTAk9FIoxK7PSIBa0CN0rmkcDmrT/7zlQCpIQ0VOwBe44eKmEWzaZSQUTNhzNwpwtNn4fw==
X-Received: by 2002:a62:8f0c:: with SMTP id n12-v6mr8344761pfd.172.1538681889144;
        Thu, 04 Oct 2018 12:38:09 -0700 (PDT)
Received: from ?IPv6:2620:0:1000:fd28:2c8f:9cc8:6674:4e3e? ([2620:0:1000:fd28:2c8f:9cc8:6674:4e3e])
        by smtp.gmail.com with ESMTPSA id y9-v6sm7624166pfn.123.2018.10.04.12.38.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 12:38:07 -0700 (PDT)
Date:   Thu, 04 Oct 2018 12:38:02 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <CANn89iJMhGEkw13KrGbqrvGbznb45QZwdr7eLy_rUV6zitvs=Q@mail.gmail.com>
References: <20181004154749.111595-1-edumazet@google.com> <20181004185949.GA233675@dtor-ws> <CANn89iJMhGEkw13KrGbqrvGbznb45QZwdr7eLy_rUV6zitvs=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] Input: mousedev - add a schedule point in mousedev_write()
To:     Eric Dumazet <edumazet@google.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        linux-input@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Message-ID: <30074728-D1C4-46D4-8BF5-6AB8ECAE3EBD@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On October 4, 2018 12:28:56 PM PDT, Eric Dumazet <edumazet@google=2Ecom> wr=
ote:
>On Thu, Oct 4, 2018 at 11:59 AM Dmitry Torokhov
><dmitry=2Etorokhov@gmail=2Ecom> wrote:
>>
>> Hi Eric,
>>
>> On Thu, Oct 04, 2018 at 08:47:49AM -0700, Eric Dumazet wrote:
>> > syzbot was able to trigger rcu stalls by calling write()
>> > with large number of bytes=2E
>> >
>> > Add a cond_resched() in the loop to avoid this=2E
>>
>> I think this simply masks a deeper issue=2E The code fetches characters
>> from userspace in a loop, takes a lock, quickly places response in an
>> output buffer, and releases interrupt=2E I do not see why this should
>> cause stalls as we do not hold spinlock/interrupts off for extended
>> period of time=2E
>>
>> Adding Paul so he can straighten me out=2E=2E=2E
>>
>
>Well=2E=2E=2E
>
>write(fd, buffer, 0x7FFF0000);
>
>Takes between 20 seconds and 2 minutes depending on CONFIG options =2E=2E=
=2E=2E

That's fine even if it takes a couple of years=2E We are not holding spinl=
ock for the entirety of this time, so we should get bumped off CPU at some =
point=2E

>
>So either apply my patch, or add a limit on the max count, and
>possibly break legitimate user space ?

Legitimate users write a single character at a time and read response, so =
exciting after, let's say, 32 bytes would be fine=2E But I still want to un=
derstand why we have to do that=2E

>
>I dunno=2E=2E=2E
>
>> >
>> > Link: https://lkml=2Eorg/lkml/2018/8/23/1106
>> > Signed-off-by: Eric Dumazet <edumazet@google=2Ecom>
>> > Reported-by: syzbot+9436b02171ac0894d33e@syzkaller=2Eappspotmail=2Eco=
m
>> > Cc: Dmitry Torokhov <dmitry=2Etorokhov@gmail=2Ecom>
>> > Cc: linux-input@vger=2Ekernel=2Eorg
>> > ---
>> >  drivers/input/mousedev=2Ec | 1 +
>> >  1 file changed, 1 insertion(+)
>> >
>> > diff --git a/drivers/input/mousedev=2Ec b/drivers/input/mousedev=2Ec
>> > index
>e08228061bcdd2f97aaadece31d6c83eb7539ae5=2E=2E412fa71245afe26a7a8ad757055=
66f83633ba347
>100644
>> > --- a/drivers/input/mousedev=2Ec
>> > +++ b/drivers/input/mousedev=2Ec
>> > @@ -707,6 +707,7 @@ static ssize_t mousedev_write(struct file
>*file, const char __user *buffer,
>> >               mousedev_generate_response(client, c);
>> >
>> >               spin_unlock_irq(&client->packet_lock);
>> > +             cond_resched();
>> >       }
>> >
>> >       kill_fasync(&client->fasync, SIGIO, POLL_IN);
>> > --
>> > 2=2E19=2E0=2E605=2Eg01d371f741-goog
>> >
>>
>> Thanks=2E
>>
>> --
>> Dmitry


Thanks=2E

--=20
Dmitry
