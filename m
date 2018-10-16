Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F07FC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 416E1205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fbpHRhuO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 416E1205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbeJPRmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 13:42:09 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45387 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbeJPRmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 13:42:09 -0400
Received: by mail-pf1-f193.google.com with SMTP id u12-v6so11168613pfn.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 02:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Tug2zdl4RwdXBNq9m2E48/q91paM1YgASEUMA05RtHM=;
        b=fbpHRhuOidzVOTpZ0RRaE7NjjFcfXYPX/Aemsv6+G1QfKs3wUG7I9WlV+j0L6NmlBx
         mdnp0dAuD2Rj6A5owSAb2HyWYg2yjPCj2g70Aw7npssO/rXYgWkSBgRLUwTyKgwoM57h
         CyswVda9Yo67DBw5yh9mDlZVyrdTSDX2V7b2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Tug2zdl4RwdXBNq9m2E48/q91paM1YgASEUMA05RtHM=;
        b=sU5q+95besJ0L7FfPyKCHLdGrVQrsG0AHtg+wanPvuzi4dIb3JDJ9OYAtz17EomWGJ
         +dMQt1iz3tX4IMN1uyoUoNv083JOIznF6vTfmcPR+N4oeV1SKFjvNNwBSStx6WOxGjBU
         JJW8QKQDcRHFA1x4MOTr7QJRpGX8U8iuYKvjCzswfm7mT8QkDXXudAygwg1DgW9e0df7
         LMgeQAlUafjhj1I5FGam98KOWyL/mXVYxiVsO+ZHD622OnfEVFHtpOE+jf5f+psiQ0wT
         Z17vbDLxbFBJojzzyhKv2uQM7ihumW9pRbYJ4OZSbir0FmD2wuhPjwfbannSi4q24SyE
         E1sw==
X-Gm-Message-State: ABuFfoihAoERvcbTYun9nqAmGMfRVsJhIJIQOnzK//ZDgAPVfxomkxl8
        QSlH3RRZo9NV5nhbCos3KIk6Bw==
X-Google-Smtp-Source: ACcGV62dUcwhEBGBFV/7WnTaAfySvLNcLTTlXkHVaX2E2/Ry0duwtZNKvux1gNrYp0ZI70rCb795rQ==
X-Received: by 2002:a63:c746:: with SMTP id v6-v6mr19891646pgg.108.1539683549919;
        Tue, 16 Oct 2018 02:52:29 -0700 (PDT)
Received: from localhost ([122.172.25.62])
        by smtp.gmail.com with ESMTPSA id c69-v6sm22207876pfg.2.2018.10.16.02.52.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 02:52:28 -0700 (PDT)
Date:   Tue, 16 Oct 2018 15:22:25 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>,
        Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        t.bartholomae@intel.com
Subject: Re: [PATCH] cpufreq: conservative: Take limits changes into account
 properly
Message-ID: <20181016095225.snxu3dafz4x3w7ch@vireshk-i7>
References: <20181008150901.19667-1-waldemar.rymarkiewicz@gmail.com>
 <CAHKzcEOECQP8j6q=NKzuEjF+mc0s80fr6xWw-=NXsTtzCGGg_w@mail.gmail.com>
 <CAJZ5v0gFjBoFi=cpC2gPkZTDZof8dxdCCVx0XoAv2XuPmTfWPA@mail.gmail.com>
 <5406371.vuaACy5i7F@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5406371.vuaACy5i7F@aspire.rjw.lan>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-10-18, 23:21, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If the policy limits change between invocations of cs_dbs_update(),
> the requested frequency value stored in dbs_info may not be updated
> and the function may use a stale value of it next time.  Moreover, if
> idle periods are takem into account by cs_dbs_update(), the requested
> frequency value stored in dbs_info may be below the min policy limit,
> which is incorrect.
> 
> To fix these problems, always update the requested frequency value
> in dbs_info along with the local copy of it when the previous
> requested frequency is beyond the policy limits and avoid decreasing
> the requested frequency below the min policy limit when taking
> idle periods into account.
> 
> Reported-by: Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq_conservative.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
