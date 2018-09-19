Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DE6C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7F932150B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pJIgr1y8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7F932150B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731587AbeISSFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 14:05:24 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59866 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731330AbeISSFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 14:05:24 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8JCNh96042414;
        Wed, 19 Sep 2018 12:27:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=b7Nve3cQvXQGYHIKXnPfb38dxbUvAdOBzvTfBTbJJGg=;
 b=pJIgr1y8aIojrIcxr1zUuXL93U0U5/JMtDSJ1K7j1Exmd8qY+EkvvuaghfUOUDhG03kb
 lmVYIa2PlCTZF9f7gFvXcCD4+1hr4yr+knqR2+3gyT2labr9TOBYLpnDmHoIeRKdcfxx
 ggJhaS1lVc8P2YG0GWQ/NSOIkEHlA8FLMRmZkD/mwmtaM9sriuQTT0o4j84sFiIrR3pl
 jBLcJyeq9HZ9moaPJyNLC9CYE/BAYm7vYuF4d/5jWIdjKcS4SCLvJs//Zes4+q1fcd4B
 kS9GptMguZ4VYz9vhRLMImCpB9+iv0mz4Wss5sN2dIJxYy+5tEPK+KBa67gk19ZdBorY GA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2mgtqr2j9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Sep 2018 12:27:34 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8JCRXb9023488
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Sep 2018 12:27:33 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8JCRWvp030611;
        Wed, 19 Sep 2018 12:27:32 GMT
Received: from [192.168.2.8] (/106.120.63.17)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 19 Sep 2018 05:27:32 -0700
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
 <7fec0ad1-84e5-f490-d196-623a8b3685ac@oracle.com>
 <91cfb61b-5413-2811-771b-b3860f626010@suse.com>
Cc:     wei.liu2@citrix.com, konrad.wilk@oracle.com,
        srinivas.eeda@oracle.com, paul.durrant@citrix.com,
        boris.ostrovsky@oracle.com, roger.pau@citrix.com
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <a85d7634-b62b-7ac9-8ce9-c548b02afb1e@oracle.com>
Date:   Wed, 19 Sep 2018 20:27:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <91cfb61b-5413-2811-771b-b3860f626010@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9020 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809190125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Juergen,

