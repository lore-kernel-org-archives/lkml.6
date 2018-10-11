Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D279AC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A49102098A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:50:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A49102098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731790AbeJKXS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:18:27 -0400
Received: from mga05.intel.com ([192.55.52.43]:8278 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727375AbeJKXS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:18:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2018 08:50:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,368,1534834800"; 
   d="scan'208";a="91162729"
Received: from ahduyck-mobl.amr.corp.intel.com (HELO [10.7.198.157]) ([10.7.198.157])
  by orsmga003.jf.intel.com with ESMTP; 11 Oct 2018 08:50:29 -0700
Subject: Re: [workqueue/driver-core PATCH v2 4/5] driver core: Attach devices
 on CPU local to device node
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     tj@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, len.brown@intel.com,
        rafael@kernel.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, pavel@ucw.cz, zwisler@kernel.org
References: <20181010230435.10609.77825.stgit@localhost.localdomain>
 <20181010230836.10609.73485.stgit@localhost.localdomain>
 <20181011104501.GA30183@kroah.com>
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
Message-ID: <e2c37263-ccbd-f3e1-243d-f5c6867fa251@linux.intel.com>
Date:   Thu, 11 Oct 2018 08:50:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181011104501.GA30183@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/2018 3:45 AM, Greg KH wrote:
> On Wed, Oct 10, 2018 at 04:08:40PM -0700, Alexander Duyck wrote:
>> This change makes it so that we call the asynchronous probe routines on a
>> CPU local to the device node. By doing this we should be able to improve
>> our initialization time significantly as we can avoid having to access the
>> device from a remote node which may introduce higher latency.
> 
> This is nice in theory, but what kind of real numbers does this show?
> There's a lot of added complexity here, and what is the benifit?
> 
> Benchmarks or bootcharts that we can see would be great to have, thanks.
> 
> greg k-h
> 

In the case of persistent memory init the cost for getting the wrong 
node is pretty significant. On my test system with 3TB per node just 
getting the initialization node matched up to the memory node dropped 
initialization time per node from 39 seconds down to about 26 seconds 
per node.

We are already starting to see code like this pop up in subsystems 
anyway. For example the PCI code already has logic similar to what I am 
adding here floating around in it[1]. I'm hoping that by placing this 
change in the core device code we could start consolidating it so we 
don't have all the individual drivers or subsystems implementing their 
own NUMA specific init logic.

This is likely going to become more of an issue in the future as we now 
have CPUs like the AMD Ryzen Threadripper out there that have people 
starting to discuss NUMA in the consumer space.

- Alex

[1] 
https://elixir.bootlin.com/linux/v4.19-rc7/source/drivers/pci/pci-driver.c#L331
