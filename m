Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C051AC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5879520857
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BjW5Kniz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5879520857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732433AbeGaXRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 19:17:06 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36698 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbeGaXRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 19:17:06 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6VLXX9J002144;
        Tue, 31 Jul 2018 21:33:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=nn5LLZb285zxqDG+LXEzkep8jtQMat3n3LMrE/CHkeU=;
 b=BjW5KnizDp2h3gyJk46eaHCZK16wHcy5mkVr838+4IhRug1pUmLSUyDZTvSzKaz7CbSV
 Cgh1c25GwilhyKv6Qe/pQKowuVXcKvUor9422dWt3pc9XI51/GGMeZj5/cJc9KdStqwn
 Bg3S03UuaGCV1zciFFeDADQHOriTxAHheBNNMmHiuFBbRftBmJ4n94O3gv4v5XI3b3Ph
 fBcK/KL9OoIx7TRX8xdO0YceOgWc3KOlOQGKzaOMeeVxizfvO18j0CYsVERkldfd+M0w
 7DF0gP6o8gBpp5/rpEZYT80X+EFkisc7AMmZ2h5nVPJpbqM45fgBYqkkdpSrIURpzp/1 wA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2kgfwt31b3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jul 2018 21:33:33 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6VLXWxx008106
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jul 2018 21:33:32 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6VLXTev001066;
        Tue, 31 Jul 2018 21:33:30 GMT
Received: from [192.168.1.10] (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 31 Jul 2018 14:33:29 -0700
Subject: Re: [PATCH] mm: make __paginginit based on CONFIG_MEMORY_HOTPLUG
To:     Oscar Salvador <osalvador@techadventures.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        kirill.shutemov@linux.intel.com, iamjoonsoo.kim@lge.com,
        Mel Gorman <mgorman@suse.de>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, osalvador@suse.de
References: <20180731124504.27582-1-osalvador@techadventures.net>
 <CAGM2rebds=A5m1ZB1LtD7oxMzM9gjVQvm-QibHjEENmXViw5eA@mail.gmail.com>
 <20180731144157.GA1499@techadventures.net>
 <20180731144545.fh5syvwcecgvqul6@xakep.localdomain>
 <20180731145125.GB1499@techadventures.net>
 <CAGM2reZSZHdWECr8-7pj6j=CtjWVF2oKC9SwHhMuOsDkigdzgA@mail.gmail.com>
 <20180731150115.GC1499@techadventures.net>
 <CAGM2reZ+KhsuFhOVvJzRkQO=66TosvxDW0BYAXNf8Gw8zoRQXQ@mail.gmail.com>
 <CAGM2reaniWqEJ1hArMoreyGn5M+eSYge+wYYMxTrRHth-hxzOQ@mail.gmail.com>
 <20180731205003.GA3277@techadventures.net>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Message-ID: <34d9fff4-cc29-8c6e-42c9-48c4467b6a74@oracle.com>
Date:   Tue, 31 Jul 2018 17:33:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180731205003.GA3277@techadventures.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8971 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=955
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807310199
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/31/2018 04:50 PM, Oscar Salvador wrote:
> On Tue, Jul 31, 2018 at 11:23:33AM -0400, Pavel Tatashin wrote:
>> Yes we free meminit when no CONFIG_MEMORY_HOTPLUG
>> See here:
>> http://src.illumos.org/source/xref/linux-master/include/asm-generic/vmlinux.lds.h#107
> 
> Oh, I got the point now.
> Somehow I missed that we were freeing up the memory when CONFIG_MEMORY_HOTPLUG
> was not in place.
> 
> So your patch makes sense to me now, sorry.
> 
> Since my patchset [1] + cleanup patch [2] remove almost all __paginginit,
> leaving only pgdat_init_internals() and zone_init_internals(), I think
> it would be great if you base your patch on top of that.
> Or since the patchset has some cleanups already, I could add your patch
> into it (as we did for the zone_to/set_nid() patch) and send a v6 with it.
> 
> What do you think?

Sure, please go ahead include it in v6. Let me know if you need any help. Thank you for this work, I really like how this improves hotplug/memory-init code.

Pavel

> 
> [1] https://patchwork.kernel.org/patch/10548861/
> [2] <20180731101752.GA473@techadventures.net>
> 
> Thanks
> 
