Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40EE0C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09273218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CayHidDM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbfAYXci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 18:32:38 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:47316 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfAYXci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 18:32:38 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0PNTTvW187710;
        Fri, 25 Jan 2019 23:30:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=khFM13MUGmAuQcjDxhffkILU91NaQU/s+UehyBZeQ3A=;
 b=CayHidDM0AsIhq1es1p8MmosDeNO+UA6SWtjm5JdZHv57dAd8E9+sDo+vtOnN3UdSH4d
 yD4mu22fDmf6erYVSyYFIaXfaKYAdYI9RE8mBAXDRh80l3DbG0tI+2WNAlVegicmY46Z
 +7HFu4fbbeCKStTPmJB+htg6tza8Ey0RShycWudRnae+LLomglsEk9cEazySlzJQKevQ
 jnw8O3wKwOlYWm/D53/F3XrxV9yWTWIEZ9IsrbO4AvNciiWCfuAVCez9CKu6uoGr5+I9
 9lFA26YSq/7Hh/48h7prg/ImyQTQDSnWv42dSJffa773PK2Fa4E25S5F7bjXrRFHFuJ2 ig== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2q3vhs897m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jan 2019 23:30:17 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0PNUGmN005973
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jan 2019 23:30:16 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0PNUDIA015302;
        Fri, 25 Jan 2019 23:30:13 GMT
Received: from [10.159.149.153] (/10.159.149.153)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 25 Jan 2019 15:30:13 -0800
Subject: Re: [PATCH 5/5] dax: "Hotplug" persistent memory for use like normal
 RAM
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "Du, Fan" <fan.du@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "tiwai@suse.de" <tiwai@suse.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        "zwisler@kernel.org" <zwisler@kernel.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "baiyaowei@cmss.chinamobile.com" <baiyaowei@cmss.chinamobile.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "Wu, Fengguang" <fengguang.wu@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
References: <20190124231441.37A4A305@viggo.jf.intel.com>
 <20190124231448.E102D18E@viggo.jf.intel.com>
 <0852310e-41dc-dc96-2da5-11350f5adce6@oracle.com>
 <CAPcyv4hjJhUQpMy1CVJZur0Ssr7Cr2fkcD50L5gzx6v_KY14vg@mail.gmail.com>
 <5A90DA2E42F8AE43BC4A093BF067884825733A5B@SHSMSX104.ccr.corp.intel.com>
 <CAPcyv4ikXD8rJAmV6tGNiq56m_ZXPZNrYkTwOSUJ7D1O_M5s=w@mail.gmail.com>
 <b7d45d83a314955e7dff25401dfc0d4f4247cfcd.camel@intel.com>
 <dc7d8190-2c94-9bdb-fb5b-a80a3fb55822@oracle.com>
 <CAPcyv4hEyG-1hC=20M7YGFG-BF7yvNcG7EkLurAfysHHB2yXBA@mail.gmail.com>
From:   Jane Chu <jane.chu@oracle.com>
Organization: Oracle Corporation
Message-ID: <ef27aeed-6f09-456e-a7aa-24430167e155@oracle.com>
Date:   Fri, 25 Jan 2019 15:30:10 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4hEyG-1hC=20M7YGFG-BF7yvNcG7EkLurAfysHHB2yXBA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9147 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901250178
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/25/2019 11:15 AM, Dan Williams wrote:
> On Fri, Jan 25, 2019 at 11:10 AM Jane Chu <jane.chu@oracle.com> wrote:
>>
>>
>> On 1/25/2019 10:20 AM, Verma, Vishal L wrote:
>>>
>>> On Fri, 2019-01-25 at 09:18 -0800, Dan Williams wrote:
>>>> On Fri, Jan 25, 2019 at 12:20 AM Du, Fan <fan.du@intel.com> wrote:
>>>>> Dan
>>>>>
>>>>> Thanks for the insights!
>>>>>
>>>>> Can I say, the UCE is delivered from h/w to OS in a single way in
>>>>> case of machine
>>>>> check, only PMEM/DAX stuff filter out UC address and managed in its
>>>>> own way by
>>>>> badblocks, if PMEM/DAX doesn't do so, then common RAS workflow will
>>>>> kick in,
>>>>> right?
>>>>
>>>> The common RAS workflow always kicks in, it's just the page state
>>>> presented by a DAX mapping needs distinct handling. Once it is
>>>> hot-plugged it no longer needs to be treated differently than "System
>>>> RAM".
>>>>
>>>>> And how about when ARS is involved but no machine check fired for
>>>>> the function
>>>>> of this patchset?
>>>>
>>>> The hotplug effectively disconnects this address range from the ARS
>>>> results. They will still be reported in the libnvdimm "region" level
>>>> badblocks instance, but there's no safe / coordinated way to go clear
>>>> those errors without additional kernel enabling. There is no "clear
>>>> error" semantic for "System RAM".
>>>>
>>> Perhaps as future enabling, the kernel can go perform "clear error" for
>>> offlined pages, and make them usable again. But I'm not sure how
>>> prepared mm is to re-accept pages previously offlined.
>>>
>>
>> Offlining a DRAM backed page due to an UC makes sense because
>>    a. the physical DRAM cell might still have an error
>>    b. power cycle, scrubing could potentially 'repair' the DRAM cell,
>> making the page usable again.
>>
>> But for a PMEM backed page, neither is true. If a poison bit is set in
>> a page, that indicates the underlying hardware has completed the repair
>> work, all that's left is for software to recover.  Secondly, because
>> poison is persistent, unless software explicitly clear the bit,
>> the page is permanently unusable.
> 
> Not permanently... system-owner always has the option to use the
> device-DAX and ARS mechanisms to clear errors at the next boot.
> There's just no kernel enabling to do that automatically as a part of
> this patch set.
> 
> However, we should consider this along with the userspace enabling to
> control which device-dax instances are set aside for hotplug. It would
> make sense to have a "clear errors before hotplug" configuration
> option.
> 

Agreed, it would be nice to clear error prior to the hotplug operation,
better if that can be handled by the kernel.

thanks,
-jane

