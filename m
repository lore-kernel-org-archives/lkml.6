Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C522CC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9408820844
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uVxB7tP0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbfA2TCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 14:02:24 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37332 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfA2TCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 14:02:23 -0500
Received: by mail-pf1-f194.google.com with SMTP id y126so10098633pfb.4;
        Tue, 29 Jan 2019 11:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bHHOBYjyBT1Ud/qjsk79tJmi5ZAILVa95ORbRxakPhE=;
        b=uVxB7tP0v4QWrBR/iFSdhVfHaUlhKF4U3ep56BvWzZ4PNxZxPdJt4mdK5F5p5JDMvt
         4O1i4bowWnXuCQhYwj0NsJ/cqWUh3XSTLu6+HhAcV05pByUqquFtjoK6DyNNes8/w5LD
         cVUa3atXbx7TITkrCWU4ipu9DMf3OFjf1nWMn25xLJegMlW/3Wf/PQ9b22M7nq8DUpap
         TMlDtEVKy5fkIeKm5AEDe+I6BCHQirpiVWzgxWSxXwbJY4nd/38JEfVaLVLRdk8sMIhh
         5IzSmlqHcrIa6jJvsR/oA7brcfpC8e2qQUA34bB40GiRBvZSUCcTmMCOebhPuu6SP3Qg
         ZMGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=bHHOBYjyBT1Ud/qjsk79tJmi5ZAILVa95ORbRxakPhE=;
        b=TVkWDR2rtkjcQLGHXcTMnqHvmgPnhjbmHkPDWNlzFQOmYylPRGLd23z0itYL70GKrF
         siT9Gw9GpW155zNnhbz3dc9fpmTfMDDiNJNuS/UnRGvqvPLcanGVOnB6qfqyGpcfXJfE
         gcZFrTvnZZlvza32Umbsfkrk2pmPNQ/mopOTiRUJf64ZGevFs2kGmU+n+t5OsFS6QdP0
         EkD0TSwzxVNtHYxBT+XbgIb0JmD/D3VE6ctvt8s4IV43Vj3hCg/rvGO9bPvacaj6GJ3E
         u4HP3cjYVvBPivP325A85B2IRecL/ijjJ43xK02d/RvHYFfKjD8aE6j/yrzGkYGKjdX3
         Dmug==
X-Gm-Message-State: AJcUukcqGAKr4qmiWLKr1LR4V7PcwSOSGY0BVerGpce+ew785TuO+XwW
        4DSF79JoCfsXV1JSj83SYlk=
X-Google-Smtp-Source: ALg8bN7HdtODbZncVAu34ulOk2/3Wwab9On1fp0TqLkvInip+mmPVWWtIELTEClqTrBGKIVV1bISrg==
X-Received: by 2002:a63:e615:: with SMTP id g21mr25131951pgh.290.1548788542372;
        Tue, 29 Jan 2019 11:02:22 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v70sm50780274pfa.152.2019.01.29.11.02.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 11:02:21 -0800 (PST)
Date:   Tue, 29 Jan 2019 11:02:20 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/44] 4.9.154-stable review
Message-ID: <20190129190220.GA6116@roeck-us.net>
References: <20190129113139.826927690@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129113139.826927690@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 12:35:55PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.154 release.
> There are 44 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Jan 31 11:31:22 UTC 2019.
> Anything received after that time might be too late.
> 

fs/cifs/connect.c: In function 'zero_credits':
fs/cifs/connect.c:527:34: error: 'struct TCP_Server_Info' has no member named 'echo_credits'
fs/cifs/connect.c:527:57: error: 'struct TCP_Server_Info' has no member named 'oplock_credits'

Seen with:

arm:s3c2410_defconfig 
arm:nhk8815_defconfig 
arm:cm_x2xx_defconfig 
ia64:defconfig 
m68k:defconfig 
m68k:sun3_defconfig 
microblaze:mmu_defconfig 
mips:defconfig 
mips:nlm_xlp_defconfig 
parisc:defconfig 
parisc:generic-32bit_defconfig 
parisc:a500_defconfig 
powerpc:defconfig 
powerpc:ppc64e_defconfig 
powerpc:ppc6xx_defconfig 
s390:performance_defconfig
tile:tilegx_defconfig 

Guenter
