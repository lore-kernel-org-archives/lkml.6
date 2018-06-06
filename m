Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 04F81607B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751968AbeFFM1h (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 08:27:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52582 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751856AbeFFM1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 08:27:34 -0400
Date: Wed, 6 Jun 2018 14:27:32 +0200
From: Jakub Racek <jracek@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        jracek@redhat.com
Subject: [4.17 regression] Performance drop on kernel-4.17 visible on Stream,
 Linpack and NAS parallel benchmarks
Message-ID: <20180606122731.GB27707@jra-laptop.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-OS: Linux jra-laptop 3.10.0-862.el7.x86_64 x86_64
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There is a huge performance regression on the 2 and 4 NUMA node systems on stream 
benchmark with 4.17 kernel compared to 4.16 kernel. 
Stream, Linpack and NAS parallel benchmarks show upto 50% performance drop.

When running for example 20 stream processes in parallel, we see the following behavior:

* all processes are started at NODE #1
* memory is also allocated on NODE #1
* roughly half of the processes are moved to the NODE #0 very quickly. 
* however, memory is not moved to NODE #0 and stays allocated on NODE #1

As the result, half of the processes are running on NODE#0 with memory being still 
allocated on NODE#1. This leads to non-local memory accesses
on the high Remote-To-Local Memory Access Ratio on the numatop charts.  

So it seems that 4.17 is not doing a good job to move the memory to the right NUMA
node after the process has been moved.

----8<----

The above is an excerpt from performance testing on 4.16 and 4.17 kernels.

For now I'm merely making sure the problem is reported.

Thank you.

Best regards,
Jakub Racek
