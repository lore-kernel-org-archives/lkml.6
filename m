Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63E2C43612
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 23:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A62012084D
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 23:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqjM7Ryb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbfAHXJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 18:09:33 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44181 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728946AbfAHXJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 18:09:32 -0500
Received: by mail-pg1-f194.google.com with SMTP id t13so2384401pgr.11;
        Tue, 08 Jan 2019 15:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zvfPO/Yfat/KmvxNju56FpCbFHFk3MEOl/IVS1jAYIg=;
        b=nqjM7RybF1i1DhcBH/KB/5ORhb/ztwSkJDROu53PpsZCivvpvfZFW2VYrafQpXxuUp
         H6L7E8ZKAWOyGsR94lqKSlgIIkGZGkYcjs3bVrlQku3bEyK8KiZf6jVHSbXakH5gN6IB
         8cqnGD4v3S+eeu938lqqk/3UF8iF4RLCNEn/r/4NUfRKbSYfActxptgDghr8BM08tNYp
         EIpk7xyiICQdPVaTcoYpDbLsOGqyScwLiUC6L92BbvnE5RNcQW0/N+VrfjDz/494qi1L
         SEoHlOQEVI13qTMc8r1BRpiZQk1yp+rfR46kveYNjLcBTIFcgqCe8IFOQnXZYkYdXv8l
         m+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=zvfPO/Yfat/KmvxNju56FpCbFHFk3MEOl/IVS1jAYIg=;
        b=M+8Iun8rqHvmEZuslcY4z0wnNOXiCuOm2R0g/Grw8hryJ46rCczmxwlAi4HvpGgOG1
         2RfWw6Wi7nR8eieIeP/4BM2vT7kX64IB9uQP3kVr+0YI4OB6B48UhpmYqB8slqjY4kIJ
         K3ugWcEz1Lohre9Yso5qulI63y2TVzgESRSRkgaVO9QyZ76osNlXlv9EB73jQ+HXedhY
         7xNFLv3BpFO8NmVBSzNBXYaTxfiCipSVoKRNq2TZSOE4t3tCBxWoKbV7aCIERN5jDRQ8
         3fuQta6M8KU2vDFf2NSHLFDQFLeJpKr5geslBEtPIVULTcFBaQvPb5rxuZFzFl6p+tgx
         U2Lw==
X-Gm-Message-State: AJcUukckiPrqZmWF+GqFC58uOttB+ZPbwFHb43NiHEiKMAJifsy9Y1W6
        56iY4NxEGkX+viAv/Sx/Njs=
X-Google-Smtp-Source: ALg8bN5d+Kem3OS8BiqW7dAScjcOOdTnH9guHepADBBkbHGdMpz3jYjZN6oCzI/q4t57sdPUEz5G3Q==
X-Received: by 2002:a62:31c1:: with SMTP id x184mr3738437pfx.204.1546988972326;
        Tue, 08 Jan 2019 15:09:32 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d11sm97398765pgi.25.2019.01.08.15.09.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 15:09:31 -0800 (PST)
Date:   Tue, 8 Jan 2019 15:09:30 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.20 000/145] 4.20.1-stable review
Message-ID: <20190108230930.GD20519@roeck-us.net>
References: <20190107104437.308206189@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 01:30:37PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.20.1 release.
> There are 145 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Jan  9 10:43:39 UTC 2019.
> Anything received after that time might be too late.
> 

For v4.20-146-g212b8222d189:

Build results:
	total: 158 pass: 158 fail: 0
Qemu test results:
	total: 332 pass: 332 fail: 0

Guenter
