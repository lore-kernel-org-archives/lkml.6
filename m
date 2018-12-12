Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D87C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4D7820811
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5yapcEV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4D7820811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbeLLSu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 13:50:59 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:47071 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727897AbeLLSu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 13:50:58 -0500
Received: by mail-pf1-f194.google.com with SMTP id c73so9270187pfe.13;
        Wed, 12 Dec 2018 10:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7UwpaMLoOYR5iq+4LmVxP3ASwv4X4wvY/1Q1qxbRFuM=;
        b=l5yapcEVVdUexUPyzCMyqSMPXwExre+304TvVBeDISQAWTx6oc+S8SlRkw86Hlvqft
         P7oKJi9qzSFEjX8d8/ViiYl5BfeB7/BKcf3TVsOK6mvVGGH3UfwS7GNnyZizXYXkfkCB
         57TEClWOsuV7sY04OMEd9QugJfzL2qarE//ZLwC5SOsfi6PUHpZof+1UDpa9eekRUoh9
         kloSH2W/wB8i0R+S0seA0qRMjR2T+sIWBqfLcKg9Ys6+kfQQvgoFJIRAunnedPUXRFsp
         vwiLitn0V3yHWnTHv3mNGh3MX+Ydlfh++HwaJCNxCrt7Mgk9QjU3tSg2uG+t9YaS2dso
         1UXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=7UwpaMLoOYR5iq+4LmVxP3ASwv4X4wvY/1Q1qxbRFuM=;
        b=opVtYUKz6q8+nEydN1aqJTy2PLYdEQbL3M5I0/wFe4j5+JQDGsQPTZNLAW4uVolk3Q
         gUWhd6lsAoUxMJucmlPZVgBYYDztL8J4rv4HuIcY5o7/m0Qg5FmUUcoCI2PmLsvcquiL
         A7i0r9rI4adP0UY2bBZ/61yB9NY820AizjsVGcsuyLUSMT8cBRAW4skxx+vQnqEtUlAX
         wUjyZK4JEry2khCUba4zfVM0aIig1OCu6JpPRVSX1+Mmu1yXWo0sj+QT0FB9E4RcJqYn
         2eRu46LI+lHniJBNfLmFZoaK1iwcmnm82uFCetzDKWNNKn8A5uAegGUtBgOUZfwDMJeP
         W/nw==
X-Gm-Message-State: AA+aEWa/7d3lgcj7EGkMWJuTlhIeeD7Fki3hC8znDiMzhv4vrGicl2C9
        0KKuIcAJk7/+TXc5mF+RLlQ=
X-Google-Smtp-Source: AFSGD/UYNEI6toXXFXQJsCz/Zzt/T4Gym0k3aeHCaD+6e/KetWZmVFB65bm7Dx6xALgMshpsvepDJQ==
X-Received: by 2002:a62:1c96:: with SMTP id c144mr21141334pfc.129.1544640657949;
        Wed, 12 Dec 2018 10:50:57 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n186sm25322316pfn.137.2018.12.12.10.50.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 10:50:57 -0800 (PST)
Date:   Wed, 12 Dec 2018 10:50:56 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 000/118] 4.19.9-stable review
Message-ID: <20181212185056.GC21649@roeck-us.net>
References: <20181211151644.216668863@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 04:40:19PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.9 release.
> There are 118 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Dec 13 15:16:10 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 155 pass: 155 fail: 0
Qemu test results:
	total: 337 pass: 337 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
