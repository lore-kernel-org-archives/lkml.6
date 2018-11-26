Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8046C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DA6820865
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="inAY0JYK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DA6820865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbeK0CA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 21:00:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:54718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbeK0CA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 21:00:27 -0500
Received: from localhost (unknown [178.228.8.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E55920664;
        Mon, 26 Nov 2018 15:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543244764;
        bh=X3bA0wZjpwBpMR0m5mfvynB5HNC9RqXba/mi2qz5zYM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=inAY0JYKl31Pt7K117H9l2dOB/0yoM2ha8ULi8EIkrI6JZkoZfxg9BV3b90cS/e+l
         nisCvKByamXOV+zNFkJ/ECOEUDgHKLhFSGqqRm9BMCS/+EXmDrFk7SjpQg5Vox2IKK
         QXdLb/HGHeKKCVzpPhzGh2iZAAqZ0vaAFYLE6IRg=
Date:   Mon, 26 Nov 2018 16:06:01 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        viresh.kumar@linaro.org, Chris Redpath <chris.redpath@linaro.org>,
        Quentin Perret <quentin.perret@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Li Yang <leoyang.li@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH V4 2/2] base/drivers/arch_topology: Default dmips-mhz if
 they are not set in DT
Message-ID: <20181126150601.GD4637@kroah.com>
References: <1543234847-21611-1-git-send-email-daniel.lezcano@linaro.org>
 <1543234847-21611-2-git-send-email-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543234847-21611-2-git-send-email-daniel.lezcano@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 01:20:43PM +0100, Daniel Lezcano wrote:
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -243,9 +243,20 @@ static int __init register_cpufreq_notifier(void)
>  	 * until we have the necessary code to parse the cpu capacity, so
>  	 * skip registering cpufreq notifier.
>  	 */
> -	if (!acpi_disabled || !raw_capacity)
> +	if (!acpi_disabled)
>  		return -EINVAL;
>  
> +	if (!raw_capacity) {
> +
> +		pr_info("cpu_capacity: No capacity defined in DT, set default "
> +		       "values to %ld\n", SCHED_CAPACITY_SCALE);

Why the extra blank line?

And what is userspace going to do with this noise?  Is this an error?
Just normal operation?  A device should never be saying anything to the
log for normal boot functionality.  When is this called?

And no need for the "cpu_capacity:" right?  Shouldn't the pr_info() line
handle the prefix for you?

thanks,

greg k-h
