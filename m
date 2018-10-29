Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A33EC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 11:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F13642082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 11:35:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F13642082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729105AbeJ2UXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 16:23:16 -0400
Received: from foss.arm.com ([217.140.101.70]:39148 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726582AbeJ2UXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 16:23:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF9D4165C;
        Mon, 29 Oct 2018 04:24:57 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B0A953F6A8;
        Mon, 29 Oct 2018 04:24:57 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id A9D081AE091C; Mon, 29 Oct 2018 11:25:04 +0000 (GMT)
Date:   Mon, 29 Oct 2018 11:25:04 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     John Garry <john.garry@huawei.com>
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH] arm64/numa: Add more vetting in numa_set_distance()
Message-ID: <20181029112504.GF14127@arm.com>
References: <1540562267-101152-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540562267-101152-1-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Fri, Oct 26, 2018 at 09:57:47PM +0800, John Garry wrote:
> Currently it is acceptable to set the distance between 2 separate nodes to
> LOCAL_DISTANCE.
> 
> Reject this as it is invalid.
> 
> This change avoids a crash reported in [1].
> 
> [1] https://www.spinics.net/lists/arm-kernel/msg683304.html
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> 
> diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
> index 146c04c..6092e3d 100644
> --- a/arch/arm64/mm/numa.c
> +++ b/arch/arm64/mm/numa.c
> @@ -335,7 +335,8 @@ void __init numa_set_distance(int from, int to, int distance)
>  	}
>  
>  	if ((u8)distance != distance ||
> -	    (from == to && distance != LOCAL_DISTANCE)) {
> +	    (from == to && distance != LOCAL_DISTANCE) ||
> +	    (from != to && distance == LOCAL_DISTANCE)) {

The current code here is more-or-less lifted from the x86 implementation
of numa_set_distance(). I think we should either factor out the sanity check
into a core helper or make the core code robust to these funny configurations.

Will
