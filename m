Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C60C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A693E2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KWbTyts2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A693E2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbeKZVNj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:13:39 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38381 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbeKZVNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:13:38 -0500
Received: by mail-pf1-f193.google.com with SMTP id q1so6360391pfi.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 02:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=igwD1zgtXW1H8JJjPZ7oyS9EFjmFPog78EeENwGq6sU=;
        b=KWbTyts2J5fmLi/YIi+X2iM0ZDZm/ypBQjrkT3zhRWvQIjIt7SGCGNduwNMaXBijn3
         opc8H+Ty/KnXyMB8sJXfxeKQ9aCHzwV2kuXvDhhKKUFHAtiKW43dmFUwjA7JLUbhJfES
         Me/qSfb/uWOrxjIkoIAv3FTB+t4aPeULfMMMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=igwD1zgtXW1H8JJjPZ7oyS9EFjmFPog78EeENwGq6sU=;
        b=EZ2svJ+aIvvan3Ge2i6OhSHiKtaDzaZa1jQMR2KIBoa8+ySovTDKzsT8pjnr5iPfnW
         rxV4TPv5v8ix8jeVLvFCn/KqjYP1WL5MIdHUKMGmJQBuuavTE3gxkZ8GfyFXjPz4tstj
         iATcn6GgfeEg90EMmdPgHDIXc1bOOngIalcdOW9yn3bC1JjyLQ5/MuKkrHuNaLEaef04
         iyHfL+k8v02mC1eU7gR3kORCPbZINpPDFBVDtSQimFI8Zz9kiWTlHO9ZvxNX9q1avM7q
         YoiahqdyttM9p7QFEwd6cM0q6YFJ0o1r4GOVXK+VF9y7DVNRxEquvm+L7L/nkIGgPAq9
         Xxrw==
X-Gm-Message-State: AA+aEWbJpetT9VeenmDedzNJN9NwYXpvXVEWBNC9JF69TciH1sKmwukg
        kIFZxoVF8QYMiNklhq7aqrM92Q==
X-Google-Smtp-Source: AFSGD/XoIHHyIJFFCqREiA4zHGkEbdxfG1hiEnd+hrzCLttJOKljvksC0atTrQNwXnaB/Py/hZjsPA==
X-Received: by 2002:a63:8043:: with SMTP id j64mr24699093pgd.405.1543227598867;
        Mon, 26 Nov 2018 02:19:58 -0800 (PST)
Received: from localhost ([122.172.88.116])
        by smtp.gmail.com with ESMTPSA id u70sm26618051pfa.176.2018.11.26.02.19.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 02:19:58 -0800 (PST)
Date:   Mon, 26 Nov 2018 15:49:55 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Quentin Perret <quentin.perret@linaro.org>, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org,
        Chris Redpath <chris.redpath@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V3 2/2] base/drivers/arch_topology: Default dmips-mhz if
 they are not set in DT
Message-ID: <20181126101955.pdn76f2ujeb6urxz@vireshk-i7>
References: <1543221866-19671-1-git-send-email-daniel.lezcano@linaro.org>
 <1543221866-19671-2-git-send-email-daniel.lezcano@linaro.org>
 <20181126095224.i5se3n5lavww4a2n@queper01-ThinkPad-T460s>
 <97f85a4b-efb6-b26f-94d0-cd538c83a03e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97f85a4b-efb6-b26f-94d0-cd538c83a03e@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-11-18, 11:08, Daniel Lezcano wrote:
> On 26/11/2018 10:52, Quentin Perret wrote:
> > Maybe you want to test 'if (!raw_capacity || cap_parsing_failed)' at the
> > top of topology_parse_cpu_capacity() ?
> 
> I prefer to update the documentation, it makes more sense than adding
> more cumbersome tests in the current code.

+1

Throwing an error and ignoring DT number completely for the capacity
are good enough in my opinion as well.

And who cares for the platforms that can't even fill the DT properly :)

-- 
viresh
