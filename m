Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752110AbeBHBlw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 20:41:52 -0500
Received: from mga11.intel.com ([192.55.52.93]:58489 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751153AbeBHBlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 20:41:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,476,1511856000";
   d="scan'208";a="28286809"
Message-ID: <5A7BAB7D.7070805@intel.com>
Date: Thu, 08 Feb 2018 09:44:29 +0800
From: Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org,
        pbonzini@redhat.com, liliang.opensource@gmail.com,
        yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com,
        riel@redhat.com, huangzhichao@huawei.com
Subject: Re: [PATCH v27 3/4] mm/page_poison: expose page_poisoning_enabled
 to kernel modules
References: <1517986471-15185-1-git-send-email-wei.w.wang@intel.com> <1517986471-15185-4-git-send-email-wei.w.wang@intel.com> <20180207203004-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180207203004-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2018 02:34 AM, Michael S. Tsirkin wrote:
> On Wed, Feb 07, 2018 at 02:54:30PM +0800, Wei Wang wrote:
>> In some usages, e.g. virtio-balloon, a kernel module needs to know if
>> page poisoning is in use. This patch exposes the page_poisoning_enabled
>> function to kernel modules.
>>
>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Michal Hocko <mhocko@kernel.org>
>> Cc: Michael S. Tsirkin <mst@redhat.com>
>> ---
>>   mm/page_poison.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/mm/page_poison.c b/mm/page_poison.c
>> index e83fd44..c08d02a 100644
>> --- a/mm/page_poison.c
>> +++ b/mm/page_poison.c
>> @@ -30,6 +30,11 @@ bool page_poisoning_enabled(void)
>>   		debug_pagealloc_enabled()));
>>   }
>>   
>> +/**
>> + * page_poisoning_enabled - check if page poisoning is enabled
>> + *
>> + * Return true if page poisoning is enabled, or false if not.
>> + */
>>   static void poison_page(struct page *page)
>>   {
>>   	void *addr = kmap_atomic(page);
>> @@ -37,6 +42,7 @@ static void poison_page(struct page *page)
>>   	memset(addr, PAGE_POISON, PAGE_SIZE);
>>   	kunmap_atomic(addr);
>>   }
>> +EXPORT_SYMBOL_GPL(page_poisoning_enabled);
>>   
>>   static void poison_pages(struct page *page, int n)
>>   {
> Looks like both the comment and the export are in the wrong place.

Thanks. Will be more careful.

> I'm a bit concerned that callers also in fact poke at the
> PAGE_POISON - exporting that seems to be more of an accident
> as it's only used without page_poisoning.c - it might be
> better to have page_poisoning_enabled get u8 * and set it.
>

PAGE_POISON is a macro defined in the header, why would callers using it 
be a concern?

Do you suggest to have:

bool page_poisoning_get(u8 *val)
{
     if (page_poisoning_enabled()) {
         *val = PAGE_POISON;
         return true;
     }

     return false;
}
EXPORT_SYMBOL_GPL(page_poisoning_get);


Best,
Wei
