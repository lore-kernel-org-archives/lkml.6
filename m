Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C47C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A35852064A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="yi3sl9nc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A35852064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730475AbeJBUqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:46:23 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:44757 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728811AbeJBUqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:46:22 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id c36e9f43
        for <linux-kernel@vger.kernel.org>;
        Tue, 2 Oct 2018 14:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=xXGtl1BYH3b3OZvgTyR3YLsG7gk=; b=yi3sl9
        ncQAnqF5IPPXKzDyiQhWDJmZfgR+4jU3bfggjxLA7IZ0OaOAJtljTED8T1iaGjOP
        xNBST08gEFUc61gTflV6X9YjWPdKy8acT83Y6ntK+1aqqNhAof9OE+1I8C8SQS+n
        KbAJur45fbH9wIorunMqnctcZxKLxASw/vm1e6v8qd+8B9OaOvbLEIr58lRHayx/
        9BUg9YyqIqQ0eMSxn0lflYkwA8TxgYEAHEXUgX1+Y70wdtmu3VdBHpXDjJnjFH4Y
        64YS871/RUXON7Be4l/HYC+DW4HfjD4j6NyQFhif4QRmRjrHxcCznPS7VH0c6+c4
        faanAEPkZsoY9rrQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b6064f8f (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO)
        for <linux-kernel@vger.kernel.org>;
        Tue, 2 Oct 2018 14:02:45 +0000 (UTC)
Received: by mail-ot1-f50.google.com with SMTP id c20-v6so1963685otl.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 07:02:48 -0700 (PDT)
X-Gm-Message-State: ABuFfoiMIvhoGHTOgwXEMqkSzx8q8c96RyAyVH5SCCD+erOs+9P0Rp9x
        DFQ5nqgOytmmVCSl65gqyeOWmXA0OygCDpzCOHk=
X-Google-Smtp-Source: ACcGV60RyCBfs3wUFSAs7eVRODZUUhGE0W8wRnpXNc55n115KID2MsdhWYLWXyrDvln/KbvMyTtkGMVKCc25qsD+n/U=
X-Received: by 2002:a9d:48ac:: with SMTP id d41-v6mr9007309otf.144.1538488963292;
 Tue, 02 Oct 2018 07:02:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAKv+Gu8NXyfNAzk4Fe=J0QHEEV-txbRAoEcQmjG-6PgCyW5SZg@mail.gmail.com>
 <20181002132026.14931-1-Jason@zx2c4.com> <CAKv+Gu_mwu+TFrbRPqDZ8i5csSqS26a534yzJ_wAQL_Y+W6F7w@mail.gmail.com>
 <CAK8P3a06uOvGcju7MppqqhsR5dwPKUBawrDbGYNXURqxGsZOKw@mail.gmail.com>
In-Reply-To: <CAK8P3a06uOvGcju7MppqqhsR5dwPKUBawrDbGYNXURqxGsZOKw@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 2 Oct 2018 16:02:31 +0200
X-Gmail-Original-Message-ID: <CAHmME9ozKiYvBz2zGoxKBZuYLcqqsDDddsvcUEeEWtMwCcaGuQ@mail.gmail.com>
Message-ID: <CAHmME9ozKiYvBz2zGoxKBZuYLcqqsDDddsvcUEeEWtMwCcaGuQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: makefile: use ARMv3M mode for RiscPC
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>, arm@kernel.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 2, 2018 at 3:54 PM Arnd Bergmann <arnd@arndb.de> wrote:
> Please add this to Russell's patch tracker for inclusion at
> http://www.arm.linux.org.uk/developer/patches/

Wild! And done:
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8801/1
