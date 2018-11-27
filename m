Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2ECCC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C9692086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:15:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C9692086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730498AbeK0VNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 16:13:04 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60680 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726405AbeK0VNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 16:13:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6235C3563;
        Tue, 27 Nov 2018 02:15:39 -0800 (PST)
Received: from [10.1.196.73] (unknown [10.1.196.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 07C833F575;
        Tue, 27 Nov 2018 02:15:37 -0800 (PST)
Subject: Re: [PATCH 0/7] ACPI HMAT memory sysfs representation
To:     Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Keith Busch <keith.busch@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20181114224902.12082-1-keith.busch@intel.com>
 <1ed406b2-b85f-8e02-1df0-7c39aa21eca9@arm.com>
 <4ea6e80f-80ba-6992-8aa0-5c2d88996af7@intel.com>
 <b79804b0-32ee-03f9-fa62-a89684d46be6@arm.com>
 <c6abb754-0d82-8739-fe08-24e9402bae75@intel.com>
 <aae34dde-fa70-870a-9b74-fff9e385bfc9@arm.com>
 <f5315662-5c1a-68a3-4d04-21b4b5ca94b1@intel.com>
 <ac942498-8966-6a9b-0e55-c79ae167c679@arm.com>
 <9015e51a-3584-7bb2-cc5e-25b0ec8e5494@intel.com>
 <CAPcyv4jnnnXi9Fqaf-d7AdnKrTMDCWr-e9tAx+G6nphrEPYm=w@mail.gmail.com>
 <b9962dfa-924f-77f7-a40f-407dd20e9082@intel.com>
 <CAPcyv4hVFMvut9+Rq7G41yyKzV072U33YEeHNh160VBr3QW-nw@mail.gmail.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <325d0e69-053a-ae9c-eede-7cdf28b1dbd6@arm.com>
Date:   Tue, 27 Nov 2018 15:45:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAPcyv4hVFMvut9+Rq7G41yyKzV072U33YEeHNh160VBr3QW-nw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/26/2018 11:38 PM, Dan Williams wrote:
> On Mon, Nov 26, 2018 at 8:42 AM Dave Hansen <dave.hansen@intel.com> wrote:
>>
>> On 11/23/18 1:13 PM, Dan Williams wrote:
>>>> A new system call makes total sense to me.  I have the same concern
>>>> about the completeness of what's exposed in sysfs, I just don't see a
>>>> _route_ to completeness with sysfs itself.  Thus, the minimalist
>>>> approach as a first step.
>>> Outside of platform-firmware-id to Linux-numa-node-id what other
>>> userspace API infrastructure does the kernel need to provide? It seems
>>> userspace enumeration of memory attributes is fully enabled once the
>>> firmware-to-Linux identification is established.
>>
>> It would be nice not to have each app need to know about each specific
>> platform's firmware.
> 
> The app wouldn't need to know if it uses a common library. Whether the
> library calls into the kernel or not is an implementation detail. If
> it is information that only the app cares about and the kernel does
> not consume, why have a syscall?

If we just care about platform-firmware-id <--> Linux-numa-node-id mapping
and fetching memory attribute from the platform (and hiding implementation
details in a library) then the following interface should be sufficient.

/sys/devices/system/node/nodeX/platform_id

But as the series proposes (and rightly so) kernel needs to start providing
ABI interfaces for memory attributes instead of hiding them in libraries.
