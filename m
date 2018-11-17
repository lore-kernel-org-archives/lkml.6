Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD891C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 06:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96DC92084A
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 06:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g.ncu.edu.tw header.i=@g.ncu.edu.tw header.b="VldLsqoo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96DC92084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=g.ncu.edu.tw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbeKQQsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 11:48:39 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:36805 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbeKQQsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 11:48:38 -0500
Received: by mail-oi1-f175.google.com with SMTP id r127-v6so21465902oie.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 22:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g.ncu.edu.tw; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RlxmfE4tt152fRRlCJtSNo8MILBqGkvG/pauVYVjLcU=;
        b=VldLsqoofB6seR5qEdtcwQqZ1bA3y5bPTxaTU8Lr3H7KQxQZxvZ9RFn2eJuO1V5V/7
         H72BxWjUOXLpRZNKOhkksLxT17c9NBhy83SDYZdda3ZWYumsQC0gmBtDCfC69QNc+UPE
         ikeO3PaRlK/CvEHv3eTnANvp/+vPQ3LZyAUtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RlxmfE4tt152fRRlCJtSNo8MILBqGkvG/pauVYVjLcU=;
        b=Rzdk6nujAAvg7dZdy9Z56NEsdJKQht2Ng4fgi01x/PaKD5FXrLsJQiJut1cNvMZu2y
         +EaNLCsbU6DQub95VBk86FmtJuc8V8X1Du94O2uG7qLeJJeRzI5Kb+HhFsRiU4ZkFyW3
         V8yoywcKsMbdzFBWw6UZkvXu6tAoTnMH0oFWlnF3e4xEN3FAwyJdlBDuI1Wr8P14xBlj
         1THZEfayPY0230qck4F7vJ6h0lT8Ne60XjosUD0wA/O+F+gk2u2p5wCQhDq83fsVdkEt
         KYS89ix0oiuBDBwx3EhTwNwHM9MjfcHd8Z27HyNOGzq5mywHv4JrmQGA4vnMrgUgH1lm
         2/hg==
X-Gm-Message-State: AGRZ1gKSR7CMaN1SEKSF0YieZD5N7ybeEvnIxCP30BflXDVNimT7ZSbp
        yJvahaicg5ozarRiH300v1QmkA==
X-Google-Smtp-Source: AJdET5fvJlnWaXkxtqkryVSX96TIZY7CAh/j1swdMPM1w0jIoUoOXMN+KIubYTIjZwvOCI2pkhPp/w==
X-Received: by 2002:aca:2dc9:: with SMTP id t192mr2765420oit.325.1542436380273;
        Fri, 16 Nov 2018 22:33:00 -0800 (PST)
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com. [209.85.210.44])
        by smtp.gmail.com with ESMTPSA id k132-v6sm11183560oia.46.2018.11.16.22.32.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 22:32:59 -0800 (PST)
Received: by mail-ot1-f44.google.com with SMTP id g27so23382999oth.6;
        Fri, 16 Nov 2018 22:32:59 -0800 (PST)
X-Received: by 2002:a9d:325:: with SMTP id 34mr8461115otv.94.1542436378671;
 Fri, 16 Nov 2018 22:32:58 -0800 (PST)
MIME-Version: 1.0
References: <20181105.101610.1437737564548154497.davem@davemloft.net>
 <20181114160126.4445-5-starnight@g.ncu.edu.tw> <20181116.203250.116640520195643915.davem@davemloft.net>
In-Reply-To: <20181116.203250.116640520195643915.davem@davemloft.net>
From:   Jian-Hong Pan <starnight@g.ncu.edu.tw>
Date:   Sat, 17 Nov 2018 14:32:59 +0800
X-Gmail-Original-Message-ID: <CAC=mGzgeh=qh-FBBiwKH=4aNxVcrfqojtTWkdVLy3FkF9a9V3w@mail.gmail.com>
Message-ID: <CAC=mGzgeh=qh-FBBiwKH=4aNxVcrfqojtTWkdVLy3FkF9a9V3w@mail.gmail.com>
Subject: Re: [PATCH V3 4/7] net: maclorawan: Add maclorawan module declaration
To:     "David S. Miller" <davem@davemloft.net>
Cc:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        netdev@vger.kernel.org,
        "<linux-arm-kernel@lists.infradead.org\\" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org>," <linux-kernel@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        Stefan Schmidt <stefan@datenfreihafen.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller <davem@davemloft.net> =E6=96=BC 2018=E5=B9=B411=E6=9C=8817=E6=
=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=8812:32=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> From: Jian-Hong Pan <starnight@g.ncu.edu.tw>
> Date: Thu, 15 Nov 2018 00:01:25 +0800
>
> > + * @rx1_window:              RX1 window opening time in mini-seconds
> > + * @rx2_window:              RX2 window opening time in mini-seconds
>
> What is a "mini-second"?

Spelling mistake.  It should be millisecond.
Thanks for pointing out
