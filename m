Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B48C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7038E21580
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="HnLo+Gxa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7038E21580
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbeI0O6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 10:58:36 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33313 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbeI0O6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 10:58:35 -0400
Received: by mail-lf1-f68.google.com with SMTP id o21-v6so1500884lfe.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 01:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aj3loS6hzUS9FjQxA2zA81gFmbQV9Zk5u4IJUxPDUe0=;
        b=HnLo+GxaqRKzO/z0bL8tVOWp+BTLo8uRmvSmAH0097wxs4MYeK3Wn5wCdLiWOqPMam
         GzdgV+FLMY2mSOwt56CzIkH27C9p6T1uWNBoGxweHeNqnqF8WdTNy54efvpa5QRsbYP7
         CMebxSdTdnTS50ii180KsLsxFLI9vy0YbYuDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aj3loS6hzUS9FjQxA2zA81gFmbQV9Zk5u4IJUxPDUe0=;
        b=XsxftRM0Ts2Y5nVpCQn1HUXdkAPLGw9Mb4NJnlhVH1CEperucBF1KdsLYWDr+/UL+Q
         r9jHuGfLIrbYSnpmMJztf9G1c+R+njuStFt6oNbO2+VC5OmBCgGX+BMsit5HMiNFGsxy
         SgAWmMHY6676xrUh/FkzwgAKs+wPI2fDDFTtCnnxPZnlJHRPxiuFlTxOqUjkwLRrnx2d
         G3hUiBuk1Ard+1OSgxt3N/ZqPNu4nxbqYaYsBQFz+i2SkpH9Ux073nR8gWzGMKEaXnbn
         10X2lthQkrd/DolMumGXbs/UPTIdRkvUCPZ4HmNN3ZrEFrAG6IHa2luEVcYSz07J5XPQ
         pU4g==
X-Gm-Message-State: ABuFfohWeX8FFP56CYYdGJ3LYaM2Cda4EBtAPHr9rNB/eK67hciJsGIW
        WWeR52yNUp2uaIPYG/vgrr9qUw==
X-Google-Smtp-Source: ACcGV63jJKiiJ39Y5HZtFOsnitfXZf6zx5gXSxW1xz7wf3z9CNXnP49zirktypmWoqFPlROfRomPng==
X-Received: by 2002:a19:109e:: with SMTP id 30-v6mr6273702lfq.96.1538037687792;
        Thu, 27 Sep 2018 01:41:27 -0700 (PDT)
Received: from [172.16.11.40] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id b10-v6sm292364lje.47.2018.09.27.01.41.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 01:41:27 -0700 (PDT)
Subject: Re: [PATCH 06/22] linux/printk.h: use unique identifier for each
 struct _ddebug
To:     Petr Mladek <pmladek@suse.com>
Cc:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
References: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
 <20180919220444.23190-7-linux@rasmusvillemoes.dk>
 <20180927082215.ybphmhivvtqwma64@pathway.suse.cz>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <26e500c2-a0a0-c98a-8a2e-346e2073c37f@rasmusvillemoes.dk>
Date:   Thu, 27 Sep 2018 10:41:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180927082215.ybphmhivvtqwma64@pathway.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-27 10:22, Petr Mladek wrote:
> On Thu 2018-09-20 00:04:28, Rasmus Villemoes wrote:
>> Changes on x86-64 later in this series require that all struct _ddebug
>> descriptors in a translation unit uses distinct identifiers. Realize
>> that for pr_debug_ratelimited by generating such an identifier via
>> __UNIQUE_ID and pass that to an extra level of macros.
>>
>> No functional change.
>>
>> Cc: Petr Mladek <pmladek@suse.com>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> 
> Acked-by: Petr Mladek <pmladek@suse.com>
> 
> My understanding is that this patch would go with the other changes
> via Andrew's tree.

Yes. I'm still waiting for x86 folks to comment on the x86 parts, and if
they get rejected, this patch (and others in the series) become
pointless - unless some other 64 bit arch decides to play along.

Rasmus
