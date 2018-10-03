Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BDEC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 500A72082A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="djMwAbp7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 500A72082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbeJCUty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 16:49:54 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:42789 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726755AbeJCUty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 16:49:54 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id d281dbe3;
        Wed, 3 Oct 2018 14:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=irW8/nv4hDRPd3Ssx7ZBho/Ljqo=; b=djMwAb
        p7QWc+M3jcw3txjTOdWLFaDNwb2v8NCS371g9o2xA6zZLx6WbeBG391dzdfMZhFd
        FW3/jCrzb9+u9ywcZSwzfQP5n7vnqzKVlPylU794YMT/vEAV+8lAPJ0i/Lq2eNZq
        S7qS+LqxICkXCZ2bKE0BYFtMXuFOY3nGUu/ESvDH9K2VAX4AXI3Bps0mPbHB1mnM
        LTiJuOW2z74mlAcTiShK16z1RqCIN0lDqiFpb3ZQhe56CI+r69NyHkl3bqCWgUXZ
        PPHuNLihV9EL7Bu9470Ixs3BX5YnOxDq3P00pQ0OOO+lI0ScxV4Tb40EZcZIVCld
        xCvv0ZHIJafvP0Yw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id cdb25dfe (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Wed, 3 Oct 2018 14:01:08 +0000 (UTC)
Received: by mail-ot1-f44.google.com with SMTP id i12-v6so5669580otl.1;
        Wed, 03 Oct 2018 07:01:19 -0700 (PDT)
X-Gm-Message-State: ABuFfoh2zBu+UsWXRqmA0oqQQN94JMbJfn8HHsV/Gi1+yR9OCqFLFaZl
        V4XRde6OroWvlH/AfexpZa9ZrPReD0dcxAwTgWw=
X-Google-Smtp-Source: ACcGV610S+yC59o+aJbXQDTMRDyI091bC+pytQoHw7FVeXsHDzGookv8+fLPcpkh/yg+kSb6JXchlxVb6DzwDckDopY=
X-Received: by 2002:a9d:1d47:: with SMTP id m65mr960946otm.199.1538575278368;
 Wed, 03 Oct 2018 07:01:18 -0700 (PDT)
MIME-Version: 1.0
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-22-Jason@zx2c4.com>
 <20181003055559.GA745@sol.localdomain>
In-Reply-To: <20181003055559.GA745@sol.localdomain>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 3 Oct 2018 16:01:06 +0200
X-Gmail-Original-Message-ID: <CAHmME9qxND1UR0SN6TLQb39f0wz0tiwJWfd7PKeQZ0-W+no39Q@mail.gmail.com>
Message-ID: <CAHmME9qxND1UR0SN6TLQb39f0wz0tiwJWfd7PKeQZ0-W+no39Q@mail.gmail.com>
Subject: Re: [PATCH net-next v6 21/23] crypto: port ChaCha20 to Zinc
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andrew Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Wed, Oct 3, 2018 at 7:56 AM Eric Biggers <ebiggers@kernel.org> wrote:
> Multiple threads may use the same tfm concurrently, so the tfm context must not
> be used to store per-request information such as the IV.

Thanks, fixed for v7.

Jason
