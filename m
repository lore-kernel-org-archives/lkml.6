Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017D0C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2E7A2146D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="KyYN+OZL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2E7A2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbeIMAkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 20:40:23 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:52505 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728188AbeIMAkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 20:40:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536780862; x=1568316862;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=RN9ouUxYZUXD06iQAIag/DTyVak9c5Sr8d62op1mXOM=;
  b=KyYN+OZLJ3i1aukD6j1T6Vag+7shftK579cSiX6C7h0eyv8iiO9qfi0E
   zNiPIWrGynqPC80TcUDR827nYBWR3riSZ6wTtZvpa7dW70AQh41JzjkGK
   hKl/eage591J72+ZxsW8h3UTtNlxXiNpd2DXAXcyedfVrin+nZvBn8GJY
   U=;
X-IronPort-AV: E=Sophos;i="5.53,365,1531785600"; 
   d="scan'208";a="697368888"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1a-af6a10df.us-east-1.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 12 Sep 2018 19:34:21 +0000
Received: from u7588a65da6b65f.ant.amazon.com (iad7-ws-svc-lb50-vlan3.amazon.com [10.0.93.214])
        by email-inbound-relay-1a-af6a10df.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w8CJYGnl070387
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Wed, 12 Sep 2018 19:34:19 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id w8CJYEio026896;
        Wed, 12 Sep 2018 21:34:15 +0200
Subject: Re: [RFC 00/60] Coscheduling for Linux
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
References: <20180907214047.26914-1-jschoenh@amazon.de>
 <20180912002449.GA21797@breakout>
From:   "=?UTF-8?Q?Jan_H._Sch=c3=b6nherr?=" <jschoenh@amazon.de>
Openpgp: preference=signencrypt
Message-ID: <c41f4e4f-30a1-5a3c-dec6-dc8f1d181c94@amazon.de>
Date:   Wed, 12 Sep 2018 21:34:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180912002449.GA21797@breakout>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2018 02:24 AM, Nishanth Aravamudan wrote:
> [ I am not subscribed to LKML, please keep me CC'd on replies ]
> 
> I tried a simple test with several VMs (in my initial test, I have 48
> idle 1-cpu 512-mb VMs and 2 idle 2-cpu, 2-gb VMs) using libvirt, none
> pinned to any CPUs. When I tried to set all of the top-level libvirt cpu
> cgroups' to be co-scheduled (/bin/echo 1 >
> /sys/fs/cgroup/cpu/machine/<VM-x>.libvirt-qemu/cpu.scheduled), the
> machine hangs. This is using cosched_max_level=1.
> 
> There are several moving parts there, so I tried narrowing it down, by
> only coscheduling one VM, and thing seemed fine:
> 
> /sys/fs/cgroup/cpu/machine/<VM-1>.libvirt-qemu# echo 1 > cpu.scheduled 
> /sys/fs/cgroup/cpu/machine/<VM-1>.libvirt-qemu# cat cpu.scheduled 
> 1
> 
> One thing that is not entirely obvious to me (but might be completely
> intentional) is that since by default the top-level libvirt cpu cgroups
> are empty:
> 
> /sys/fs/cgroup/cpu/machine/<VM-1>.libvirt-qemu# cat tasks 
> 
> the result of this should be a no-op, right? [This becomes relevant
> below] Specifically, all of the threads of qemu are in sub-cgroups,
> which do not indicate they are co-scheduling:
> 
> /sys/fs/cgroup/cpu/machine/<VM-1>.libvirt-qemu# cat emulator/cpu.scheduled 
> 0
> /sys/fs/cgroup/cpu/machine/<VM-1>.libvirt-qemu# cat vcpu0/cpu.scheduled 
> 0
> 

This setup *should* work. It should be possible to set cpu.scheduled
independent of the cpu.scheduled values of parent and child task groups.
Any intermediate regular task group (i.e. cpu.scheduled==0) will still
contribute the group fairness aspects.

That said, I see a hang, too. It seems to happen, when there is a
cpu.scheduled!=0 group that is not a direct child of the root task group.
You seem to have "/sys/fs/cgroup/cpu/machine" as an intermediate group.
(The case ==0 within !=0 within the root task group works for me.)

I'm going to dive into the code.

[...]
> I am happy to do any further debugging I can do, or try patches on top
> of those posted on the mailing list.

If you're willing, you can try to get rid of the intermediate "machine"
cgroup in your setup for the moment. This might tell us, whether we're
looking at the same issue.

Thanks,
Jan
