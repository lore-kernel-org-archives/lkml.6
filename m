Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8EC0C43612
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A12C21903
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="UzBJBBgh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389249AbeLUHaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 02:30:16 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46680 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730788AbeLUH1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 02:27:50 -0500
Received: by mail-wr1-f65.google.com with SMTP id l9so4112558wrt.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 23:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=rjZtowWUqDsN4RH1qNFnjBtrtgFPRxVMd6Ulv41qXsY=;
        b=UzBJBBgh/BktdVnXhtKlHk9itqQASDm1jkyxMpvkc0BTrgrKsvEK0KgNKHME45pX5b
         CjE9h+ehASd3NjO2Bv3ERDNOHXJ3o9PKQRzabLxniQzm6IZKqY8CQPszdhDtX4SVwD+m
         2GAloryPe1M/CWnDPrDTq/Lnmu4FcMoUe0YfG9cYWNoCcbni3KJTPTEAeFDcNZWo2gnf
         JoDKgEJhhkz2/31JuwrtwBW3i1P0Gv990vx14n9aeGv80hRY7Kykj73I3hwe1mT8lcky
         NP53i9XxwCDdc/zaoY58JCuF6ErnjGRsPlkfi06tYLWanVjM77oT0gbDvkJlWRbmKDQv
         AF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=rjZtowWUqDsN4RH1qNFnjBtrtgFPRxVMd6Ulv41qXsY=;
        b=lg+JRi50BV9pHlXZubyqiCnkXemMi2d8nkj1W0i+VszfDdUvluXwvYcyVNEqMKvdpa
         lCeg97QAlX/BDATTu3ZILB9791V9O2ORqjl1Gfq0Jdt1Yf8Asmx9d/d5yFHhZQ2fHSc5
         aelFT1OEa4/B9wnA9EQJgODZqgUoK9LhWaXL2JCZFjHPVyeXOaQOeCdbgHmorkK0rE70
         iip7SydP1wNGROcEYIg2ZAHuOcaavThTQZmsYcI5YKboyFSk3JVDDksLZb1PX9W+9rKO
         5+QaQMIeCTxGMQfqZlDfa6ITUYnmPDrDyc7TRehix/ODkMKRBFX2JVVP0XYzUrMUn44r
         k4WA==
X-Gm-Message-State: AJcUukcsJs0c41kmnXdQLM0hKwzVqAY/6jBfRypRn/I578q1y09OUXFk
        E2MiHq/Rhq0OAxgsPbcxeB6NoaiiK4E=
X-Google-Smtp-Source: ALg8bN6EI3K4mQSZ/jfercd++i3hNRLl4DCcExiMm5U3ZpaNdmJhQ4Pekw9u30NKzwLEOVNY83Nojw==
X-Received: by 2002:adf:9d4c:: with SMTP id o12mr1221981wre.94.1545377268837;
        Thu, 20 Dec 2018 23:27:48 -0800 (PST)
Received: from ?IPv6:2a02:8109:b6c0:6c14:e5c3:3a2b:437c:4c9c? ([2a02:8109:b6c0:6c14:e5c3:3a2b:437c:4c9c])
        by smtp.gmail.com with ESMTPSA id y34sm28543053wrd.68.2018.12.20.23.27.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 23:27:48 -0800 (PST)
Date:   Fri, 21 Dec 2018 08:27:45 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <CAB0TPYF6hgNt0QcYNj0_jZmKVxuUpko-nSoRGwz19_M0OFzmCA@mail.gmail.com>
References: <20181220104057.18628-1-christian@brauner.io> <20181220105444.GB8548@kroah.com> <B16ED4A7-5C64-4285-A076-1CBFEFE47DDB@brauner.io> <20181220110923.GA10786@kroah.com> <CAB0TPYF6hgNt0QcYNj0_jZmKVxuUpko-nSoRGwz19_M0OFzmCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] MAINTAINERS: update Android binder
To:     Martijn Coenen <maco@android.com>,
        Greg KH <gregkh@linuxfoundation.org>
CC:     Todd Kjos <tkjos@google.com>, LKML <linux-kernel@vger.kernel.org>
From:   Christian Brauner <christian@brauner.io>
Message-ID: <2DBEE08C-32BB-48F4-B2CD-63966B47CF72@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On December 20, 2018 1:13:26 PM GMT+01:00, Martijn Coenen <maco@android=2Ec=
om> wrote:
>Thanks Christian for signing up!
>
>On Thu, Dec 20, 2018 at 12:09 PM Greg KH <gregkh@linuxfoundation=2Eorg>
>wrote:
>> Ok, no objection from me, Todd/Martijn/Joel/Arve, can I get an ack
>from
>> someone?
>
>Acked-By: Martijn Coenen <maco@android=2Ecom>

Thanks Martijn! Happy holidays!
Christian

>
>>
>> thanks,
>>
>> greg k-h

