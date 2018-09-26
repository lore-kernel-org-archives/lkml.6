Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F733C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49FD021527
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:19:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49FD021527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbeIZWct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 18:32:49 -0400
Received: from mga18.intel.com ([134.134.136.126]:26260 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727285AbeIZWct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 18:32:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2018 09:19:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,306,1534834800"; 
   d="scan'208";a="76115327"
Received: from ahduyck-mobl.amr.corp.intel.com (HELO [10.7.198.154]) ([10.7.198.154])
  by orsmga007.jf.intel.com with ESMTP; 26 Sep 2018 09:18:16 -0700
Subject: Re: [PATCH v5 2/4] mm: Provide kernel parameter to allow disabling
 page init poisoning
To:     Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        pavel.tatashin@microsoft.com, dave.jiang@intel.com,
        jglisse@redhat.com, rppt@linux.vnet.ibm.com,
        dan.j.williams@intel.com, logang@deltatee.com, mingo@kernel.org,
        kirill.shutemov@linux.intel.com
References: <20180925200551.3576.18755.stgit@localhost.localdomain>
 <20180925201921.3576.84239.stgit@localhost.localdomain>
 <20180926073831.GC6278@dhcp22.suse.cz>
 <c57da51a-009a-9500-4dc5-1d9912e78abd@linux.intel.com>
 <98411844-19b7-a75b-d52c-6e2c46b40d57@intel.com>
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
Message-ID: <0845f5c1-5737-3749-69dd-e7fb5d1b75c6@linux.intel.com>
Date:   Wed, 26 Sep 2018 09:18:16 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <98411844-19b7-a75b-d52c-6e2c46b40d57@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/26/2018 8:41 AM, Dave Hansen wrote:
> On 09/26/2018 08:24 AM, Alexander Duyck wrote:
>> With no options it works just like slub_debug and enables all
>> available options. So in our case it is a NOP since we wanted the
>> debugging enabled by default.
> 
> Yeah, but slub_debug is different.
> 
> First, nobody uses the slub_debug=- option because *that* is only used
> when you have SLUB_DEBUG=y *and* CONFIG_SLUB_DEBUG_ON=y, which not even
> Fedora does.
> 
> slub_debug is *primarily* for *adding* debug features.  For this, we
> need to turn them off.
> 
> It sounds like following slub_debug was a bad idea, especially following
> its semantics too closely when it doesn't make sense.

I actually like the idea of using slub_debug style semantics. It makes 
sense when you start thinking about future features being added. Then we 
might actually have scenarios where vm_debug=P will make sense, but for 
right now it is probably not going to be used. Basically this all makes 
room for future expansion. It is just ugly to read right now while we 
only have one feature controlled by this bit.
