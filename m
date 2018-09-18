Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15552ECE565
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF9232150D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYkYSAYG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF9232150D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730644AbeIRVyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 17:54:44 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36212 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729618AbeIRVyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 17:54:43 -0400
Received: by mail-pg1-f195.google.com with SMTP id d1-v6so1288931pgo.3;
        Tue, 18 Sep 2018 09:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=afKT8VcQZfACC4mvKuLtHhz/4dsH32ASnbc3VeDJ/B8=;
        b=kYkYSAYGHfRap38ezeYyvV4/ZNOILNenlii9CCQ5r69fYtmJjSTVlZfRLeYcB4vtzo
         bi23D1ehOPITLV2OmblNljWg93U4UWecGKREwBFFsO5ShSidAYbpnYC0WmnddNiZ7A5R
         fzTjs81HuL5kKWgsjbh4DecbC/Y//23D7ea7IO1XCiJYgV72LYFoyhhnuUShZ9b6tffe
         zkeUfdBeHGykoSvAJtUVpOq6o8yv1FhZSFvUMyLrKpBmQ/W37VJUwmCYPp+FEtIYZdxw
         emsDLtfRZDaOHtYv/RJufbUGiegZZ1Olm9L7Mutp9xVCfoMr9fUli2bZXitjg7slZqIm
         9J6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=afKT8VcQZfACC4mvKuLtHhz/4dsH32ASnbc3VeDJ/B8=;
        b=MT+l0MWyjasGt5eoZsjhFLBSSVjRX07KnNI9nnKgGt+wXIe6boiCAZj8jbzjk7a32t
         xVEaSpMSMC3oc+u1tGrEUk0nGggc3VcOgLkeVFnMk91KIG4KC0zgXTAJRsSrfFuSDgaj
         BsZRXeEIe00qsV+5T5JxZPl1T8NIf+iyizF1rc6bLsQgitTFoYsZwdOO6d7APW/AIlE5
         YizM20X9hi2Cvhk0M8EeZ2UvSAmU21YmYkenDV6CDtiXxRz9Geb6BEraRsxoHmLIjgRb
         V9sMdcbQC8KF7VIOat8XDwxlJJkuD3K0VSeGhaG7S06dpSjUYJaaagHEb9iaVQfELv2w
         AYzg==
X-Gm-Message-State: APzg51C0p/19GH717UGWsqeh0BqhRYs592VjgVa8ZdS1CGzDAETS/P7R
        Ut2cRdfVrAL2bBgzekne6iQ=
X-Google-Smtp-Source: ANB0VdZZq+/xXSiEeL2msB9aIfDMIEQidb/0JGKBKK05DP8MrRxZHvbyLC1M7U2hFvB+EK9yGKwqIA==
X-Received: by 2002:a62:ce03:: with SMTP id y3-v6mr3865123pfg.140.1537287685107;
        Tue, 18 Sep 2018 09:21:25 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id v6-v6sm28569257pfa.28.2018.09.18.09.21.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 09:21:24 -0700 (PDT)
Date:   Tue, 18 Sep 2018 09:21:23 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.18 000/158] 4.18.9-stable review
Message-ID: <20180918162123.GD28152@roeck-us.net>
References: <20180917211710.383360696@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180917211710.383360696@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 12:40:30AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.18.9 release.
> There are 158 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Sep 19 21:16:14 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 137 pass: 137 fail: 0
Qemu test results:
	total: 318 pass: 318 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
