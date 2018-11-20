Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079B8C46465
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 20:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B562720851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 20:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVkGDaEU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B562720851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbeKUHLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 02:11:50 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33173 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbeKUHLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 02:11:50 -0500
Received: by mail-pl1-f195.google.com with SMTP id z23so2010158plo.0;
        Tue, 20 Nov 2018 12:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SlYWVKmYcABuFFwIOpxeHjnxIwgCSG3RFhBQguRlKKU=;
        b=nVkGDaEUjw6kH72+5b3haCy1n/MEUBwmqDAxB/ajEA6SKCzk6gVh4wnIuNV7EGX7WC
         Yac9FaXa43gsdU/hBOSwcegk5Kjj1IcW0b8kMVh7NmZ3E+ccqK11chadzjO7DdPezXxq
         dolb0yTKsn/C2qxadclj9pKaMZ8j5GHN+t+TAD3UiJxEEkIKgdPWM6jp8fRGBSSxb00E
         ccEwmDXhT9bENGkqnAu7rJp5ET9MMFz3vZukwjC+ymSuLCm5LFFFu+y702ucaxsPq3H5
         xK0aG/HxrP84tUuOQDv3K9p7FOJzzomRE6UQNl71LC8mtpLfV0bGfT362PG+gZHsitGb
         DzUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=SlYWVKmYcABuFFwIOpxeHjnxIwgCSG3RFhBQguRlKKU=;
        b=p1PBaestofIbH2sWZ5nJ3TvoX4RofGfrwfV7tMA7gyQC3oN5hpSFwsXy/RVMglYY17
         GP05GwKkv21SsiboyphtD7b7geiTRv9zK/RhRUSZzqoJt+PWXFwUPdUa4pVK8uElvtFe
         y8Qwaij9nQPdBVfcQGj5iCb/s9TKZh3j7mc5PCJpNjpO924uRjs7wg7BtEhtImMe+KnS
         0fVDgrRdJMOw26Nlb9S04ls3n15rT8h21U4NBDL0FNRMAvLfEr7i77T8S1cBYBjKKURR
         YgbU072vxt5zcOdJY1jhYhqsfsuObkp0QkV4N1+VbHci06+sn5G8KM3OjXC3U3EZ5RmR
         xBRA==
X-Gm-Message-State: AA+aEWaNPtiREaQ6m91dcBf/k64oIpure4FD/qmpaZNhrYJ2Ku4dVZbk
        Li8ZXB23T4XYQNbZjA830A8=
X-Google-Smtp-Source: AJdET5fQh985x2jqXLyl1PByECmSbfblCt3wFD/wgfCavoH0B/6/6Ylkdr/nOsaUN5k5JlIt357QBw==
X-Received: by 2002:a63:f141:: with SMTP id o1mr3363425pgk.134.1542746449676;
        Tue, 20 Nov 2018 12:40:49 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s62-v6sm53979501pfb.73.2018.11.20.12.40.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 12:40:49 -0800 (PST)
Date:   Tue, 20 Nov 2018 12:40:48 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 000/205] 4.19.3-stable review
Message-ID: <20181120204048.GF19385@roeck-us.net>
References: <20181119162616.586062722@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 05:25:07PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.3 release.
> There are 205 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Nov 21 16:24:55 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 135 pass: 135 fail: 0
Qemu test results:
	total: 291 pass: 291 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
