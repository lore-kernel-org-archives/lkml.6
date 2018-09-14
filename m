Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300E2ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5C8820861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="uW56jEf6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5C8820861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbeINTso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:48:44 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38304 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbeINTso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:48:44 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8EEXYjB104798;
        Fri, 14 Sep 2018 14:33:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=np+CwPrccdU2WJ65XzX5VDQajFTxPT0dUAiahoGxGx0=;
 b=uW56jEf6TKCFf3UvXxIU+/C4JIYOandppo0JPFRrlO9HYT3QA7WUzqW0nmOjxHQfirHr
 Sj19fmRR34NwLb0JwIx9JjdFwC9D6qaS10QTlZ1SN/WwZ5VxhvwELqG0gyHvYJd9HW05
 +XGeJ+nbaNIwIlpfVlVo5YXyERvDzEXL1FJOqmWarC5wMxunFvkDvdUfloI2b0uU9lIq
 iRMI2S7BhmrMjVJEfzDQ2eUAYmL/8uNBrfjFJZA2q6i7UgkPJQjyeGv7SAaC7T2qR1f2
 SB4DuDE0c9sQnyZNgnzIKtISnf8dhK/gcfpOvPv1XP1Oa9Fz7KdK8tA/vPC6U7NJ+oqD Qw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2mc6cq7fk4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Sep 2018 14:33:51 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8EEXj6x009497
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Sep 2018 14:33:46 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8EEXjnU008053;
        Fri, 14 Sep 2018 14:33:45 GMT
Received: from [10.191.8.88] (/10.191.8.88)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 14 Sep 2018 07:33:44 -0700
Subject: Re: [Xen-devel] [PATCH 5/6] xenbus: process be_watch events in
 xenwatch multithreading
To:     Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
References: <1536910456-13337-1-git-send-email-dongli.zhang@oracle.com>
 <1536910456-13337-6-git-send-email-dongli.zhang@oracle.com>
 <8d6457cf-a105-3d88-bd38-d46b24f70501@suse.com>
Cc:     wei.liu2@citrix.com, konrad.wilk@oracle.com,
        srinivas.eeda@oracle.com, paul.durrant@citrix.com,
        boris.ostrovsky@oracle.com, roger.pau@citrix.com
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <4ff0a18e-1971-0758-d59c-bc5096c6961a@oracle.com>
Date:   Fri, 14 Sep 2018 22:33:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <8d6457cf-a105-3d88-bd38-d46b24f70501@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9015 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809140151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Juergen,

On 09/14/2018 05:12 PM, Juergen Gross wrote:
> On 14/09/18 09:34, Dongli Zhang wrote:
>> This is the 5th patch of a (6-patch) patch set.
>>
>> With this patch, watch event in relative path pattern
>> 'backend/<pvdev>/<domid>i/...' can be processed in per-domU xenwatch
> 
> superfluous "i" ----------^
> 
>> thread.
>>
>> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
>> ---
>>  drivers/xen/xenbus/xenbus_probe.c         |  2 +-
>>  drivers/xen/xenbus/xenbus_probe_backend.c | 32 +++++++++++++++++++++++++++++++
>>  include/xen/xenbus.h                      |  2 ++
>>  3 files changed, 35 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
>> index ba0644c..aa1b15a 100644
>> --- a/drivers/xen/xenbus/xenbus_probe.c
>> +++ b/drivers/xen/xenbus/xenbus_probe.c
>> @@ -552,7 +552,7 @@ int xenbus_probe_devices(struct xen_bus_type *bus)
>>  }
>>  EXPORT_SYMBOL_GPL(xenbus_probe_devices);
>>  
>> -static unsigned int char_count(const char *str, char c)
>> +unsigned int char_count(const char *str, char c)
> 
> Please change the name of the function when making it globally
> visible, e.g. by prefixing "xenbus_".
> 
> Generally I think you don't need to use it below.
> 
>>  {
>>  	unsigned int i, ret = 0;
>>  
>> diff --git a/drivers/xen/xenbus/xenbus_probe_backend.c b/drivers/xen/xenbus/xenbus_probe_backend.c
>> index b0bed4f..50df86a 100644
>> --- a/drivers/xen/xenbus/xenbus_probe_backend.c
>> +++ b/drivers/xen/xenbus/xenbus_probe_backend.c
>> @@ -211,9 +211,41 @@ static void backend_changed(struct xenbus_watch *watch,
>>  	xenbus_dev_changed(path, &xenbus_backend);
>>  }
>>  
>> +static domid_t path_to_domid(const char *path)
>> +{
>> +	const char *p = path;
>> +	domid_t domid = 0;
>> +
>> +	while (*p) {
>> +		if (*p < '0' || *p > '9')
>> +			break;
>> +		domid = (domid << 3) + (domid << 1) + (*p - '0');
> 
> reinventing atoi()?
> 
> Please don't do that. kstrtou16() seems to be a perfect fit.
> 
>> +		p++;
>> +	}
>> +
>> +	return domid;
>> +}
>> +
>> +/* path: backend/<pvdev>/<domid>/... */
>> +static domid_t be_get_domid(struct xenbus_watch *watch,
>> +			    const char *path,
>> +			    const char *token)
>> +{
>> +	const char *p = path;
>> +
>> +	if (char_count(path, '/') < 2)
>> +		return 0;
>> +
>> +	p = strchr(p, '/') + 1;
>> +	p = strchr(p, '/') + 1;
> 
> Drop the call of char_count() above and test p for being non-NULL
> after each call of strchr?

The usage of char_count() is copied from xenbus_dev_changed() which is used to
process pattern 'backend/<type>/...'.

I use char_count() just because I would prefer we always use the same
equation/algorithm to process xenstore path in linux kernel.

I can drop it if it is better to not change char_count() from static to global
function.

556 void xenbus_dev_changed(const char *node, struct xen_bus_type *bus)
557 {
558         int exists, rootlen;
559         struct xenbus_device *dev;
560         char type[XEN_BUS_ID_SIZE];
561         const char *p, *root;
562
563         if (char_count(node, '/') < 2)
564                 return;
565
566         exists = xenbus_exists(XBT_NIL, node, "");
567         if (!exists) {
568                 xenbus_cleanup_devices(node, &bus->bus);
569                 return;
570         }
571
572         /* backend/<type>/... or device/<type>/... */
573         p = strchr(node, '/') + 1;
574         snprintf(type, XEN_BUS_ID_SIZE, "%.*s", (int)strcspn(p, "/"), p);
575         type[XEN_BUS_ID_SIZE-1] = '\0';

Dongli Zhang

> 
> 
> Juergen
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xenproject.org
> https://lists.xenproject.org/mailman/listinfo/xen-devel
> 
