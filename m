Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F477C65BAF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22D4320645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aNrvuw4W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22D4320645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbeLGKBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 05:01:07 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35901 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbeLGKBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 05:01:06 -0500
Received: by mail-wr1-f68.google.com with SMTP id u3so3229094wrs.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 02:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=KTrgKZ7XMVslfV/vKvMZa8+Nk1ppKsTfGuP7Gy2lJcI=;
        b=aNrvuw4WXIdoyOIbrHtlCDuOgx/RrN+wC4ZYBMsw8Yh1Gdv955aRjn/EyS10cbJ3Oc
         Wx15an9FxVzbVNF3Wsc1IvD4ZqMyKFk4whtq0t5ihwgnWouWqj1DBkVCPF+yTgDx7uI7
         xg5WaiTbUXP+OuoqdPjHXOFuVi8MR248OoZso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=KTrgKZ7XMVslfV/vKvMZa8+Nk1ppKsTfGuP7Gy2lJcI=;
        b=ZcbdZLLi18y9F8j1BLgrp/xrDIJ//Vnv0eMdD0CC9nqY9p00bBc3mADxShSxz7scY3
         XiHOAF7yuVJI/YkWB00F8nvpxutRSTASPYyquOZKiRu7iqiqhaGX0dnNBzz8AyxJL6Yv
         VQVye8wWIkwkkJnsEUU4FQ9zk5xbfsE6P0wLoEkaXjJiXVEeoMGY3K+tzeATspx7tx9E
         YjDBR+0ppX/3ZUnA+arjqcLckGuqbrtiXBUw39d+qeDsSJUToC1x+v3VKTSQFLIHXUUt
         pzlBbnGT3kM8l72qFd1EE/44S79Qxp7fBhXFoYUyK+gsXy3M7ILLn7M3OAyczxsUMJyo
         SUAg==
X-Gm-Message-State: AA+aEWYg1h2huEBhXXJ/vgw+fWW8sQjmHPxChAAM8/FbGHw3QNbtwISB
        Z80ZBEV2lUPbY82W5QEH77wNXO0X+Kg=
X-Google-Smtp-Source: AFSGD/VmtcbLbgxKe/u/THwA15xoaZTnvFR38tMr1g67KP78N1AZhmHQALcHAURKB6oNW6vZnpamhg==
X-Received: by 2002:adf:92a4:: with SMTP id 33mr1209953wrn.11.1544176864670;
        Fri, 07 Dec 2018 02:01:04 -0800 (PST)
Received: from wifi-122_dhcprange-139.wifi.unimo.it (wifi-122_dhcprange-139.wifi.unimo.it. [155.185.122.139])
        by smtp.gmail.com with ESMTPSA id h12sm7927220wma.48.2018.12.07.02.01.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 02:01:03 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [PATCH BUGFIX 0/2] bfq: fix unbalanced decrements causing loss of
 throughput
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <09393ef1-9559-2042-6c83-75ed3fd529d3@kernel.dk>
Date:   Fri, 7 Dec 2018 11:01:03 +0100
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, federico@willer.it
Content-Transfer-Encoding: quoted-printable
Message-Id: <8753C347-2BFD-40D4-A97E-DA955BC0207C@linaro.org>
References: <20181206181819.11148-1-paolo.valente@linaro.org>
 <09393ef1-9559-2042-6c83-75ed3fd529d3@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 7 dic 2018, alle ore 03:23, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> On 12/6/18 11:18 AM, Paolo Valente wrote:
>> Hi Jens,
>> the first patch in this series fixes an error in the decrementing of
>> the counter of the number of groups with pending I/O. This wrong
>> decrement caused loss of throughput or, less likely, of control on
>> I/O. The second patch is a fix of some wrong comments, which somehow
>> contributed to making the above bug more difficult to find.
>=20
> Are you fine with this going into 4.21? I can't quite tell what your
> intent is. The first patch has a Fixes for something

yep, that fixes a serious error.

> that went into
> this series, but then patch 2 is a comment update that would not
> normally be something to be applied at this stage.
>=20

and yes, only comments changed by the second one

May it make sense to apply them in two steps, one in the 4.20 and the =
other one in the 4.21?

Thanks,
Paolo

> --=20
> Jens Axboe
>=20

