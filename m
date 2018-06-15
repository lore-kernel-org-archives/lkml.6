Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D3E4BC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 14:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2877B208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 14:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rNJpW1j3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2877B208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936313AbeFOOLC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 10:11:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:55032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932360AbeFOOLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 10:11:00 -0400
Received: from mail-wm0-f51.google.com (mail-wm0-f51.google.com [74.125.82.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 207E1208DD;
        Fri, 15 Jun 2018 14:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529071860;
        bh=Di0+uXJ3VKlH4BGK9M4ZEjcvdWkEW4t69fhXOLtJjjM=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=rNJpW1j3asmtWrhPBJQ/lXLVve2SR6AOUyawCZuuVQwY46/qzAgwmA1kRSj1gn4o2
         Sg/SeAvyMFDmxuSrV8HiPu+ksI9+dKZWgVHLc5mAidCM5T+KZ6y/diLxM0eW3Aw+Jr
         3FXqlTIyOYYYIavqgxis0FLAFLseOcLS7rLviywk=
Received: by mail-wm0-f51.google.com with SMTP id r15-v6so3790294wmc.1;
        Fri, 15 Jun 2018 07:11:00 -0700 (PDT)
X-Gm-Message-State: APt69E037N6YJbjdgZ3M8vGGodp2NzV3lnmbIIrozOBphcAGipFiZQsj
        UlpbtLaGJvqjr8JsfLKilpNamZlPzHYZSk7zLQM=
X-Google-Smtp-Source: ADUXVKLHUzKpWsVb8CexDulg1+DsWa/NvKph8RwjNb0Wb5DCAg9tpKRDIQ/9oHzg+k22GG3e9Y/0LEJ+cUWiEAgeQhk=
X-Received: by 2002:a1c:c05:: with SMTP id 5-v6mr1489592wmm.117.1529071858632;
 Fri, 15 Jun 2018 07:10:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9166:0:0:0:0:0 with HTTP; Fri, 15 Jun 2018 07:10:58
 -0700 (PDT)
In-Reply-To: <CAJKOXPfX0CytKcYDaDAYYuCQjk-mcGjFRHfZco-wPQsc4G1agA@mail.gmail.com>
References: <CAJKOXPd2rntNOpU1quR9Zm_J22+=pEaj4ZTC_tdZ0zcRYUciFg@mail.gmail.com>
 <CAPKp9uZ79ybkv7dMpcy2GQ9L+rWk+vdExQ48diWWQPOUdDQtSQ@mail.gmail.com> <CAJKOXPfX0CytKcYDaDAYYuCQjk-mcGjFRHfZco-wPQsc4G1agA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 15 Jun 2018 16:10:58 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcmV7qvSuNwcQNDrwQSg3=674Gw_kNfkPHac_Vh9JcWVw@mail.gmail.com>
Message-ID: <CAJKOXPcmV7qvSuNwcQNDrwQSg3=674Gw_kNfkPHac_Vh9JcWVw@mail.gmail.com>
Subject: Re: [BUG BISECT] NFSv4 client fails on Flush Journal to Persistent Storage
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Trond Myklebust <trond.myklebust@primarydata.com>,
        linux-nfs@vger.kernel.org,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 4:07 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> I test it on systemd versions 236 and 238... and it fails on both.
> However one board passes always - it is Odroid HC1 with same core
> configuration as described before. Probably there is some different SW
> package on it.
>
>>> Let me know if you need any more information.
>>>
>>
>> Also I was observing this issue with Linus master branch from
>> the time the above patch was merged until today. The issue
>> is no longer seen since this morning however I just enabled lockdep
>> and got these messages.

About this lockdep error - I see it for very long time and it appears
always (see end of serial log here:
https://krzk.eu/#/builders/21/builds/707/steps/10/logs/serial0). It
started much before this issue came so I am not sure whether it is
related.

Best regards,
Krzysztof
