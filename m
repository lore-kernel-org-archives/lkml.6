Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02493ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8539020833
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QCbqR+CB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8539020833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbeINTMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:12:50 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36188 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeINTMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:12:49 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8EDsF9H039959;
        Fri, 14 Sep 2018 13:58:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=RHbh0utafHFR9jplXtqKSgr2av9j2/vL8i5VDDDWlZI=;
 b=QCbqR+CBNIzLxpJD1iIpUs4Wk9viwX3P9xA8wesT+ZFLMjKvNoHmY6Kj7clyDp1253xV
 pNMQMX1oXYpl/n2QYRWPXcm4UkMbeFbEnANiOAV2lVrzywLwchxN7SjcEwepWPU6J960
 9bN9xs+ynj7Xiqw05E0opK693m6SuankbS+4FD+CmBcf8dFc0UXGQ4OJir3HhlICJTlP
 6lySDs7mGDYvoXRMo6hnTpzlWd46K9h4q0QuxG1kGLGzjWDdNRyFt6JcY7b57hv7rggT
 sTm3z/PXqYCp8Rqkp1NluyOquhYVNvd15qzzXYfFPYOjZFHKjJjs0zcXZR6EtclK0jJF jw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2mc5uty9da-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Sep 2018 13:58:05 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8EDw4bM007452
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Sep 2018 13:58:04 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8EDw3Gn029029;
        Fri, 14 Sep 2018 13:58:03 GMT
Received: from [10.191.8.88] (/10.191.8.88)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 14 Sep 2018 06:58:02 -0700
Subject: Re: [Xen-devel] [PATCH 1/6] xenbus: prepare data structures and
 parameter for xenwatch multithreading
To:     Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, paul.durrant@citrix.com
References: <1536910456-13337-1-git-send-email-dongli.zhang@oracle.com>
 <1536910456-13337-2-git-send-email-dongli.zhang@oracle.com>
 <23dc17b9-dc76-776b-74ef-d11f4b77552d@suse.com>
Cc:     wei.liu2@citrix.com, konrad.wilk@oracle.com,
        srinivas.eeda@oracle.com, boris.ostrovsky@oracle.com,
        roger.pau@citrix.com
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <45609402-c392-565b-042d-71179d982d61@oracle.com>
Date:   Fri, 14 Sep 2018 21:57:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <23dc17b9-dc76-776b-74ef-d11f4b77552d@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9015 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809140145
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Juergen and Paul,

On 09/14/2018 04:32 PM, Juergen Gross wrote:
> On 14/09/18 09:34, Dongli Zhang wrote:
>> This is the 1st patch of a (6-patch) patch set.
>>
>> This patch set of six patches introduces xenwatch multithreading (or
>> multithreaded xenwatch, abbreviated as 'mtwatch') to dom0 kernel. In
>> addition to the existing single xenwatch thread, each domU has its own
>> kernel thread ([xen-mtwatch-<domid>]) to process its xenwatch event.
>>
>> A kernel parameter 'xen_mtwatch' is introduced to control whether the
>> feature is enabled or not during dom0 kernel boot. The feature is disabled
>> by default if 'xen_mtwatch' is not set in grub. In addition, this patch
>> also introduces the data structures to maintain the status of each per-domU
>> xenwatch thread. The status of each xenwatch thread (except the default
>> one) is maintained by a mtwatch domain.
>>
>> The feature is available only on dom0.
>>
>> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
>> ---
>>  Documentation/admin-guide/kernel-parameters.txt |  3 ++
>>  drivers/xen/xenbus/xenbus_xs.c                  | 31 ++++++++++++
>>  include/xen/xenbus.h                            | 65 +++++++++++++++++++++++++
>>  3 files changed, 99 insertions(+)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 64a3bf5..fc295ef 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -4992,6 +4992,9 @@
>>  				the unplug protocol
>>  			never -- do not unplug even if version check succeeds
>>  
>> +	xen_mtwatch     [KNL,XEN]
>> +			Enables the multithreaded xenwatch (mtwatch).
>> +
>>  	xen_nopvspin	[X86,XEN]
>>  			Disables the ticketlock slowpath using Xen PV
>>  			optimizations.
>> diff --git a/drivers/xen/xenbus/xenbus_xs.c b/drivers/xen/xenbus/xenbus_xs.c
>> index 49a3874..3f137d2 100644
>> --- a/drivers/xen/xenbus/xenbus_xs.c
>> +++ b/drivers/xen/xenbus/xenbus_xs.c
>> @@ -95,6 +95,19 @@ static pid_t xenwatch_pid;
>>  static DEFINE_MUTEX(xenwatch_mutex);
>>  static DECLARE_WAIT_QUEUE_HEAD(watch_events_waitq);
>>  
>> +bool xen_mtwatch;
>> +EXPORT_SYMBOL_GPL(xen_mtwatch);
>> +
>> +struct mtwatch_info *mtwatch_info;
>> +
>> +static bool param_xen_mtwatch;
>> +static __init int xen_parse_mtwatch(char *arg)
>> +{
>> +	param_xen_mtwatch = true;
>> +	return 0;
>> +}
>> +early_param("xen_mtwatch", xen_parse_mtwatch);
> 
> Add a Kconfig item to set the default when building the kernel? We can
> start with default "off", but later we might want to enable this feature
> as the default.

Is there any weakness/downside configuring the param via early_param? Or is
there any strength via Kconfig?

I would prefer to not fix the configuration when building the kernel. The
administrator/user will not be able to choose the preferred option.

I would prefer to configure the option via kernel param and set default as 'off'
(false). In a common cloud environment, the administrator is only required to
enable the param in dom0/driver domain kernel.

For common domU (not using as backend), this feature is useless. I assume there
are always more domUs than dom0 (and driver domain), especially in cloud
environment.

> 
>> +
>>  static void xs_suspend_enter(void)
>>  {
>>  	spin_lock(&xs_state_lock);
>> @@ -929,6 +942,24 @@ int xs_init(void)
>>  	if (err)
>>  		return err;
>>  
>> +	if (xen_initial_domain() && param_xen_mtwatch) {
> 
> Wouldn't it be better to drop the test for xen_initial_domain() and do
> this initialization only when a caller (backend) is requesting the
> multithread mode? This would avoid wasting memory in case it isn't going
> top be used and - more important - would support driver domains.

This would save us <4KB.

Suppose the default 'param_xen_mtwatch' is 'off'. The administrator knows the
domain is used as pv backend when he/she enables the option manually.

In such scenario, is there any benefit to make it on-demand to save <4KB memory?

Thank you very much!

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
