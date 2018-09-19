Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5BAECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B379D21508
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aTKfOGSm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B379D21508
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731006AbeISLvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 07:51:39 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49918 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730605AbeISLvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 07:51:39 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8J6EJbP162431;
        Wed, 19 Sep 2018 06:15:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=6mK7RUjJlkmB1iasE55LKV9liI7vpNSBZ+hky3p6Ngg=;
 b=aTKfOGSmzau3vP4Jt7xk+IXi/R0ezqtgVqbyg3k04liSIBRsbN9oi+e5WNSiFmcYr/c/
 5Y8egwyThxJLlF6EM4Mv4NgQxui2XN2GxJ9t/HF/rsBr5xa4w8GVJc8GU5XLyhAiW9HS
 yFAto6NCKyKzoO0H84vV7oRWEGbFqI9oeHL7rUi3P3B7Ozy1swcrLaYwHaPX34oASuOV
 C7mdmjRY0LktKPB15EsNVpqwq63iExZlcWiTHLQgazHPVByL+jX/74AVVUIITZNBtCxr
 KJkAw4+XvRtEnTgK4BpJwWwe74dtDPohupXThI4MPVeBacg2TEh1Tdzx4lHOohmrJpNP 2A== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2mgsgtrwtj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Sep 2018 06:15:09 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8J6F81L029980
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Sep 2018 06:15:09 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8J6F8wb016932;
        Wed, 19 Sep 2018 06:15:08 GMT
Received: from [10.182.70.168] (/10.182.70.168)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Sep 2018 23:15:08 -0700
Subject: Re: [Xen-devel] [PATCH 5/6] xenbus: process be_watch events in
 xenwatch multithreading
To:     Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
References: <1536910456-13337-1-git-send-email-dongli.zhang@oracle.com>
 <1536910456-13337-6-git-send-email-dongli.zhang@oracle.com>
 <8d6457cf-a105-3d88-bd38-d46b24f70501@suse.com>
 <8f4c7508-1e8f-9d7e-1327-f537917845f4@oracle.com>
 <d5c6f15b-500d-91fd-1201-9fa552bc77cc@suse.com>
 <0753b7b8-31a6-22f5-479a-2760fea0149c@oracle.com>
 <62194cbd-be25-fc2e-f115-5111888d7bc6@suse.com>
Cc:     wei.liu2@citrix.com, konrad.wilk@oracle.com,
        srinivas.eeda@oracle.com, paul.durrant@citrix.com,
        boris.ostrovsky@oracle.com, roger.pau@citrix.com
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <7fec0ad1-84e5-f490-d196-623a8b3685ac@oracle.com>
Date:   Wed, 19 Sep 2018 14:15:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <62194cbd-be25-fc2e-f115-5111888d7bc6@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9020 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809190065
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Juergen,

