Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A257BC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5102825A24
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvIStRA/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5102825A24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753702AbeGBVuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 17:50:01 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:33569 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752910AbeGBVt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 17:49:58 -0400
Received: by mail-yw0-f194.google.com with SMTP id c135-v6so5336311ywa.0;
        Mon, 02 Jul 2018 14:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DPseJUsXv8XiEHChnSubbZD6tnCCewMKlVPAwpxiODk=;
        b=hvIStRA/rGoveTXduhVciISd3OqczrvPTrFJwEy2b1o1kivQjxWGcW6FRB+6ZC928v
         Dqs8RZxkg08lKnWr8daSI41+cSn6a+xFNwUC7Nz0x17NEsIvMejuaHZunqwLJC+2vv98
         UDc9z2fu/Wjt8P4t8LG7PBkyPz8yR5+F2tJ81WNEnhH/cEaJ7SoGURlTijhlf31yzOsN
         Rd7KpFlOdYAlLtfhSPLuYX45lTyTuPYKU8Ol8ZGPYc4TKbQ7WSJmOoQ1QfhlIQAzZ+yV
         gf1SYDLelr5GxP+//PuyJl9WSdwwcRTswdEcxFO2yk25XknonHRO4EZGm5H1i7epPZsf
         PVCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=DPseJUsXv8XiEHChnSubbZD6tnCCewMKlVPAwpxiODk=;
        b=EYqrOhYFk+zF2xpsC6lnkRLW3+07ncxz3up4QWh13REEfNNIqnfaDhSwHjUXNEpJ2k
         JAsndio6CsYVzSYzPh/Rra9ZHUW7VA57OPSZPRq0vhbdnAJwB/RmCY/pXbZ1O4Th4fYC
         dfxGm/otgd0SSwDAjEW6CrwxfZtpePmUM0w9UMQ93IBAknL7+sXgQX/W4Xekuk0tKZjA
         CT981N0mtIKr75bojnF1ZXd4iAtQ5zDoGBrdE4C/cFai+ShPLEFf6WT4KLErbubQemnK
         8zYAXrjdGdG7netvZr+TlJOS6yaIiuNYZZIL0MOCtXPFdyC8G8W/YruQG1kcZjqB4vDU
         OX4w==
X-Gm-Message-State: APt69E03Cq7f8DByZ5jv5G7hwYBQJSEbApimlUSntqEmSXcJ/WZev8bT
        E1HHAM2qWtFMwO3qnRJCaWAvmxDu
X-Google-Smtp-Source: ADUXVKI3UTfShMCmvNFKvmqO1Jsyn1ReEvdNC5pbly3OJsrN+ScMMoL+GfMayIZRTEl8bYYQ8Y5jzw==
X-Received: by 2002:a0d:ee03:: with SMTP id x3-v6mr13238925ywe.62.1530568198261;
        Mon, 02 Jul 2018 14:49:58 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2b6f])
        by smtp.gmail.com with ESMTPSA id q131-v6sm9194624ywq.8.2018.07.02.14.49.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 14:49:57 -0700 (PDT)
Date:   Mon, 2 Jul 2018 14:49:56 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     axboe@kernel.dk, kernel-team@fb.com, linux-block@vger.kernel.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Josef Bacik <jbacik@fb.com>
Subject: Re: [PATCH 13/14] Documentation: add a doc for blk-iolatency
Message-ID: <20180702214956.GP533219@devbig577.frc2.facebook.com>
References: <20180629192542.26649-1-josef@toxicpanda.com>
 <20180629192542.26649-14-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629192542.26649-14-josef@toxicpanda.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 03:25:41PM -0400, Josef Bacik wrote:
> From: Josef Bacik <jbacik@fb.com>
> 
> A basic documentation to describe the interface, statistics, and
> behavior of io.latency.
> 
> Signed-off-by: Josef Bacik <jbacik@fb.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
