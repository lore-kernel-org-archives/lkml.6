Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34CDC004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 14:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75BE020833
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 14:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jdc0wvK+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75BE020833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbeI3UkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 16:40:04 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36044 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728220AbeI3UkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 16:40:03 -0400
Received: by mail-pf1-f195.google.com with SMTP id b7-v6so7357520pfo.3;
        Sun, 30 Sep 2018 07:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d9qI2vd2GksWJES3cf2+T4OsS5CWi6qJXxoZFkL3Crc=;
        b=Jdc0wvK+xf81Q7JKjJ5mDdfto4BW+W8W/gFrMMuXFWcZ33k9zQ99zbO22rSd9/8/Tu
         r8u3Bk9HaxCqERED4nf3IUwk2GVZoFcxQDFQzCjNL+lFQONc+ZGwlXzS1xTSe+242oWo
         HuYtbrgtwxQJvg3SkCYZW4a76NJ+mGYETtl6qCoLxaw0YGWORmGDSXLV9JQ/jFdBJoYc
         OXK8SF6X4F7Hnaa5Fjcmj7Ap1yTyYewjarWYKU2YeTyqO0Yrh0t8Ymv9NrIh0alGxG9v
         3BlzecLWCpIroZ8HqQbIaPR9KedE5wgC+GBUw7A2RqwrS8sDXcooY6CnHgb7BUTGk1ak
         pX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d9qI2vd2GksWJES3cf2+T4OsS5CWi6qJXxoZFkL3Crc=;
        b=MvY+fWLfniL44b/JWkyCplS6U1/DHY0aFpygjGO3ywMNwrjnmvEB9AyAZiRFhGU1U2
         gpsv0Cl7xaMS3iZ3nImngjDa9HeDXAbiWhhWMDT8cK+X0Cl425umd/DSq4BqIjo7Na3U
         QDh1kmBlH43j7xtEE40pgnRffWcHlJk3akP9ben8uS3ePeCr+c3XNgZP/1hPYxwxA/c8
         0UItiwUTSKAOYymCiA9R7+7lnDzyVmJxeuasUFHnuw/ysZGTMtBZM65lyYiUK0NTAI5l
         SwwCD4c3C4WkaFEUB8MA49+BXK13MZn9Iw+psBtKDvOuqjmxH040wjk8gg74yzwmKbTV
         viMg==
X-Gm-Message-State: ABuFfogarfR6RC4D9RX6U3ndX1HCCUJIvzeQCTY1qBQG/g4chdiDsi7I
        LU6Yw2rXHNE31+3o61OaWfM=
X-Google-Smtp-Source: ACcGV60QgR3XYh1E6iZkOt+bOfgp3z2BCqMZ+dKzMo1LThZ9WYtMcyHZ0YyEdExJtlLJILGCqEvApg==
X-Received: by 2002:a63:af5b:: with SMTP id s27-v6mr6530478pgo.448.1538316413254;
        Sun, 30 Sep 2018 07:06:53 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id y185-v6sm12272531pgd.8.2018.09.30.07.06.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 07:06:52 -0700 (PDT)
Subject: Re: [PATCH 3.16 000/131] 3.16.59-rc1 review
To:     Ben Hutchings <ben@decadent.org.uk>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org
References: <lsq.1538257386.330095874@decadent.org.uk>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <c10b2127-8db4-4d52-d03c-3139dca51f43@roeck-us.net>
Date:   Sun, 30 Sep 2018 07:06:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <lsq.1538257386.330095874@decadent.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/29/2018 02:43 PM, Ben Hutchings wrote:
> This is the start of the stable review cycle for the 3.16.59 release.
> There are 131 patches in this series, which will be posted as responses
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon Oct 01 21:43:06 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 139 pass: 139 fail: 0
Qemu test results:
	total: 217 pass: 217 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
