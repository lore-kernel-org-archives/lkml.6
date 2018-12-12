Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1412C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC85F20851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ogqzEb1m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC85F20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbeLLWTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 17:19:46 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46624 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728428AbeLLWTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 17:19:41 -0500
Received: by mail-pl1-f196.google.com with SMTP id t13so9234814ply.13;
        Wed, 12 Dec 2018 14:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LNHwnp+nfwOwqut3UmEZ+uxwzXs/B8z6X6qWWJZIDbE=;
        b=ogqzEb1mu4GA+Bc5jpCDBN76iI+iL7feL/V2kM5VDTUPAKvUU4d7dx/JiLJprHmvEk
         xmvXx6zkMxz/SyU7bmvi4uljrGQQFfcx0M+qEQ7Ag1KFI9IaJdVsOzTnbtu/3wRl6tEk
         IOgKXyXmkVjQfzSMROnd2suJzsya+to810LAgxV7P6xzrXiPqhdCsWRD84gso8PAa5JR
         Qu0jZLbDQPoaPvWCodo/P/657KQ1QpB3JsXYSB6WDvh0mrq8Gj8GQeEEO07gE3xQJ9KK
         bgaFXC0CHoA3s275vEO2LoAK/u0rwMZHKs1qidzF24KmpgFNQtLH0xsoljUl8dvac5ow
         Tffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=LNHwnp+nfwOwqut3UmEZ+uxwzXs/B8z6X6qWWJZIDbE=;
        b=AOmtBJ6Hl/hbEJy1Vlj8fOoThq8t7gvyP0h+xq0ZiqbTC1b9wqEdjrlfTEOms26HOK
         JRs/AsbZ2fNLbJlTfGlnSEOsiOd5jg7dYwSPH9ST1xYlmFJH8unKax9YpChD09h8eP0x
         wHNMmOIx7ZUcLVgCIhMxxb9E+PlDov0S4T4G6+iv5GyEPYTiMu9oaxuxhj4OMkkk9tCC
         uB4lXlKI1TyAQCHG0y9TCmSHtcwnwo+8VQe03XI0aLmVXgx2KUglwdx5WL+Y/ijvWw/J
         ceujbfIsNq1d+LP6XnGFHbscP+zPrrwG8qXA6umr94pvQNwSYTJdxIIeuGc58q691IYV
         C+gg==
X-Gm-Message-State: AA+aEWb4qZ7s/POBHZhuA/ct1aS7ulqaWJtwoDgGx1Ne5V03NSoaDqHe
        9rGRoyxwtpnBKz5j8hjRBak=
X-Google-Smtp-Source: AFSGD/V2mVa0U9C0bmTLbsge0ZigZ8mt/tHvCVBEyC1l3nv7JzF1xUDkUOaz5YJVraQKZN3pNnJpIg==
X-Received: by 2002:a17:902:1682:: with SMTP id h2mr21372484plh.243.1544653180393;
        Wed, 12 Dec 2018 14:19:40 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d80sm6578pfm.146.2018.12.12.14.19.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 14:19:39 -0800 (PST)
Date:   Wed, 12 Dec 2018 14:19:37 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/54] 3.18.129-stable review
Message-ID: <20181212221937.GA2290@roeck-us.net>
References: <20181211151546.010073210@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211151546.010073210@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 04:40:48PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.129 release.
> There are 54 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Dec 13 15:15:33 UTC 2018.
> Anything received after that time might be too late.
> 

For v3.18.128-54-ge518503ddca9:

Build results:
	total: 154 pass: 154 fail: 0
Qemu test results:
	total: 223 pass: 223 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
