Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B780916256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65A8B20892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="WutrVYTn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65A8B20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731763AbeG3TP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 15:15:27 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46923 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731606AbeG3TP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 15:15:27 -0400
Received: by mail-ed1-f65.google.com with SMTP id o8-v6so4463596edt.13
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 10:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sxdKP5KpAw0ISaQZY4SIiqIk+juaM7rLN36l3EnF8w8=;
        b=WutrVYTnVaumcuxyHztw7TKBL5ru5WdVS7OiwpMmnU9/6AruOnuuPEpJKDqv+3S2c0
         xT0ANfLGWkp6any8pHQ+HggYaL0o4ykvn2zhUybXLHDj2XHzQOVAf+4Pac71wGzxxPO5
         6Cm3b7S65kVWHeqC8WRVvDKx5cBqb8s6zI36cdD17jxZX/WppZXi0B1+VAxLC5t40oSc
         noZwTziNQ7XeE+9cWaliSKSnEMqHXegGU/NjkdXshdAd/0IE6kUewapbMq7QleLdUDGZ
         o1uj+sfayfzvSN9OWsJxxt4/0aZKMT320xcgKCSPjuHmoFw4aSCyHtptkR8yg+kpsRZp
         T2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sxdKP5KpAw0ISaQZY4SIiqIk+juaM7rLN36l3EnF8w8=;
        b=GSJowjx3qOsfWa9eTBpVzXmFhnBw1Ju3gvKhc50NtKEfDzOL7bFXIJFPQUdWG5M7JD
         YNw4SC8dORmOOk68UNXSCBz0Av5diKZsYPVH3XRxEyzLULHlgHOrw0S+jwjWzSr0go5o
         keBCE7fRKQHlUCBd2ukTXDg9pFtMFa29yVLzlaFuCUA7eVjCmoKvxrZBkXsNg3iYmdpV
         LkB/Ym4vts61c/8cxy3ijO2V0SITw4zvuMP4sZ4E/ZbeFkR8MrjpTYGkfkCWW6ZtQLxj
         cdCQq+PB8cEpFKPmIMW6V6GMW1aRIQi7K7XH7OV14ahrzKWrhXxtGzbo1m/8aMf4tkC+
         /JjQ==
X-Gm-Message-State: AOUpUlGZyFgXUsG7XAOZ4v46Iq0OoS/BqQ9IIVfhkMfbiuiVJTwtCfQT
        oyuTZOVQDxdEm4C7BGVaH7InOQ==
X-Google-Smtp-Source: AAOMgpfbw4dqXFw7NosCwvoRLM6m1vvnYe5ngC39pzTn50CQJz2DzaHDHomxUuWpryTZsT+47jYV5g==
X-Received: by 2002:aa7:c70f:: with SMTP id i15-v6mr9159916edq.231.1532972362754;
        Mon, 30 Jul 2018 10:39:22 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id f11-v6sm6462558ede.76.2018.07.30.10.39.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 10:39:21 -0700 (PDT)
Message-ID: <1532972360.2679.32.camel@arista.com>
Subject: Re: [PATCH 00/18] xfrm: Add compat layer
From:   Dmitry Safonov <dima@arista.com>
To:     David Miller <davem@davemloft.net>
Cc:     nharold@google.com, fw@strlen.de, steffen.klassert@secunet.com,
        linux-kernel@vger.kernel.org, herbert@gondor.apana.org.au,
        0x7f454c46@gmail.com, netdev@vger.kernel.org, luto@kernel.org,
        ard.biesheuvel@linaro.org, hpa@zytor.com, mingo@redhat.com,
        john.stultz@linaro.org, kirill.shutemov@linux.intel.com,
        oleg@redhat.com, sboyd@kernel.org, rostedt@goodmis.org,
        tglx@linutronix.de, x86@kernel.org, linux-efi@vger.kernel.org,
        akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        mchehab+samsung@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, eparis@redhat.com,
        kadlec@blackhole.kfki.hu, pablo@netfilter.org, paul@paul-moore.com,
        coreteam@netfilter.org, linux-audit@redhat.com,
        netfilter-devel@vger.kernel.org, fan.du@intel.com
Date:   Mon, 30 Jul 2018 18:39:20 +0100
In-Reply-To: <20180728.141812.1026007723536955024.davem@davemloft.net>
References: <1532703111.2679.20.camel@arista.com>
         <CADhJOfam+cY8uD4XTGvZSEFQdAgTu49G6cg6c64NJoP3bNuBmw@mail.gmail.com>
         <1532795215.2679.27.camel@arista.com>
         <20180728.141812.1026007723536955024.davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-07-28 at 14:18 -0700, David Miller wrote:
> From: Dmitry Safonov <dima@arista.com>
> Date: Sat, 28 Jul 2018 17:26:55 +0100
> 
> > Well, I think, I'll rework my patches set according to critics and
> > separate compat xfrm layer. I've already a selftest to check that
> 32/64
> > bit xfrm works - so the most time-taking part is done.
> 
> The way you've done the compat structures using __packed is only
> going
> to work on x86, just FYI.

Thanks for pointing, so I'll probably cover it under something like
HAS_COMPAT_XFRM.
(if there isn't any better idea).

> The "32-bit alignment for 64-bit objects" thing x86 has is very much
> not universal amongst ABIs having 32-bit and 64-bit variants.

-- 
Thanks,
             Dmitry
