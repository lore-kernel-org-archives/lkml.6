Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2608BC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA9582086B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="dHK1ZXDM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA9582086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729800AbeIRT04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 15:26:56 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:41090 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727846AbeIRT0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 15:26:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1537278852; x=1568814852;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=3PR+VbrDCzNid6wVZkf5NCEEC5jrBB6e77Qbjn32Q4A=;
  b=dHK1ZXDMWaOnYOWATIPosKpAvpL4nxSHGuXsAaGR6hM4TtsEhI7Cr9mm
   7XYfnQGlVAO54cfTPOg6rePkQaW4afi2JSZS0ZSmw2aFvkH9Dj2X2TvOV
   qkyxmMDjrmSIRp0aZzyJ47UI5JFgANHH3TO+xvIsHZl72bYKQ1T5hkfnv
   s=;
X-IronPort-AV: E=Sophos;i="5.53,389,1531785600"; 
   d="scan'208";a="362890027"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-4ff6265a.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 18 Sep 2018 13:54:10 +0000
Received: from u7588a65da6b65f.ant.amazon.com (pdx2-ws-svc-lb17-vlan2.amazon.com [10.247.140.66])
        by email-inbound-relay-2b-4ff6265a.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w8IDs6eE007894
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Tue, 18 Sep 2018 13:54:08 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id w8IDs4Xs006243;
        Tue, 18 Sep 2018 15:54:04 +0200
Subject: Re: Task group cleanups and optimizations (was: Re: [RFC 00/60]
 Coscheduling for Linux)
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Paul Turner <pjt@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Rik van Riel <riel@surriel.com>
References: <20180907214047.26914-1-jschoenh@amazon.de>
 <20180914111251.GC24106@hirez.programming.kicks-ass.net>
 <1d86f497-9fef-0b19-50d6-d46ef1c0bffa@amazon.de>
 <282230fe-b8de-01f9-c19b-6070717ba5f8@amazon.de>
 <20180917094844.GR24124@hirez.programming.kicks-ass.net>
 <08b930d9-7ffe-7df3-ab35-e7b58073e489@amazon.de>
 <20180918133805.GN24106@hirez.programming.kicks-ass.net>
From:   "=?UTF-8?Q?Jan_H._Sch=c3=b6nherr?=" <jschoenh@amazon.de>
Openpgp: preference=signencrypt
Message-ID: <3d49801b-01cd-579b-f731-d6ca7aed985d@amazon.de>
Date:   Tue, 18 Sep 2018 15:54:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180918133805.GN24106@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/18/2018 03:38 PM, Peter Zijlstra wrote:
> On Tue, Sep 18, 2018 at 03:22:13PM +0200, Jan H. Schönherr wrote:
>> AFAIK, changing the affinity of a cpuset overwrites the individual affinities of tasks
>> within them. Thus, it shouldn't be an issue.
> 
> No, it only shrinks the set. Also nothing stops you calling
> sched_setaffinity() once you're inside the cpuset. The only contraint is
> that your mask is a subset of the cpuset mask.

I meant setting the affinity of the cpuset *after* setting an individual affinity.

Like this:

# mkdir /sys/fs/cgroup/cpuset/test
# cat /sys/fs/cgroup/cpuset/cpuset.mems > /sys/fs/cgroup/cpuset/test/cpuset.mems
# cat /sys/fs/cgroup/cpuset/cpuset.cpus > /sys/fs/cgroup/cpuset/test/cpuset.cpus
# echo $$ > /sys/fs/cgroup/cpuset/test/tasks
# taskset -c -p 0 $$
pid 4745's current affinity list: 0-3
pid 4745's new affinity list: 0
# echo "0-1" > /sys/fs/cgroup/cpuset/test/cpuset.cpus
# taskset -c -p $$
pid 4745's current affinity list: 0,1
#

The individual affinity of $$ is lost, despite it being a subset.
