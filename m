Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865B8C43143
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 02:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B8C720854
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 02:02:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B8C720854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbeIKG7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 02:59:14 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:58820 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbeIKG7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 02:59:13 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 261A4C0894;
        Tue, 11 Sep 2018 02:02:21 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo01-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id M7CMylfw2hou; Tue, 11 Sep 2018 02:02:21 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 972A1C067C;
        Tue, 11 Sep 2018 02:02:06 +0000 (UTC)
Subject: Re: [PATCH] arm64: add NUMA emulation support
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Will Deacon <will.deacon@arm.com>, catalin.marinas@arm.com,
        sudeep.holla@arm.com, ganapatrao.kulkarni@cavium.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
References: <20180824230559.32336-1-shuah@kernel.org>
 <20180828174011.GE20375@arm.com>
 <a58ad11f-3c22-ed7f-a0cd-938aabc4adaf@kernel.org>
 <20180829110802.GD10349@dhcp22.suse.cz>
 <f041ba95-03e6-4a7d-c324-870b45a2f648@kernel.org>
 <20180905064252.GW14951@dhcp22.suse.cz>
 <c1b58f13-6190-20e9-7e4f-b8bc2b9d5f80@kernel.org>
 <20180907083452.GC19621@dhcp22.suse.cz>
 <e46e715c-f115-f054-eeb2-3cecbcd1192d@kernel.org>
 <20180910134845.GH10951@dhcp22.suse.cz>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <4d7beb50-f778-507a-4c3c-f6de92f8cfb9@kernel.org>
Date:   Mon, 10 Sep 2018 20:02:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180910134845.GH10951@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On 09/10/2018 07:48 AM, Michal Hocko wrote:
> On Fri 07-09-18 16:30:59, Shuah Khan wrote:
>> On 09/07/2018 02:34 AM, Michal Hocko wrote:
>>> On Thu 06-09-18 15:53:34, Shuah Khan wrote:
[....]
>>
>> In addition to isolation, being able to reserve a block instead is one of the
>> issues I am looking to address. Unfortunately memory cgroups won't address that
>> issue.
> 
> Could you be more specific why you need reservations other than
> isolation.
> 

Taking automotive as a specific example, there are two classes of applications:
1. critical applications that must run
2. Infotainment and misc. user-space.

In this case, being able to reserve a block of memory for critical applications
will ensure the memory is available for them. If a critical application has to
restart and/or when an on-demand critical application starts, it might not be able
to allocate memory if it is not reserved.

When a flat system has multiple memory blocks, with NUMA emulation in conjunction with
cpusets, one or more block can be reserved for critical applications configuring a set
of cpus and one of more memory nodes for them.

Memory cgroups will not support such reservation. Hope this helps explain the use-case
I am trying to address with this patch.

thanks,
-- Shuah
