Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB3BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 613FD20817
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBg7/fyC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 613FD20817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbeK0GAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 01:00:39 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35795 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbeK0GAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 01:00:38 -0500
Received: by mail-pg1-f193.google.com with SMTP id s198so6598373pgs.2;
        Mon, 26 Nov 2018 11:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xMCX093hZ96xuLvgm7yaasku7w8dyREUwFIpYJc9FZY=;
        b=OBg7/fyCvjS8uWwmWk1bN31EftRo0JMvQmNoNoBD5I3pI8lZaeWDKXsshMoWIyG7Kv
         uKOAiHbJwcMbouWNmaPf0ETOk+7BObeBQcr4gqMgrZ55rhhMayBnc6L3MZcdavdv/DKE
         GHWXj8I0EbDlP2r/iDiLbcmu0txvZjJxPocra6mPrl0nVIKmsb95fwsMzQyZQtCxGCsC
         9BaSHlptFKWy2Z6LtqFLn6rjqCihMUMCp4493lgmCsEej5kzzlOGg3+Nk6Eo1buAeQDa
         21d7CKEHXRo4rPJpZtkIpwtOQEgm5L6MfO1XCDgQ9+SWS9vk2F+riP4R2SBAU+t58QAF
         G7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xMCX093hZ96xuLvgm7yaasku7w8dyREUwFIpYJc9FZY=;
        b=cAjxiEM3rwNDvrwQtGh8qwcboG93/uk8sQJLs8nmBv60K9OO76q091GoZcreAIC4tK
         guDNhe6xF3fu4vypS7PcR6xIjaoaBGJmqHSGgMGETydkN3Ws/Q8hYk+sqlFKc3fiz3u5
         ZsLoBpBbThWSAWWUzrMMH7z2JzAMmN4E/QzYendgGSnJVY4xWcPPNNm0BUmspAw6AzfD
         5u9vieIO8JJsbzibQe6M6w7GpKv5+guKL7PvNK+QtHK83S7safqPI7SH1N04rmBJkBO/
         A70CTzGOSSOwUU0qe337eZjeUWxHGfHV+a8X5MqsRyHKhCsQJz4xzU761jr8wkWcwa3D
         tz4w==
X-Gm-Message-State: AA+aEWazNqH65ig8alARDDMQipqgRcI/PruwJhGg6cY6j2JCaQ2fy/1s
        JTECwuQyT+qdEcJkD0nYCV/k+UHL
X-Google-Smtp-Source: AFSGD/U8RVDtUj3kwFNJEqpwsD4DMCKOgPv+W4xIy9wVG4re2M96jQ7OYts7OgOvFiONIP7wvdTkXA==
X-Received: by 2002:a63:9a09:: with SMTP id o9mr25056439pge.94.1543259136208;
        Mon, 26 Nov 2018 11:05:36 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c20sm1327448pfc.92.2018.11.26.11.05.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 11:05:35 -0800 (PST)
Date:   Mon, 26 Nov 2018 11:05:34 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 000/118] 4.19.5-stable review
Message-ID: <20181126190534.GC14137@roeck-us.net>
References: <20181126105059.832485122@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126105059.832485122@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 11:49:54AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.5 release.
> There are 118 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Nov 28 10:50:22 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 135 pass: 135 fail: 0
Qemu test results:
	total: 311 pass: 311 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
