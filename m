Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164BDC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D075C2064E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:06:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D075C2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbeJBStV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 14:49:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58220 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727510AbeJBStV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 14:49:21 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5A273C025D20;
        Tue,  2 Oct 2018 12:06:22 +0000 (UTC)
Received: from darcari.bos.csb (dhcp-17-203.bos.redhat.com [10.18.17.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 59E0017167;
        Tue,  2 Oct 2018 12:06:19 +0000 (UTC)
Subject: Re: [LKP] [mailbox] afd0b1fb22:
 kmsg.Error_parsing_PCC_subspaces_from_PCCT
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Al Stone <ahs3@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, lkp@01.org
References: <20180930031715.GH15893@shao2-debian>
From:   David Arcari <darcari@redhat.com>
Organization: Red Hat
Message-ID: <639587bc-bbdc-8ff4-6e3d-7ef4c0a4a034@redhat.com>
Date:   Tue, 2 Oct 2018 08:06:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180930031715.GH15893@shao2-debian>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 02 Oct 2018 12:06:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Can someone help me interpret this email?  I was expecting this to be about a
dmesg change which is expected, but the content doesn't seem to indicate that.

For the record, the commit shouldn't really introduce any functional changes.
It merely avoids calling kcalloc with count==-EINVAL.  In both cases, an error
should be returned from  acpi_pcc_probe to pcc_init, which should in turn always
return -ENODEV.

So with the commit in place, this would be logged:

[    3.957345] ACPI: [PCCT:0x00] Invalid zero length
[    3.962340] Error parsing PCC subspaces from PCCT

instead of:

[    3.957345] ACPI: [PCCT:0x00] Invalid zero length
[    3.962340] Could not allocate space for PCC mbox channels


On 09/29/2018 11:17 PM, kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: afd0b1fb22269f48d68fdf269891c653818c8047 ("mailbox: PCC: handle parse error")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> in testcase: ftq
> with following parameters:
> 
> 	nr_task: 100%
> 	samples: 6000ss
> 	test: cache
> 	freq: 20
> 	ucode: 0x200004d
> 	cpufreq_governor: performance
> 
> test-description: The FTQ benchmarks measure hardware and software interference or 'noise' on a node from the applications perspective.
> test-url: https://github.com/rminnich/ftq
> 
> 
> on test machine: 104 threads Intel(R) Xeon(R) Platinum 8170 CPU @ 2.10GHz with 192G memory
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> 
> 
> 2018-09-21 23:31:26 ./ftq_cache -f 20 -n 6000 -t 104 -a 360448
> ticks per ns 2.09508

This ^^^ appears to be the actual error, but I don't understand what the
expected result should be or what this really means.

Thanks,

-Dave


> 
> 
> 
> To reproduce:
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp install job.yaml  # job file is attached in this email
>         bin/lkp run     job.yaml
> 
> 
> 
> Thanks,
> Rong Chen
> 

