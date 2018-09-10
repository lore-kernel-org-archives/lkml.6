Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A03C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D9A4206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:05:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D9A4206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbeIJP70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 11:59:26 -0400
Received: from foss.arm.com ([217.140.101.70]:55404 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727649AbeIJP70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 11:59:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 695A218A;
        Mon, 10 Sep 2018 04:05:55 -0700 (PDT)
Received: from [10.4.12.120] (e107158-lin.emea.arm.com [10.4.12.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7090C3F575;
        Mon, 10 Sep 2018 04:05:54 -0700 (PDT)
Subject: Re: [RFC PATCH 3/4] sched/topology: remove smt_gain
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
References: <1535548752-4434-1-git-send-email-vincent.guittot@linaro.org>
 <1535548752-4434-4-git-send-email-vincent.guittot@linaro.org>
 <20180904082424.GA2090@linux.vnet.ibm.com>
 <20180904093626.GA23936@linaro.org>
 <20180904103742.GC61288@linux.vnet.ibm.com>
From:   Qais Yousef <qais.yousef@arm.com>
Message-ID: <1370aa29-2b86-a199-05b9-a1995d65f966@arm.com>
Date:   Mon, 10 Sep 2018 12:05:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180904103742.GC61288@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09/18 11:37, Srikar Dronamraju wrote:
> * Vincent Guittot <vincent.guittot@linaro.org> [2018-09-04 11:36:26]:
>
>> Hi Srikar,
>>
>> Le Tuesday 04 Sep 2018 à 01:24:24 (-0700), Srikar Dronamraju a écrit :
>>> However after this change, capacity_orig of each SMT thread would be
>>> 1024. For example SMT 8 core capacity_orig would now be 8192.
>>>
>>> smt_gain was suppose to make a multi threaded core was slightly more
>>> powerful than a single threaded core. I suspect if that sometimes hurt
>> Is there system with both single threaded and multi threaded core ?
>> That was the main open point for me (and for Qais too)
>>
> I dont know of any systems that have come with single threaded and
> multithreaded. However some user can still offline few threads in a core
> while leaving other cores untouched. I dont really know why somebody
> would want to do it.  For example, some customer was toying with SMT 3
> mode in a SMT 8 power8 box.

What was the customer trying to achieve by this? Did this end up being 
useful?

If we get mixed SMT 3 and SMT 8 in the system we might have issues, but 
again I don't see how this makes sense from system point of view. I 
don't think power savings will be significant by turning off few 
hardware threads since the core which I'd expect to be the main energy 
consumer is still on. From performance perspective, SMT 3 might have 
less contention (hence better 'performance'), but we don't do anything 
special to decide to schedule work in this case to take advantage of 
that. So I don't think the setup is useful to cater for or encourage.

-- 
Qais Yousef

