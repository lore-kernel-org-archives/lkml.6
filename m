Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29F3C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEDE4214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0CjJx7L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388936AbeLQUMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 15:12:13 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44064 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbeLQUMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 15:12:12 -0500
Received: by mail-pl1-f196.google.com with SMTP id e11so5991492plt.11;
        Mon, 17 Dec 2018 12:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zWL5BpTF6y6Q4j7DWvb7z+4NxkbobxJQpmo9GGX0q68=;
        b=Y0CjJx7LyhaGCyjWQ0d0r1aFT2yk/tv4Uv1X3n1e7hbGUK2NSJjXBSgFXBq7WD49Pq
         FR1SQHWyfFWFgJiJJlPPID/0Ie3/CwzI75PKNVjNpys7qtmIyICfK3MKdXVuvIumZDYm
         G2jSCPOh/Le9HMP0ZjcNJ+UGoiGdZcxUN0OjqB5KGaTFIcQX85D46XH28h7ZM1WtdLo6
         WWDlqktFkAiu0xgVgVB99tHIjnBLSG7WyXjDSCd7kganKbLzA57iwIH6aBSIir76aldV
         yx+O8oBYJeWYy216W8c3HwQrxoMEe4fZYljrDn8wk/dI/xy3g3mYLzzNw7t4hjWjeWyP
         A5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=zWL5BpTF6y6Q4j7DWvb7z+4NxkbobxJQpmo9GGX0q68=;
        b=GVaAHvG8WaYOMXeOgt3CI4NekfdjZ8d5N95+HBRIP1fkpQ3Dm5jN0CiDJlGTvHa1QK
         gFF749B3kG5vWjoZseGsjTr/nFav473NuYME9XDtVoU61MQjZvjq+vmGGkun4KmKeT5G
         QZCBM4DWYAtuQmWyUKm4EGV8RMCETTLNfjlSl8DVECk6d7KMKqEAMbdjN1bbsJbXgP1q
         vyrIJzq7C81pQtRC/Trts8cN6d18e95ww5x13vv6dz06cJVnTiGLWcSO53vNg3MrcE0C
         LqgE/xAZdxgJU49j39QOl6WSLv6awuDhBZVfCHbJBiLSnUg/4+dM0Ppsy43nviUOIDbb
         fUyw==
X-Gm-Message-State: AA+aEWZ9LYX8+3MJVi7ylo05x3dTdJgOrqDbwu2A5Rst8kqiNg69UFu0
        XSgppUbAdgTgzeGT+VJnFLM=
X-Google-Smtp-Source: AFSGD/UiqiAbuBRtxBcFJzaJqOej5//NxGOI8K0Grr+PdzWNILccMNzd7LQLQdo9vzIxLihCm788cA==
X-Received: by 2002:a17:902:e085:: with SMTP id cb5mr13688863plb.24.1545077531316;
        Mon, 17 Dec 2018 12:12:11 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n186sm18000195pfn.137.2018.12.17.12.12.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 12:12:10 -0800 (PST)
Date:   Mon, 17 Dec 2018 12:12:09 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/88] 4.4.168-stable review
Message-ID: <20181217201209.GC29585@roeck-us.net>
References: <20181214115702.151309521@linuxfoundation.org>
 <dfd49bfd-359a-7f5e-8332-5e6ad6da21cd@roeck-us.net>
 <20181215080729.GG10074@kroah.com>
 <c5862b36-beae-4810-fb33-4b646e96378b@roeck-us.net>
 <1545004693.19315.66.camel@codethink.co.uk>
 <20181217090533.GA12938@kroah.com>
 <ca64083a-158f-7faf-d6e7-566336ad03d0@roeck-us.net>
 <20181217190834.GB13773@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217190834.GB13773@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 08:08:34PM +0100, Greg Kroah-Hartman wrote:
> > 
> > v4.4.167-89-g9c558d7fe359 seemed to be happy. v4.4.167-89-g50a0280f2f7e
> > replaced it and will take a while.
> 
> If I read your site right, it passed everything except one qemu test?
> Is that normal?
> 

Kind of. I was playing with that specific build, swapping out the root file
system, and that was broken for a bit. I restarted the test, but for all
practial purposes the build is fine.

Guenter
