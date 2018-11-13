Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_SBL,
	URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5BEC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5582224E0
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p096o8p2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5582224E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730422AbeKMKuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 05:50:46 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34192 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbeKMKup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 05:50:45 -0500
Received: by mail-pg1-f194.google.com with SMTP id 17so4580291pgg.1;
        Mon, 12 Nov 2018 16:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+JLrpKepENDR0lAMK3ppaQ8fh4MWt/syiyRsfXul0Gk=;
        b=p096o8p21dvaKjr+sGYbypQDmui3zPf68T8EdbV5D1S21nu7m7cni/4nSch2BDEZ6n
         DK0M2KyBqMKpXDZxsiRH+1lerHYYefknOqQro9dc75UngbBfhCBxcnulX+JrUIruNphd
         xTK2t4U5688YI1JsD7n6b7tZ7Gx7Y/MOIPFnE0fmXbMB2vsjbw9ImZLMb9wJ6yDMgt6R
         5b368Pz9PdVNeiv4gh/yBRB1wmIrdbD206i9hexZ+ZScNqHheMqB1owZBq4tN0s8Zeu8
         dfvII5ySFerZ1evNsbYWzItW80176ejTsPcPiNjFEd8eb4g1IuKjUQN0Gl6CZaoldUa9
         GsMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=+JLrpKepENDR0lAMK3ppaQ8fh4MWt/syiyRsfXul0Gk=;
        b=EujSC1idm9C4DWwfkie36e6gAoDOwjPRlpj4dTpbaUgKLauDtxN/ylJ+hkB7bUNWuD
         +DpYfg2mcClYrfu98/S1kNrgsODcNxXztdsobhnj9pPebIFqmAZu3pc+tNFX+B8RZNhL
         r8LuZS61qwnDJ+ySSQfeacucV7ru7Ai/j9gNltleABcnuWXPApfYlu0dMvVJjtqZFwl5
         YmAf9wNmyF2r22IqUw1H/u92Asg0s4RrwVZ9O6nUTW1Oxog+gxyPjYD80v+HP92jw4Bu
         ccImakZzlVoKL2R6ZHb1k1CkYiKZCkYcEYqNOcJmZuzFNM6HpN+2zkomUR7tiiyhx8C4
         eQlQ==
X-Gm-Message-State: AGRZ1gJSJlQU5CbC6siB+fTeiQ8G1Ha2tuRg4qW60GKnRzO5BxYOwd2n
        xG7JCLf8bqLUImhCX2767CY=
X-Google-Smtp-Source: AJdET5dPoQe5rKzWjA10JNACIyB4Q89YMI/KZX+F33oi/kd10TEqXVhC2rwKbJzrBI9GuYjZGiyDCg==
X-Received: by 2002:a63:de04:: with SMTP id f4mr2771154pgg.292.1542070507641;
        Mon, 12 Nov 2018 16:55:07 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d6sm4383492pgc.89.2018.11.12.16.55.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 16:55:06 -0800 (PST)
Date:   Mon, 12 Nov 2018 16:55:05 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 000/141] 4.9.137-stable review
Message-ID: <20181113005505.GA2997@roeck-us.net>
References: <20181111221627.853046496@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181111221627.853046496@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 02:24:19PM -0800, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.137 release.
> There are 141 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue Nov 13 22:15:38 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 150 pass: 150 fail: 0
Qemu test results:
	total: 283 pass: 283 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