On 09/14/2018 10:44 PM, Juergen Gross wrote:
> On 14/09/18 16:29, Dongli Zhang wrote:
>> Hi Juergen,
>>
>> On 09/14/2018 10:26 PM, Juergen Gross wrote:
>>> On 14/09/18 16:18, Dongli Zhang wrote:
>>>> Hi Juergen,
>>>>
>>>> On 09/14/2018 05:12 PM, Juergen Gross wrote:
>>>>> On 14/09/18 09:34, Dongli Zhang wrote:
>>>>>> This is the 5th patch of a (6-patch) patch set.
>>>>>>
>>>>>> With this patch, watch event in relative path pattern
>>>>>> 'backend/<pvdev>/<domid>i/...' can be processed in per-domU xenwatch
>>>>>
>>>>> superfluous "i" ----------^
>>>>>
>>>>>> thread.
>>>>>>
>>>>>> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
>>>>>> ---
>>>>>>  drivers/xen/xenbus/xenbus_probe.c         |  2 +-
>>>>>>  drivers/xen/xenbus/xenbus_probe_backend.c | 32 +++++++++++++++++++++++++++++++
>>>>>>  include/xen/xenbus.h                      |  2 ++
>>>>>>  3 files changed, 35 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
>>>>>> index ba0644c..aa1b15a 100644
>>>>>> --- a/drivers/xen/xenbus/xenbus_probe.c
>>>>>> +++ b/drivers/xen/xenbus/xenbus_probe.c
>>>>>> @@ -552,7 +552,7 @@ int xenbus_probe_devices(struct xen_bus_type *bus)
>>>>>>  }
>>>>>>  EXPORT_SYMBOL_GPL(xenbus_probe_devices);
>>>>>>  
>>>>>> -static unsigned int char_count(const char *str, char c)
>>>>>> +unsigned int char_count(const char *str, char c)
>>>>>
>>>>> Please change the name of the function when making it globally
>>>>> visible, e.g. by prefixing "xenbus_".
>>>>>
>>>>> Generally I think you don't need to use it below.
>>>>>
>>>>>>  {
>>>>>>  	unsigned int i, ret = 0;
>>>>>>  
>>>>>> diff --git a/drivers/xen/xenbus/xenbus_probe_backend.c b/drivers/xen/xenbus/xenbus_probe_backend.c
>>>>>> index b0bed4f..50df86a 100644
>>>>>> --- a/drivers/xen/xenbus/xenbus_probe_backend.c
>>>>>> +++ b/drivers/xen/xenbus/xenbus_probe_backend.c
>>>>>> @@ -211,9 +211,41 @@ static void backend_changed(struct xenbus_watch *watch,
>>>>>>  	xenbus_dev_changed(path, &xenbus_backend);
>>>>>>  }
>>>>>>  
>>>>>> +static domid_t path_to_domid(const char *path)
>>>>>> +{
>>>>>> +	const char *p = path;
>>>>>> +	domid_t domid = 0;
>>>>>> +
>>>>>> +	while (*p) {
>>>>>> +		if (*p < '0' || *p > '9')
>>>>>> +			break;
>>>>>> +		domid = (domid << 3) + (domid << 1) + (*p - '0');
>>>>>
>>>>> reinventing atoi()?
>>>>>
>>>>> Please don't do that. kstrtou16() seems to be a perfect fit.
>>>>
>>>> I did use kstrtou*() in the early prototype and realized kstrtou16() returns 0
>>>> if the input string contains non-numerical characters.
>>>>
>>>> E.g., the example of input can be "1/0/state", where 1 is fotherend_id
>>>> (frontend_id) and 0 is handle.
>>>>
>>>> When "1/0/state" is used at input, kstrtou16() returns 0 (returned integer) and
>>>> -22 (error).
>>>
>>> Aah, okay. Then simple_strtoul()?
>>
>> I did consider simple_strtoul() initially. Unfortunately, it is obsolete (below
>> line 81). AFAIR, the patch would not be able to pass the check_patch script when
>> this function is used.
> 
> Better use that than open coding a new instance of it.
> 
> Another variant would be to use sscanf() or similar. Then you could even
> drop using strchr() by adding that in the format string:
> 
> return (sscanf(path, "%*u/%u/", &domid) == 1) ? domid : DOMID_SELF;

I recall what was happened.

Suppose one sample of path is "backend/vif/19/3/state". (we would like to obtain
domid=19)

Initially I would like to use sscanf(path, "backend/%*[a-z]/%hu/%*u") to obtain
the domid from xenstore path in one call.

Unfortunately, unlike userspace sscanf(), the version in linux kernel does not
support '[' so that I would not be able to use "%*[a-z]" in sscanf() in linux
kernel.

Finally, I decided to skip 2 '/' to reach at "19/3/state" and I forgot to
continue using sscanf and implemented my own one :(

With sscanf, I think I still need to skip 2 '/' to skip "backend/<pv device>" in
order to reach at "<domid>/xxxxxxx...":

1. return if the number of '/' in the path is less than 2

2. skip 2 '/' (e.g., backend/vif/)

3. process the rest of patch via sscanf.

Dongli Zhang


