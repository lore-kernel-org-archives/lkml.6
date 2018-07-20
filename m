Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947E0ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 22:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 456BC20661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 22:27:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 456BC20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=supermicro.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729817AbeGTXRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 19:17:52 -0400
Received: from mgb.supermicro.com ([207.212.57.85]:47197 "EHLO
        mgb.supermicro.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728469AbeGTXRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 19:17:52 -0400
Received: from pps.filterd (MGB.supermicro.com [127.0.0.1])
        by MGB.supermicro.com (8.16.0.22/8.16.0.22) with SMTP id w6KMR3Fa003870;
        Fri, 20 Jul 2018 15:27:33 -0700
Received: from ex2013-mbx1.supermicro.com (ex2013-mbx1.supermicro.com [10.2.1.36])
        by MGB.supermicro.com with ESMTP id 2k7gsrax1q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 20 Jul 2018 15:27:33 -0700
Received: from [172.16.95.100] (10.2.0.41) by EX2013-MBX1.supermicro.com
 (10.2.1.36) with Microsoft SMTP Server (TLS) id 15.0.1236.3; Fri, 20 Jul 2018
 15:26:37 -0700
Subject: Re: [RFC] x86, tsc: Add kcmdline args for skipping tsc calibration
 sequences
To:     "Brown, Len" <len.brown@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "mingo@kernel.org" <mingo@kernel.org>,
        "Du, Alek" <alek.du@intel.com>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>,
        "Tang, Feng" <feng.tang@intel.com>
References: <fdf96605-a4a0-049b-51c9-1e68cc2a9b93@supermicro.com>
 <1A7043D5F58CCB44A599DFD55ED4C94849A1AACF@FMSMSX126.amr.corp.intel.com>
From:   patrickg <patrickg@supermicro.com>
Message-ID: <c7582a8c-8cc1-eff3-2452-a8d42d23fea1@supermicro.com>
Date:   Fri, 20 Jul 2018 15:27:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1A7043D5F58CCB44A599DFD55ED4C94849A1AACF@FMSMSX126.amr.corp.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.2.0.41]
X-ClientProxiedBy: EX2013-CA1.supermicro.com (10.2.1.31) To
 EX2013-MBX1.supermicro.com (10.2.1.36)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-20_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807200242
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the delay.  Expect another large delay if you have any questions.  I'm pretty heavily context switching.

I wanted to double check to make sure that I wasn't mis-documenting and mis-remembering things.

On 07/13/2018 07:40 PM, Brown, Len wrote:
> We disabled CPUID-based TSC calibration on SKX in December for several reasons.
> If you still have it enabled, you need this patch:
> 
> commit b511203093489eb1829cb4de86e8214752205ac6
>     x86/tsc: Fix erroneous TSC rate on Skylake Xeon
So, yeah.  I tested against mainline RHEL-alike elrepo builds before and I still saw the TSC running faster.

I've also tested against 3.10.0-862.6.3 which has those patches backported.

> 
> If you are referring to another platform that has CPUID-TSC calibration...
> it should still work on an over-clocked system.  Over-clocked platforms should
> use exactly the same reference crystal as non-overclocked platforms, but should
> modify the crystal/core multiplier.   If you are changing the reference
> crystal, then I believe you are using an un-supported hardware configuration,
> and my ability to support you is limited.
FYI for reference this is SKX Server.  Specifically the `gold` series procs.

Now; I'm not sure if we happen to be doing something strange in regards to changing the ref crystal.  I'll need to poke at them to figure that out.

I'm working on building something up with a lot of verbosity so that I can see if perhaps something is happening or not happening in an expected way.
