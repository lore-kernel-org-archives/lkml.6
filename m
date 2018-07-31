Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D31C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 022A420841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ox+0PmtJ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ox+0PmtJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 022A420841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732329AbeGaVGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 17:06:47 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36694 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728800AbeGaVGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 17:06:46 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 810DA60B19; Tue, 31 Jul 2018 19:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533065099;
        bh=EPTk36YUrGKglBOFpQ0mNMSjipOdFGISnVPnsrBN6xI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ox+0PmtJ4DZpxetPSr8sPQN0HVjkjCubcGlphOb1vHINHLypYuV5/GDc4UY5326kx
         2kN6LPRnniv5+SErGUmqFYVLPRpLeuwjKhZz/A4ZFAoOOKY6KCXfExnKH5+PTpY1p/
         UlUf/32MdCcQq1oyLnHpTZgz7c/mEsrE6SiMb5F0=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 12F0460585;
        Tue, 31 Jul 2018 19:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533065099;
        bh=EPTk36YUrGKglBOFpQ0mNMSjipOdFGISnVPnsrBN6xI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ox+0PmtJ4DZpxetPSr8sPQN0HVjkjCubcGlphOb1vHINHLypYuV5/GDc4UY5326kx
         2kN6LPRnniv5+SErGUmqFYVLPRpLeuwjKhZz/A4ZFAoOOKY6KCXfExnKH5+PTpY1p/
         UlUf/32MdCcQq1oyLnHpTZgz7c/mEsrE6SiMb5F0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 31 Jul 2018 12:24:59 -0700
From:   skannan@codeaurora.org
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rajendra Nayak <rnayak@codeaurora.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM / devfreq: Generic cpufreq governor
In-Reply-To: <1532750217-8886-1-git-send-email-skannan@codeaurora.org>
References: <1532750217-8886-1-git-send-email-skannan@codeaurora.org>
Message-ID: <304a412a17e9bff85991eb1e7e175be8@codeaurora.org>
X-Sender: skannan@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-27 20:56, Saravana Kannan wrote:
> Many CPU architectures have caches that can scale independent of the 
> CPUs.
> Frequency scaling of the caches is necessary to make sure the cache is 
> not
> a performance bottleneck that leads to poor performance and power. The 
> same
> idea applies for RAM/DDR.
> 
> To achieve this, this patch adds a generic devfreq governor that can 
> listen
> to the frequency transitions of each CPU frequency domain and then 
> adjusts
> the frequency of the cache (or any devfreq device) based on the 
> frequency
> of the CPUs.
> 
> To decide the frequency of the device, the governor does one of the
> following:
> 
> * Uses a CPU frequency to device frequency mapping table
>   - Either one mapping table used for all CPU freq policies (typically 
> used
>     for system with homogeneous cores/clusters that have the same OPPs.
>   - One mapping table per CPU freq policy (typically used for ASMP 
> systems
>     with heterogeneous CPUs with different OPPs)
> 
> OR
> 
> * Scales the device frequency in proportion to the CPU frequency. So, 
> if
>   the CPUs are running at their max frequency, the device runs at its 
> max
>   frequency.  If the CPUs are running at their min frequency, the 
> device
>   runs at its min frequency. And interpolated for frequencies in 
> between.
> 
> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> ---
>  .../bindings/devfreq/devfreq-cpufreq.txt           |  53 ++
>  drivers/devfreq/Kconfig                            |   8 +
>  drivers/devfreq/Makefile                           |   1 +
>  drivers/devfreq/governor_cpufreq.c                 | 583 
> +++++++++++++++++++++
>  4 files changed, 645 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/devfreq/devfreq-cpufreq.txt
>  create mode 100644 drivers/devfreq/governor_cpufreq.c
> 
> diff --git
> a/Documentation/devicetree/bindings/devfreq/devfreq-cpufreq.txt
> b/Documentation/devicetree/bindings/devfreq/devfreq-cpufreq.txt
> new file mode 100644
> index 0000000..6537538

MyungJoo, Chanwoo,

Thoughts? Good enough to merge?

Rob,

DT review? I know this DT documentation should be a separate patch, but 
I've kept it here for context. I can split it up once the code and the 
binding have been agreed to.

Thanks,
Saravana
