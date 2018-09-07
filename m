Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD70C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 02:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F294B20844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 02:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mzsnk3qf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F294B20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbeIGGqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 02:46:46 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45989 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727841AbeIGGqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 02:46:46 -0400
Received: by mail-pl1-f196.google.com with SMTP id j8-v6so5829091pll.12;
        Thu, 06 Sep 2018 19:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hh1yjQTwttsny38NMyvRJOMTD1z7c5y+qebCDm0jLxw=;
        b=Mzsnk3qfeKzPyhXBAOggPhfBXIOSaUBQsOqSThtpiyCc1hgETBY973ZxiuSbjtqHml
         MOdLH9QnUwW3X89ZmkC4tYf+UHyp5h0nj8SSKgNllzi1ZCSWTFlu0lKuTsqSCTm2CX4X
         FBbahIPcYUcgmmhbpdBuBvNiTeYR3QNc1ZYkNUSyTZZGMI/OC6NuQjV/pdoYkFZrK/Vg
         1Td9ndi++txdseuWRr9ioNPOCJv14fYrYzLIFNMA2N0ZW5Moh+zsPiPuzWWtA/cdPP9f
         n1F1YGvtSi420z2VYlfoOqpvgm0Y7kvIyQwFGOK6YMfen1rarRe6cFfIsUdPoO2lBQZH
         SGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=hh1yjQTwttsny38NMyvRJOMTD1z7c5y+qebCDm0jLxw=;
        b=Sv+YbBh3MIlDPFT+y5jY3CUiwtrkxSD+4H0KmE9avyOe4qzOaX6FNCbE8CcsmNGtag
         HiwmYapPOw1NlUoaouPOtrpXMgGLh2YQTn3kDkhh7WtUja8dz5ox8DveBgl4hkcpbyov
         FBBvRwr91AoGse3Z5PsmnjPx+sjSYiWaf0qWDsXcq42drF7GV3uMuRNDkpDQAG9NJM/j
         G2g4EeoM8zV/96p8gVY/1GU3TT8zZ3qRf4xaVZ/+3Q5HTjbMWsLaAvi0ZuIo2pjMOBoU
         pxAtuVVIHvKFSknLtpfTC3cplL2zciSDG4GFbD2Aj4f05KWwyOsmG9coCJ4qc3g9BHx9
         1GPA==
X-Gm-Message-State: APzg51DhA+Dw7t4RwOZNJb+UH6pzakc4OLBHorkFOURzw1Xfpzg+Mnnm
        ir+J05VVQaiqt9wWMHrc4nE=
X-Google-Smtp-Source: ANB0VdYHHKQNOHnfmcW8kyib+9OmHG9NNvjzgnl06i5fZUomgvUDrrampLDFc1Q5wSjbw44SA4pmJQ==
X-Received: by 2002:a17:902:bd4a:: with SMTP id b10-v6mr5675622plx.209.1536286100395;
        Thu, 06 Sep 2018 19:08:20 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id h190-v6sm12972625pge.18.2018.09.06.19.08.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 19:08:19 -0700 (PDT)
Date:   Thu, 6 Sep 2018 19:08:18 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, daniel.lezcano@linaro.org,
        jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com,
        gnu-csky@mentor.com, thomas.petazzoni@bootlin.com,
        wbx@uclibc-ng.org, green.hu@gmail.com
Subject: Re: [PATCH V3 00/26] C-SKY(csky) Linux Kernel Port
Message-ID: <20180907020818.GA9110@roeck-us.net>
References: <cover.1536138304.git.ren_guo@c-sky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1536138304.git.ren_guo@c-sky.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Sep 05, 2018 at 08:07:39PM +0800, Guo Ren wrote:
> This is the 3th version patchset to add the Linux kernel port for C-SKY(csky).
> Thanks to everyone who provided feedback on the previous version.
> 
> This patchset adds architecture support to Linux for C-SKY's 32-bit embedded
> CPU cores and the patches are based on linux-4.18.4
> 
> There are two ABI versions with several CPU cores in this patchset:
>   ABIv1: ck610 (16-bit instruction, 32-bit data path, VIPT Cache ...)
>   ABIv2: ck807 ck810 ck860 (16/32-bit variable length instruction, PIPT Cache,
> 	 SMP ...)
> 

My key question is about upstream toolchain support.
The buildroot clone tells me

$ git describe csky/master
2017.11-2111-ge9cc5a5

and

$ git log --oneline origin/master..csky/master  | wc
   1180    7436   57104

with
$ git remote -v
csky	https://gitlab.com/c-sky/buildroot.git 
origin	git://git.buildroot.net/buildroot

So it looks like there are more thasn a thousand patches on top of
buildroot. Adding an architecture to buildroot should only take a
single patch, or maybe a few, but not more than a thousand.
This strongly suggests that a lot of changes are not upstream
but only available in the buildroot clone. 

When are we going to see all those changes in upstream gcc, binutils,
and qemu ? I don't really want to dig through more than a thousand
patches in a buildroot clone to find out details about the status
of upstream toolchain support.

Thanks,
Guenter
