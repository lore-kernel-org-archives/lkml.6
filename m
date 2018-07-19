Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B58ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E3EE2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="O0MZ0ALl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E3EE2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731874AbeGSPrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 11:47:46 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39027 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727584AbeGSPrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 11:47:46 -0400
Received: by mail-pg1-f195.google.com with SMTP id g2-v6so4021331pgs.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 08:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=JBN3PsRzLt9lMYD1XC9ypqtI2ead7/taMEtzNrmMDlE=;
        b=O0MZ0ALlKXWBLfGunJHBEvLOf0NXCgp5yyskyR236Cd3sZjvkJrxBA3X3P/ERTCFy4
         m3q8JNGh0fAb0DCCF0wUGgCLM9fJwwDF3R1lwEVs54x170KOKjcvnjdji0AA5+A5+kb3
         6TSFD/ylOIzDc/JjeVgrGDyVftRTWhOFdqQxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=JBN3PsRzLt9lMYD1XC9ypqtI2ead7/taMEtzNrmMDlE=;
        b=b0ycqHyXKj7QRoCBwS9+ST9CD4e6NUB5fswoU5mj+YcrMQ2tNJhkq8qE244b4ym8Zy
         ABnGyOANyD79gCFnd/xb28dqdRM79H7NjHC8W4O4WOjJL+2CRtokT03Od+YLyfPtm5Qt
         x3vWrwAY9I5HBe79vkB98/1vHN6zr+Hg/uaMuif5gntdkVqEIUw0fBxkXT3haph6CcJW
         50HXbK3xQszWC5T2uTv1VVxwGi0VL3/7Wch/PtHhfSh48pqyPmIZsTPYe5Wh2LXAQNPR
         hyl6aEf6aOln2BxRbFXpzlOPGkpSZocpbBOOu5x0fRkA36szlGEFdXEZNVrO1Zzu81ft
         syCA==
X-Gm-Message-State: AOUpUlFz7jbU3OilLe1iMY+49pepmN4Apqh1CrK+rrNg0HVmEhUGV9Nr
        rr1m20bkoxMQ/oRx1D1YFQP/nG0luyQ=
X-Google-Smtp-Source: AAOMgpeoJraMtA6p94e+FppTM/Zdw5/Y/xRdBCDpzmfnqH3HxiEHUaaHaPQhxhrh0n6f3lpZQ/BVvw==
X-Received: by 2002:a62:3b03:: with SMTP id i3-v6mr9923219pfa.197.1532012650836;
        Thu, 19 Jul 2018 08:04:10 -0700 (PDT)
Received: from [192.168.1.180] (ip68-5-145-143.oc.oc.cox.net. [68.5.145.143])
        by smtp.gmail.com with ESMTPSA id p66-v6sm18943599pfd.65.2018.07.19.08.04.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 08:04:10 -0700 (PDT)
Subject: Re: [PATCH 0/4] Rework NVMe abort handling
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        Christoph Hellwig <hch@lst.de>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>,
        Hannes Reinecke <hare@suse.de>, Ewan Milne <emilne@redhat.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
References: <20180719132838.15556-1-jthumshirn@suse.de>
 <20180719134203.GA15212@lst.de>
 <20180719141025.yveza2svhvc2r4lw@linux-x5ow.site>
 <20180719142355.GA18800@lst.de>
 <20180719143534.i36vo45lhz24xbrg@linux-x5ow.site>
 <20180719145005.GA21000@lst.de>
 <20180719145422.2tdrbwa34gheuam3@linux-x5ow.site>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <8d1ad465-c6b2-b67d-39f5-c88d849a89dd@broadcom.com>
Date:   Thu, 19 Jul 2018 08:04:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180719145422.2tdrbwa34gheuam3@linux-x5ow.site>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/2018 7:54 AM, Johannes Thumshirn wrote:
> On Thu, Jul 19, 2018 at 04:50:05PM +0200, Christoph Hellwig wrote:
>> The upper layer is only going to retry after tearing down the transport
>> connection.  And a tear down of the connection MUST clear all pending
>> commands on the way.  If it doesn't we are in deep, deep trouble.
>>
>> A NVMe abort has no chance of clearing things at the transport layer.
> OK so all I can do in my case (if I want soft error recovery) is send
> out a transport abort in the timeout handler and then rearm the timer
> and requeue the command.
>
> Which leaves us to the FC patch only, modified of cause.
>

Which I'm going to say no on. I originally did the abort before the 
reset and it brought out some confusion in the reset code. Thus the 
existing flow which just resets the controller which has to be done 
after the abort anyway.

-- james

