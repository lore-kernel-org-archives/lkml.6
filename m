Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752448AbeBHSer (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 13:34:47 -0500
Received: from mail-ot0-f174.google.com ([74.125.82.174]:44050 "EHLO
        mail-ot0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752056AbeBHSeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 13:34:46 -0500
X-Google-Smtp-Source: AH8x227Flc2ZwGO5x5KjL28dIvZNLPFsph6YXGhxERtKdMTSX5I4c/ayUdLsI7nJUm5ZJEXB3mEL7Q==
Subject: Re: Regression after commit 19809c2da28a ("mm, vmalloc: use
 __GFP_HIGHMEM implicitly")
To: Matthew Wilcox <willy@infradead.org>
Cc: Kai Heng Feng <kai.heng.feng@canonical.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <627DA40A-D0F6-41C1-BB5A-55830FBC9800@canonical.com>
 <20180208130649.GA15846@bombadil.infradead.org>
 <f8be3fc9-a96d-bf37-4da0-43220014caed@redhat.com>
 <20180208181800.GA9524@bombadil.infradead.org>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <d7314317-f3d6-a38d-326a-7a27e05a5e67@redhat.com>
Date: Thu, 8 Feb 2018 10:34:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180208181800.GA9524@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2018 10:18 AM, Matthew Wilcox wrote:
> On Thu, Feb 08, 2018 at 09:56:42AM -0800, Laura Abbott wrote:
>>> +++ b/drivers/media/v4l2-core/videobuf-dma-sg.c
>>> @@ -77,7 +77,7 @@ static struct scatterlist *videobuf_vmalloc_to_sg(unsigned char *virt,
>>>    		pg = vmalloc_to_page(virt);
>>>    		if (NULL == pg)
>>>    			goto err;
>>> -		BUG_ON(PageHighMem(pg));
>>> +		BUG_ON(page_to_pfn(pg) >= (1 << (32 - PAGE_SHIFT)));
>>>    		sg_set_page(&sglist[i], pg, PAGE_SIZE, 0);
>>>    	}
>>>    	return sglist;
>>>
>>
>> the vzalloc in this function needs to be switched to vmalloc32 if it
>> actually wants to guarantee 32-bit memory.
> 
> Whoops, you got confused between the sglist allocation and the allocation
> of the pages which will be mapped ...
> 

Ah yeah, clearly need more coffee this morning.
