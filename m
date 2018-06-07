Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id J44qBLQRGVuPKQAAmS7hNA
	; Thu, 07 Jun 2018 11:07:21 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 048A0608C1; Thu,  7 Jun 2018 11:07:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8B041606DD;
	Thu,  7 Jun 2018 11:07:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8B041606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753552AbeFGLHS (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 07:07:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:36848 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753088AbeFGLHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 07:07:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7F4BBACA5;
        Thu,  7 Jun 2018 11:07:15 +0000 (UTC)
Date: Thu, 7 Jun 2018 13:07:13 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Jakub Racek <jracek@redhat.com>
Cc: linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Mel Gorman <mgorman@suse.de>, linux-mm@kvack.org
Subject: Re: [4.17 regression] Performance drop on kernel-4.17 visible on
 Stream, Linpack and NAS parallel benchmarks
Message-ID: <20180607110713.GJ32433@dhcp22.suse.cz>
References: <20180606122731.GB27707@jra-laptop.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180606122731.GB27707@jra-laptop.brq.redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[CCing Mel and MM mailing list]

On Wed 06-06-18 14:27:32, Jakub Racek wrote:
> Hi,
> 
> There is a huge performance regression on the 2 and 4 NUMA node systems on
> stream benchmark with 4.17 kernel compared to 4.16 kernel. Stream, Linpack
> and NAS parallel benchmarks show upto 50% performance drop.
> 
> When running for example 20 stream processes in parallel, we see the following behavior:
> 
> * all processes are started at NODE #1
> * memory is also allocated on NODE #1
> * roughly half of the processes are moved to the NODE #0 very quickly. *
> however, memory is not moved to NODE #0 and stays allocated on NODE #1
> 
> As the result, half of the processes are running on NODE#0 with memory being
> still allocated on NODE#1. This leads to non-local memory accesses
> on the high Remote-To-Local Memory Access Ratio on the numatop charts.
> 
> So it seems that 4.17 is not doing a good job to move the memory to the right NUMA
> node after the process has been moved.
> 
> ----8<----
> 
> The above is an excerpt from performance testing on 4.16 and 4.17 kernels.
> 
> For now I'm merely making sure the problem is reported.

Do you have numa balancing enabled?
-- 
Michal Hocko
SUSE Labs
