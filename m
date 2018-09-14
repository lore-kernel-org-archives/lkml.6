Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157CEECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7C28206B5
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:26:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7C28206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbeINTlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:41:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:47116 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726908AbeINTlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:41:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9F656AD81;
        Fri, 14 Sep 2018 14:26:39 +0000 (UTC)
Subject: Re: [Xen-devel] [PATCH 5/6] xenbus: process be_watch events in
 xenwatch multithreading
To:     Dongli Zhang <dongli.zhang@oracle.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     wei.liu2@citrix.com, konrad.wilk@oracle.com,
        srinivas.eeda@oracle.com, paul.durrant@citrix.com,
        boris.ostrovsky@oracle.com, roger.pau@citrix.com
References: <1536910456-13337-1-git-send-email-dongli.zhang@oracle.com>
 <1536910456-13337-6-git-send-email-dongli.zhang@oracle.com>
 <8d6457cf-a105-3d88-bd38-d46b24f70501@suse.com>
 <8f4c7508-1e8f-9d7e-1327-f537917845f4@oracle.com>
From:   Juergen Gross <jgross@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jgross@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <d5c6f15b-500d-91fd-1201-9fa552bc77cc@suse.com>
Date:   Fri, 14 Sep 2018 16:26:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <8f4c7508-1e8f-9d7e-1327-f537917845f4@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/18 16:18, Dongli Zhang wrote:
> Hi Juergen,
> 
> On 09/14/2018 05:12 PM, Juergen Gross wrote:
>> On 14/09/18 09:34, Dongli Zhang wrote:
>>> This is the 5th patch of a (6-patch) patch set.
>>>
>>> With this patch, watch event in relative path pattern
>>> 'backend/<pvdev>/<domid>i/...' can be processed in per-domU xenwatch
>>
>> superfluous "i" ----------^
>>
>>> thread.
>>>
>>> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
>>> ---
>>>  drivers/xen/xenbus/xenbus_probe.c         |  2 +-
>>>  drivers/xen/xenbus/xenbus_probe_backend.c | 32 +++++++++++++++++++++++++++++++
>>>  include/xen/xenbus.h                      |  2 ++
>>>  3 files changed, 35 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
>>> index ba0644c..aa1b15a 100644
>>> --- a/drivers/xen/xenbus/xenbus_probe.c
>>> +++ b/drivers/xen/xenbus/xenbus_probe.c
>>> @@ -552,7 +552,7 @@ int xenbus_probe_devices(struct xen_bus_type *bus)
>>>  }
>>>  EXPORT_SYMBOL_GPL(xenbus_probe_devices);
>>>  
>>> -static unsigned int char_count(const char *str, char c)
>>> +unsigned int char_count(const char *str, char c)
>>
>> Please change the name of the function when making it globally
>> visible, e.g. by prefixing "xenbus_".
>>
>> Generally I think you don't need to use it below.
>>
>>>  {
>>>  	unsigned int i, ret = 0;
>>>  
>>> diff --git a/drivers/xen/xenbus/xenbus_probe_backend.c b/drivers/xen/xenbus/xenbus_probe_backend.c
>>> index b0bed4f..50df86a 100644
>>> --- a/drivers/xen/xenbus/xenbus_probe_backend.c
>>> +++ b/drivers/xen/xenbus/xenbus_probe_backend.c
>>> @@ -211,9 +211,41 @@ static void backend_changed(struct xenbus_watch *watch,
>>>  	xenbus_dev_changed(path, &xenbus_backend);
>>>  }
>>>  
>>> +static domid_t path_to_domid(const char *path)
>>> +{
>>> +	const char *p = path;
>>> +	domid_t domid = 0;
>>> +
>>> +	while (*p) {
>>> +		if (*p < '0' || *p > '9')
>>> +			break;
>>> +		domid = (domid << 3) + (domid << 1) + (*p - '0');
>>
>> reinventing atoi()?
>>
>> Please don't do that. kstrtou16() seems to be a perfect fit.
> 
> I did use kstrtou*() in the early prototype and realized kstrtou16() returns 0
> if the input string contains non-numerical characters.
> 
> E.g., the example of input can be "1/0/state", where 1 is fotherend_id
> (frontend_id) and 0 is handle.
> 
> When "1/0/state" is used at input, kstrtou16() returns 0 (returned integer) and
> -22 (error).

Aah, okay. Then simple_strtoul()?


Juergen
