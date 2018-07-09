Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA69C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 664102089B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWP+CqQ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 664102089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933594AbeGIP1J (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:27:09 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34438 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933268AbeGIP1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:27:07 -0400
Received: by mail-lf0-f66.google.com with SMTP id n96-v6so15590450lfi.1;
        Mon, 09 Jul 2018 08:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=0q/cnfr+j97y0Ki/m+3sBtk+JestrZEY05fYBkTIS64=;
        b=TWP+CqQ3gp6bq4WVAn+k5NpfE2jUwNMMLF+9AHxmtMM0mm67EXn735TLQH3ycQjnOY
         5qQpCW9rdmMeXhzDpgWc+O39Sfb8iACXp5XEcUfqX4QECeX1HaFf5at6DxCW3ElNSMO3
         PKlvHyztryTpBVBCM4gXPSBRgYKf4QCXV9WMITE2Oc2KJjI2yWjWk10XYvWfvAw+R+9o
         E942ys6q/kboUMLCykMP/M7c9L8Q/lKv0+lPjf0Y3J3ti4bP5Ei0xiedUEv7ZCOcupvF
         ZU0sEM7szZx2Tf1aPzP/YvpkH0M1y7+J48s0mz65fOYV7o9YzT2ZmgB/Z0NRu8wvYZxp
         6eHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=0q/cnfr+j97y0Ki/m+3sBtk+JestrZEY05fYBkTIS64=;
        b=JH/DRgE7wobOOcrCYfZMrMqQM6mSgJmyDp5PYgqp4hnW3I6v88k6eLzfyiJ2/UVZiv
         hm0e73fRtVRGf9oIp53ZHYQE/Vi88KCFnbz3upBBzx2ejIqBvIgZmJIq43ozAxcAKy/A
         cNDUltfauTFNqeXl5yHQ0WF44F9OqFCxkXPb2/OoKRtVMI6cWr9TEr0vJkzH23dQ043Y
         fmNLVYYGyBMeiOUF5wSJnaX953MWy8GU7btKgPxNgfmG+aqMrTesHNZn5QJ6DxYzRfJ5
         zwHM1wnybvhEtex4t+/0OEaCGoywC+/YHKDJ5mVgl5jhQMH1jGMbOuvBi3Hej1JHvR5F
         +LRQ==
X-Gm-Message-State: APt69E1cCiIUWNKTPtIuAousIiaGZ4yj09vGoLSRQnuARI06oZ/bfy2x
        pIPiVSrNo8ofY0Zm9yEDOoxZC0wLah4xHa2XxsM=
X-Google-Smtp-Source: AAOMgpft/tmnAq86Y45do3vZLC2eF3763C56buu8zkmZtc9i7ZAIZYODRd9b7SO8bC9juYV7HUCAloxbML368xp2m6k=
X-Received: by 2002:a19:b24e:: with SMTP id b75-v6mr49226lff.11.1531150025432;
 Mon, 09 Jul 2018 08:27:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Mon, 9 Jul 2018 08:27:04 -0700 (PDT)
In-Reply-To: <20180706155401.7jwc5laxqvnfpiur@salvia>
References: <20180706123805.2852900-1-arnd@arndb.de> <20180706124542.jybscbmzixyt4rx2@salvia>
 <20180706124827.xwho2rgu3jkk3hp5@salvia> <CAK8P3a23rdqk-5i_6jLtCH6Z+_SSJ-0=5r=KfPuL-Xaas=6VyA@mail.gmail.com>
 <20180706155401.7jwc5laxqvnfpiur@salvia>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 9 Jul 2018 17:27:04 +0200
X-Google-Sender-Auth: q5pj3AGOrwJJvLnRIH4Ntiecj3A
Message-ID: <CAK8P3a10sLvYb1=ZS9K_-Nf+vzY_ZkFsTRmZ3Bz7KMZL8g8MSw@mail.gmail.com>
Subject: Re: [PATCH net-next] netfilter: fix NETFILTER_XT_TARGET_TEE dependencies
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        =?UTF-8?B?TcOhdMOpIEVja2w=?= <ecklm94@gmail.com>,
        Fernando Fernandez Mancera <ffmancera@riseup.net>,
        "Pablo M. Bermudo Garay" <pablombg@gmail.com>,
        Felix Fietkau <nbd@nbd.name>, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 6, 2018 at 5:54 PM, Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> On Fri, Jul 06, 2018 at 03:05:13PM +0200, Arnd Bergmann wrote:
>> On Fri, Jul 6, 2018 at 2:48 PM, Pablo Neira Ayuso <pablo@netfilter.org> wrote:
>> > On Fri, Jul 06, 2018 at 02:45:42PM +0200, Pablo Neira Ayuso wrote:
>> >> On Fri, Jul 06, 2018 at 02:37:58PM +0200, Arnd Bergmann wrote:
>> >> > With NETFILTER_XT_TARGET_TEE=y and IP6_NF_IPTABLES=m, we get a link
>> >> > error when referencing the NF_DUP_IPV6 module:
>> >> >
>> >> > net/netfilter/xt_TEE.o: In function `tee_tg6':
>> >> > xt_TEE.c:(.text+0x14): undefined reference to `nf_dup_ipv6'
>> >> >
>> >> > The problem here is the 'select NF_DUP_IPV6 if IP6_NF_IPTABLES'
>> >> > that forces NF_DUP_IPV6 to be =m as well rather than setting it
>> >> > to =y as was intended here. Adding a soft dependency on
>> >> > IP6_NF_IPTABLES avoids that broken configuration.
>> >>
>> >> Applied to nf.git, thanks Arnd.
>> >
>> > Sorry, let me reconsider.
>> >
>> > We many need similar patches to other spots in 35bf1ccecaaa ?
>> >
>> > If so, it would be good to fix in the one go.
>>
>> I'm fairly sure that  NETFILTER_XT_TARGET_LOG is safe, since
>> NF_LOG_IPV6 already depends on IP6_NF_IPTABLES.
>>
>> NF_SOCKET_IPV6 like NF_DUP_IPV6 does not depend on
>> IP6_NF_IPTABLES, so we may have a similar problem there, though
>> I have not come across that. I have done only a few hundred randconfig
>> builds since I started yesterday, so I may have missed something,
>> but I think this is safe because CONFIG_NF_SOCKET_IPV6 is
>> used like a 'bool' symbol these days, we don't actually control building
>> a module with it, only a small portion in the nft_socket file.
>
> Thanks for explaining.

Unfortunately I came across a related build error that my patch failed
to address. I've sent another patch for that one. Feel free to fold it
into my first patch in case you rebased before you forward the patches
to net-next.

      Arnd
