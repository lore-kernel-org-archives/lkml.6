Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9A8C282CE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D229217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="MkTo2X3q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730829AbfBLQGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:06:33 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:55735 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730758AbfBLQGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 11:06:32 -0500
Received: by mail-it1-f196.google.com with SMTP id o131so5099694itc.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 08:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x5UGUdhlZ6jxGbIC2Rsw1FTby2fyMVTXpk0fljdo5BE=;
        b=MkTo2X3qg+gR3GHtUXRYuV3ZhkpOT6/HBgMd15+FYiJv1yhX6rDThShwFQZZj2Sj03
         0m7cE32LYpKzlQedFdGIvi8DGfn4EB08FVSpb6ZidKD1ZakpS29Me78TZX0sltnb903P
         7Qky1rQ7ZvIZc+hT9gj3QoU7ILso5DhZHBnwjNTGy7SKgqw2PTTn8WhHianGO49ed+LN
         7KNdifqWdVpiZx9112Raa2AgX6ukzWOYpEVE/1kncu/HO69EjriZIZE5URlz01bmB53K
         J8/+BzFr077leLuaB0xW4VKmLw/7/96ncZC7aid7xbz5mZdXvTRMLhOHwopiaWWBII7u
         Ut+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x5UGUdhlZ6jxGbIC2Rsw1FTby2fyMVTXpk0fljdo5BE=;
        b=Ze0Py7jECTOPdg9/4Ag23KEl8CtwCKmj4qGNJoyyVvn6xumUGBHuEXrtMp3jHLkm9N
         BVosH6Gy0G3qXaMEwgk01aY9S1a6XTUyvz32N7jNDcKJBE1PduFCAIwScQnKnK1bvp9U
         UEGZ3uxUYTHKuMtsWFN8PXMUyVBpJgdFH0R1ASq9rGGyzfNFQojzljxaKgHN25Jf2Dkp
         OtLmdYKC4IOhFa4J0XUAJeQlIEAT6T7+faVjbELK+YfUJS5obmEwtDmyzZdWyC1BMTgV
         hAuOmzrqI32V7eI/izmNEGujcsGvwhT+kHi2xk5YFt+/suyREyhu+y9HjxPVPgGnu1Rn
         OQtA==
X-Gm-Message-State: AHQUAua7pgAR9CLzHUuaEIUSkcv0fqUg6P9gQMPxfbODlU19f35Ckv4I
        yjygB272uCYz5BqIz99r1rOCbw==
X-Google-Smtp-Source: AHgI3IZhb4RpxsReI789CdK54OUFQEi4wAgwxmU+3SMP7+JsAl1PC5P0mOAVutbNl5EywarJg57JqA==
X-Received: by 2002:a5d:9650:: with SMTP id d16mr2425037ios.289.1549987591523;
        Tue, 12 Feb 2019 08:06:31 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id c128sm1598091itc.43.2019.02.12.08.06.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 08:06:30 -0800 (PST)
Subject: Re: [PATCH] scsi: sd: fix entropy gathering for most rotational disks
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-scsi <linux-scsi@vger.kernel.org>
Cc:     Xuewei Zhang <xueweiz@google.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mikael Pettersson <mikpelinux@gmail.com>
References: <1549987525.3173.17.camel@HansenPartnership.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e9a411a2-49e2-4897-4e02-1cf790465cbd@kernel.dk>
Date:   Tue, 12 Feb 2019 09:06:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1549987525.3173.17.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/19 9:05 AM, James Bottomley wrote:
> The problem is that the default for MQ is not to gather entropy,
> whereas the default for the legacy queue was always to gather it.  The
> original attempt to fix entropy gathering for rotational disks under MQ
> added an else branch in sd_read_block_characteristics(). 
> Unfortunately, the entire check isn't reached if the device has no
> characteristics VPD page.  Since this page was only introduced in SBC-3 
> and its optional anyway, most less expensive rotational disks don't
> have one, meaning they all stopped gathering entropy when we made MQ
> the default.  In a wholly unrelated change, openssl and openssh won't
> function until the random number generator is initialised, meaning lots
> of people have been seeing large delays before they could log into
> systems with default MQ kernels due to this lack of entropy, because it
> now can take tens of minutes to initialise the kernel random number
> generator.
> 
> The fix is to set the non-rotational and add-randomness flags
> unconditionally early on in the disk initialization path, so they can
> be reset only if the device actually reports being non-rotational via
> the VPD page.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

