Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FC7C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4147A206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uP9sZlk5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4147A206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405981AbeKWDQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 22:16:21 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40855 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388792AbeKWDQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 22:16:21 -0500
Received: by mail-pl1-f194.google.com with SMTP id b22-v6so9467702pls.7;
        Thu, 22 Nov 2018 08:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JJvjt5k/hzwBGqpi8y5wY9D2mdhh0Pus4Adz8E5wrmU=;
        b=uP9sZlk5YViUIHGy9ScDqUVZvO97fsjfYF0aBNe76YIDuAjdf+ycojaYyJegN1FocC
         1BJC/v9ZLktdbtBOyBQLVxwGnF72FeaPXA3WHjR/lnrKxtXdgcFBy+ifiMxAT6zzF87I
         mw4j01BzPaP21l++/ypmJt3jxwxxOixD9mLT/KCpV5vrgFayQ3lsstaNXMn/mKlMyfQ5
         lqqL34st1YfTmQRK+/s1ltkhElQageOeNLsllatwwVUz0oRKXUMpB8XqmEhgHhXiZcin
         mNNIO3DxF7dSA+Dq+1FVh523Be//eStAX/V9ltvkRsaZP9xQSP59gAAPtTwo2e7FTii8
         e4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JJvjt5k/hzwBGqpi8y5wY9D2mdhh0Pus4Adz8E5wrmU=;
        b=RSgu28iVN57zpBQ0rybn4D6c9Vard9lwuY5Ingp5QGOL341FMqVYkMK0GAsPZumCPE
         zprBs5R3FopUaFqg93BCFBy1Vc1gLzmIv+4xC/3w683icEsZ0oP/JPN/QS/+TEonbmIX
         qqBGzMM+soeahwE/tSfv4xqZLFwE5Nky6eHHBeuvU7ijmX9K7NKMNqXRRo0yw1hSL6JN
         LsZ1NXXB8x5u+EpZ108cvEEnVp1VSx6LORWFVCX44pybXIjMN02gk/U/bQrY/kqZBoS+
         15us0RwEb8BvOCWR13UyvCgqEunfVknIByxrOqRFSStFv9XDd3O7URbjCOmdSWADy35N
         S15Q==
X-Gm-Message-State: AA+aEWZlqjdyi1WdPyFpLHFbe012s1bxSa2d7DEEGhPrj9PcCkyEu15O
        uTHIdMPJVbTslbfYqaFaALZtvuYL
X-Google-Smtp-Source: AFSGD/UC+CX1IjsE/h8zaqyDnzmNSpPf6luHeM7HH3xvQRG97SmlAqMyDzE5hzxj5wBchd9o6HArzQ==
X-Received: by 2002:a17:902:a516:: with SMTP id s22-v6mr11914121plq.255.1542904574444;
        Thu, 22 Nov 2018 08:36:14 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q5sm42108296pfi.165.2018.11.22.08.36.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 08:36:13 -0800 (PST)
Subject: Re: [PATCH 4.19 00/42] 4.19.4-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20181121183147.869199006@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <8cc559b4-9d61-0047-916e-191fa31e2290@roeck-us.net>
Date:   Thu, 22 Nov 2018 08:36:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181121183147.869199006@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/18 11:05 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.4 release.
> There are 42 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri Nov 23 18:31:31 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 135 pass: 135 fail: 0
Qemu test results:
	total: 291 pass: 291 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
