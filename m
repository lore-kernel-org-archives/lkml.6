Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCB7C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 21:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1555120823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 21:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbqjkrMB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbfBDVor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 16:44:47 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34966 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727330AbfBDVoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 16:44:46 -0500
Received: by mail-pl1-f194.google.com with SMTP id p8so554329plo.2;
        Mon, 04 Feb 2019 13:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j7QV924BT3z/y9KFQuI+dkoXcIcfQCM1UDkMPQI0Eq8=;
        b=dbqjkrMBgoUBqRQK7TQmf5cWhqzTOFB7pBDxANt8Vz+1D6hrDWMjSqi637vP0ipYiN
         DDn8VmUFracO7OpCf1xEJYWWBPjBObQkRF2vslE/5lLEAMkH9+TKuGHB1dCriBWfIxOj
         JGnWPYZsdn+qSXwwCfVZeh0RsBy8uHi3bu7oRh9GiYHGxhWu8QittK8zHHhfO02btd1Q
         v3oCQbfPGI0TUlErVyDVJNaQSlJPFszxFbJorWBwgTfBuiJM+zbbx1AN4iF+RzxCzEKm
         S9xCbQN0TbNCR0vShuv8tNjt53+3fWYaD6lxJz+JKEgx8lhjB6MLhQqesWOHw8rI/tLG
         ajGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=j7QV924BT3z/y9KFQuI+dkoXcIcfQCM1UDkMPQI0Eq8=;
        b=ZHoCUKbBBF7uIoxpYm0YURff9djxd7gDWmNrT1AMD0RXYWhzG2gx1LT2TNv/FZ5TOJ
         3TuEz3Z+/SiA1/RZ/Kt7sieMyrvQmszv8CDGEygyIeP/ZZc0+covhLQHMJu8Qhxx5uZd
         tDcttAOD2wE+UzLB+OVZBmh/Bt1KBx+IBh0EtaXHwHpwmkooIpXOT00cb4cSWFnr8CVZ
         1VfdB6oMuFlIzf9DnPvW1R5KazWrQCMpQ7wZB2/rH7VHP2tD10SkD/DXzWSvS2OrA1dr
         OE9pDRd5E3xFcYi7k0jNedQrfwyj8zmrqb8HxmQDOfl1dqR5k2Q6avDE5GelZx/xRPmZ
         9r8Q==
X-Gm-Message-State: AHQUAuZPuauSH18rm/u+Wg278j67jbQIgempvbjyIT1j/Ttw8gCK0Uxn
        11ZLkaQHY6dPIpthOIfzibesJ9PJ
X-Google-Smtp-Source: AHgI3IZ5eckHFqRiPyRYvd+4DeLV16PpXa3AYJKkOn+j2f8bKVH9KtZogYt9c+7fyoyabtTtNUMTwQ==
X-Received: by 2002:a17:902:2f03:: with SMTP id s3mr1476008plb.277.1549316686238;
        Mon, 04 Feb 2019 13:44:46 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p64sm1613229pfi.56.2019.02.04.13.44.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 13:44:45 -0800 (PST)
Date:   Mon, 4 Feb 2019 13:44:44 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/31] 3.18.134-stable review
Message-ID: <20190204214444.GB18895@roeck-us.net>
References: <20190204103557.903263774@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204103557.903263774@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 11:36:15AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.134 release.
> There are 31 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Feb  6 10:35:28 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 155 pass: 153 fail: 2
Failed builds: 
	arm64:defconfig 
	arm64:allmodconfig 
Qemu test results:
	total: 222 pass: 222 fail: 0

Error log:

Error log:
arch/arm64/kernel/head.o: In function `el2_setup':
(.head.text+0x130): relocation truncated to fit: R_AARCH64_ADR_PREL_LO21 against
symbol `__hyp_stub_vectors' defined in .hyp.text section in arch/arm64/kernel/built-in.o

Looks like this is due to commit 8640f2308921 ("arm64: hyp-stub: Forbid
kprobing of the hyp-stub").

Guenter
