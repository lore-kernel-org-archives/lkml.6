Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B42EC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 22:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CC3721565
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 22:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYGV9uYp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CC3721565
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731038AbeHPBel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 21:34:41 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:46890 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727610AbeHPBel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 21:34:41 -0400
Received: by mail-pl0-f68.google.com with SMTP id t17-v6so1071188ply.13;
        Wed, 15 Aug 2018 15:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OA5ml5mVSGHIKSLaM1S+tfSif46UipweDCILxsUDFg8=;
        b=RYGV9uYpPi2VlnnFfZaP18gEmcSoI/aDIEnvQ8TP9bePFexQj3+FBi8CbGZ7yEDF+g
         5bd3/l12bcxHBmrXb+eoPhgApiJJjMIB3Q9IMQQCz5Wcnov21ZgjAG03G+Xjjn5sIEEd
         9DpkP7qFZ9PuDEVKX6WpJ40cqCJQwsGum9djCf872rzAWY7ItW3LNQxu1eXkKnqTC1Bb
         DtkEhxeHG5Qu/yG6cqBuYNo4+2TYIsjf3GFAfu0hWcq8dUF8GBYyEoO7yv+l1ejuEbNw
         7x4DpM19GGNZOv3GIfugBBjEmSkkVFbjmfHjVp+aXTcEvJ7v31YxXUhGJp4+SL9QomA8
         T3+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=OA5ml5mVSGHIKSLaM1S+tfSif46UipweDCILxsUDFg8=;
        b=bc2B6jqPS8mV1J6yqRgxTX+2VFcSsYupk+HhSgYTaH1G+18LqQktZonJqz0T3CPeXi
         Yt+pRuFd2dfHP6JllrJcZeEUuVG1kgK3m8IReMabz7BjUHIucMxxpdWvwI9wuy9w3bZz
         2TRLtSWdiuYGcPeazYz1hWRjFTe1T71e7VO3x+X/mGa2+wuXpZ9oCgpphrFdvaWID2oR
         +DmKG8+mk7G6JImJNcIl1Xwxt7moNJ9tdGrofs/eR2ZCWGYUEhEmc2OkHQd1oGVty0Pn
         T7Pd4aQsKFOb5uKODgZRYknkBma+ubDQyDvC/SBINJq1A624VN8SJyCz59s9BWSLeQly
         R3Rw==
X-Gm-Message-State: AOUpUlGwoA7YGL90ti1TqFAaJIAqV2v4kQtdbgQkrHzIZRBYyDm56Zl9
        9kKtXJO2vu7Nieg6YTO7+ZF1I4St
X-Google-Smtp-Source: AA+uWPw17toLaXdYUR++YAoH/XOdP/c0Ft1xmIeMPxTBvSuLUM105/KLbauaC7/7LsG4kNzEXhzJaA==
X-Received: by 2002:a17:902:ac96:: with SMTP id h22-v6mr26233622plr.17.1534372829992;
        Wed, 15 Aug 2018 15:40:29 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id v30-v6sm41334001pgn.80.2018.08.15.15.40.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 15:40:29 -0700 (PDT)
Date:   Wed, 15 Aug 2018 15:40:28 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Hari Vyas <hari.vyas@broadcom.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, ray.jui@broadcom.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] pci: Proof of concept at fixing
 pci_enable_device/bridge races
Message-ID: <20180815224028.GA12104@roeck-us.net>
References: <1530608741-30664-1-git-send-email-hari.vyas@broadcom.com>
 <20180731163727.GK45322@bhelgaas-glaptop.roam.corp.google.com>
 <ecaed7664b46d73888d2494065905f8e108fc0f4.camel@kernel.crashing.org>
 <5e42f7990673d11e3a020e7efcfd333215d48138.camel@kernel.crashing.org>
 <58192cf94de3941f9141aa3203399ae2bcdf6b7a.camel@kernel.crashing.org>
 <08bc40a6af3e614e97a78fbaab688bfcd14520ac.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08bc40a6af3e614e97a78fbaab688bfcd14520ac.camel@kernel.crashing.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 07:50:13AM +1000, Benjamin Herrenschmidt wrote:
> (Resent with lkml on copy)
> 
> [Note: This isn't meant to be merged, it need splitting at the very
> least, see below]
> 
> This is something I cooked up quickly today to test if that would fix
> my problems with large number of switch and NVME devices on POWER.
> 

Is that a problem that can be reproduced with a qemu setup ?

Thanks,
Guenter