On 09/19/2018 04:01 PM, Juergen Gross wrote:
> On 19/09/18 08:15, Dongli Zhang wrote:
>> Hi Juergen,
>>
>> On 09/14/2018 10:44 PM, Juergen Gross wrote:
>>> On 14/09/18 16:29, Dongli Zhang wrote:
>>>> Hi Juergen,
>>>>
>>>> On 09/14/2018 10:26 PM, Juergen Gross wrote:
>>>>> On 14/09/18 16:18, Dongli Zhang wrote:
>>>>>> Hi Juergen,
>>>>>>
>>>>>> On 09/14/2018 05:12 PM, Juergen Gross wrote:
>>>>>>> On 14/09/18 09:34, Dongli Zhang wrote:
>>>>>>>> This is the 5th patch of a (6-patch) patch set.
>>>>>>>>
>>>>>>>> With this patch, watch event in relative path pattern
>>>>>>>> 'backend/<pvdev>/<domid>i/...' can be processed in per-domU xenwatch
>>>>>>>
>>>>>>> superfluous "i" ----------^
>>>>>>>
>>>>>>>> thread.
>>>>>>>>
>>>>>>>> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
>>>>>>>> ---
>>>>>>>>  drivers/xen/xenbus/xenbus_probe.c         |  2 +-
>>>>>>>>  drivers/xen/xenbus/xenbus_probe_backend.c | 32 +++++++++++++++++++++++++++++++
>>>>>>>>  include/xen/xenbus.h                      |  2 ++
>>>>>>>>  3 files changed, 35 insertions(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
>>>>>>>> index ba0644c..aa1b15a 100644
>>>>>>>> --- a/drivers/xen/xenbus/xenbus_probe.c
>>>>>>>> +++ b/drivers/xen/xenbus/xenbus_probe.c
>>>>>>>> @@ -552,7 +552,7 @@ int xenbus_probe_devices(struct xen_bus_type *bus)
>>>>>>>>  }
>>>>>>>>  EXPORT_SYMBOL_GPL(xenbus_probe_devices);
>>>>>>>>  
>>>>>>>> -static unsigned int char_count(const char *str, char c)
>>>>>>>> +unsigned int char_count(const char *str, char c)
>>>>>>>
>>>>>>> Please change the name of the function when making it globally
>>>>>>> visible, e.g. by prefixing "xenbus_".
>>>>>>>
>>>>>>> Generally I think you don't need to use it below.
>>>>>>>
>>>>>>>>  {
>>>>>>>>  	unsigned int i, ret = 0;
>>>>>>>>  
>>>>>>>> diff --git a/drivers/xen/xenbus/xenbus_probe_backend.c b/drivers/xen/xenbus/xenbus_probe_backend.c
>>>>>>>> index b0bed4f..50df86a 100644
>>>>>>>> --- a/drivers/xen/xenbus/xenbus_probe_backend.c
>>>>>>>> +++ b/drivers/xen/xenbus/xenbus_probe_backend.c
>>>>>>>> @@ -211,9 +211,41 @@ static void backend_changed(struct xenbus_watch *watch,
>>>>>>>>  	xenbus_dev_changed(path, &xenbus_backend);
>>>>>>>>  }
>>>>>>>>  
>>>>>>>> +static domid_t path_to_domid(const char *path)
>>>>>>>> +{
>>>>>>>> +	const char *p = path;
>>>>>>>> +	domid_t domid = 0;
>>>>>>>> +
>>>>>>>> +	while (*p) {
>>>>>>>> +		if (*p < '0' || *p > '9')
>>>>>>>> +			break;
>>>>>>>> +		domid = (domid << 3) + (domid << 1) + (*p - '0');
>>>>>>>
>>>>>>> reinventing atoi()?
>>>>>>>
>>>>>>> Please don't do that. kstrtou16() seems to be a perfect fit.
>>>>>>
>>>>>> I did use kstrtou*() in the early prototype and realized kstrtou16() returns 0
>>>>>> if the input string contains non-numerical characters.
>>>>>>
>>>>>> E.g., the example of input can be "1/0/state", where 1 is fotherend_id
>>>>>> (frontend_id) and 0 is handle.
>>>>>>
>>>>>> When "1/0/state" is used at input, kstrtou16() returns 0 (returned integer) and
>>>>>> -22 (error).
>>>>>
>>>>> Aah, okay. Then simple_strtoul()?
>>>>
>>>> I did consider simple_strtoul() initially. Unfortunately, it is obsolete (below
>>>> line 81). AFAIR, the patch would not be able to pass the check_patch script when
>>>> this function is used.
>>>
>>> Better use that than open coding a new instance of it.
>>>
>>> Another variant would be to use sscanf() or similar. Then you could even
>>> drop using strchr() by adding that in the format string:
>>>
>>> return (sscanf(path, "%*u/%u/", &domid) == 1) ? domid : DOMID_SELF;
>>
>> I recall what was happened.
>>
>> Suppose one sample of path is "backend/vif/19/3/state". (we would like to obtain
>> domid=19)
>>
>> Initially I would like to use sscanf(path, "backend/%*[a-z]/%hu/%*u") to obtain
>> the domid from xenstore path in one call.
>>
>> Unfortunately, unlike userspace sscanf(), the version in linux kernel does not
>> support '[' so that I would not be able to use "%*[a-z]" in sscanf() in linux
>> kernel.
> 
> That is not correct. It doesn't support ranges in [], but it is
> perfectly fine to use %[^/]. This requires a temporary buffer, as
> %*[ isn't supported.
> 
> Why don't you use:
> 
> char temp[16];
> 
> ...
> 
> /* kernel sscanf() %[] doesn't support '*' modifier and needs length. */
> sscanf(path, "backend/%15[^/]%hu/%*u", temp, &domid)
> 

One '\' between "%15[^/]" and "%hu" is missing.

We should use "backend/%15[^/]/%hu/%*u" instead.

Seems this is supported since commit f9310b2f9a19b7f16c7b1c1558f8b649b9b933c1.
Only tag since 4.6 support this feature.

I should avoid using old ubuntu 4.4.0 kernel to test such features the next time :(

Thank you very much for your help!

As the "devicetype[32]" in struct xenbus_device_id is of size 32, should I use
temp[32] instead of temp[16]?

Dongli Zhang
