Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B83C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 22:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A43872147C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 22:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730088AbfBYVSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:18:20 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41288 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730081AbfBYVSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:18:16 -0500
Received: by mail-oi1-f196.google.com with SMTP id e7so8528216oia.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 13:18:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HeOVro+otyADpcyD6b86HkD7lruoKaaeHTH1sbe9jEA=;
        b=sNm8iU1utnt2QpbJ+anoJg6ClF/WSgobajSfKFA099qJKRwkKiNRT+WOC9kT8p6kQ4
         p+Yap0zwJS1/f1AkAbJveHhdggG1Gj3loFwRkyJOyOwkh8LDjb5W7oN3V+CnnPr2MAHa
         V6E+aLQ4YHW9TawkSy8NNT2BpLo+VZ+PojxB/6BV+wotmsnmSHNYWqjZ6EK5ENLgj6nY
         RQELUPhOfmawhbZSC4L+8t8kTd82CBdTIx9IjDOD/vR7GVBXigbGDnaWMPKA1qp0IlHS
         RUHXkhgGDEr7r6/+aL2jdArcypb/r8vSvqhQvGc4PE0vX4wkM/cjgz5v0F6bbXMIq63v
         KmKQ==
X-Gm-Message-State: AHQUAuZ9xSzjA+BJpT0T7A/Y7qcRnHilnkwSUU4NLqDcCz/dDtDfFpHI
        rtkmuMTpULvbmbei3uv7g8gj03cw
X-Google-Smtp-Source: AHgI3IYR1sdQGspSWiPyh7b6I2v40QQs+KT94MaZ+yJbjiqtkrb0rBBJ+kZJwayCMxquPwrEJERyrg==
X-Received: by 2002:aca:3687:: with SMTP id d129mr219348oia.51.1551129495812;
        Mon, 25 Feb 2019 13:18:15 -0800 (PST)
Received: from [192.168.1.114] (162-195-240-247.lightspeed.sntcca.sbcglobal.net. [162.195.240.247])
        by smtp.gmail.com with ESMTPSA id l18sm4592526otp.74.2019.02.25.13.18.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 13:18:15 -0800 (PST)
Subject: Re: [PATCH] nvmet: disable direct I/O when unavailable
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>
References: <20190221182234.22345-1-jthumshirn@suse.de>
 <SN6PR04MB4527A810D247541AA7C4A512867F0@SN6PR04MB4527.namprd04.prod.outlook.com>
 <6c3fa30a-d516-a453-a001-1014202ff9ce@suse.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <71982410-d373-a659-0c0f-8aadf06d1d96@grimberg.me>
Date:   Mon, 25 Feb 2019 13:18:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <6c3fa30a-d516-a453-a001-1014202ff9ce@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Frankly, we have a ton of testing related special cases in the kernel.
> 
> This one is a) simple and small, only 10 LoC, b) far away from the fast
> path or any other place where it could have any impact on legitimate
> users and c) it prints an informal message showing you what happened.
> 
> Sorry but this is a https://xkcd.com/386/ moment.

How about we just fail it with a proper error message and let the
user set buffered_io instead of trying to get smart here...
