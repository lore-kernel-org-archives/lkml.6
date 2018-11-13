Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B51C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B82E020868
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rix8tRCL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B82E020868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730751AbeKMKxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 05:53:15 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36360 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbeKMKxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 05:53:15 -0500
Received: by mail-pg1-f194.google.com with SMTP id z17-v6so4841185pgv.3;
        Mon, 12 Nov 2018 16:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=axBshCx3sJvYXHFZO15OP6bk+ApzH5gryChQdQ8m5xM=;
        b=rix8tRCLOTUAHuj/Q2AbE2bTOAIEHiviclNylcld6UzDlZBp7T567epL5oLCoOKROs
         Q3EeFjQKHT2AFEVpzoFtCp5/20tRBWU8V33aizkzOG5n31dTv38MLLf5Ij1RF1qKcM9m
         5MjSPkDRJuZJ6xyFmlMC8rbX1fN/+BaXkV2M1rmSBS0PnQwnY1LINXTHnnkz325nFsEx
         yCj1REwSDIMFduBBrztxY+WF2KjJw+SfqgYnRt7pRGsUhsY+L94DbQo6aavFnq1flZf2
         hj6/UMsCbWODFUuP7jIzICWk4UXGZ74C8LYe66GtpXsr5v3eYNHzp1t45FjSXTVrfjaL
         ZxBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=axBshCx3sJvYXHFZO15OP6bk+ApzH5gryChQdQ8m5xM=;
        b=eCgrTcEruGXOKwXuazyGgzpuTq+IsLd6U/y6c3qe2P7NVJLjGp1uE69V9EYqzvqSlW
         KvTqnnUcV99t3mxDbGdACezltN/YQzhkQdZbAEbv2mswANYShC1HH4R1EL3GIbKTdsf6
         R2JHKLRnnG/d/H3ELBFFVdpmnmQVbxN8fUzY8xiz9HjKNUrqBgILkxMCoclp2vI9YpNR
         D8BMT7DNL7QqB8Gxj2eArMKKxw6xtDoLzRTX0nW0QilxQW0UkTC/oNdikm9tVpchPtTj
         ar14hteQg/e6EPNITHIhMZejW2JU5x0tiLEW/pV3jr3u4uGhNPpK/7w2+FGEqhM7w3d5
         Ecxw==
X-Gm-Message-State: AGRZ1gLMCTqHA2ykwgBrlcphijRswRu2mIUWj4Aqvdz/XIzglUhRtFbY
        oz8ODxtyWPRvpaf8VCnv/mQ=
X-Google-Smtp-Source: AJdET5fLvai7krrQSyRkZoQPCS/l3pzwldgcbj6hdYFO5V+qOb97wv5XfxOQconDg4qso0q6B6RAqg==
X-Received: by 2002:a63:40c6:: with SMTP id n189mr2746137pga.355.1542070656605;
        Mon, 12 Nov 2018 16:57:36 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t1-v6sm27019298pfm.169.2018.11.12.16.57.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 16:57:36 -0800 (PST)
Date:   Mon, 12 Nov 2018 16:57:35 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.18 000/350] 4.18.19-stable review
Message-ID: <20181113005735.GC2997@roeck-us.net>
References: <20181111221707.043394111@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 02:17:44PM -0800, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.18.19 release.
> There are 350 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue Nov 13 22:15:28 UTC 2018.
> Anything received after that time might be too late.
> 
Build results:
	total: 136 pass: 136 fail: 0
Qemu test results:
	total: 296 pass: 296 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
