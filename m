Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DB5C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 10:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC042204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 10:53:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC042204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbeKATz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 15:55:29 -0400
Received: from ozlabs.org ([203.11.71.1]:57969 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726520AbeKATz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 15:55:29 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42m29S65HXz9sSq;
        Thu,  1 Nov 2018 21:53:00 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        Frank Rowand <frowand.list@gmail.com>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: Re: [PATCH 01/21] of: Add cpu node iterator for_each_of_cpu_node()
In-Reply-To: <CABGGisw_bd+bJedZ_T2e-dxmRnXf2N_gGBZj8u+QVGQxj_gc+Q@mail.gmail.com>
References: <20180905193738.19325-1-robh@kernel.org> <20180905193738.19325-2-robh@kernel.org> <874ld3jz6v.fsf@concordia.ellerman.id.au> <871s87jz3g.fsf@concordia.ellerman.id.au> <CABGGisw_bd+bJedZ_T2e-dxmRnXf2N_gGBZj8u+QVGQxj_gc+Q@mail.gmail.com>
Date:   Thu, 01 Nov 2018 21:52:57 +1100
Message-ID: <87tvl1dq7q.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh@kernel.org> writes:
> On Tue, Oct 30, 2018 at 9:20 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>>
>> Michael Ellerman <mpe@ellerman.id.au> writes:
>> > Hi Rob,
>> >
>> > Sorry I missed this when you posted it.
>> >
>> > Rob Herring <robh@kernel.org> writes:
>> >> Iterating thru cpu nodes is a common pattern. Create a common iterator
>> >> which can find child nodes either by node name or device_type == cpu.
>> >> Using the former will allow for eventually dropping device_type
>> >> properties which are deprecated for FDT.
>> >
>> > Device trees we see on powerpc generally don't (never?) use "cpu" as the
>> > node name for CPU nodes. And many of those device trees come from
>> > firmware, so we can't update them.
>> >
>> > So dropping support for device_type is a non-starter from our POV.
>>
>> ps. presumably that's what you meant by deprecated *for FDT*.
>
> Right.
>
>> But anyway just wanted to make sure we are on the same page.
>
> Yes, I was aware at least older powerpc DTs don't use 'cpu' for node names.

Actually newer ones too, see below :)

And there's code out there that expects this, so we can't realistically
change it any time soon :/

  https://github.com/ibm-power-utilities/powerpc-utils/blob/master/src/drmgr/common_cpu.c#L186
  https://github.com/ibm-power-utilities/powerpc-utils/blob/master/src/ppc64_cpu.c#L344

cheers

$ ls -d1 /proc/device-tree/cpus/PowerPC\,POWER9@*
/proc/device-tree/cpus/PowerPC,POWER9@14
/proc/device-tree/cpus/PowerPC,POWER9@1c
/proc/device-tree/cpus/PowerPC,POWER9@34
/proc/device-tree/cpus/PowerPC,POWER9@3c
/proc/device-tree/cpus/PowerPC,POWER9@4
/proc/device-tree/cpus/PowerPC,POWER9@48
/proc/device-tree/cpus/PowerPC,POWER9@54
/proc/device-tree/cpus/PowerPC,POWER9@804
/proc/device-tree/cpus/PowerPC,POWER9@80c
/proc/device-tree/cpus/PowerPC,POWER9@814
/proc/device-tree/cpus/PowerPC,POWER9@81c
/proc/device-tree/cpus/PowerPC,POWER9@834
/proc/device-tree/cpus/PowerPC,POWER9@83c
/proc/device-tree/cpus/PowerPC,POWER9@844
/proc/device-tree/cpus/PowerPC,POWER9@84c
/proc/device-tree/cpus/PowerPC,POWER9@c
