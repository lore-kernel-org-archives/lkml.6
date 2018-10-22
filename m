Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E636AC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 18:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5362205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 18:01:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5362205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbeJWCVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 22:21:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37572 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727463AbeJWCVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 22:21:22 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B3308CA1DA;
        Mon, 22 Oct 2018 18:01:49 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-8.bos.redhat.com [10.18.17.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1AB2C194AA;
        Mon, 22 Oct 2018 18:01:48 +0000 (UTC)
Subject: Re: [PATCH v1 2/2] x86/hyperv: make HvNotifyLongSpinWait hypercall
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Juergen Gross <jgross@suse.com>, Yi Sun <yi.y.sun@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        chao.p.peng@intel.com, chao.gao@intel.com,
        isaku.yamahata@intel.com, michael.h.kelley@microsoft.com,
        tianyu.lan@microsoft.com, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
References: <1539954835-34035-1-git-send-email-yi.y.sun@linux.intel.com>
 <1539954835-34035-3-git-send-email-yi.y.sun@linux.intel.com>
 <bab010e9-a122-95f1-d8cc-790e56c72716@suse.com>
 <20181022015342.GK11769@yi.y.sun>
 <2e0d62cb-b706-a5b4-65f7-982a913fb32b@suse.com>
 <ba75b994-c1a6-6e91-6499-b9af90636fcf@redhat.com>
 <20181022171516.GH3117@worktop.programming.kicks-ass.net>
 <6d8095c0-af95-5967-3ca5-2ceeb74233ea@redhat.com>
 <20181022173144.GB3109@worktop.c.hoisthospitality.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <0f36b234-fa4e-d52f-735c-078ddeab6720@redhat.com>
Date:   Mon, 22 Oct 2018 14:01:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20181022173144.GB3109@worktop.c.hoisthospitality.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 22 Oct 2018 18:01:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/2018 01:31 PM, Peter Zijlstra wrote:
> On Mon, Oct 22, 2018 at 01:27:27PM -0400, Waiman Long wrote:
>
>>>> I agree with Juergen on that. I would suggest rename the
>>>> vcpu_is_preempted hook into a more generic vcpu_stop_spinning, perhaps,
>>>> so different hypervisors can act on the information accordingly. Adding
>>>> an extra parameter is fine.
>>> No; no extra parameters. vcpu_is_preempted() is a simple and intuitive
>>> interface. Why would we want to make it complicated?
>> Hyperv seems to do it in a somewhat different way by looking at the spin
>> counter and decide if it should continue. I don't know why they do that
>> and what advantage it has.
>>
>> The current patch is definitely not OK. A revised patch that makes use
>> of an existing paravirt hook will be more acceptable. Again, I would
>> like to see some performance figure and why they do it this way to see
>> if it is worthwhile to change the existing interface.
> Note that there are vcpu_is_preempted() users that are not in a
> spin-loop.

You are right. I forgot about that. In that case, someone has to prove
that using an alternative way to stop spinning really has a performance
advantage compared to what we already have today.

Cheers,
Longman

