Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 414D2ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 19:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F21702087A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 19:54:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F21702087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=supermicro.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731952AbeGMUKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 16:10:55 -0400
Received: from mgb.supermicro.com ([207.212.57.85]:35524 "EHLO
        mgb.supermicro.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730017AbeGMUKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 16:10:55 -0400
Received: from pps.filterd (MGB.supermicro.com [127.0.0.1])
        by MGB.supermicro.com (8.16.0.22/8.16.0.22) with SMTP id w6DJnmZh000826;
        Fri, 13 Jul 2018 12:54:49 -0700
Received: from ex2013-mbx2.supermicro.com ([10.2.1.38])
        by MGB.supermicro.com with ESMTP id 2k2w4s8tf1-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 13 Jul 2018 12:54:49 -0700
Received: from [172.16.95.100] (10.2.0.41) by Ex2013-MBX2.supermicro.com
 (10.2.1.38) with Microsoft SMTP Server (TLS) id 15.0.1236.3; Fri, 13 Jul 2018
 12:53:56 -0700
Subject: Re: [RFC] x86, tsc: Add kcmdline args for skipping tsc calibration
 sequences
To:     Arjan van de Ven <arjan@linux.intel.com>, <len.brown@intel.com>,
        <linux-kernel@vger.kernel.org>
CC:     <mingo@kernel.org>, <alek.du@intel.com>, <feng.tang@intel.com>
References: <fdf96605-a4a0-049b-51c9-1e68cc2a9b93@supermicro.com>
 <9cdcf3bb-4d01-19cc-536f-4745ecb058c6@linux.intel.com>
From:   patrickg <patrickg@supermicro.com>
Message-ID: <3987740c-44b4-72fa-3b3e-ebccecc32b00@supermicro.com>
Date:   Fri, 13 Jul 2018 12:54:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <9cdcf3bb-4d01-19cc-536f-4745ecb058c6@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.2.0.41]
X-ClientProxiedBy: EX2013-CA1.supermicro.com (10.2.1.31) To
 Ex2013-MBX2.supermicro.com (10.2.1.38)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-13_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=794
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807130179
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/13/2018 12:40 PM, Arjan van de Ven wrote:
> On 7/13/2018 12:19 PM, patrickg wrote:
>> This RFC patch is intended to allow bypass CPUID, MSR and QuickPIT calibration methods should the user desire to.
>>
>> The current ordering in ML x86 tsc is to calibrate in the order listed above; returning whenever there's a successful calibration.  However there are certain BIOS/HW Designs for overclocking that cause the TSC to change along with the max core clock; and simple 'trusting' calibration methodologies will lead to the TSC running 'faster' and eventually, TSC instability.
>>
> 
> 
> that would be a real violation of the contract between cpu and OS: tsc is not supposed to change for the duration of the boot
With the methodology used; the TSC is still invariant; it's just running faster than the CPUID math calculates.

> 
>> I only know that there's a use-case for me to want to be able to skip CPUID calibration, however I included args for skipping all the rest just so that all functionality is covered in the long run instead of just one use-case.
> 
> wouldn't it be better to start the detailed calibration with the value from CPUID instead; that way we also properly calibrate spread spectrum etc...
> 
> I thought we switched to that recently to be honest...
Are you referencing:

1bf8915ae5156dff439d2c65314bd8fdde1b83bf - x86/tsc: Enumerate SKL cpu_khz and tsc_khz via CPUID

However since it's returning at CPUID calibration during native_calibrate_cpu(); it's not compared after-the-fact, leading to the TSC to use the 'slower' number returned by CPUID.

Now keep in mind; I dunno if there was any reason to explicitly not want to utilize the PIT calib sequences on SKL.  That'd be a factor for this.

Would comparing the number after the fact; then if there's a significant difference between PIT and MSR/CPUID, defaulting to the 'faster' value be a better solution?
