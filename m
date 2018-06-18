Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55685C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A45520852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="o1huBMSV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A45520852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935182AbeFROdW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 10:33:22 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:38559 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935072AbeFROdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 10:33:18 -0400
Received: by mail-it0-f67.google.com with SMTP id v83-v6so12270866itc.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 07:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yuMiMSflelDEEimEVFsc4yRS6OR+JzcbmlL5zbydOr0=;
        b=o1huBMSVL9FXfWNV1mssk/f+pwKL7w0HHLsu8CvmBn2kEfDVaFJGCTPvmC0CjmDuhX
         93RCAfzTHVQr27TzV6aVKB/FVfkuSjjOexH24K2N8MoSNI/WLXRfuKpmppOST61IhaoN
         IswzVnOL03HQTooC258RjmKJ148287iLsDvNKRleUq4/Aeax77fv0zSquqESkYQPTwNQ
         1aalF603KluTJUyuVJeJx33olDBQoAhU3CBa4q579nvjbrMVCitX/15soXtU6Lx009KP
         HjaUG6A4pHQHZecJ5QjlH9JoEEJWuM1sDXdlGp0Km5YGfgJek0n1WKQvaT5WHkQEOCv2
         I5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yuMiMSflelDEEimEVFsc4yRS6OR+JzcbmlL5zbydOr0=;
        b=YfifA7u/IHQA95JiZlCr8xc6AzCAkklScPKkcq15+64pBQAFunkEVSfMibuUPwP85g
         ycMXSFTGoJMS17JiQEPhy0a2JYjoGbUqgeYuMuisRz76Xvlu/w0j3PIyVYR+urRfRvg7
         lETl9QDq7w2PuUWkjC7sASbXanM7ZgjJ94GncUqr4vC7YKixrwVYLmLe2c7pnSF0F/bl
         aSMD6gtroUm970evChwYAXN9GKCejrYbcAP+DNG47xM2gLh8MeJu8vfuIanutBV3Nexy
         ++eAmZ0KeCny5rUPYVTCQR0ayBsAZvSoXh+KWj1yBbrF/bHkBFQdNy2AiaDPkhku8P9z
         QF4w==
X-Gm-Message-State: APt69E3JChS19wwD2gWP0MZGB0Ee8L26+O8FwPawEMN4f/9W7IM0dy8m
        HC9MPM4o0Xgf1/3GepT1TW9HlQ==
X-Google-Smtp-Source: ADUXVKK3UxDQQSlnpfM3gUis7dyf+lJcsaunJB1FUzUulAP148apaEv01xL1YquLM19X/ULqrvN17Q==
X-Received: by 2002:a24:690f:: with SMTP id e15-v6mr9679980itc.70.1529332397968;
        Mon, 18 Jun 2018 07:33:17 -0700 (PDT)
Received: from [192.168.1.167] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id y64-v6sm4231382itb.33.2018.06.18.07.33.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 07:33:16 -0700 (PDT)
Subject: Re: Constant ata messages on console with commit 28361c403683
 ("libata: add extra internal command") (was Re: [GIT PULL 2/2] libata changes
 for v4.18-rc1)
To:     Michael Ellerman <mpe@ellerman.id.au>, Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <20180605190807.GE1351649@devbig577.frc2.facebook.com>
 <20180605191525.GF1351649@devbig577.frc2.facebook.com>
 <87bmc8a6qi.fsf@concordia.ellerman.id.au>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ddef9feb-2764-6959-3a36-e97fbe377931@kernel.dk>
Date:   Mon, 18 Jun 2018 08:33:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <87bmc8a6qi.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/18/18 1:33 AM, Michael Ellerman wrote:
> Tejun Heo <tj@kernel.org> writes:
> ...
>> Jens Axboe (10):
>>       libata: introduce notion of separate hardware tags
>>       libata: convert core and drivers to ->hw_tag usage
>>       libata: bump ->qc_active to a 64-bit type
>>       libata: use ata_tag_internal() consistently
>>       libata: remove assumption that ATA_MAX_QUEUE - 1 is the max
>>       sata_nv: set host can_queue count appropriately
>>       libata: add extra internal command
> 
> Replying here because I can't find the original mail.
> 
> The above commit is causing one of my machines to constantly spew ata
> messages on the console, according to bisect:
> 
> # first bad commit: [28361c403683c2b00d4f5e76045f3ccd299bf99d] libata: add extra internal command
> 
> To get it to boot I have to also apply:
> 
>   88e10092f6a6 ("sata_fsl: use the right type for tag bitshift")
> 
> 
> The system boots OK and seems fine, except that it's just printing
> multiple of these per second:
> 
>   ata2: Signature Update detected @ 0 msecs
>   ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>   ata2.00: configured for UDMA/100
>   ata2: Signature Update detected @ 0 msecs
>   ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>   ata2.00: configured for UDMA/100
>   ata2: Signature Update detected @ 0 msecs
>   ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>   ata2.00: configured for UDMA/100
>   ata2: Signature Update detected @ 0 msecs
>   ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>   ata2.00: configured for UDMA/100
>   ata2: Signature Update detected @ 0 msecs
> 
> And it never seems to stop.
> 
> The machine is a Freescale/NXP P5020ds, using the sata_fsl driver
> presumably. Any ideas?

Hmm that's odd. Can you include the boot log from a working boot as
well? Would be nice to see what devices are on the sata adapter.
The above just looks like a hardreset loop.

-- 
Jens Axboe

