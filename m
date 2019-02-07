Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D03C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D9AF20844
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfBGJZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 04:25:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44484 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727037AbfBGJZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 04:25:12 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7D16B88E64;
        Thu,  7 Feb 2019 09:25:12 +0000 (UTC)
Received: from [10.40.204.71] (ovpn-204-71.brq.redhat.com [10.40.204.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ED8F61048125;
        Thu,  7 Feb 2019 09:25:10 +0000 (UTC)
Subject: Re: [PATCH v2] powerpc/mm: move a KERN_WARNING message to pr_debug()
To:     David Gibson <david@gibson.dropbear.id.au>
Cc:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@c-s.fr>
References: <20190205202133.5048-1-lvivier@redhat.com>
 <20190207030305.GA518@umbus.fritz.box>
From:   Laurent Vivier <lvivier@redhat.com>
Message-ID: <632657bb-acd7-54bd-ac02-0d6f9d87d26b@redhat.com>
Date:   Thu, 7 Feb 2019 10:25:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190207030305.GA518@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 07 Feb 2019 09:25:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2019 04:03, David Gibson wrote:
> On Tue, Feb 05, 2019 at 09:21:33PM +0100, Laurent Vivier wrote:
>> resize_hpt_for_hotplug() reports a warning when it cannot
>> increase the hash page table ("Unable to resize hash page
>> table to target order") but this is not blocking and
>> can make user thinks something has not worked properly.
>> As we move the message to the debug area, report again the
>> ENODEV error.
>>
>> If the operation cannot be done the real error message
>> will be reported by arch_add_memory() if create_section_mapping()
>> fails.
>>
>> Fixes: 7339390d772dd
>>        powerpc/pseries: Don't give a warning when HPT resizing isn't available
>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> 
> Sorry, I'm pretty dubious about this.  It's true that in the case for
> which this bug was filed this is a harmless situation which deserves a
> pr_debug() at most.
> 
> But that's not necessarily true in all paths leading to this message.
> It will also trip if we fail to reshrink the HPT after genuinely
> hotunplugging a bunch of memory, in which case failing to release
> expected resources does deserve a warning.

But if there is a real problem this function should return an error and
this error should be managed by the caller.

Moreover, the function that can fail (pseries_lpar_resize_hpt()) has
already a warning for each error case:

ETIMEDOUT: "Unexpected error %d cancelling timed out HPT resize\n"
EIO:       "Unexpected error %d from H_RESIZE_HPT_PREPARE\n"
           "Unexpected error %d from H_RESIZE_HPT_COMMIT\n
ENOSPC:    "Hash collision while resizing HPT\n"

ENODEV has no error message but is already silently ignored.
EINVAL and EPERM have no message but this happens if hcall is not used
correctly and deserve only a pr_debug() I think.

Thanks,
Laurent
