Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8059C46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 11:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC6C22082C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 11:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="BKmovRns"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC6C22082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=natalenko.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbeJ0TpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 15:45:16 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:58266 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728477AbeJ0TpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 15:45:16 -0400
Received: from mail.natalenko.name (vulcan.natalenko.name [IPv6:fe80::5400:ff:fe0c:dfa0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 2101744A89B;
        Sat, 27 Oct 2018 13:04:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1540638279;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OyG1IkvwLGrBm8pZPboQW6HvbidL0w/dzMJfzk6SFHo=;
        b=BKmovRnssjpO+oUOl2lG+QTmiAhYaz9OsoD2pppa8fk8X1dt0CfisfZ4DPRhb8L+AWhS+v
        HAw/PaapHv6HmxAFrGdf8DAsmawTOzN+Yr+7pVHyWuSMgfJSQ24VpjAQ3CvnBcIwRmA0UW
        6NFgn+LwJYpcTSdSpoqQjBTFuu041ik=
DMARC-Filter: OpenDMARC Filter v1.3.2 vulcan.natalenko.name 2101744A89B
Authentication-Results: vulcan.natalenko.name; dmarc=fail (p=none dis=none) header.from=natalenko.name
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 27 Oct 2018 13:04:38 +0200
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Dave Taht <dave.taht@gmail.com>
Cc:     hkallweit1@gmail.com,
        =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        "David S. Miller" <davem@davemloft.net>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        =?UTF-8?Q?Ji?= =?UTF-8?Q?=C5=99=C3=AD_P=C3=ADrko?= 
        <jiri@resnulli.us>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: CAKE and r8169 cause panic on upload in v4.19
In-Reply-To: <CAA93jw4pvEYiXZ-C=yH1H_twZigSYAuEMrE_CCDjzLnVHwAdVA@mail.gmail.com>
References: <61d09f0db41f269cc9ee13dd68a5c285@natalenko.name>
 <fbd7f0b8-10c8-be17-fce6-327a95d8ea2e@gmail.com>
 <CAA93jw7xoaokrN4oGAyqh6JHAn8nJpUpp_wj-iy+GWNoV-ipNA@mail.gmail.com>
 <b80e6819da8ea74f18b6ec0aaf9128fa@natalenko.name>
 <CAA93jw4pvEYiXZ-C=yH1H_twZigSYAuEMrE_CCDjzLnVHwAdVA@mail.gmail.com>
Message-ID: <5a9ff4ac2596869f23e871b40d862802@natalenko.name>
X-Sender: oleksandr@natalenko.name
User-Agent: Roundcube Webmail/1.3.7
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=arc-20170712; t=1540638279;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OyG1IkvwLGrBm8pZPboQW6HvbidL0w/dzMJfzk6SFHo=;
        b=yG3PPxLTy3CzMK0OOmJD6zigef/vJrGtaiv9tArikQq4/4/g7BBDYPpCE0ZjU4HqIxFqQv
        k98rbCIh7G9808Pu3BZNJ4IpiTBP4aIUfNtg5pUTNMXcHMSHWXh5Jqls5y6fq8X29N/YtZ
        Rj+HdSX4KEVjKLUaLAUSItxKlxou+eQ=
ARC-Seal: i=1; s=arc-20170712; d=natalenko.name; t=1540638279; a=rsa-sha256;
        cv=none;
        b=nbaHXxXB33ZF6RGgOWC/9yUIGcP40+IKb7zCowHvY2zuoFwymZca3IkZLvE5Yq0wEQI7uHAY+oF6oDArq2TuMyy8u709GE9CCGEof5lkeuPgZlijls5DPyjk0zCRkUIsqE5zh/ub0eO/9qymiqb9/1zpZfngQABAOdwGfWcqfV8=
ARC-Authentication-Results: i=1;
        vulcan.natalenko.name;
        auth=pass smtp.auth=oleksandr@natalenko.name smtp.mailfrom=oleksandr@natalenko.name
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On 27.10.2018 01:08, Dave Taht wrote:
> Groovy. :whew:
> 
> I do look forward to more cake test results, particularly on different
> network cards such as these, and at speeds higher than 10Gbit on high
> end hardware, and in the 100-1Gbit range on low to mid-range. After
> the last round of features added to cake before it went into linux, we
> run now out of cpu on inbound shaping at those speeds on low end apu2
> (x86) hardware, (atom and a15 chips are not so hot now either) and I
> wish I knew what we could do to speed it up. The new "list skb" and
> mirred code looked promising but we haven't got around to exploring it
> yet.
> 
> Thank you for trying and I hope this gets sorted out on your chipset.

Yeah, but this is still strange. Both LAN computer and router run 4.19, 
but only router panics. The LAN computer employs alx driver, router 
employs r8169. Both had GRO enabled at the moment of panic. But [1] 
reports that this happens with Intel NIC too, so must not be limited to 
Realtek.

> We tend to use flent's rrul test to *really* abuse things. :)
> 
> So cake's ok with gro disabled in hw?

Yes, I've gone back to CAKE but with GRO disabled for NIC, and it is 
stable now. I've also asked a bug reporter [1] to do the same, so we 
will see.

Thanks.

-- 
   Oleksandr Natalenko (post-factum)

[1] https://bugzilla.kernel.org/show_bug.cgi?id=201063
