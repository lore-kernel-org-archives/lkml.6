Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D2FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8983020817
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PHYf+Q8q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8983020817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbeK0Ghs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 01:37:48 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:51092 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbeK0Ghm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 01:37:42 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAQJcueQ078897;
        Mon, 26 Nov 2018 19:42:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=R5fZG83EtOqv1Ht8GaGYcbiTpmPNApAubkV7ks6Rxn4=;
 b=PHYf+Q8qjK12yQrmhyxGPuA+W2ng7j0xmPimmD2xY8Y9+944t3slG3BjjfvgOSdOXbXB
 FVDi1ZLMnN5keIoLLF9d/cWGiq3aY7A+K4EExlhcIXryplZ7DLrigKbDPVIOF5TSFiMs
 qhm1L2Qwatk80WozTRKzOwGW+SO/dPeKicLM1cyn0iSbhm34Ob6rYRwWiYuw3HMdBGBg
 +a4qBs7ftpRh2+F24JivHcm+szTTuEyekInQ5RXTKzFXYReTZgV5iTabi/jrXiGg7FLv
 Rb9S12cDL+/RCpx2s4tlkiHNCq6FGN0e9e7ZXhpwq5aSgNKhHAUf8Ih2BZ7GKkVSLhSW Ig== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2nxy9qyvm1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Nov 2018 19:42:22 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wAQJgGWP009344
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Nov 2018 19:42:16 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wAQJgFK0029119;
        Mon, 26 Nov 2018 19:42:15 GMT
Received: from dhcp-burlington7-2nd-B-east-10-152-55-162.usdhcp.oraclecorp.com (/10.152.32.65)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 26 Nov 2018 11:42:15 -0800
Subject: Re: [Xen-devel] [PATCH v3] xen/balloon: Mark unallocated host memory
 as UNUSABLE
To:     Igor Druzhinin <igor.druzhinin@citrix.com>,
        xen-devel@lists.xen.org, linux-kernel@vger.kernel.org
Cc:     jgross@suse.com, helgaas@kernel.org, christian.koenig@amd.com,
        JBeulich@suse.com
References: <1513778746-6155-1-git-send-email-boris.ostrovsky@oracle.com>
 <7c833e3a-4a0b-e80c-91e2-4348d6959651@citrix.com>
 <d42938a7-2081-65f4-a0d9-6fb7a8dd2fa0@oracle.com>
 <f955576f-532d-d4de-e7eb-718dae4b14c1@citrix.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Openpgp: preference=signencrypt
Autocrypt: addr=boris.ostrovsky@oracle.com; prefer-encrypt=mutual; keydata=
 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
 Jg6OxFYd01z+a+oL
Message-ID: <3dd5153d-0f17-0e3b-7ebb-5579a7200765@oracle.com>
Date:   Mon, 26 Nov 2018 14:42:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <f955576f-532d-d4de-e7eb-718dae4b14c1@citrix.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9089 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811260168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/26/18 12:10 PM, Igor Druzhinin wrote:
> On 26/11/2018 16:25, Boris Ostrovsky wrote:
>> On 11/25/18 8:00 PM, Igor Druzhinin wrote:
>>> On 20/12/2017 14:05, Boris Ostrovsky wrote:
>>>> Commit f5775e0b6116 ("x86/xen: discard RAM regions above the maximum
>>>> reservation") left host memory not assigned to dom0 as available for
>>>> memory hotplug.
>>>>
>>>> Unfortunately this also meant that those regions could be used by
>>>> others. Specifically, commit fa564ad96366 ("x86/PCI: Enable a 64bit BAR
>>>> on AMD Family 15h (Models 00-1f, 30-3f, 60-7f)") may try to map those
>>>> addresses as MMIO.
>>>>
>>>> To prevent this mark unallocated host memory as E820_TYPE_UNUSABLE (thus
>>>> effectively reverting f5775e0b6116) and keep track of that region as
>>>> a hostmem resource that can be used for the hotplug.
>>>>
>>>> Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>>> This commit breaks Xen balloon memory hotplug for us in Dom0 with
>>> "hoplug_unpopulated" set to 1. The issue is that the common kernel
>>> memory onlining procedures require "System RAM" resource to be 1-st
>>> level. That means by inserting it under "Unusable memory" as the commit
>>> above does (intentionally or not) we make it 2-nd level and break memory
>>> onlining.
>> What do you mean by 1st and 2nd level?
>>
> I mean the level of a resource in IOMEM tree (the one that's printed
> from /proc/iomem). 1-st level means its parent is root and so on.

Ah, OK. Doesn't
additional_memory_resource()->insert_resource(iomem_resource) place the
RAM at 1st level? And if not, can we make it so?

>
>>> There are multiple ways to fix it depending on what was the intention of
>>> original commit and what exactly it tried to workaround. It seems it
>>> does several things at once:
>>> 1) Marks non-Dom0 host memory "Unusable memory" in resource tree.
>>> 2) Keeps track of all the areas safe for hotplug in Dom0
>>> 3) Changes allocation algorithms itself in balloon driver to use those areas
>> Pretty much. (3) is true in the sense that memory is first allocated
>> from hostmem_resource (which is non-dom0 RAM).
>>
>>> Are all the things above necessary to cover the issue in fa564ad96366
>>> ("x86/PCI: Enable a 64bit BAR on AMD Family 15h (Models 00-1f, 30-3f,
>>> 60-7f)")?
>> Not anymore, as far as that particular commit is concerned, but that's
>> because of 03a551734 ("x86/PCI: Move and shrink AMD 64-bit window to
>> avoid conflict") which was introduced after balloon patch. IIRC there
>> were some issues with fa564ad96366 unrelated to balloon.
>>
> If it's not a problem anymore IIUC, can we revert the change as it still
> breaks "hotplug_unpopulated=1" for the reasons I described above?

Since this seems to have broken existing feature this would be an
option. But before going that route I'd like to see if we can fix the patch.

I have been unable to reproduce your problem. Can you describe what you did?


>
>>> Can we remove "Unusable memory" resources as soon as we finished
>>> booting? Is removing on-demand is preferable over "shoot them all" in
>>> that case?
>> The concern is that in principle nothing prevents someone else to do
>> exact same thing fa564ad96366 did, which is grab something from right
>> above end of RAM as the kernel sees it. And that can be done at any point.
>>
> Nothing prevents - true, but that's plainly wrong from OS point of view
> to grab physical ranges for something without knowing what's actually
> behind on that platform. 

I am not sure I agree that this is plainly wrong. If not for BIOS issues
that 03a551734cf mentions I think what the original implementation of
fa564ad963 did was perfectly reasonable. Which is why I would prefer to
keep keep the hostmem resource *if possible*.


-boris


> I think we shouldn't consider this as a valid
> thing to do and don't try to workaround initially incorrect code.
>
>> -boris
>>
>>> Does it even make sense to remove the 1-st level only restriction in
>>> kernel/resource.c ?
>>
>>

