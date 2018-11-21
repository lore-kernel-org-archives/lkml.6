Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E283BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 23:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A16D7206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 23:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rrUNRprO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A16D7206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390629AbeKVKSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 05:18:44 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38702 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387885AbeKVKSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 05:18:44 -0500
Received: by mail-pl1-f193.google.com with SMTP id e5so7635284plb.5;
        Wed, 21 Nov 2018 15:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zOmAleggS3TRriazAl7hiVaJjFzSbE8srMkk+h0EwFc=;
        b=rrUNRprO1MAcjan7YssyaDYprZk7bULVpwVK62CErfEDfwZVwsx5Qo0tj2nfSnu/5Y
         phIcKRTPd4XGqnvyC270S3efXDDEJ/9KJSCsUEzfS39opw8rzrbvKyV1rgza17zp+Vbt
         40dj6ho6qlp6LxCsckv9Y4a8bUnI7Q+iMyIvZ0AFbW3JNgDZY8MFBz6TZbGgBlq+CbGH
         lLK8Yk6o80ffJ8AjlgIAMxZt0cW/ok1Q92aZPgoMcmjhQZe5uHMTuBXfloXKDU9A9Tql
         Qykk6uALXMeBZ+gAbRxcsZwICVpGBWcdTZUu1GjeS65FutDhMSqQ+YXf63A7PBwwJ9o5
         A5BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=zOmAleggS3TRriazAl7hiVaJjFzSbE8srMkk+h0EwFc=;
        b=fYjWJu87KMvZApcfU3Pu/IoPZubKJQ86UtsKuWKTq52fq3qDEP1PrSiEeD6Xdsc4ZZ
         hxEw+aRZCNdOZrlVkb5S4+Pw1Mojw9BzMEli4o6k7OKIjw9RjEjOnegHMudQAYlJ8NFi
         jiq3GvrVhLmS3lWagApPg8qwf8vGChupftqVAoM0RbV/gQoyjuBGkK1mKVVZVLahAfea
         nMb/lLj5SxijxHcxXCS3YDwlIKdS6RhAV07hl/yFwrfFItROH8qB6jUSwyWPtf+iEhv4
         Ohuug0isF87zykm1PVsdZjfASHm/m/A+x4snGoTQfvJZSUuI6fEDyK5UHO6+CVfGTOAX
         K9Zg==
X-Gm-Message-State: AGRZ1gLZ2fJMlltIDn0dr6UfAESWeQe7eJzpBc9Pt0u6Agaw9/poKmZ7
        JDBNexo3CV3TUpw8ADhMKyg=
X-Google-Smtp-Source: AJdET5dCWxjIJF7r1Cvh4GPfN8Mm0p2DSC0KWkGwlZW2PLU1wxDAB/W5MfUF6qjHjGCAUzNVeQ34Cg==
X-Received: by 2002:aa7:8552:: with SMTP id y18mr9124547pfn.83.1542843729472;
        Wed, 21 Nov 2018 15:42:09 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n87-v6sm64097463pfb.62.2018.11.21.15.42.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 15:42:08 -0800 (PST)
Date:   Wed, 21 Nov 2018 15:42:08 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: hwmon: Add descriptions for ina2xx sysfs
 entries
Message-ID: <20181121234208.GA4920@roeck-us.net>
References: <20181119203116.25589-1-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119203116.25589-1-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 12:31:16PM -0800, Nicolin Chen wrote:
> There are a few sysfs entries being exposed to user space by the
> ina2xx hwmon driver while not getting explicitly documented. So
> this patch just adds a description section for them.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>

Applied to hwmon-next.

Thanks,
Guenter
