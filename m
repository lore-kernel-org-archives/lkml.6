Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A72C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4311255D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:01:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4311255D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933912AbeGBKBy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 06:01:54 -0400
Received: from foss.arm.com ([217.140.101.70]:56438 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753269AbeGBKBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 06:01:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF52A18A;
        Mon,  2 Jul 2018 03:01:52 -0700 (PDT)
Received: from [10.1.210.28] (e107155-lin.cambridge.arm.com [10.1.210.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B712E3F5BA;
        Mon,  2 Jul 2018 03:01:50 -0700 (PDT)
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jeremy Linton <jeremy.linton@arm.com>,
        shunyong.yang@hxt-semitech.com, yu.zheng@hxt-semitech.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI/PPTT: use ACPI ID whenever
 ACPI_PPTT_ACPI_PROCESSOR_ID_VALID is set
To:     Andrew Jones <drjones@redhat.com>
References: <1530289077-2444-1-git-send-email-sudeep.holla@arm.com>
 <20180630071620.gszzib7oha3jn3j2@hawk.localdomain>
From:   Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <a6c51606-05a5-84ce-8e6b-c66c7f2c77f2@arm.com>
Date:   Mon, 2 Jul 2018 11:01:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180630071620.gszzib7oha3jn3j2@hawk.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/06/18 08:16, Andrew Jones wrote:
> On Fri, Jun 29, 2018 at 05:17:57PM +0100, Sudeep Holla wrote:
>> Currently we use the ACPI processor ID only for the leaf/processor nodes
>> as the specification states it must match the value of ACPI processor ID
>> field in the processor’s entry in the MADT.
>>
>> However, if a PPTT structure represents processors group, it match a
>> processor container UID in the namespace and ACPI_PPTT_ACPI_PROCESSOR_ID_VALID
>> flag describe whether the ACPI processor ID is valid.
>>
>> Lets use UID whenever ACPI_PPTT_ACPI_PROCESSOR_ID_VALID is set to be
>> consistent instead of using table offset as it's currently done for non
>> leaf nodes.
>>
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>  drivers/acpi/pptt.c | 10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> Hi,
>>
>> There's ongoing discussion on assigning ID based in OS using simple
>> counters. It can never be consistent with firmware's view. So if the
>> firmware provides valid UID for non-processors node, we must use it.
> 
> I agree with this. I've been so focused on the fact that the ACPI offsets
> are arbitrary, and thus counters can't be worse, that I nearly forgot how
> these IDs are actually defined:
> 

Yes, it's platform dependent and I now realize that I never explicitly
mentioned that, let alone emphasize on that. I was for UID for the same
reason.

[...]

> 
> When the valid flag is set we'll now return a [hopefully] correct platform
> dependent ID, but when it's not we'll return an ACPI table offset. How
> will users of the ID know? Also, it's possible to return -ENOENT for the
> ID when calling find_acpi_cpu_topology(). How can we distinguish that from
> an arbitrary platform dependent ID?
> 

But why should one need to distinguish that ? Even offset is kind of
sparsely distributed UID.
-- 
Regards,
Sudeep
