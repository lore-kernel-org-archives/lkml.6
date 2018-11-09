Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCAAC43610
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CCC9208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 21:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KKXYxgrr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CCC9208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbeKJHi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 02:38:27 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:52808 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbeKJHi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 02:38:26 -0500
Received: by mail-it1-f194.google.com with SMTP id t190-v6so5126181itb.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 13:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=GTudZ/Gt0tKt03v4CL/v+cvGb77MBzTtv5Yl1iAgsfM=;
        b=KKXYxgrrF0H++NQxbsAckUUgDToa3oUBAvyFrqVxqhjDlIbdQAve1OGOAnzMDE5LSm
         OGIIAnxyWGzRpUuxoQO6htZoqqTb1CdNK+DUE38+zBxNOYSKRTw4eyu9KqI5qbbfchcG
         Ls1ZgoArY+fMRo2D0t17FMsLbWKFyEWYCJzc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=GTudZ/Gt0tKt03v4CL/v+cvGb77MBzTtv5Yl1iAgsfM=;
        b=iyo3B5+Ulm87DclDau7X6m0nm/IhOrQuTfo5nTn/IgQ51LFVKdkVdBANWQHOuflffy
         mRYn7PFX8JeRKCx8BVE0k4/fJ3FDEPtakkSay27wmfCV8420v57TBgpDOfERPz7puX6T
         HWvSkSyO7gxvLixwT10gf2/E95qOsN6PXy1kodUWa30a64au2M4UzdpOw6l88/Hb9/UR
         fNWyrsbXu5J3G3pESmycasmWBMbPfrH55FOrjcUCP0MeLIfne4cARZqhMuofrxrnXr1S
         JELs3jFrJ6OoU6qWKoYOj1MW2swaWizNWbzaInJ8yi+4BON6zR006ioQ8IUBlOd9tWH/
         HetQ==
X-Gm-Message-State: AGRZ1gJQigvEXPRx2XTXeocMdEYw4KC0vek9aOXH7E+CFmYZC1Exvm4R
        DiRUmtucNU3CzHifNoUj8xnzyA==
X-Google-Smtp-Source: AJdET5fdBxYpJ/kzj+dxUtyXCNEK3wuBDh3va9JswI0FEEwxmiGU20RoWK8qoqNBLRFTj/kJkKSc1Q==
X-Received: by 2002:a24:7283:: with SMTP id x125-v6mr3646366itc.66.1541800556569;
        Fri, 09 Nov 2018 13:55:56 -0800 (PST)
Received: from localhost (c-107-2-67-121.hsd1.mn.comcast.net. [107.2.67.121])
        by smtp.gmail.com with ESMTPSA id t25-v6sm3238980iob.73.2018.11.09.13.55.55
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
Subject: Re: [PATCH 4.9 000/171] 4.9.136-stable review
Message-ID: <20181109215554.bhjy3wwfmt5222k2@xps.therub.org>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
References: <20181108215127.257643509@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 01:49:30PM -0800, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.136 release.
> There are 171 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Nov 10 21:50:40 UTC 2018.
> Anything received after that time might be too late.

Results from Linaro’s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.9.136-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.9.y
git commit: cc46a1dedc8bc44d1f238a21ee2848ff2ca6f6d4
git describe: v4.9.135-172-gcc46a1dedc8b
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/build/v4.9.135-172-gcc46a1dedc8b


No regressions (compared to build v4.9.135)


No fixes (compared to build v4.9.135)

-- 
Linaro LKFT
https://lkft.linaro.org
