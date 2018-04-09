Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753150AbeDIQCf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 12:02:35 -0400
Received: from mga12.intel.com ([192.55.52.136]:60641 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751633AbeDIQCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 12:02:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,427,1517904000";
   d="scan'208";a="32860327"
Subject: Re: [PATCH v3 2/4] mm/sparsemem: Defer the ms->section_mem_map
 clearing
To: Baoquan He <bhe@redhat.com>
References: <20180228032657.32385-1-bhe@redhat.com>
 <20180228032657.32385-3-bhe@redhat.com>
 <8e147320-50f5-f809-31d2-992c35ecc418@intel.com>
 <20180408065055.GA19345@localhost.localdomain>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        pagupta@redhat.com, linux-mm@kvack.org,
        kirill.shutemov@linux.intel.com
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <fa2bb08a-42cc-c0cc-31c0-39d6e14f6f92@intel.com>
Date: Mon, 9 Apr 2018 09:02:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180408065055.GA19345@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/07/2018 11:50 PM, Baoquan He wrote:
>> Should the " = 0" instead be clearing SECTION_MARKED_PRESENT or
>> something?  That would make it easier to match the code up with the code
>> that it is effectively undoing.
> 
> Not sure if I understand your question correctly. From memory_present(),
> information encoded into ms->section_mem_map including numa node,
> SECTION_IS_ONLINE and SECTION_MARKED_PRESENT. Not sure if it's OK to only
> clear SECTION_MARKED_PRESENT.  People may wrongly check SECTION_IS_ONLINE
> and do something on this memory section?

What is mean is that, instead of:

	
	ms->section_mem_map = 0;

we could literally do:

	ms->section_mem_map &= ~SECTION_MARKED_PRESENT;

That does the same thing in practice, but makes the _intent_ much more
clear.
