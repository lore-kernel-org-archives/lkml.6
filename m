Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17411C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D953C2070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqpPfVmi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfBVXbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 18:31:34 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42036 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfBVXbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 18:31:34 -0500
Received: by mail-pl1-f193.google.com with SMTP id s1so1745163plp.9;
        Fri, 22 Feb 2019 15:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1KqAoisF5mpk+XBgO/4MMAr3c5wo22jswJEaEzvoygA=;
        b=SqpPfVmibrHCp0wjKYBwB6ZXRNpaDKc7g3q2QSnhuCvwFb5Flwj/65EonokKojPsdN
         lzulj7A87zuMR0TwXW2UAyy3oB4oYoFj/RvBNp0JaIyHqPkgSfE2b0bLfBBzF5ulvcvU
         3tZdcoD/1eyTHI386gC3rQBig0vUL43NRguJPvOd74e1aw+RxCd1kiZeqqF4+DbZ7VpQ
         Ezika+h9KE4MZ2d011UAE07fvjeLaANjIYKTodTByIZWA6jSFAkvUsHgKhX5iYOJJJkO
         bdZs47G4DaxpeTx7zoZbwSlY/KNuczJ8gy6ei1qT/f4kVeau7MYuWWhEiXblNf10J5DU
         QDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=1KqAoisF5mpk+XBgO/4MMAr3c5wo22jswJEaEzvoygA=;
        b=ClQsHABKBaAu7a3QSXbBGiZ7k2MdF2TMrj1V4xmq7a9TevRJTiD7/IvgrcSQ8RrN5W
         0l1vs7fNq+IDSqpDtOY2u/AzaoEamxj09nlF8Mz/D2iZZV5nQFrQ84yM2m5lyoGvSaEc
         QaPFBUu59PW0iDoUBH8UBccvNaJ/+7XQMfzE6M3GwbGA/bt6dnji8wgjThoM32G6hrXh
         wcPm6X4M6jqoMvY1UlnGaJD2x9oEOSLzgSkQyWpvSJ5A1h1sAoiOVHXxRkvIqKgUBr3R
         5cJqovq7C6GYOd0jkYNpxoa2VTIahBWWLTG6nmo6tsb2mEwoRwdO88aqTkv/BfRtCuBi
         umzw==
X-Gm-Message-State: AHQUAuZ3AhylPWNxZ/DVTjLkvhlMQ2sCDYZ9dcUTLTyCd8JBt5qdf2Sr
        45hVLEbMOYU1oGxYpYRcmmM=
X-Google-Smtp-Source: AHgI3IYJrGw7qUqhtcmc/rdJ1fPEJU1NJOkX22QAusNx+vh3RAt7PMeY9tcxHc7itgHFXxtdAlHxuw==
X-Received: by 2002:a17:902:7202:: with SMTP id ba2mr6539906plb.147.1550878293956;
        Fri, 22 Feb 2019 15:31:33 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d5sm4307544pfo.83.2019.02.22.15.31.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 15:31:33 -0800 (PST)
Date:   Fri, 22 Feb 2019 15:31:32 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/23] 4.14.103-stable review
Message-ID: <20190222233132.GD25975@roeck-us.net>
References: <20190221125246.162644302@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221125246.162644302@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 03:35:42PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.103 release.
> There are 23 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Feb 23 12:52:22 UTC 2019.
> Anything received after that time might be too late.
> 
Build results:
	total: 172 pass: 172 fail: 0
Qemu test results:
	total: 328 pass: 328 fail: 0

Guenter
