Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F84BC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E7420840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 21:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GGywii75"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42E7420840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbeKJHiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 02:38:25 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:43062 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbeKJHiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 02:38:25 -0500
Received: by mail-io1-f65.google.com with SMTP id t81-v6so2337246iod.10
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 13:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=kOmZAsnQmwyCGQi68TkbO3NX6UT7U0JJm33IPWXG10U=;
        b=GGywii75Y41gg4Q8r2dwYxFAvreKwWe8EcShxyD0UJi466HASzBuSat768W3HYy6Ib
         /MVa1CeS6GTY+dFXTXh9Of3POBRUVno1ccX+Jo+z/ifBloeRszU16EufE9nvQ4qq/sap
         ApSQLrPZd0zRMJEoUWkRy/kXDID137QdPxpSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=kOmZAsnQmwyCGQi68TkbO3NX6UT7U0JJm33IPWXG10U=;
        b=ZhFnKk0KnswU5L46GANuj5v9WZ7CKSaVzIKXhb4ck8ogzmg006ZJc1oEikywH1BXbH
         M+G58oFDjbLfE9avs5mHcziAJc9LMStvvZEA/nzgPj8S207d+oH9VGgk0B7KheK5Twjp
         7RTbSElfR2L9PNaFSa13M76Q4jSNpoKLckvH1wG48nR16XhyWkhDIp4TLrfDJQkJLhoO
         FtGb1WICRBmuclA5GNFkflYhm4ftnE6urJ8e28pf4KA33IfyE36oT1GbBEFUVlbSrQYa
         YeKGb/1V+YUypBaNfUNOZXoL9iXB0aRkIpJZvH9iXb5xHuwjFkFA0EpXcRxzjgBeHqMs
         VyHA==
X-Gm-Message-State: AGRZ1gImTrM6e4gex8Zk2fXOeU2Fp/MlupdqH+bu85C60FDYRaOxDui2
        GNgJwAVhFU7wQKFL/UYkWYGIug==
X-Google-Smtp-Source: AJdET5fkOTq6wnQuNOpggx5+UrISK7BF3tEr9nefiIqrSOzIep76m2l4p6zG+waArU/r2p7cjLjg5Q==
X-Received: by 2002:a6b:8fc5:: with SMTP id r188-v6mr8391448iod.128.1541800555823;
        Fri, 09 Nov 2018 13:55:55 -0800 (PST)
Received: from localhost (c-107-2-67-121.hsd1.mn.comcast.net. [107.2.67.121])
        by smtp.gmail.com with ESMTPSA id x6-v6sm1152789itg.15.2018.11.09.13.55.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Nov 2018 13:55:55 -0800 (PST)
Date:   Fri, 9 Nov 2018 15:55:54 -0600
From:   Dan Rue <dan.rue@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
Subject: Re: [PATCH 4.4 000/114] 4.4.163-stable review
Message-ID: <20181109215554.4yhum5dkkib7gvlw@xps.therub.org>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
References: <20181108215059.051093652@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181108215059.051093652@linuxfoundation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 01:50:15PM -0800, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.163 release.
> There are 114 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Nov 10 21:50:28 UTC 2018.
> Anything received after that time might be too late.

Results from Linaro’s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.4.163-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.4.y
git commit: b63fc4e232dfad182f129c0a55afeb860ea0ce54
git describe: v4.4.162-116-gb63fc4e232df
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/build/v4.4.162-116-gb63fc4e232df


No regressions (compared to build v4.4.162)


No fixes (compared to build v4.4.162)

-- 
Linaro LKFT
https://lkft.linaro.org
