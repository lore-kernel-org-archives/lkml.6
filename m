Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDEEC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F146A20847
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDA6TZ+O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F146A20847
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754605AbeGENPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:15:51 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:37007 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754415AbeGENPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:15:47 -0400
Received: by mail-lf0-f67.google.com with SMTP id j8-v6so6934302lfb.4;
        Thu, 05 Jul 2018 06:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Dm/A0pgydLdCFIyhmRmDxrJDH6fPPC9yFjGqEz8JJbI=;
        b=gDA6TZ+OLzGctQm37+Ozq4Vuf4pVfTlV6ov3fbtPCEiVbO6XXWtEQp8wVwzmKhKahR
         azydjbKSEZf/O0XJaCrf98v4wnTpNjp5EhhhjJQXtnReVYQrF3suRGFqHblGN9ZeDvnZ
         dT2pXotaxZNbO6Ih8IN1Lgt2YD/q8JzbCImPFKjU5emG7MeeGi7jCVuJYV6S/jcVVuGo
         ViO/++/EDPhwdGRjqJlaac2TQVPj0SRxBmuVvLzwrCTFGUD2y2ioQeafGzQYmqnamLvn
         KKCplp5dHqTmemRth93/PHhGy5jFf9CrZOf0sUjZCErnXREXNfVDYA0ZymTLKhE2UP7g
         ZEAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Dm/A0pgydLdCFIyhmRmDxrJDH6fPPC9yFjGqEz8JJbI=;
        b=KW5lmNX93Mf+1AULt3zXgpo2VntE8Mp8iG/aPhYe+jsBzkgXDkGRZ9FlygZ7tXhZ8o
         npRhadx9wQSzEdA1cU6TMbQtyRxwZtZ6N8o5pqPnhy1K2mTDeUnkUMlLXOfzLzaSxSLM
         kJVJrpSJcHxnGCx20id3NQI4lL/Gw5bJeVE+DSI+4JMatTEYCiWcuu7SXZ4IxiqH1dsr
         7rNWa88SzXGhZygD8Ouf1JirEVYxBXh98uWg5UR3K5eHPE61YvaKl8mvQwUyJFbgWBl5
         sBPBBZZW2DeU0kHhTzk5LRfJoqBCBdPLny9WsWm8uWn0enXi41Dwm5DyUs2fQbtcUuPj
         TSuw==
X-Gm-Message-State: APt69E1yF9K1cdSxjZi0cPA38wMFVVMcJstBGwAy+6iAgYs/Rruo7Adu
        kieXowTt386TrY3528Jr/SbrstS3lWTQDPxf3qc=
X-Google-Smtp-Source: AAOMgpcROkjvv9R5rq46KnOH2WwWGIEvuzGaUmx0nN6TXEelR/OuAUpS2OFyz2uiUaXp4V4xd/FxK6YARYoz+X4TD/M=
X-Received: by 2002:a19:5c06:: with SMTP id q6-v6mr4405974lfb.6.1530796545578;
 Thu, 05 Jul 2018 06:15:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Thu, 5 Jul 2018 06:15:44 -0700 (PDT)
In-Reply-To: <201807010157.h1EBGb0w%fengguang.wu@intel.com>
References: <20180627132628.915978-1-arnd@arndb.de> <201807010157.h1EBGb0w%fengguang.wu@intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 5 Jul 2018 15:15:44 +0200
X-Google-Sender-Auth: Grh3CuChRxHKuoHlDrCb9Zo3-sg
Message-ID: <CAK8P3a2B-YOsfgomq_ggAM8kzbCe6jB8_K8wiEe5v4Thjm=YJA@mail.gmail.com>
Subject: Re: [PATCH] [v2] infiniband: i40iw, nes: don't use wall time for TCP
 sequence numbers
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "David S. Miller" <davem@davemloft.net>,
        Henry Orosco <henry.orosco@intel.com>,
        Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Yuval Shaia <yuval.shaia@oracle.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 30, 2018 at 9:00 PM, kbuild test robot <lkp@intel.com> wrote:
> Hi Arnd,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.18-rc2 next-20180629]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Arnd-Bergmann/infiniband-i40iw-nes-don-t-use-wall-time-for-TCP-sequence-numbers/20180627-221142
> config: x86_64-randconfig-s2-06302231 (attached as .config)
> compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64
>
> All errors (new ones prefixed by >>):
>
>    drivers/infiniband/hw/i40iw/i40iw_cm.o: In function `i40iw_make_cm_node':
>>> drivers/infiniband/hw/i40iw/i40iw_cm.c:2232: undefined reference to `secure_tcpv6_seq'
>

Fixed this now by added a

        depends on IPV6 || !IPV6

dependency in Kconfig. This ensures that with IPV6=m, i40iw cannot be built-in.

Will send v3 after a little more build testing.

      Arnd
