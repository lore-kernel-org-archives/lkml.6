Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C94ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 23:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20F0120881
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 23:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="b0+spVro"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20F0120881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbeIPFJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 01:09:49 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:54653 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbeIPFJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 01:09:49 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id d9720293;
        Sat, 15 Sep 2018 23:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=clQV7eKZuw0YehQb3mEbrwANDuQ=; b=b0+spV
        ro9oNgVinuCxb5cdofUm4/97IE95gxppXm98QsgZckltcgmfcYXMpmHXNWA5ppO8
        WaQlyDGTW902+rVD2jg3qamEqaRWbDZgMCRKTuEwaykZocbpK1lNNcxRTmkly0+f
        ipy1Gs5bP9twV+JYdmde5ZXBKZNPH0voV9T17ET/1zIpd6yDuVhjFesXzVd2Zcxw
        NFFPTtUzlTLJLVeeaj94zTsnIKCVmVBdmHJa0pwd2nlMWj9aqLfsMJDF4qnEsvi7
        kHK5tkeXjed0p+G34sN7MgRdpwcFN09CezGmglSatlk2BVvu2mPry5YYmQa9KfzI
        kvb1+dSxVCFhWHOw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 9d1cbf7a (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Sat, 15 Sep 2018 23:31:45 +0000 (UTC)
Received: by mail-ot1-f41.google.com with SMTP id v44-v6so7938357ote.13;
        Sat, 15 Sep 2018 16:48:58 -0700 (PDT)
X-Gm-Message-State: APzg51ARavqPpgKqqdBSk7+6hGOit+0KdFHmsIKm3gPuB5T1l3wzrsJw
        EJon/XLa7tUYkBGckm/ZHEXeXCyksW2Vx95S5UQ=
X-Google-Smtp-Source: ANB0VdZFCQ6HHVmWPUXqZ49XNFdN4etGzIwjy5rDItmeKRZny8M0d/dzughQHptvm/52cunLKgq7UsTtxwTdwxYFi30=
X-Received: by 2002:a9d:3a34:: with SMTP id j49-v6mr8333046otc.317.1537055338144;
 Sat, 15 Sep 2018 16:48:58 -0700 (PDT)
MIME-Version: 1.0
References: <20180914162240.7925-21-Jason@zx2c4.com> <201809160701.EQDrNg4f%fengguang.wu@intel.com>
In-Reply-To: <201809160701.EQDrNg4f%fengguang.wu@intel.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sun, 16 Sep 2018 01:48:46 +0200
X-Gmail-Original-Message-ID: <CAHmME9p9z_aO_9FS7ouCOPG3dCENgBPzUs=Rc0ciaiY9kCK3RA@mail.gmail.com>
Message-ID: <CAHmME9p9z_aO_9FS7ouCOPG3dCENgBPzUs=Rc0ciaiY9kCK3RA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 20/20] net: WireGuard secure network tunnel
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mr. Ro Bot,

Looks like this is related to stack frames with KASAN. I've fixed this for v5.

Thanks,
Jason
