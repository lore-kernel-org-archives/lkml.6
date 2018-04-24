Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755957AbeDXGXo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 02:23:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:46602 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751312AbeDXGXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 02:23:40 -0400
Subject: Re: [Xen-devel] [RFC 0/2] To introduce xenwatch multithreading (xen
 mtwatch)
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: Wei Liu <wei.liu2@citrix.com>, ian.jackson@eu.citrix.com,
        linux-kernel@vger.kernel.org, srinivas.eeda@oracle.com,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com,
        Joao Martins <joao.m.martins@oracle.com>
References: <1523100355-27647-1-git-send-email-dongli.zhang@oracle.com>
 <20180423140911.bihiwfwtlneobgzd@citrix.com>
 <6c379249-886d-76ee-db9c-942967b23d80@oracle.com>
 <db08fec6-5648-4d87-4ace-2f42d1d04479@suse.com>
 <9a91b19a-5556-f1ea-92d5-29f2baa0ccd5@oracle.com>
 <0280ae73-fd29-33a6-e4d5-8c83a8c2a5d7@suse.com>
 <1685df30-d31c-0c1b-40a4-b3282fbcd609@oracle.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <beef32cf-10bd-c02c-25e0-a8fc66657077@suse.com>
Date: Tue, 24 Apr 2018 08:23:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1685df30-d31c-0c1b-40a4-b3282fbcd609@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/18 08:10, Dongli Zhang wrote:
> 
> 
> On 04/24/2018 02:03 PM, Juergen Gross wrote:
>> On 24/04/18 07:52, Dongli Zhang wrote:
>>> Hi Juergen,
>>>
>>> On 04/24/2018 01:22 PM, Juergen Gross wrote:
>>>> On 24/04/18 01:55, Dongli Zhang wrote:
>>>>> Hi Wei,
>>>>>
>>>>> On 04/23/2018 10:09 PM, Wei Liu wrote:
>>>>>> On Sat, Apr 07, 2018 at 07:25:53PM +0800, Dongli Zhang wrote:
>>>>>>> About per-domU xenwatch thread create/destroy, a new type of xenstore node is
>>>>>>> introduced: '/local/domain/0/mtwatch/<domid>'.
>>>>>>>
>>>>>>> Suppose the new domid id 7. During the domU (domid=7) creation, the xen
>>>>>>> toolstack writes '/local/domain/0/mtwatch/7' to xenstore before the insertion
>>>>>>> of '/local/domain/7'. When the domid=7 is destroyed, the last xenstore
>>>>>>> operation by xen toolstack is to remove '/local/domain/0/mtwatch/7'.
>>>>>>>
>>>>>>> The dom0 kernel subscribes a watch at node '/local/domain/0/mtwatch'.  Kernel
>>>>>>> thread [xen-mtwatch-7] is created when '/local/domain/0/mtwatch/7' is inserted,
>>>>>>> while this kernel thread is destroyed when the corresponding xenstore node is
>>>>>>> removed.
>>>>>>
>>>>>> Instead of inventing yet another node, can you not watch /local/domain
>>>>>> directly?
>>>>>
>>>>> Would you like to watch at /local/domain directly? Or is your question "is there
>>>>> any other way to not watch at /local/domain, while no extra xenstore node will
>>>>> be introduced"?
>>>>>
>>>>> Actually, the first prototype of this idea was to watch at /local/domain
>>>>> directly to get aware of the domU create/destroy, so that xen toolstack will not
>>>>> get involved. Joao Martins (CCed) had a concern on the performance as watching
>>>>> at /local/domain would lead to large amount of xenwatch events.
>>>>
>>>> That's what the special watches "@introduceDomain" and "@releaseDomain"
>>>> are meant for.
>>>
>>> I used to consider to watch at "@introduceDomain". However, there is no domain
>>> information appended with "@introduceDomain" and it is still required for dom0
>>> kernel to proactively confirm who is created.
>>
>> That isn't too hard, right? You just need to read /local/domain to get
>> the list of its children and look for new domains there.
> 
> You are right. I will try to limit the modification within linux kernel, and try
> to not dirty xen toolstack.
> 
> Thank you very much for the suggestion.

When going that route you should extend xenbus_directory() in the kernel
to use XS_DIRECTORY_PART in case XS_DIRECTORY returns E2BIG (see
xs_directory() in Xen's tools/xenstore/xs.c ). This will enable the
kernel to support more than about 1000 domains.


Juergen
