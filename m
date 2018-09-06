Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B181C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 19:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 095632075E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 19:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cQWrCf+r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 095632075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbeIGALJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 20:11:09 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:36382 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbeIGALJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 20:11:09 -0400
Received: by mail-it0-f67.google.com with SMTP id u13-v6so16529946iti.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 12:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9yc7I4G5vbLVhFRZe4S7B81LJCOZmusl0uzsPEddW50=;
        b=cQWrCf+r3Zx7SvEh3KCfAt/hLaSnwz7Yn1pd7gjdX0R0AH8Xwwg+VzTSnd9RkQ78pg
         CgfiJTMq3PWeqeE1NdfJwDtTHFRJLqDvSOfb2dcAlGnE3HersWKn8TtilOnW0sh5UWEC
         eH0zMjXcCTwW/UdSX8AzSeqCX8HHopRrD8a8GO9GPNXZY/QPkhsC9uPKPjAlUXhLABUW
         53GZQYScRJOteDBdEtl5E7PwmyHlApgyWKACgjeIdqyVJzh+l1d8B+/TuCEFxc31c22e
         XQAzv9ASbns6fINufSTmAD+JFgmvVq+dkazD7j204aM8Dp5INr8BO/000Da2/cBG66We
         XDdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9yc7I4G5vbLVhFRZe4S7B81LJCOZmusl0uzsPEddW50=;
        b=lXT4FEIvkPkYIOCY/DL849D4QPQRgA1yCM4M2pbXtz8DiFbcUC/Num+LY1IwNbsh3R
         6xSvQacYouY27gR7V1uPOPgA3rA3M7DHdNk4oIjdeI0qymqxN6IHoueUZvdLhFPLjvh0
         M8E9E6cJjKibH0bVoBuRTqQ2ha5qksfC9GRhXW84dw9w75bahnF2NnGGOwNsajSt2WyV
         GOVbcdthlPkZHnBTXtWCXJI4bRlC/j2fwSasTgcKpXJXnPi67HGWYc15qtYJ55aPd9xY
         IvWUz220WYT5JFdyGCuVsclxTVar80Db6C/3hQOrHEowvPfnMOswu7xv4uNQcr1EEpiv
         w4Vg==
X-Gm-Message-State: APzg51BObWxPhOV396PfVVqnkA6rqXEzX7a96vIg4Co95ij5ZNKpS+10
        0AkCi+/aODWeR3cm0YYqDyxy/pbd66k6X/IGUsbIkw==
X-Google-Smtp-Source: ANB0VdZ76mOgU2kCYgFyHQi3+zRXj6lWeilyvEFPP+AmfrKvYclhMHheWZmdRhHbr6PPF1fVHlhfcNxvduMJpA0upH4=
X-Received: by 2002:a02:c4c6:: with SMTP id h6-v6mr3643136jaj.26.1536262451541;
 Thu, 06 Sep 2018 12:34:11 -0700 (PDT)
MIME-Version: 1.0
References: <20180906192034.8467-1-olof@lixom.net>
In-Reply-To: <20180906192034.8467-1-olof@lixom.net>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 6 Sep 2018 12:33:58 -0700
Message-ID: <CANn89i+akEWrHELBkZJQOxok-ZfYy+FNPUWdPEfB6c4YyWLqJA@mail.gmail.com>
Subject: Re: [PATCH] net/sock: move memory_allocated over to percpu_counter variables
To:     Olof Johansson <olof@lixom.net>
Cc:     David Miller <davem@davemloft.net>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Vladislav Yasevich <vyasevich@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-sctp@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        linux-decnet-user@lists.sourceforge.net,
        kernel-team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 6, 2018 at 12:21 PM Olof Johansson <olof@lixom.net> wrote:
>
> Today these are all global shared variables per protocol, and in
> particular tcp_memory_allocated can get hot on a system with
> large number of CPUs and a substantial number of connections.
>
> Moving it over to a per-cpu variable makes it significantly cheaper,
> and the added overhead when summing up the percpu copies is still smaller
> than the cost of having a hot cacheline bouncing around.

I am curious. We never noticed contention on this variable, at least for TCP.

Please share some numbers with us.
