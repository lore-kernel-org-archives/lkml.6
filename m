Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB472FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 641A820861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IiZTsxnY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 641A820861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbeINTpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:45:07 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51486 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbeINTpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:45:06 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8EESr6T078921;
        Fri, 14 Sep 2018 14:30:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=dgIhLD1bEWyN0FGIH0tfiTd5A9jNgGa4X0x8xDLkBII=;
 b=IiZTsxnY4v0FtnOmFr+fsdJ7A6XPTXkAd7iBy79XLJhzLsGMHwhgi4Q7KIyCZ2NM+Hmr
 f3xiNosEyIZN9h+IlSQk5aFf6BGUUcUxrbj1f7DUJMQN6R9mMDWbfa/g84v0wtQj8gOA
 xAT9qD63w0/oHpr+ePZAaSk0B0rJXzqJXMw8hG09+6ukxmVwiWEbFoANWbDsYFMLWhW1
 svv91eemjtXgW6T1brW+5sQa9XkJAs+gayMkRMna6C3bpOnH4inOvtjw+bZ1E4A8QiCa
 NzmLrnplk4007RoJbrIdH1GAPOgDAfQnST6XhJbBx0qOgHqdk3vLiPQOxxknUl109fzh oA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2mc5utyf23-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Sep 2018 14:30:14 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8EEU8XW028517
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Sep 2018 14:30:08 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8EEU8Vq031260;
        Fri, 14 Sep 2018 14:30:08 GMT
Received: from [10.191.8.88] (/10.191.8.88)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 14 Sep 2018 07:30:08 -0700
Subject: Re: [Xen-devel] [PATCH 5/6] xenbus: process be_watch events in
 xenwatch multithreading
To:     Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
References: <1536910456-13337-1-git-send-email-dongli.zhang@oracle.com>
 <1536910456-13337-6-git-send-email-dongli.zhang@oracle.com>
 <8d6457cf-a105-3d88-bd38-d46b24f70501@suse.com>
 <8f4c7508-1e8f-9d7e-1327-f537917845f4@oracle.com>
 <d5c6f15b-500d-91fd-1201-9fa552bc77cc@suse.com>
Cc:     wei.liu2@citrix.com, konrad.wilk@oracle.com,
        srinivas.eeda@oracle.com, paul.durrant@citrix.com,
        boris.ostrovsky@oracle.com, roger.pau@citrix.com
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <0753b7b8-31a6-22f5-479a-2760fea0149c@oracle.com>
Date:   Fri, 14 Sep 2018 22:29:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <d5c6f15b-500d-91fd-1201-9fa552bc77cc@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9015 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809140150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Juergen,

On 09/14/2018 10:26 PM, Juergen Gross wrote:
> On 14/09/18 16:18, Dongli Zhang wrote:
>> Hi Juergen,
>>
>> On 09/14/2018 05:12 PM, Juergen Gross wrote:
>>> On 14/09/18 09:34, Dongli Zhang wrote:
>>>> This is the 5th patch of a (6-patch) patch set.
>>>>
>>>> With this patch, watch event in relative path pattern
>>>> 'backend/<pvdev>/<domid>i/...' can be processed in per-domU xenwatch
>>>
>>> superfluous "i" ----------^
>>>
>>>> thread.
>>>>
>>>> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
>>>> ---
>>>>  drivers/xen/xenbus/xenbus_probe.c         |  2 +-
>>>>  drivers/xen/xenbus/xenbus_probe_backend.c | 32 +++++++++++++++++++++++++++++++
>>>>  include/xen/xenbus.h                      |  2 ++
>>>>  3 files changed, 35 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
>>>> index ba0644c..aa1b15a 100644
>>>> --- a/drivers/xen/xenbus/xenbus_probe.c
>>>> +++ b/drivers/xen/xenbus/xenbus_probe.c
>>>> @@ -552,7 +552,7 @@ int xenbus_probe_devices(struct xen_bus_type *bus)
>>>>  }
>>>>  EXPORT_SYMBOL_GPL(xenbus_probe_devices);
>>>>  
>>>> -static unsigned int char_count(const char *str, char c)
>>>> +unsigned int char_count(const char *str, char c)
>>>
>>> Please change the name of the function when making it globally
>>> visible, e.g. by prefixing "xenbus_".
>>>
>>> Generally I think you don't need to use it below.
>>>
>>>>  {
>>>>  	unsigned int i, ret = 0;
>>>>  
>>>> diff --git a/drivers/xen/xenbus/xenbus_probe_backend.c b/drivers/xen/xenbus/xenbus_probe_backend.c
>>>> index b0bed4f..50df86a 100644
>>>> --- a/drivers/xen/xenbus/xenbus_probe_backend.c
>>>> +++ b/drivers/xen/xenbus/xenbus_probe_backend.c
>>>> @@ -211,9 +211,41 @@ static void backend_changed(struct xenbus_watch *watch,
>>>>  	xenbus_dev_changed(path, &xenbus_backend);
>>>>  }
>>>>  
>>>> +static domid_t path_to_domid(const char *path)
>>>> +{
>>>> +	const char *p = path;
>>>> +	domid_t domid = 0;
>>>> +
>>>> +	while (*p) {
>>>> +		if (*p < '0' || *p > '9')
>>>> +			break;
>>>> +		domid = (domid << 3) + (domid << 1) + (*p - '0');
>>>
>>> reinventing atoi()?
>>>
>>> Please don't do that. kstrtou16() seems to be a perfect fit.
>>
>> I did use kstrtou*() in the early prototype and realized kstrtou16() returns 0
>> if the input string contains non-numerical characters.
>>
>> E.g., the example of input can be "1/0/state", where 1 is fotherend_id
>> (frontend_id) and 0 is handle.
>>
>> When "1/0/state" is used at input, kstrtou16() returns 0 (returned integer) and
>> -22 (error).
> 
> Aah, okay. Then simple_strtoul()?

I did consider simple_strtoul() initially. Unfortunately, it is obsolete (below
line 81). AFAIR, the patch would not be able to pass the check_patch script when
this function is used.

  75 /**
  76  * simple_strtoul - convert a string to an unsigned long
  77  * @cp: The start of the string
  78  * @endp: A pointer to the end of the parsed string will be placed here
  79  * @base: The number base to use
  80  *
  81  * This function is obsolete. Please use kstrtoul instead.
  82  */
  83 unsigned long simple_strtoul(const char *cp, char **endp, unsigned int base)
  84 {
  85         return simple_strtoull(cp, endp, base);
  86 }

Dongli Zhang

> 
> 
> Juergen
> 
