Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5185EC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 15:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 118572176D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 15:40:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 118572176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbeHCRhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 13:37:23 -0400
Received: from mga03.intel.com ([134.134.136.65]:23126 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727376AbeHCRhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 13:37:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Aug 2018 08:40:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,439,1526367600"; 
   d="scan'208";a="61859979"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.252.128.249]) ([10.252.128.249])
  by orsmga007.jf.intel.com with ESMTP; 03 Aug 2018 08:40:25 -0700
Subject: Re: [RFC PATCH 0/7] x86/intel_rdt: Restoration of Cache Pseudo-Locked
 regions
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     fenghua.yu@intel.com, Tony Luck <tony.luck@intel.com>,
        vikas.shivappa@linux.intel.com, gavin.hindman@intel.com,
        jithu.joseph@intel.com, dave.hansen@intel.com, mingo@redhat.com,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <cover.1532463771.git.reinette.chatre@intel.com>
 <alpine.DEB.2.21.1808031343020.1745@nanos.tec.linutronix.de>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <05a621ec-adce-42b1-ea99-3bd8bac00e16@intel.com>
Date:   Fri, 3 Aug 2018 08:40:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1808031343020.1745@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 8/3/2018 4:45 AM, Thomas Gleixner wrote:
> On Tue, 24 Jul 2018, Reinette Chatre wrote:
>> A Cache Pseudo-Locked region is vulnerable to certain instructions (INVD,
>> WBINVD, CLFLUSH) or deeper C-states (that could shrink or power off the
>> cache) evicting the pseudo-locked memory. The current support for
>> pseudo-locked regions already restrict deeper C-states on cores associated
>> with the pseudo-locked regions, but the vulnerability to some instructions
>> remain.
>>
>> This work does not prevent the instructions to which Cache Pseudo-Locked
>> regions are vulnerable, instead, this work support the restoration of
>> Cache Pseudo-Locked regions that can be triggered manually by the user
>> or automatically after the WBINVD instruction has been issued.
>>
>> A new debugfs file "pseudo_lock_restore" is associated with each
>> pseudo-locked region and can be used to manually trigger the memory
>> associated with the region to be pseudo-locked to cache again.
> 
> I'm not seeing how that should be used. What's the indication for an
> operator to write to that file?

Our primary indicator would come from the debugfs mechanism that the
user can use to accurately measure how well the data is pseudo-locked.
If that shows that some cache misses are encountered then the user has
the option to lock the data again.

A user may measure the success of a pseudo-lock region right after its
creation or if any performance issues are experienced by the application
that depends on this region. The latter may hint that there could be as
issue with the integration with power savings, a desctructive
instruction made it to the system, or some other cause that needs to be
investigated.

>> The system-wide "native_wbinvd()" is modified to trigger the restoration of
>> all Cache Pseudo-Locked regions after the WBINVD instruction returns and
>> effort is made to avoid any unnecessary work in this flow.
>>
>> Within the kernel two locations with direct invocations of the WBINVD
>> instruction are coverted to native_wbinvd() and compile tested. Neither
>> location is likely to be used on the platforms supporting Cache Pseudo-Locking.
> 
> Can we just get rid of WBINVD?

While directed at me I am not able to answer this. native_wbinvd() is
used in a few areas that appear important to me.

Reinette
