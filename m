Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6377AC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 08:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B3FC2151C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 08:20:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B3FC2151C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbeJLPvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 11:51:43 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44887 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbeJLPvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 11:51:42 -0400
Received: by mail-ot1-f68.google.com with SMTP id p23so11603889otf.11;
        Fri, 12 Oct 2018 01:20:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xk0q5CX14sZOPWbQK339Ju32BvuX+ClvFiXhhTcsPXA=;
        b=AoctDalrCkja2pWxDNzbXvi3taz4nMIPhbhnAWa1COKd8GvjABmnMw+VVde0TgoKyg
         LWLj+eucWnKCTA+kno6hT4h4MKrIS4JTUvIrKuT8hCrAhHI2t/oCBYM883SBiusdDNJY
         sWt461m7G+ot1THD+mwPCzOdQQeX0gL80cQbKtZnqIYnhJE272qqu0oMg3+BhaA781sQ
         z+G/nFNqC/jjroL3hSM5xGEDt7zSuSA72REv4TQt3vRvwmy4fWe9PfZ5P18fA8SyxzL5
         JmsT6YS8jk6WhILnNyzAOWJiHiRoGDCBp0JB2aIWkxavC6c1w2BKfROozJfmK8ymy+JB
         dMBA==
X-Gm-Message-State: ABuFfoi3ebAEm3xJdaMPcvZ7e2Crx0XsNmVRPp3W26/zyyjJdn285wT4
        r6TntpBGMxadAJjfNfVs0RaoXqbNu2T1anpiM28iWQ==
X-Google-Smtp-Source: ACcGV62JSPdR0zGdZZlJi3dafNa9Uyg4dDJQ+7XEaZRb+6twre1GQFrfC2j2L1UcxFK6v9QgSiF24rHlYdMdUPSzA+M=
X-Received: by 2002:a9d:4c90:: with SMTP id m16mr3025959otf.124.1539332424901;
 Fri, 12 Oct 2018 01:20:24 -0700 (PDT)
MIME-Version: 1.0
References: <20181009214633.16390-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20181009214633.16390-1-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 12 Oct 2018 10:20:13 +0200
Message-ID: <CAJZ5v0i3_2pxX48iZOwm+AyuU12E2g-bEnxNEaFURUsXyJpX3w@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] cpufreq: intel_pstate: Base frequency attribute
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        "Schmauss, Erik" <erik.schmauss@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Prashanth Prakash <pprakash@codeaurora.org>,
        George Cherian <george.cherian@cavium.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>, devel@acpica.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 9, 2018 at 11:46 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> This series presents base frequency to cpufreq sysfs when intel_pstate
> is in use in HWP mode.
>
> Changes:
> v2
> - Removed guaranteed attribute addition to acpi_cppc sysfs
> - Using the cppc_acpi interface to get base frequency and present

The code changes are fine by me, but what about documenting the new sysfs attr?

Thanks,
Rafael
