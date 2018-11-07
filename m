Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EDAC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 23:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77F3A20882
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 23:48:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77F3A20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbeKHJVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 04:21:21 -0500
Received: from ozlabs.org ([203.11.71.1]:37023 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbeKHJVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 04:21:21 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42r35Y1Ttbz9s9G;
        Thu,  8 Nov 2018 10:48:33 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org,
        nfont@linux.vnet.ibm.com,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 07/18] of: dynamic: change type of of_{at,de}tach_node() to void
In-Reply-To: <6bc78502-7587-eb9c-237f-d3f031979d42@gmail.com>
References: <1541431515-25197-1-git-send-email-frowand.list@gmail.com> <1541431515-25197-8-git-send-email-frowand.list@gmail.com> <87tvktqedf.fsf@concordia.ellerman.id.au> <6bc78502-7587-eb9c-237f-d3f031979d42@gmail.com>
Date:   Thu, 08 Nov 2018 10:48:33 +1100
Message-ID: <87h8gsqwj2.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Rowand <frowand.list@gmail.com> writes:
> On 11/7/18 4:08 AM, Michael Ellerman wrote:
>> frowand.list@gmail.com writes:
>> 
>>> From: Frank Rowand <frank.rowand@sony.com>
>>>
>>> of_attach_node() and of_detach_node() always return zero, so
>>> their return value is meaningless.
>> 
>> But should they always return zero?
>> 
>> At least __of_attach_node_sysfs() can fail in several ways.
>
> Sigh.  And of_reconfig_notify() can fail.  And at one point in the
> history the return value of of_reconfig_notify() was returned by
> of_attach_node() if of_reconfig_notify() failed.
>
>> And there's also this in __of_detach_node() which should probably be
>> returning an error:
>> 
>> 	if (WARN_ON(of_node_check_flag(np, OF_DETACHED)))
>>         	return;
>> 
>> 
>> Seems to me we should instead be fixing these to propagate errors,
>> rather than hiding them?
>
> The history of how of_attach_node() stopped propagating errors is
> a bit more complex than I want to dig into at the moment.  So I'll
> drop this patch from the series and add investigating this onto
> my todo list.  I suspect that the result of investigating will be
> that error return values should not be ignored in of_attach_node()
> and of_detach_node(), but should instead be propagated to the
> callers, as you suggest.

Thanks.

cheers
