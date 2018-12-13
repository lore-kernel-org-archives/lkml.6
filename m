Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88326C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5417120851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:56:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5417120851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbeLMC4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 21:56:40 -0500
Received: from ozlabs.org ([203.11.71.1]:53873 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbeLMC4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 21:56:40 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43FdcP2yW8z9s7h;
        Thu, 13 Dec 2018 13:56:37 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     mwb@linux.vnet.ibm.com,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        tlfalcon@linux.vnet.ibm.com, minkim@us.ibm.com,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v03] powerpc/mobility: Fix node detach/rename problem
In-Reply-To: <CAL_Jsq+t--486MiSsHnKcVy=q2wVvJgUmtAV6Vy2WwSNKymELA@mail.gmail.com>
References: <a2d46622-a957-dffe-04d1-8087bbf0f8b5@linux.vnet.ibm.com> <871s6oxkdf.fsf@concordia.ellerman.id.au> <CAL_Jsq+t--486MiSsHnKcVy=q2wVvJgUmtAV6Vy2WwSNKymELA@mail.gmail.com>
Date:   Thu, 13 Dec 2018 13:56:38 +1100
Message-ID: <87a7law2vt.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh+dt@kernel.org> writes:
> On Tue, Dec 11, 2018 at 7:29 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
...
>> diff --git a/drivers/of/base.c b/drivers/of/base.c
>> index 09692c9b32a7..d8e4534c0686 100644
>> --- a/drivers/of/base.c
>> +++ b/drivers/of/base.c
>> @@ -1190,6 +1190,10 @@ struct device_node *of_find_node_by_phandle(phandle handle)
>>                 if (phandle_cache[masked_handle] &&
>>                     handle == phandle_cache[masked_handle]->phandle)
>>                         np = phandle_cache[masked_handle];
>> +
>> +               /* If we find a detached node, remove it */
>> +               if (of_node_check_flag(np, OF_DETACHED))
>> +                       np = phandle_cache[masked_handle] = NULL;
>
> I'm wondering if we should explicitly remove the node from the cache
> when we set OF_DETACHED. Otherwise, it could be possible that the node
> pointer has been freed already.

Yeah good point.

> Or maybe we need both?

That's probably best, it could even be a WARN_ON() if we find one in
of_find_node_by_phandle().

cheers
