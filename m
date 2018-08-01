Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 949E3C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50BB0208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:55:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50BB0208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390011AbeHARmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 13:42:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60300 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389557AbeHARmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 13:42:05 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6F82F7DAC7;
        Wed,  1 Aug 2018 15:55:43 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw.lab.eng.bos.redhat.com [10.16.186.145])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 15C651C640;
        Wed,  1 Aug 2018 15:55:42 +0000 (UTC)
Subject: Re: [PATCH v2] arch/x86: Fix boot_cpu_data.microcode version output
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        sironi@amazon.de, tony.luck@intel.com,
        Oleksandr Natalenko <oleksandr@natalenko.name>
References: <20180601121939.GA23298@nazgul.tnic>
 <20180731112739.32338-1-prarit@redhat.com>
 <20180801154255.GC13988@nazgul.tnic>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <92d17176-e7cd-134c-c6aa-0507f8599cfe@redhat.com>
Date:   Wed, 1 Aug 2018 11:55:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180801154255.GC13988@nazgul.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 01 Aug 2018 15:55:43 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 01 Aug 2018 15:55:43 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'prarit@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/01/2018 11:43 AM, Borislav Petkov wrote:
> (dropping stable@)
> 
> On Tue, Jul 31, 2018 at 07:27:39AM -0400, Prarit Bhargava wrote:
>> I tested this on AMD Ryzen & Intel Broadwell system and dumped the
>> boot_cpu_data before and after a microcode update.  On the Intel
>> system I also did a fatal MCE using mce-inject to confirm the output
>> from the mce handling code.
> 
> Ok, sending the two patches I've massaged into submission as a reply to
> this message - please run them on your boxes. You can also inject MCEs
> on the AMD box to verify - simply enable CONFIG_X86_MCE_INJECT, go to
> debugfs and do, for example:
> 
> cd /sys/kernel/debug/mce-inject/
> echo 10 > /sys/devices/system/machinecheck/machinecheck0/check_interval
> echo 0x9c7d410092080813 > status; echo 0x000000006d3d483b > addr; echo 2 > cpu; echo 4 > bank; echo hw > flags
> echo 0xbc00200000010015 > status; echo 0x00000000942e4d98 > addr; echo 6 > cpu; echo 2 > bank; echo hw > flags
> echo 0xfe000010000b0c0f > status; echo 0xe1101add1e550012 > addr; echo 0xcafebeef > misc; echo 2 > cpu; echo hw > flags; echo 4 > bank
> 

Borislav, I'm not sure if you saw his comments but Oleksandr, cc'd, has an
objection to overwriting the stored microcode version in boot_cpu_data.  He has
found that information useful in debugging microcode issues.

P.

> Thanks!
> 
