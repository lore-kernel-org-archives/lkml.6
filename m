Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83133ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 11:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46C09205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 11:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="VyndSkYU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46C09205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbeJSTp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 15:45:56 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:36138 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbeJSTpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 15:45:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1539949213; x=1571485213;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=xkqo3xOkUHi5c+96JlZ6DBBUnio1mGFzS0Gdk+TPLKQ=;
  b=VyndSkYU/GmxGC4mbI0g5TFwCtkqgxseDGxnwIMMvYFnX8Xi5R+kLxqg
   za5mySvnvabhS++or4XKmzQAuM0WMG0ocPHaRIhiPFvgwpCdEAVZoHWvT
   igo4137sCbB32/lkrS+OgzY44blreOzrtNANpxljavWxGHesVc1to/Vve
   Q=;
X-IronPort-AV: E=Sophos;i="5.54,399,1534809600"; 
   d="scan'208";a="764999898"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 19 Oct 2018 11:40:10 +0000
Received: from u7588a65da6b65f.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w9JBe6I2074201
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 19 Oct 2018 11:40:08 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id w9JBe3me001875;
        Fri, 19 Oct 2018 13:40:04 +0200
Subject: Re: [RFC 00/60] Coscheduling for Linux
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Rik van Riel <riel@surriel.com>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>
References: <20180907214047.26914-1-jschoenh@amazon.de>
 <20181017020933.GC24723@lerouge>
From:   =?UTF-8?Q?Jan_H=2e_Sch=c3=b6nherr?= <jschoenh@amazon.de>
Openpgp: preference=signencrypt
Message-ID: <a177875f-2072-ab55-b079-f2142d9b776e@amazon.de>
Date:   Fri, 19 Oct 2018 13:40:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181017020933.GC24723@lerouge>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/10/2018 04.09, Frederic Weisbecker wrote:
> On Fri, Sep 07, 2018 at 11:39:47PM +0200, Jan H. Schönherr wrote:
>> C) How does it work?
>> --------------------
[...]
>> For each task-group, the user can select at which level it should be
>> scheduled. If you set "cpu.scheduled" to "1", coscheduling will typically
>> happen at core-level on systems with SMT. That is, if one SMT sibling
>> executes a task from this task group, the other sibling will do so, too. If
>> no task is available, the SMT sibling will be idle. With "cpu.scheduled"
>> set to "2" this is extended to the next level, which is typically a whole
>> socket on many systems. And so on.  If you feel, that this does not provide
>> enough flexibility, you can specify "cosched_split_domains" on the kernel
>> command line to create more fine-grained scheduling domains for your
>> system.
> 
> Have you considered using cpuset to specify the set of CPUs inside which
> you want to coschedule task groups in? Perhaps that would be more flexible
> and intuitive to control than this cpu.scheduled value.

Yes, I did consider cpusets. Though, there are two dimensions to it:
a) at what fraction of the system tasks shall be coscheduled, and
b) where these tasks shall execute within the system.

cpusets would be the obvious answer to the "where". However, in the current
form they are too inflexible with too much overhead. Suppose, you want to
coschedule two tasks on SMT siblings of a core. You would be able to
restrict the tasks to a specific core with a cpuset. But then, it is bound
to that core, and the load balancer cannot move the group of two tasks to a
different core.

Now, it would be possible to "invent" relocatable cpusets to address that
issue ("I want affinity restricted to a core, I don't care which"), but
then, the current way how cpuset affinity is enforced doesn't scale for
making use of it from within the balancer. (The upcoming load balancing
portion of the coscheduler currently uses a file similar to cpu.scheduled
to restrict affinity to a load-balancer-controlled subset of the system.)


Using cpusets as the mean to describe which parts of the system are to be
coscheduled *may* be possible. But if so, it's a long way out. The current
implementation uses scheduling domains for this, because (a) most
coscheduling use cases require an alignment to the topology, and (b) it
integrates really nicely with the load balancer.

AFAIK, there is already some interaction between cpusets and scheduling
domains. But it is supposed to be rather static and as soon as you have
overlapping cpusets, you end up with the default scheduling domains.
If we were able to make the scheduling domains more dynamic than they are
today, we might be able to couple that to cpusets (or some similar
interface to *define* scheduling domains).

Regards
Jan

