Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFF1C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 03:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50EA82086B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 03:30:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50EA82086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbeKGM7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 07:59:02 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:34852 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbeKGM7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 07:59:02 -0500
Received: by mail-oi1-f180.google.com with SMTP id v198-v6so12745560oif.2;
        Tue, 06 Nov 2018 19:30:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3P26sJSzPCf+VqIftqZf8j83wu/LAro7+Etz6S/dt2s=;
        b=cbDV5B7pM1DgwauGyr85GSVQ8k90O2poxpD5IO+I+LjUzDuEdTA1+rJBQZSXRWJolA
         sZQbHNEqjNiQV3yTb3runRqVBDaLbt+BIgmKmtHu+oRZipVc8s0DYh/EJ6WQlX0rquFQ
         /jfX1ytVZ1c6F2UteW+y+PllzExfg2SoXkl4bAa6roZWVOb1XSP0gIAtKhzAtD9yR1Ow
         btsB8UnJFVsfpvPWwRyf2rt2c5t+CA3tyDZERb0N7l849hPf1lNU2VHzRMMVjCTW4dJ6
         JD+tj061QtAIdqwmpQE8QalCwvagjT8VrQIbRfDdSDKHrl6sc/eyxeKeEw26bYPkhYVD
         FBng==
X-Gm-Message-State: AGRZ1gK4yDAa7E3cXxc3Dp5/0Lb12+SEp2AJLUUWbBDoNsLN8FtdgWob
        p4eI0qwadFcDSPWs5hYm9hI=
X-Google-Smtp-Source: AJdET5em/hWUF+hi0pcmwe37dBbb6v1liMUYkO7LX0Z1KvyJgMf2eZ4VFwC1wyHnt423gXpKD14H7g==
X-Received: by 2002:aca:61d6:: with SMTP id v205-v6mr107384oib.116.1541561431881;
        Tue, 06 Nov 2018 19:30:31 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id d140-v6sm9255944oig.7.2018.11.06.19.30.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 19:30:31 -0800 (PST)
Subject: Re: [PATCH] block: respect virtual boundary mask in bvecs
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@fb.com>
Cc:     Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
References: <20181105102301.9752-1-jthumshirn@suse.de>
 <a97f3d77-d23b-b418-abce-2d93ed725bdb@acm.org>
 <c15244a4-9085-5255-edea-b92a9ed1307c@suse.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <950a7996-e0f7-ff34-04da-47581a9496f0@grimberg.me>
Date:   Tue, 6 Nov 2018 19:30:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <c15244a4-9085-5255-edea-b92a9ed1307c@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> How about changing that expression into the following to make it easier
>> for the compiler to optimize this code?
>>
>> (offset | (bprv->bv_offset + bprv->bv_len)) & queue_virt_boundary(q)
> 
> Uhm I have to admit I'm not really able to parse the above expression.
> Sure GCC will do it but I think it's less readable (at least for me).
> Let's see what other's think.

I personally not a huge fan of decoding complicated expressions. But if
others are fine with it then I am too...
