Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA36C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B20921480
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="bJDryoPG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B20921480
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbeIZQKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 12:10:36 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:15134 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbeIZQKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 12:10:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1537955905; x=1569491905;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=bhiJG3m7iOEZXjhoifQ33rYgufD8sBS5BtmoLb7wrqU=;
  b=bJDryoPG8fk/kWhIm9xEudsYZp48ahDoo62QgVii69uWLsBtNZEOrOKj
   ouncCj0Q/VGrz/1u7vn7SZ79caVsH+KeFgRKuae6VhEnp7MOjxaZdpIs6
   gbBtsxZFh/dTQbWXLKw04AS2Rw7qPGy/oYKLIjWAWbjjpzcr/q8EiB6Cv
   M=;
X-IronPort-AV: E=Sophos;i="5.54,305,1534809600"; 
   d="scan'208";a="632755737"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2b-2eab95aa.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 26 Sep 2018 09:58:24 +0000
Received: from u7588a65da6b65f.ant.amazon.com (pdx2-ws-svc-lb17-vlan2.amazon.com [10.247.140.66])
        by email-inbound-relay-2b-2eab95aa.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w8Q9wKg7106741
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Wed, 26 Sep 2018 09:58:23 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id w8Q9wJd2024160;
        Wed, 26 Sep 2018 11:58:19 +0200
Subject: Re: [RFC 00/60] Coscheduling for Linux
To:     Peter Zijlstra <peterz@infradead.org>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Paul Turner <pjt@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
References: <20180907214047.26914-1-jschoenh@amazon.de>
 <20180914111251.GC24106@hirez.programming.kicks-ass.net>
 <1d86f497-9fef-0b19-50d6-d46ef1c0bffa@amazon.de>
 <20180917122538.GT24124@hirez.programming.kicks-ass.net>
From:   "=?UTF-8?Q?Jan_H._Sch=c3=b6nherr?=" <jschoenh@amazon.de>
Openpgp: preference=signencrypt
Message-ID: <648176de-9ad4-a4b3-c542-bbaf250cd8cb@amazon.de>
Date:   Wed, 26 Sep 2018 11:58:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180917122538.GT24124@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/17/2018 02:25 PM, Peter Zijlstra wrote:
> On Fri, Sep 14, 2018 at 06:25:44PM +0200, Jan H. Schönherr wrote:
> 
>> Assuming, there is a cgroup-less solution that can prevent simultaneous
>> execution of tasks on a core, when they're not supposed to. How would you
>> tell the scheduler, which tasks these are?
> 
> Specifically for L1TF I hooked into/extended KVM's preempt_notifier
> registration interface, which tells us which tasks are VCPUs and to
> which VM they belong.
> 
> But if we want to actually expose this to userspace, we can either do a
> prctl() or extend struct sched_attr.

Both, Peter and Subhra, seem to prefer an interface different than cgroups
to specify what to coschedule.

Can you provide some extra motivation for me, why you feel that way?
(ignoring the current scalability issues with the cpu group controller)


After all, cgroups where designed to create arbitrary groups of tasks and
to attach functionality to those groups.

If we were to introduce a different interface to control that, we'd need to
introduce a whole new group concept, so that you make tasks part of some
group while at the same time preventing unauthorized tasks from joining a
group.


I currently don't see any wins, just a loss in flexibility.

Regards
Jan
