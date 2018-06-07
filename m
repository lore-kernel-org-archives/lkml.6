Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id /beeF8YUGVufRQAAmS7hNA
	; Thu, 07 Jun 2018 11:19:34 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4C7CA608C1; Thu,  7 Jun 2018 11:19:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id DB2AC6089E;
	Thu,  7 Jun 2018 11:19:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DB2AC6089E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753595AbeFGLTb (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 07:19:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42096 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753325AbeFGLTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 07:19:30 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9E59D35C1;
        Thu,  7 Jun 2018 11:19:29 +0000 (UTC)
Received: from [10.40.204.234] (ovpn-204-234.brq.redhat.com [10.40.204.234])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C182217B409;
        Thu,  7 Jun 2018 11:19:27 +0000 (UTC)
Subject: Re: [4.17 regression] Performance drop on kernel-4.17 visible on
 Stream, Linpack and NAS parallel benchmarks
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Mel Gorman <mgorman@suse.de>, linux-mm@kvack.org
References: <20180606122731.GB27707@jra-laptop.brq.redhat.com>
 <20180607110713.GJ32433@dhcp22.suse.cz>
From: =?UTF-8?Q?Jakub_Ra=c4=8dek?= <jracek@redhat.com>
Message-ID: <cd26794b-cb82-919c-053d-9bcb6e3d78d8@redhat.com>
Date: Thu, 7 Jun 2018 13:19:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180607110713.GJ32433@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 07 Jun 2018 11:19:29 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 07 Jun 2018 11:19:29 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jracek@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06/07/2018 01:07 PM, Michal Hocko wrote:
> [CCing Mel and MM mailing list]
> 
> On Wed 06-06-18 14:27:32, Jakub Racek wrote:
>> Hi,
>>
>> There is a huge performance regression on the 2 and 4 NUMA node systems on
>> stream benchmark with 4.17 kernel compared to 4.16 kernel. Stream, Linpack
>> and NAS parallel benchmarks show upto 50% performance drop.
>>
>> When running for example 20 stream processes in parallel, we see the following behavior:
>>
>> * all processes are started at NODE #1
>> * memory is also allocated on NODE #1
>> * roughly half of the processes are moved to the NODE #0 very quickly. *
>> however, memory is not moved to NODE #0 and stays allocated on NODE #1
>>
>> As the result, half of the processes are running on NODE#0 with memory being
>> still allocated on NODE#1. This leads to non-local memory accesses
>> on the high Remote-To-Local Memory Access Ratio on the numatop charts.
>>
>> So it seems that 4.17 is not doing a good job to move the memory to the right NUMA
>> node after the process has been moved.
>>
>> ----8<----
>>
>> The above is an excerpt from performance testing on 4.16 and 4.17 kernels.
>>
>> For now I'm merely making sure the problem is reported.
> 
> Do you have numa balancing enabled?
> 

Yes. The relevant settings are:

kernel.numa_balancing = 1
kernel.numa_balancing_scan_delay_ms = 1000
kernel.numa_balancing_scan_period_max_ms = 60000
kernel.numa_balancing_scan_period_min_ms = 1000
kernel.numa_balancing_scan_size_mb = 256


-- 
Best regards,
Jakub Racek
FMK
