Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C130EC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84524208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYZTcLR4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84524208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbeKJFWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 00:22:02 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45684 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725758AbeKJFWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 00:22:02 -0500
Received: by mail-pf1-f194.google.com with SMTP id p17-v6so1359438pfj.12;
        Fri, 09 Nov 2018 11:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2t91lL00Lj7sbq1b1Bt8y8mJEXY8ZpCR7EdM+Ea07Gc=;
        b=VYZTcLR4mFRxQ7BOShG3H+1tzbRy9FN4uBI21rT96qj1io4FcaN6W4cEXeewdMqAo8
         AAkD7Hob8QIPeq/bZSrGvIMLYXMqyczpAogruc5MLa/UftUlU1uSbJZP8x/USVejI433
         10CoyFxil5UgGbnoCJ8aLyw0LTIdUx4IonlJw3IforSA02lrLbsr3Hx5/P3bbIfrObCI
         rowlkUl4r/RHWqs73LbxNVayOWK8D8hVh9CBvZ+JnA2dHmNCavlj4l4aQ4ASjxRlzpDo
         3NVr8qGa7rdQDyRTVsK5knhi1YQDR/glId+diK6zqgxPZpWJEM02O/+dzsYy3u04Rbq2
         +3jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=2t91lL00Lj7sbq1b1Bt8y8mJEXY8ZpCR7EdM+Ea07Gc=;
        b=HCExCpbNAWGZYOFdeqZPcoTBdjc0fMR9cfBu8oMr3nSWc0aYU8dJ28WmCiQjv1dM88
         +sBDQHbsqR9aXKPD5TDSRSXo95FPyUrxqcm52g3846F4libTD8xVu75TmvM6kW3eJsnS
         JJfN3BIlU9zMk5ywT3T63cpLcUMDpnHIeueOqx3Zn12LJLGijJbH1g5CbZepkxV4TYVo
         p/lqXeuOyO2GiYT+GSEA44g7q4148eIIsjmNwReq01t6BELwRnVqp8QlCriSv4S9a5L5
         uQMmPEYH55GnO96HFvM0XJ64Ke9vAfwYaMBCxddW0bNjgawV3EOlYLTtuEzu41NWfbpE
         U+eQ==
X-Gm-Message-State: AGRZ1gInP4Wb0zvTihiG/Zsq1CktoisLtEJ2YQFF5U/m6ugvDM9Wo4Lq
        ieKlPhSSFFfs1NGZfXeRPgA=
X-Google-Smtp-Source: AJdET5cH6WFm13xgjAhBWPz1VvfOXOyRs5/lOy8+UCKeG5x+WClED3jNPWzKXPFKRh7O3DBOs1Cm3w==
X-Received: by 2002:a62:c184:: with SMTP id i126-v6mr10350968pfg.53.1541792400976;
        Fri, 09 Nov 2018 11:40:00 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u9-v6sm7682384pfm.175.2018.11.09.11.39.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 11:39:59 -0800 (PST)
Date:   Fri, 9 Nov 2018 11:39:58 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 3.18 000/144] 3.18.125-stable review
Message-ID: <20181109193958.GA27564@roeck-us.net>
References: <20181108215054.826084593@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 01:49:31PM -0800, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.125 release.
> There are 144 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Nov 10 21:50:17 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 138 pass: 138 fail: 0
Qemu test results:
	total: 221 pass: 221 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
