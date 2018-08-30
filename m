Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D185FC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97F8020658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:34:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97F8020658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbeH3Uhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 16:37:31 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45620 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbeH3Uhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 16:37:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B091ED1;
        Thu, 30 Aug 2018 09:34:34 -0700 (PDT)
Received: from [10.4.12.81] (melchizedek.emea.arm.com [10.4.12.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C90303F557;
        Thu, 30 Aug 2018 09:34:31 -0700 (PDT)
Subject: Re: [PATCH] EDAC, ghes: use CPER module handles to locate DIMMs
To:     Borislav Petkov <bp@alien8.de>, Fan Wu <wufan@codeaurora.org>
Cc:     mchehab@kernel.org, baicar.tyler@gmail.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "Kani, Toshi" <toshi.kani@hpe.com>
References: <1535567632-18089-1-git-send-email-wufan@codeaurora.org>
 <20180830104307.GC20005@nazgul.tnic>
From:   James Morse <james.morse@arm.com>
Message-ID: <150ad0e4-e84a-565b-95ac-e7135e98bdc0@arm.com>
Date:   Thu, 30 Aug 2018 17:34:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180830104307.GC20005@nazgul.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 30/08/18 11:43, Borislav Petkov wrote:
> On Wed, Aug 29, 2018 at 06:33:52PM +0000, Fan Wu wrote:
>> The current ghes_edac driver does not update per-dimm error
>> counters when reporting memory errors, because there is no
>> platform-independent way to find DIMMs based on the error
>> information provided by firmware. This patch offers a solution
>> for platforms whose firmwares provide valid module handles
>> (SMBIOS type 17) in error records. In this case ghes_edac will
>> use the module handles to locate DIMMs and thus makes per-dimm
>> error reporting possible.

> If we're going to do this, it needs to be tested on an x86 box which loads
> ghes_edac. Adding Toshi to Cc.

Good point, thanks.


> Otherwise it must remain ARM-specific.

Hmmm, that would be a shame.

This should only be a problem if HPE Servers set CPER_MEM_VALID_MODULE_HANDLE,
but don't actually provide module handles, or if firmware has a different idea
of what they are.

If firmware never sets CPER_MEM_VALID_MODULE_HANDLE, this patch shouldn't change
anything.

(Someone must have an x86 that sets CPER_MEM_VALID_MODULE_HANDLE, otherwise the
code wouldn't be there right?!)


Thanks,

James
