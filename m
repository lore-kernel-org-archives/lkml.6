Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_SBL,
	URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBEDC6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39971205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0zEAnyK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39971205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbeJMBYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 21:24:05 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:44403 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbeJMBYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 21:24:05 -0400
Received: by mail-pg1-f169.google.com with SMTP id g2-v6so6164956pgu.11;
        Fri, 12 Oct 2018 10:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Aj15l2cEApeqHsAshcdV7obPJ1IzQYJUiv8+UAkSWaQ=;
        b=B0zEAnyKtf1NIHD6GQpKUMmb+nkqekxV5iPsJkHGTaw4FtKyI6jZ6oig5pr42Ltksm
         AMXOMWsciGX43aCfrsagabHqOFx3RPz4q1aNAub3IQqd1a83jgQ5u3SKo48Rok5FppQy
         8eXRjYVWRuh0/w6avXoESrWmS8kBtuw4yOZJ78TdXJHo2zl3Xi8nunQoRRgNJGjf4xm5
         YBIveyqJvF7Lls/pEZh0QE8wAtm6bOiSx1Wybh8ewpFoakS5p+mTuOcB2QeAdjgtAHzd
         P2FPkfPWOLV5gsREMUlz1AwdCL3qHzT+Tv41VpmMLsZtjjOPhbU2RqrgJ5Xz+Sdpvisy
         i3lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Aj15l2cEApeqHsAshcdV7obPJ1IzQYJUiv8+UAkSWaQ=;
        b=iixSQco7AxBpZFkPSZKX39GWH2G54ePJR7iA3r5MErTMCS/LKQAYMU/4ttSYxpNooP
         tgRSfwy886HORq8K3IwNoN5ZVPM6k+F7Q3gTmvNVvErC3XoruZsphizwjwAPUHx7x7PC
         x5j0mq4lJe2rEiqU5/zSyQa1rA46ESHBy28PUpAE1oaUE5TD/jZfjT8NC0jo7NNvXTqX
         2UluJLpxbZtaVMt0N6pJLWkjDQzvvrI3+J8PMFhLu/dHK5Rl0LV/UBUx7OCSUt/bxETy
         UOksnoH/5x+AIEGoGehzlh/0NPW2LsZw0NM5paslpULfoYx1M4tWyOPsFAn5UaZRe2bl
         Boig==
X-Gm-Message-State: ABuFfohPRaR3KLmKtNjFms0q/+PPmA/G34kgVFqoeoz+7IRJs4KN5fS0
        L8pIiBJChSq0WcAjSP7CHWc=
X-Google-Smtp-Source: ACcGV61FkZaLjH7XXGd2igE+OK2NNEVXYtW3Z9qGliIlhahnA1VJSgWuBI/pCtWVt8rqqJ8UsH9G3Q==
X-Received: by 2002:a62:e414:: with SMTP id r20-v6mr7084155pfh.25.1539366627954;
        Fri, 12 Oct 2018 10:50:27 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id y144-v6sm3268690pfb.81.2018.10.12.10.50.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 10:50:26 -0700 (PDT)
Date:   Fri, 12 Oct 2018 10:50:25 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/35] 4.9.133-stable review
Message-ID: <20181012175025.GA25636@roeck-us.net>
References: <20181011152520.174949126@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011152520.174949126@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 05:35:02PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.133 release.
> There are 35 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Oct 13 15:25:09 UTC 2018.
> Anything received after that time might be too late.
> 

For v4.9.132-33-ge4e7bd48c9de:

Build results:
	total: 150 pass: 150 fail: 0
Qemu test results:
	total: 308 pass: 308 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
