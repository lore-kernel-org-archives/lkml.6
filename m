Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98192C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 04:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BF1720645
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 04:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=earthlink.net header.i=@earthlink.net header.b="EEwEFurr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BF1720645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=earthlink.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbeH3Iph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 04:45:37 -0400
Received: from elasmtp-mealy.atl.sa.earthlink.net ([209.86.89.69]:50488 "EHLO
        elasmtp-mealy.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725904AbeH3Ipg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 04:45:36 -0400
X-Greylist: delayed 25655 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Aug 2018 04:45:36 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=earthlink.net;
        s=dk12062016; t=1535604320; bh=74YuXKyGuIPm6TN2ftzViNxJLd8H0MT9vUcB
        JdX7oYU=; h=Received:Content-Type:Mime-Version:Subject:From:
         In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:
         References:To:X-Mailer:X-ELNK-Trace:X-Originating-IP; b=EEwEFurrMz
        UWACT/pD3S7UkGfOM09akG6+0W2/uHhZaOwZ6Oq6HknnptGrTRrjCkWvmoLD2kEEkU7
        yWIQ/gc1NDa5lE+sOGXgHXGUQLHrecZ65e+79igW2lJxl9sKV8bmrZHLjVi+qMllOO0
        VQheicBFkny3ib/GJgS4gTMg3tBtDELlnX/yvbRxr1S/awRp5IHhNkw/e/S3wWsczUK
        JpwPbeXjLFVnCRB7FX3/Plz3t6aZZBVxKE+rcR0EBKe4KDB5pbvfPsZxZpWfM6JI2Or
        rXbigIzf5TOw28WrE24kNSG1zLz/6XVvghp8U3mzUL1z1Yb0eR7hULWIzuapdhMQ==
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=dk12062016; d=earthlink.net;
  b=P2KyHJaGNqRfJLy+gX/7LrfaLtLjzymWJ75PxRy+vURQLJn9+Bteahcjm/5zeZdFpT/8L3BVozzwsInR6dJiQ1uTQdFcdV85DAyx2YDADlrMu7z7WMRONQ4Bfqy2PB6v+P3oSak1BfOtTGCA1Uizcmil5fmqPiwHB5l0ldwwhDfeOWhW/TzlXmNkF8jWqluSay7QVwsY7yBDN/F+wTh41KzGZwKcRrtWhWh5P2ER8NkPGTDciOMLOSSc1AWtMMCgNKIZdRAisRBWY1jIUZ4hud5N6ZYZKq5RskqyOCn/GFeQG1poRsfsAPS9v8lj7FyECIkFVDp2NpCACpuARBir1A==;
  h=Received:Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:References:To:X-Mailer:X-ELNK-Trace:X-Originating-IP;
Received: from [24.6.250.120] (helo=[10.0.0.43])
        by elasmtp-mealy.atl.sa.earthlink.net with esmtpsa (TLSv1:ECDHE-RSA-AES256-SHA:256)
        (Exim 4)
        (envelope-from <erblichs@earthlink.net>)
        id 1fv8B7-000D0U-H1; Wed, 29 Aug 2018 17:39:05 -0400
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [Bug #16626] Machine hangs with EIP at skb_copy_and_csum_dev
From:   Mitchell Erblich <erblichs@earthlink.net>
In-Reply-To: <20100831192659.GA3093@del.dom.local>
Date:   Wed, 29 Aug 2018 14:39:02 -0700
Cc:     Plamen Petrov <pvp-lsts@fs.uni-ruse.bg>,
        "Rafael J. Wysocki" <rjw@sisk.pl>,
        Kernel Testers List <kernel-testers@vger.kernel.org>,
        Maciej Rutecki <maciej.rutecki@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <10B93621-9D01-4A72-A483-FAC185ACB66A@earthlink.net>
References: <4LwrqITm-eJ.A.r8G.eFueMB@chimera> <4AUWBNzTkbD.A.ey.cGueMB@chimera> <courier.4C7C99F2.00001F74@fs.ru.acad.bg> <20100831192659.GA3093@del.dom.local>
To:     Jarek Poplawski <jarkao2@gmail.com>
X-Mailer: Apple Mail (2.3124)
X-ELNK-Trace: 074f60c55517ea841aa676d7e74259b7b3291a7d08dfec795a3a43304d9c16bc411c277489a30ffa350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 24.6.250.120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

						OLD REPLY =E2=80=A6 and =
Correcting . Suggesting of Corrections of LONG TERM embedded problems=20

Summary:

		Due to watermark awareness differences that is =
problematic in embedded systems, the GFP_ATOMIC which is not memory =
watermark aware is used in interrupt / atomic context.

		To properly monitor WATERMARK levels at suggested kernel =
locations, the =E2=80=9CPROPER=E2=80=9D GFP_FLAG SHOULD be GFP_NOWAIT. =
This is atomic/interupt friendly and is aware of memory watermarks, thus =
if memory is below the specified watermark level, it will then return a =
ENOMEM from that location.

					GFP_ATOMIC will not return =
ENOMEM and by the time the watermarks drop, ALL GFP_KERNEL callers are =
now SLEEPING.

					Please be embedded friendly with =
code patches=E2=80=A6

		FYI: Embedded system due to no 2ndary drive can not =
clean PTEs (page frames), thus callers need to be aware of low memory =
issues and be able to reduce their memory consumption based on receiving =
ENOMEMs. GFP_KERNEL callers will just sleep until memory is back above =
the watermarks.

Mitchell Erblich
erblichs@earthlink.net



> On Aug 31, 2010, at 12:26 PM, Jarek Poplawski <jarkao2@gmail.com> =
wrote:
>=20
> On Tue, Aug 31, 2010 at 08:58:10AM +0300, Plamen Petrov wrote:
>> Rafael J. Wysocki ????????????:
>>=20
>>> This message has been generated automatically as a part of a summary =
report
>>> of recent regressions.
>>>=20
>>> The following bug entry is on the current list of known regressions
>>> from 2.6.35.  Please verify if it still should be listed and let the =
tracking team
>>> know (either way).
>>>=20
>>>=20
>>> Bug-Entry	: http://bugzilla.kernel.org/show_bug.cgi?id=3D16626
>>> Subject		: Machine hangs with EIP at =
skb_copy_and_csum_dev
>>> Submitter	: Plamen Petrov <pvp-lsts@fs.uni-ruse.bg>
>>> Date		: 2010-08-19 09:57 (11 days old)
>>> Handled-By	:  Eric Dumazet <eric.dumazet@gmail.com>
>>>=20
>>>=20
>>=20
>> Should "generic receive offload" work on a forwarding setup?
>> If yes - then the bug should remain open.
>> If not - then it's my mistake.
>=20
> If/since it's on by default it should work and it definitely can't be
> your mistake. (Unless we can't find the real reason... ;-)
>=20
> Jarek P.
> --
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

