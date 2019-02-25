Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7591EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 445CD20651
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MeRQNlRP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbfBYPxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 10:53:12 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:44448 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727505AbfBYPxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 10:53:12 -0500
Received: by mail-yw1-f68.google.com with SMTP id x21so3809075ywx.11;
        Mon, 25 Feb 2019 07:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pTzgRwKemYEQEeN0Ivpij5dXhAf3aLGeYBmU9huiZu0=;
        b=MeRQNlRPe3xaMn3kF8bdS4FFAs8YqXHKdNQEyL0xLi4RXAqatio9SaloYWOGfSb+6j
         3foaHgbxC29JG+r2Zx44i0VTTRnBiRFQSfFTFp9oGRJ2fYsn0YnnM2NHMMwYh7WBugin
         t+zpnLp18ZJbE5LKOHsS15g5elwAximhGWtkQnAomsa9hVNBXPLx7zYD4V5V3RdaaTCL
         dvN3BBRB1UYCV3Ye4QtthTLRn3RBi5hcnwIOAXfTuDk6+v+bNqPeho7/qDsOJuRWkY1s
         Io0B8Q8E21LIMYWV9iUmgC2IZ4Hm+raGVXoniWtl7bcoVnNKspZ6bTiy7bCpcuB48ILd
         acIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pTzgRwKemYEQEeN0Ivpij5dXhAf3aLGeYBmU9huiZu0=;
        b=adpGlKUOfUYGv0T79ERqM1/WK+WZWuOLRdwAabwhUzKKgYAGif3imFkO9q+jDwOlbq
         0U4ddziTKuMaYIcqJOn6UML0jKgcAI7JRxEEqijqAQZzIkinQkJWQEVFdJU5zLAtVwru
         iKR0OGMdBFj+nTm9t9bHDUgQIfnZMzw+DA8VMAg8wVX/Gr5XVG+ObIXoVYpNK98HmhhH
         W8gB6EMO+HEOHZhnGu5aPcDRQQJhEmWiTTMD1zjyO4f3jI3EdbxRs4f3YtHhVX+GJ9vJ
         SO8vUPlChjdjtgPigruHNFIb46RAff8kafLOl3rywqLC5AZXBuYnifzQB/oMPtRJlImF
         wGRA==
X-Gm-Message-State: AHQUAuaynAdErGpT//FluqQgg5WRhmf7dMb705iCArqTOK6g0XhNBpcY
        VR3iEqwSuRX9ZlXcqXFlMICGO0kH
X-Google-Smtp-Source: AHgI3IaWMT+aG/EuKNO6ttHRLO6KYbYoN8/iW6m+h1yR7DDduwf46vLSOYkWwSRK8qW4HuzIci72rw==
X-Received: by 2002:a81:3dc8:: with SMTP id k191mr14455549ywa.139.1551109991147;
        Mon, 25 Feb 2019 07:53:11 -0800 (PST)
Received: from [192.168.88.60] (216.sub-166-144-35.myvzw.com. [166.144.35.216])
        by smtp.gmail.com with ESMTPSA id g82sm1099849ywg.60.2019.02.25.07.53.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 07:53:10 -0800 (PST)
Subject: Re: [PATCH] tun: fix blocking read
To:     David Miller <davem@davemloft.net>, mail@timurcelik.de
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190223115313.15064-1-mail@timurcelik.de>
 <20190224.221236.905722532971991928.davem@davemloft.net>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <b727b3bb-ec46-12bf-dd38-0363c9ca5854@gmail.com>
Date:   Mon, 25 Feb 2019 07:53:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190224.221236.905722532971991928.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/24/2019 10:12 PM, David Miller wrote:
> From: Timur Celik <mail@timurcelik.de>
> Date: Sat, 23 Feb 2019 12:53:13 +0100
> 
>> This patch moves setting of the current state into the loop. Otherwise
>> the task may end up in a busy wait loop if none of the break conditions
>> are met.
>>
>> Signed-off-by: Timur Celik <mail@timurcelik.de>
> 
> Applied and queued up for -stable, thanks.
> 

First part of the patch was matching the changelog, however
the second change was not really needed, or should have used 

__set_current_state(TASK_RUNNING);

