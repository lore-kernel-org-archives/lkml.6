Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1F4C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29FC5216FE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="LesRW5Eo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29FC5216FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbeI1Cvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 22:51:49 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46972 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbeI1Cvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 22:51:48 -0400
Received: by mail-io1-f68.google.com with SMTP id y12-v6so2801605ioj.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 13:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:from:message-id;
        bh=xCH7yiyLXlZr1Up+3oAqIzJNXN+8X2mepSDlKKTs+Tw=;
        b=LesRW5EoReyVs98A290jIzK2y0W67wsQet85vJbOHxajaLR92A/MDD82SFCZ+3Mbfn
         qonWiVRBUfpJAHqVlwWY6hUil3+2VHRdfr5/ZL/W3U7qDh3OF2fDNM37eiNrMFDVaGNT
         WbdlZi5goPcBdAk4hfvyq7FtrM2MYY9lO40tKwFkKU1TjUTuImbSiFtqzscuyKx89Ihv
         r15XId5suUV9Qz9piuWUzpEv47o7I10ZbmQqzWzB546PBlL122YI4aC5r4lF4A23j2dP
         JZtdwxQOhT2SfkKfT261Jmd0kLX4xMpBhr59zJHeHdPoOl1MFtRU93k9Xx0Z58IzWaOF
         aZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:from:message-id;
        bh=xCH7yiyLXlZr1Up+3oAqIzJNXN+8X2mepSDlKKTs+Tw=;
        b=CYISSaB8XzQsQzur+tz4ZTo/7IlHzY58riOXGVctO50zYEdrRI98PGujpZ6X5u7Eul
         xWmu9/8oO1vFNNbuylPzz4UTRG2cgI3G8PAPfl9wQh7DRrbc2oGfnPG9rFDYInmITHaw
         fME0ZJpNNZeTyy6M52xYTrCrR7eA6LTC8wFNZK3Yyq2BqZ4aNW4iSowGfZkpT53Irs3Q
         QuO6mPvobKrJqDeqafrHb+hGXkY5Z5EChnNikrTlOlgmgQ1wtQ+lLQluhrwE/f0iG4pq
         07LnOgLtm9obE5Bt/pORTgjDz0PkFlDnaMLIjy64TY+pXnXydMl5eq23jVvusW0ZQ01e
         kyRA==
X-Gm-Message-State: ABuFfoixlgeLbP8mzaL0B2n3HRafWnQv3Ga9DKAYsG7WyrwoEa4igTPP
        tRCLAaNi/JATxRvOATc5LqUqhA==
X-Google-Smtp-Source: ACcGV60ET4RMGz3PPN5mjKMKSMxpwKxtMBcJ1eUHZaauBq1x6a3FyDNwCeOAsj8j0Q99oQoQJ/NfLQ==
X-Received: by 2002:a6b:203:: with SMTP id 3-v6mr9779181ioc.131.1538080304033;
        Thu, 27 Sep 2018 13:31:44 -0700 (PDT)
Received: from [26.66.85.135] ([172.56.12.112])
        by smtp.gmail.com with ESMTPSA id k81-v6sm1259187ioe.26.2018.09.27.13.31.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 13:31:42 -0700 (PDT)
Date:   Thu, 27 Sep 2018 22:31:37 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <e7ec6202-7d4b-8dc1-1b25-76325129ba6f@gmail.com>
References: <20180927175857.3511-1-christian@brauner.io> <e7ec6202-7d4b-8dc1-1b25-76325129ba6f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next 0/7] rtnetlink: add RTM_GETADDR2
To:     David Ahern <dsahern@gmail.com>, jbenc@redhat.com,
        davem@davemloft.net, stephen@networkplumber.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Christian Brauner <christian@brauner.io>
Message-ID: <15579097-D689-4CBC-AE9E-B554527C71DF@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On September 27, 2018 10:24:36 PM GMT+02:00, David Ahern <dsahern@gmail=2Ec=
om> wrote:
>On 9/27/18 11:58 AM, Christian Brauner wrote:
>> Various userspace programs (e=2Eg=2E iproute2) have sent RTM_GETADDR
>> requests with struct ifinfomsg=2E This is wrong and should have been
>> struct ifaddrmsg all along as mandated by the manpages=2E However, dump
>> requests so far didn't parse the netlink message that was sent and
>> succeeded even when a wrong struct was passed along=2E
>
>=2E=2E=2E
>
>> The correct solution at this point seems to me to introduce a new
>> RTM_GETADDR2 request=2E This way we can parse the message and fail hard
>if
>> the struct is not struct ifaddrmsg and can safely extend it in the
>> future=2E Userspace tools that rely on the buggy RTM_GETADDR API will
>> still keep working without even having to see any log messages and
>new
>> userspace tools that want to make user of new features can make use
>of
>> the new RTM_GETADDR2 requests=2E
>
>First, I think this is the wrong precedent when all we need is a single
>bit flag that userspace can use to tell the kernel "I have a clue and I
>am passing in the proper header for this dump request"=2E

That had been NAKed previously but if you have an idea that will be accept=
ed all the more power to you=2E

>
>Second, you are not addressing the problems of the past by requiring
>the
>proper header and checking values passed in it=2E

I don't follow=2E RTM_GETADDR requests are absolutely unchanged=2E The ful=
l legacy behavior is restored by this patchset=2E

And requiring that RTM_GETADDR2 requests always pass the correct header is=
 absolutely fine=2E We don't want built invalid legacy behavior into a new =
request  type=2E

>
>I have another idea=2E I'll send an RFC patch soon=2E

