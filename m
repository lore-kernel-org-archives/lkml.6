Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C34C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 08:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 380A32173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 08:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfBZIki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 03:40:38 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:37794 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfBZIki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 03:40:38 -0500
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id C57BF184A3;
        Tue, 26 Feb 2019 09:40:35 +0100 (CET)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id YPknBDMvn3gz; Tue, 26 Feb 2019 09:40:35 +0100 (CET)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
        by bastet.se.axis.com (Postfix) with ESMTPS id F2B6518470;
        Tue, 26 Feb 2019 09:40:34 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C60061A07C;
        Tue, 26 Feb 2019 09:40:34 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BAD2E1A07B;
        Tue, 26 Feb 2019 09:40:34 +0100 (CET)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
        by boulder02.se.axis.com (Postfix) with ESMTP;
        Tue, 26 Feb 2019 09:40:34 +0100 (CET)
Received: from XBOX04.axis.com (xbox04.axis.com [10.0.5.18])
        by thoth.se.axis.com (Postfix) with ESMTP id AE73722F;
        Tue, 26 Feb 2019 09:40:34 +0100 (CET)
Received: from [10.88.41.2] (10.0.5.60) by XBOX04.axis.com (10.0.5.18) with
 Microsoft SMTP Server (TLS) id 15.0.1365.1; Tue, 26 Feb 2019 09:40:34 +0100
Subject: Re: [PATCH] mm: migrate: add missing flush_dcache_page for non-mapped
 page migrate
To:     Vlastimil Babka <vbabka@suse.cz>, Lars Persson <larper@axis.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     <linux-mips@vger.kernel.org>
References: <20190219123212.29838-1-larper@axis.com>
 <65ed6463-b61f-81ff-4fcc-27f4071a28da@suse.cz>
From:   Lars Persson <lars.persson@axis.com>
Message-ID: <ed4dd065-5e1b-dc20-2778-6d0a727914a8@axis.com>
Date:   Tue, 26 Feb 2019 09:40:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <65ed6463-b61f-81ff-4fcc-27f4071a28da@suse.cz>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: sv
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: XBOX03.axis.com (10.0.5.17) To XBOX04.axis.com (10.0.5.18)
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/25/19 4:07 PM, Vlastimil Babka wrote:
> On 2/19/19 1:32 PM, Lars Persson wrote:
>> Our MIPS 1004Kc SoCs were seeing random userspace crashes with SIGILL
>> and SIGSEGV that could not be traced back to a userspace code
>> bug. They had all the magic signs of an I/D cache coherency issue.
>>
>> Now recently we noticed that the /proc/sys/vm/compact_memory interface
>> was quite efficient at provoking this class of userspace crashes.
>>
>> Studying the code in mm/migrate.c there is a distinction made between
>> migrating a page that is mapped at the instant of migration and one
>> that is not mapped. Our problem turned out to be the non-mapped pages.
>>
>> For the non-mapped page the code performs a copy of the page content
>> and all relevant meta-data of the page without doing the required
>> D-cache maintenance. This leaves dirty data in the D-cache of the CPU
>> and on the 1004K cores this data is not visible to the I-cache. A
>> subsequent page-fault that triggers a mapping of the page will happily
>> serve the process with potentially stale code.
>>
>> What about ARM then, this bug should have seen greater exposure? Well
>> ARM became immune to this flaw back in 2010, see commit c01778001a4f
>> ("ARM: 6379/1: Assume new page cache pages have dirty D-cache").
>>
>> My proposed fix moves the D-cache maintenance inside move_to_new_page
>> to make it common for both cases.
>>
>> Signed-off-by: Lars Persson <larper@axis.com>
> 
> What about CC stable and a Fixes tag, would it be applicable here?
> 

Yes this is candidate for stable so let's add:
Cc: <stable@vger.kernel.org>

I do not find a good candidate for a Fixes tag.
