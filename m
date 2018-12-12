Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7180C6783B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 02:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DF3C20851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 02:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544581088;
	bh=hyyypa92e7Vh1MJaNR3uvfSYiwu3b/TgH3nOD8KBIWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Qk5dJUosze0DhXzVlMW4eHewsZTJwwn92QNtvBVe2kjr8epg1LV5zZwLbQ2ZW5Xn8
	 FOPxM5NZO4aBVnuE5IoexUyVIj1XVozKgP2JpN6crrgL8gnZRQbG+kl18wSLn2rL8A
	 TDjLwrqrywHa9Kn+8dyvTi6b71yxwl+UN3jdhWMU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DF3C20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbeLLCSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 21:18:07 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34091 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbeLLCSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 21:18:06 -0500
Received: by mail-ot1-f65.google.com with SMTP id t5so16224751otk.1;
        Tue, 11 Dec 2018 18:18:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C2cH5IsrGr+G0d23Ns9LiEi//qIodgXBW3qvwxoEVy4=;
        b=k115gdc1B62PuY2HyHnfMiRrHhlREKlW2CPxDYZdN7sFI0r88rifiBGkm1XgLRA+9H
         n5KCfoij1dQeDL/O5peY9cBFrHGakzEGyyOE2sMCq/KegccWjFfoZlNvSnm7cHt06YzV
         SHv6TW7PH5iQl6uPctv3iPk961uT7evKa/yjpHosBrjZ+MCrvxqBX7WFG1RitgKxBg9N
         A9wpzlTWBHGwdRVvSnRbakLw+3qj5Ue5NtFjNXPcfJvnFHKdOWDVqT1Ow7qOLecSLf/8
         jrXCS5kYumJi4/iIaw4JzAyDG2vV9w9Ti9iLC4OD83fGg9YoFuPHQtMqcquYbwH0gyRi
         jkZQ==
X-Gm-Message-State: AA+aEWbY2qXtEBzk1izslUrIJO5YRC4pV9ng1khKdoRqRPY67XrtaHq5
        +hyO5JbfrCjSKrX9cDvB5A==
X-Google-Smtp-Source: AFSGD/VaTk/hj6fFAryl7RdYqZ+mFfX9CV213oEG7jg2A0yfa/dqrXR+h9c8GGmKtLeCs4WIIRvztA==
X-Received: by 2002:a9d:6c3:: with SMTP id 61mr13974421otx.314.1544581085619;
        Tue, 11 Dec 2018 18:18:05 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m207sm8134554oig.2.2018.12.11.18.18.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 18:18:04 -0800 (PST)
Date:   Tue, 11 Dec 2018 20:18:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Atish Patra <atish.patra@wdc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        devicetree@vger.kernel.org,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Juri Lelli <juri.lelli@arm.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [RFT PATCH v1 1/4] Documentation: DT: arm: add support for
 sockets defining package boundaries
Message-ID: <20181212021804.GA13998@bogus>
References: <1543534100-3654-1-git-send-email-atish.patra@wdc.com>
 <1543534100-3654-2-git-send-email-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543534100-3654-2-git-send-email-atish.patra@wdc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Nov 2018 15:28:17 -0800, Atish Patra wrote:
> From: Sudeep Holla <sudeep.holla@arm.com>
> 
> The current ARM DT topology description provides the operating system
> with a topological view of the system that is based on leaf nodes
> representing either cores or threads (in an SMT system) and a
> hierarchical set of cluster nodes that creates a hierarchical topology
> view of how those cores and threads are grouped.
> 
> However this hierarchical representation of clusters does not allow to
> describe what topology level actually represents the physical package or
> the socket boundary, which is a key piece of information to be used by
> an operating system to optimize resource allocation and scheduling.
> 
> Lets add a new "socket" node type in the cpu-map node to describe the
> same.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/topology.txt | 52 ++++++++++++++++------
>  1 file changed, 39 insertions(+), 13 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
