Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D894C282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 19:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48DFD218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 19:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ff8SwgtI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbfAYTMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 14:12:08 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:34368 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbfAYTMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 14:12:08 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0PIxPSs188697;
        Fri, 25 Jan 2019 19:10:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=e45pddu4T0w+FZczQB8gd8TNniiUMDMlHfFvF74y4JI=;
 b=ff8SwgtIWxZPFtqsLadGhu4mtI0nERLxpNCxpKi9D7k2+TeF/luMhTQeV+PEMuZTfbsF
 6AHkMy3tEYB4pBKt3ApVHu3f+2dRXwVVbbACswLUkCrwB27m+SYV03L43aSGHoW57DnH
 heskUdFNt+yoOsj6y3NZDFOx4MKSQN2mgEskUqqWZY29etnzxyZKLEFccoC0/3GwigSs
 khfLQQ5W+zK9QM4G8KipYG7LXJ1QcvX4uwiBNi8XNgwd+3q21Zypr/+/MFoguiF1rcMH
 D5956ArTpzsqnoAFx/wSxhkVrFAq1YlsT0Izr3/rmUSiIdd9sKnf8cGkp8hb6znBhrnS 4A== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2q3vhs7ckn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jan 2019 19:10:25 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0PJAOSR022527
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jan 2019 19:10:25 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0PJAOMP028010;
        Fri, 25 Jan 2019 19:10:24 GMT
Received: from [10.159.247.181] (/10.159.247.181)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 25 Jan 2019 11:10:24 -0800
Subject: Re: [PATCH 5/5] dax: "Hotplug" persistent memory for use like normal
 RAM
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Du, Fan" <fan.du@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
From:   Jane Chu <jane.chu@oracle.com>
Organization: Oracle Corporation
Message-ID: <dc7d8190-2c94-9bdb-fb5b-a80a3fb55822@oracle.com>
Date:   Fri, 25 Jan 2019 11:10:22 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <b7d45d83a314955e7dff25401dfc0d4f4247cfcd.camel@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9147 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901250148
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/25/2019 10:20 AM, Verma, Vishal L wrote:
> 
> On Fri, 2019-01-25 at 09:18 -0800, Dan Williams wrote:
>> On Fri, Jan 25, 2019 at 12:20 AM Du, Fan <fan.du@intel.com> wrote:
>>> Dan
>>>
>>> Thanks for the insights!
>>>
>>> Can I say, the UCE is delivered from h/w to OS in a single way in
>>> case of machine
>>> check, only PMEM/DAX stuff filter out UC address and managed in its
>>> own way by
>>> badblocks, if PMEM/DAX doesn't do so, then common RAS workflow will
>>> kick in,
>>> right?
>>
>> The common RAS workflow always kicks in, it's just the page state
>> presented by a DAX mapping needs distinct handling. Once it is
>> hot-plugged it no longer needs to be treated differently than "System
>> RAM".
>>
>>> And how about when ARS is involved but no machine check fired for
>>> the function
>>> of this patchset?
>>
>> The hotplug effectively disconnects this address range from the ARS
>> results. They will still be reported in the libnvdimm "region" level
>> badblocks instance, but there's no safe / coordinated way to go clear
>> those errors without additional kernel enabling. There is no "clear
>> error" semantic for "System RAM".
>>
> Perhaps as future enabling, the kernel can go perform "clear error" for
> offlined pages, and make them usable again. But I'm not sure how
> prepared mm is to re-accept pages previously offlined.
> 

Offlining a DRAM backed page due to an UC makes sense because
  a. the physical DRAM cell might still have an error
  b. power cycle, scrubing could potentially 'repair' the DRAM cell,
making the page usable again.

But for a PMEM backed page, neither is true. If a poison bit is set in
a page, that indicates the underlying hardware has completed the repair 
work, all that's left is for software to recover.  Secondly, because 
poison is persistent, unless software explicitly clear the bit,
the page is permanently unusable.

thanks,
-jane
