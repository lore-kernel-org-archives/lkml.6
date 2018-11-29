Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1038C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 04:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B10362081B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 04:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y8Zs7UoY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B10362081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727643AbeK2P2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 10:28:09 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38017 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbeK2P2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 10:28:09 -0500
Received: by mail-pg1-f196.google.com with SMTP id g189so327695pgc.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 20:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ipkrWTzK4ZIDnXQCG0F3aIAB5W4HKHW11MOiYaYFM2c=;
        b=Y8Zs7UoYCkuzTvWLrDOyCcJtS/Zc9DOmFbwkaej7hJY0Zr0V90JU5ucwTstYwyhFKp
         hiASbRjg2FTE4xfavBmgn1uyWX7xpDlFk6KZfoIEWnHjDYC/Y0RCQdHdv/ROZ80rKPq1
         bV72vRusE1BqmvKjqfyKXqq0MLqBPg948IL58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ipkrWTzK4ZIDnXQCG0F3aIAB5W4HKHW11MOiYaYFM2c=;
        b=hE7/UEmR1h0pIyFewdc+6pg48tRDYmFLBZB2W6wmsuTSHn6Dt71RAgAQAdAQ8SX0fR
         zLQ/0StNC93W/m4vdYvRVXh690QazPYfdiwdkt8FP7Q11/0b5yIwOVlxTVJ98J1/8KlT
         MjKRqziqSYrl2HSolR9wzTvHHRUwyVjv2umGfH2JgDBdBAmt+OnKLGfozR1qrtnuX5vX
         YjuNvVPmCvfKUsUygeG7tBogb4mAsFmtkDSjEiaQuRf9v/OL/ha3qS/76+XcVqUv5vHC
         p4Cb3Qo7CWco5Y3a5HMOHcwFQ3WRp/j5fA/9Eig5V07OfyXVJlQXgeUQsf7VP/evyaMI
         Pgow==
X-Gm-Message-State: AA+aEWbPzmESgoGnmTRgzw5y+Mik9EqL3Y88FQ/NgsY1YbtAEXxQffi7
        PIAXATGu3swMI9KMcoo57F3Now==
X-Google-Smtp-Source: AFSGD/U67JkMdW66kkaUPhTy+5KXUuohlVCOCsBtx08Lg9wgCkxPFXoJOto09RzDdiS1ZjhzD/Q4xg==
X-Received: by 2002:a63:f34b:: with SMTP id t11mr35558530pgj.341.1543465450220;
        Wed, 28 Nov 2018 20:24:10 -0800 (PST)
Received: from localhost ([122.172.23.29])
        by smtp.gmail.com with ESMTPSA id d80sm935597pfm.146.2018.11.28.20.24.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 20:24:09 -0800 (PST)
Date:   Thu, 29 Nov 2018 09:54:06 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2] Documentation: admin-guide: PM: Add cpuidle document
Message-ID: <20181129042406.f2h2yt25atwnhz26@vireshk-i7>
References: <9986634.fXZiTbRPzQ@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9986634.fXZiTbRPzQ@aspire.rjw.lan>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-11-18, 12:47, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Important information is missing from user/admin cpuidle documentation
> available today, so add a new user/admin document for cpuidle containing
> current and comprehensive information to admin-guide and drop the old
> .txt documents it is replacing.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> -> v2:
>    * Fix typos.
>    * Improve description of the state0, state1, etc directories to cover the
>      relationship between their numbers and the represented idle states depth
>      (Viresh).
> 
> ---
>  Documentation/admin-guide/pm/cpuidle.rst       |  604 +++++++++++++++++++++++++
>  Documentation/admin-guide/pm/working-state.rst |    1 
>  Documentation/cpuidle/core.txt                 |   23 
>  Documentation/cpuidle/sysfs.txt                |   98 ----
>  4 files changed, 605 insertions(+), 121 deletions(-)

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
