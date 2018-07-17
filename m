Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CC8ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 05:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E761A208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 05:41:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E761A208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbeGQGLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 02:11:50 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44134 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbeGQGLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 02:11:49 -0400
Received: by mail-lj1-f194.google.com with SMTP id q127-v6so31354292ljq.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 22:40:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xYXThKdizlH2N1WQVNwQ3h6xnD6AlT1x6Rsg/eLpKAg=;
        b=gl6ODkpCSbVMD+lwLfcji5anUU7OdV81yKhakXVZDbzhQuvj6iZ/h+tuHXxTApW4C/
         9zsrmFyEijcEJeSP8rHND3EeY/jNb+gJL/6Le/rhNnDlm7Xh0O1JjkJ6PYVLKHFoeBef
         XPFrwqO7CI9XI8dINpg/J0FEoozCIu1z1mZyorMiPf9054Wpi7KzMYoKa2ilKATgBxKP
         Rm7ve9S2qq9N/tEi67tb8n9rPjiciCkIVaQhlcoiviQHFNyVeRhRufvruYksW5tfjgZ4
         y18Upvr3cuc7lvtULMSDtydzGAlLNSaQvNzJcoFrh2AeeElKsFXb3w1pxoaM1owXM0jn
         EsEA==
X-Gm-Message-State: AOUpUlF85cLReAANQVg+GxPFIhdW0UnyTjRato9lYcrb9I+SyykeeyWa
        6tXqbVmxewD6PckQHBg21sDVbkKE1inmyKTYZkLNXA==
X-Google-Smtp-Source: AAOMgpfGi8sMNPv/hUWDLHGBzkl6furCD2+wTxU55UU0Celoe7q5I/7JTYhpUKE7MuaydIyYNks2DELJgUUa2zX08Sk=
X-Received: by 2002:a2e:47c8:: with SMTP id u191-v6mr189832lja.58.1531806058630;
 Mon, 16 Jul 2018 22:40:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:240e:0:0:0:0:0 with HTTP; Mon, 16 Jul 2018 22:40:28
 -0700 (PDT)
In-Reply-To: <0cdd742b-ad2e-aeac-c85f-21c59333d54d@gmail.com>
References: <20180717041602.31100-1-jmaxwell37@gmail.com> <0cdd742b-ad2e-aeac-c85f-21c59333d54d@gmail.com>
From:   Jon Maxwell <jmaxwell@redhat.com>
Date:   Tue, 17 Jul 2018 15:40:28 +1000
Message-ID: <CAFjuzB9632y6RbdxvjUBWXQX8YbSO7GJ6TWP_SCtrpt4Vy5t1w@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] Series to improve setsockopt()
 TCP_USER_TIMEOUT accuracy
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Jon Maxwell <jmaxwell37@gmail.com>,
        "Miller, David" <davem@davemloft.net>, edumazet@google.com,
        ncardwell@google.com, David.Laight@aculab.com,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 2:56 PM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
>
> On 07/16/2018 09:15 PM, Jon Maxwell wrote:
>> This is a patch series based on:
>>
>> Jon Maxwell (3):
>>   [PATCH net-next 1/3] tcp: convert icsk_user_timeout from jiffies to msecs
>>   [PATCH net-next v1 2/3] tcp: convert icsk_user_timeout from jiffies to msecs
>>   [PATCH net-next v1 3/3] tcp: convert icsk_user_timeout from jiffies to msecs
>
> This would have been nice to use meaningful titles for each patch,
> instead of copy/pasting the first one ?
>
> Thanks !
>
>
>

This is my 1st time doing a patch series. Let me rebase and resubmit
each with a more descriptive title.

But 1st do I still need to put the patch number in the series? Even if
the title differs?

1) e.g:

Jon Maxwell (3):
   [PATCH net-next 1/3] tcp: convert icsk_user_timeout from jiffies to msecs
   [PATCH net-next 2/3] tcp: Add tcp_retransmit_stamp() helper
   [PATCH net-next 3/3] tcp: Add  tcp_clamp_rto_to_user_timeout() to
improve accuracy

2) or:

Jon Maxwell (3):
   [PATCH net-next] tcp: convert icsk_user_timeout from jiffies to msecs
   [PATCH net-next] tcp: Add tcp_retransmit_time() helper
   [PATCH net-next] tcp: Add  tcp_clamp_rto_to_user_timeout() to
improve TCP_USER_TIMEOUT accuracy

Which is preferred (1) or (2)? Are the above titles descriptive enough?

Regards

Jon
