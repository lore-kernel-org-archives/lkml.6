Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A717ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5EB52088F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ipshkYID"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5EB52088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbeIQSmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 14:42:05 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:42413 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726865AbeIQSmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 14:42:05 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id a4947330;
        Mon, 17 Sep 2018 12:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=1ym2pWLMVwmT5x0pyZWK555yauM=; b=ipshkY
        ID3hMlLQe+Loadmxl8HGrJBWrNL0M83Qbz0W+TD6/BRpGBvoYPputUUepMyr5mkS
        kOxFlzgaUKWl3f4c69a3ZKaDrpK2r+LkRE8yfooQvYi7qo5L0PyffxZxkrftbnJk
        +NcgYj1rOjgedJJHsdjxE18bktdI04w6VvKifnyWqIlHBDRORbBqmgwAQ6WbBWbv
        16pI87iI/A45kF9Id2LPvPLMfIplP7at+nLOafsJZCOHK6umJw8btwTl8eSf34QG
        bIH3K/IO4RzJEcFXqUW8xl69PojfRy5o4HkRm3gcJejWr3X5B4ApyY4xtFJlIpfB
        F1PZvvB6j0reIIBQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ef8ce5b5 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Mon, 17 Sep 2018 12:57:18 +0000 (UTC)
Received: by mail-ot1-f53.google.com with SMTP id u20-v6so11190181otk.10;
        Mon, 17 Sep 2018 06:14:44 -0700 (PDT)
X-Gm-Message-State: APzg51D03fu55zuC73gxj3mCzDf8qnb2YQcImVN3u5BbLTQVR393fDm0
        OgGNBNH+F6rgY9FHiktHhTauDfRGFZgcgb8diGk=
X-Google-Smtp-Source: ANB0VdYlkw16CQKJJ+tnoyJ6fR6iHfKFpRmYvSBK17B4k+tTWhTz5DlUAv3FF6YoBimgNqGefzs3YAyUd3aXNSL7wic=
X-Received: by 2002:a9d:2dc8:: with SMTP id g66-v6mr12036495otb.311.1537190083420;
 Mon, 17 Sep 2018 06:14:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180911010838.8818-1-Jason@zx2c4.com> <20180911010838.8818-2-Jason@zx2c4.com>
 <20180912061433.GA8484@ip-172-31-15-78> <CAHmME9pmgu_xWJ0rvdS4RhzwjKPiNdkQ9nc6mqTNeb6A8xT8Eg@mail.gmail.com>
 <20180913050301.GA26367@ip-172-31-15-78>
In-Reply-To: <20180913050301.GA26367@ip-172-31-15-78>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 17 Sep 2018 15:14:32 +0200
X-Gmail-Original-Message-ID: <CAHmME9pGCwoS25c7KM+bHAzn5P+nquiwyoLsY-_Nu67RVd6Giw@mail.gmail.com>
Message-ID: <CAHmME9pGCwoS25c7KM+bHAzn5P+nquiwyoLsY-_Nu67RVd6Giw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 01/17] asm: simd context helper API
To:     kevin@guarana.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Samuel Neves <sneves@dei.uc.pt>, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Kevin,

I found numerous other advantages in doing it the way you suggested
(which also helped squash some bugs), and so this will be part of v5.
Thanks for the suggestion.

Regards,
Jason
