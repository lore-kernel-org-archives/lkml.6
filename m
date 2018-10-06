Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CABC64EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 04:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30E0C20875
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 04:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khcclnDw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30E0C20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbeJFLa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 07:30:28 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41618 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbeJFLa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 07:30:27 -0400
Received: by mail-pf1-f196.google.com with SMTP id m77-v6so5947377pfi.8;
        Fri, 05 Oct 2018 21:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=/O48OpVMFHSVCTo9ystJgMwkMX/+75g2FepSOVPLCkE=;
        b=khcclnDwCgNDLGj4Egl25Fg5jqqqCJJUsgMaJleoTyNAguHNwlh17MNxsEyPq/e8sc
         9yWAncviq+wyC6glDV7SddEDzzRsRBLJ5YK3Rdmr5qeHg2v61nnv/E91ffsK/3pUHdlh
         xgS2fJPAb0J1CdQnIMFoRgEQB3C67ncovkfaoojSDZwE8N6jtpPBghfbtqNpm4gLhy28
         BgujzXmspO3Mmh0A9GqTXuODcb9E9pw8QXQar6TP2GTAOsE7Vp1LNWSz2R3mjyjj0tzC
         wd/MKwAAlRl3o/kykwv2ns2+qj5PT1VIJXQPw/povBq8ZcHQOGGCXDuvp9K4WTpU6F/z
         cXZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=/O48OpVMFHSVCTo9ystJgMwkMX/+75g2FepSOVPLCkE=;
        b=rYiwAsVIFN+X1+oXuR0Ylokr70NYUXMtdcS2rg7OClJSlLoqhrgidDsw6R2zwgPdSg
         hz+euOnppXjC5N72Px6xnyfu/W2n0u8pgJUooHhU16obowmrutq3SmrFe6rc0X52z/AE
         wHfwUvxM+HTCfQePwgJbXgIFJ7lwPEqGs44lJwh3bUEw7ZHXJxWH0ZqNkxje59eXKGNJ
         6PxfzRk+Xs7IWAQp441/yo35gRPWUxMh+mk/3dBt8w6ArY1Wtcybi5hP6Cxkg5eVV2T1
         YN+4xDRCwYbG2u8RkTgEvFgOKHnac8uIHesV+uPHiD8rk9stwhglkRuEcS9DDwsRitiz
         DJEA==
X-Gm-Message-State: ABuFfog54pwD036F3UeAj99slhPW2Foi+75gjjT6+xFwgRwwcgslZvO5
        7//et9CWENriYfA+ckQjtok90gCmGn4=
X-Google-Smtp-Source: ACcGV63pu3QIci8/wL9/8pdQw/6wY3wrC8hrg/jEc3lYWr1OscgUW2qStULq4jDz+Axz876yanhBmg==
X-Received: by 2002:a62:21d1:: with SMTP id o78-v6mr14763287pfj.235.1538800119497;
        Fri, 05 Oct 2018 21:28:39 -0700 (PDT)
Received: from [192.168.1.101] (222-154-41-72-adsl.sparkbb.co.nz. [222.154.41.72])
        by smtp.gmail.com with ESMTPSA id l2-v6sm9407582pgp.20.2018.10.05.21.28.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 21:28:38 -0700 (PDT)
Subject: Re: [PATCH v3 3/7] drivers: parisc: Avoids building driver if
 CONFIG_PARISC is disabled
To:     Leonardo Bras <leobras.c@gmail.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
References: <20180928020816.11251-1-leobras.c@gmail.com>
 <20180928020816.11251-4-leobras.c@gmail.com>
 <1538118915.3593.4.camel@HansenPartnership.com>
 <CADvQ+rGQenkoE0xCRTwjA5BuKZbZ2Upkyx=+qWFUGnUcit-aCQ@mail.gmail.com>
 <1538628062.18776.5.camel@HansenPartnership.com>
 <CADvQ+rG0WQjFTU=A4tAACvqFevw51DX_-yq2-9j78T8pSrjcXQ@mail.gmail.com>
Cc:     lkcamp@lists.libreplanetbr.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Robert Richter <rric@kernel.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-m68k@lists.linux-m68k.org, oprofile-list@lists.sf.net,
        linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <765df6c3-0339-ebf3-6446-cef4fc1eb1cc@gmail.com>
Date:   Sat, 6 Oct 2018 17:28:41 +1300
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <CADvQ+rG0WQjFTU=A4tAACvqFevw51DX_-yq2-9j78T8pSrjcXQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 05.10.2018 um 15:16 schrieb Leonardo Bras:
>> Well it's not really that persuasive.  Most people simply let the build
>> run to completion, but if you have a problem with a job control 3h
>> timelimit, then create a job that kills itself at 2:59 and then
>> resubmits itself.  That will produce a complete build in 3h chunks
>> without any need to call sub Makefiles.
>>
>
> Humm, I probably should have explained better how GitlabCI works.
> It works creating a docker container that have a limited lifespan of 3h max.
> After that the time is over, this container ceases to exist, leaving no build
> objects, only the console log. So there is no way of 'resuming' the building
> from where it stopped. I used the 'job' term because it's how they call it,
> and I understand it's easily confused with bash jobs.
>
>> All of our Makefiles are coded assuming the upper level can prevent
>> descent into the lower ones.  You're proposing to change that
>> assumption, requiring a fairly large patch set, which doesn't really
>> seem to provide a huge benefit.
>>
>> James
>
> I understand your viewpoint.
> But what I propose is not to change that assumption, but instead give some
> Makefiles the aditional ability to be called directly and still not build stuff
> if they were not enabled in .config.
>
> But, why these chosen Makefiles, and not all of them?
> Granularity.
> What I am trying to achieve with this patchset is the ability of building
> smaller sets of drivers without accidentally building what is not enabled
> on .config.
> And, in my viewpoint, building a single drivers/DRIVERNAME is small enough to
> be fast in most situations.

That already works, doesn't it? So all that you'd need is an offline 
tool to precompute what drivers to actually build with a given config.

'make -n' with some suitable output mangling might do the job.

There may well be other ways to achieve your stated goal, without any 
need to make changes to the kernel build process (which is the result of 
many years of evolution and tuning, BTW).

> This change is not supposed to bother the usual way of building the kernel, and

Enough people have voiced their concern to warrant that you should back 
up that claim, IMO. Have you verified that your patchset does not change 
current behaviour when building the entire set of default configurations 
for each supported architecture? Does it reduce or increase overall 
complexity of the build process?

> it is not even supposed to add overhead to kernel compilation. And it would,
> at least, solve my problem with the 3h limit, and enable the tool
> I am building on GiltabCI to help other developers.

(Apropos of nothing: Am I the only one who thinks gitlab might take a 
rather dim view of your creativity in dealing with their limit?)

> Thanks for reading,
>
> Leonardo Bras

Thanks for listening!

Cheers,

	Michael
