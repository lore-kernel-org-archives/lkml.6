Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752484AbeBANtz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 08:49:55 -0500
Received: from mga11.intel.com ([192.55.52.93]:33212 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752439AbeBANtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 08:49:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,444,1511856000";
   d="scan'208";a="28028578"
Subject: Re: [PATCH 2/2] mm/sparse.c: Add nr_present_sections to change the
 mem_map allocation
To: "Kirill A. Shutemov" <kirill@shutemov.name>,
        Baoquan He <bhe@redhat.com>
References: <20180201071956.14365-1-bhe@redhat.com>
 <20180201071956.14365-3-bhe@redhat.com>
 <20180201101641.icoxv2sp6ckrjfxd@node.shutemov.name>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        mhocko@suse.com, tglx@linutronix.de, douly.fnst@cn.fujitsu.com
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <6def8374-2de2-a30c-69ff-2a49fb57dc9a@linux.intel.com>
Date: Thu, 1 Feb 2018 05:49:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180201101641.icoxv2sp6ckrjfxd@node.shutemov.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/01/2018 02:16 AM, Kirill A. Shutemov wrote:
> On Thu, Feb 01, 2018 at 03:19:56PM +0800, Baoquan He wrote:
>> In sparse_init(), we allocate usemap_map and map_map which are pointer
>> array with the size of NR_MEM_SECTIONS. The memory consumption can be
>> ignorable in 4-level paging mode. While in 5-level paging, this costs
>> much memory, 512M. Kdump kernel even can't boot up with a normal
>> 'crashkernel=' setting.
>>
>> Here add a new variable to record the number of present sections. Let's
>> allocate the usemap_map and map_map with the size of nr_present_sections.
>> We only need to make sure that for the ith present section, usemap_map[i]
>> and map_map[i] store its usemap and mem_map separately.
>>
>> This change can save much memory on most of systems. Anytime, we should
>> avoid to define array or allocate memory with the size of NR_MEM_SECTIONS.
> That's very desirable outcome. But I don't know much about sparsemem.

... with the downside being that we can no longer hot-add memory that
was not part of the original, present sections.

Is that OK?
