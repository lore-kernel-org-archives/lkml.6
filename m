Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C51C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C5A12089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QDaOrkyr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C5A12089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbeJHXzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 19:55:21 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:59278 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbeJHXzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 19:55:21 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w98GghZY112259;
        Mon, 8 Oct 2018 11:42:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539016963;
        bh=csyuK1dVtTJndVLPbhDIUt7JxxnLSSfqmSuNSN59LKc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=QDaOrkyreCCu6HOT2GXeAF0L7IRmMufVkSEkbn3SWOZwxazvgc/6WZ6bwKZhrmxrQ
         G/qslXCZgY4U1Pvmyabvik4wFTN0lbgN5Jl3M9EvQZkiq+Yhh3bdtXk12GyVMQl2Yw
         mlBGW1g3FXb9pgZ6LxW+2DIHBZ8AhNIXvUPyBPUI=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w98GghVN021503;
        Mon, 8 Oct 2018 11:42:43 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 8 Oct
 2018 11:42:42 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 8 Oct 2018 11:42:42 -0500
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w98GggdD001524;
        Mon, 8 Oct 2018 11:42:42 -0500
Subject: Re: [PATCH 1/5] remoteproc: Fix unbalanced boot with sysfs for no
 auto-boot rprocs
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Ohad Ben-Cohen <ohad@wizery.com>,
        Loic Pallardy <loic.pallardy@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20180915003725.17549-1-s-anna@ti.com>
 <20180915003725.17549-2-s-anna@ti.com> <20181006061341.GC12063@builder>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <28c0d25e-62eb-0d6c-c479-52eb7fc6f095@ti.com>
Date:   Mon, 8 Oct 2018 11:42:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181006061341.GC12063@builder>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/2018 01:13 AM, Bjorn Andersson wrote:
> On Fri 14 Sep 17:37 PDT 2018, Suman Anna wrote:
> 
>> The remoteproc core performs automatic boot and shutdown of a
>> remote processor during rproc_add() and rproc_del() for remote
>> processors supporting 'auto-boot'. The remoteproc devices not using
>> 'auto-boot' require either a remoteproc client driver or a
>> userspace client to use the sysfs 'state' variable to perform the
>> boot and shutdown. The in-kernel client drivers hold the
>> corresponding remoteproc driver module's reference count when they
>> acquire a rproc handle through the rproc_get_by_phandle() API, but
>> there is no such support for userspace applications performing the
>> boot through sysfs interface.
>> 
>> The shutdown of a remoteproc upon removing a remoteproc platform 
>> driver is automatic only with 'auto-boot' and this can cause a 
>> remoteproc with no auto-boot to stay powered on and never freed up
>> if booted using the sysfs interface without a matching stop, and
>> when the remoteproc driver module is removed or unbound from the
>> device. This will result in a memory leak as well as the 
>> corresponding remoteproc ida being never deallocated. Fix this by
>> holding a module reference count for the remoteproc's driver during
>> a sysfs 'start' and releasing it during the sysfs 'stop' 
>> operation.
>> 
> 
> This prevents you from rmmod'ing the remoteproc driver, but it does
> not prevent you from issuing an unbind of the driver - resulting in
> the same issue.

Well, the unbind is always a problem as it ignores the module usecounts,
and that's a generic issue. I have used suppress_bind_attrs in the
relevant remoteproc drivers downstream (need to actually add that for
wkup_m3) when they are being booted by other clients, otherwise more
often than not the client drivers create a kernel crash.

> 
> I would prefer if we made sure that rproc_del() always cleaned up
> any resources (and stopped the remoteproc processor), but I'm
> uncertain of how to deal with remote processors that are supposed to
> survive Linux shutting down.

This creates unbalanced paths and we definitely do not want stop a
processor from underneath the client drivers that have booted them.
Hence this patch which creates parity with auto-booted processors and
still requested by some other clients.

regards
Suman

> 
> But I'm also uncertain how we can make the remoteproc core ensure
> that no dynamic resources are leaked in such scenario.
> 
> Regards, Bjorn
> 
>> Signed-off-by: Suman Anna <s-anna@ti.com> --- 
>> drivers/remoteproc/remoteproc_sysfs.c | 16 +++++++++++++++- 1 file
>> changed, 15 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/remoteproc/remoteproc_sysfs.c
>> b/drivers/remoteproc/remoteproc_sysfs.c index
>> 47be411400e5..2142b3ea726e 100644 ---
>> a/drivers/remoteproc/remoteproc_sysfs.c +++
>> b/drivers/remoteproc/remoteproc_sysfs.c @@ -11,6 +11,7 @@ * GNU
>> General Public License for more details. */
>> 
>> +#include <linux/module.h> #include <linux/remoteproc.h>
>> 
>> #include "remoteproc_internal.h" @@ -100,14 +101,27 @@ static
>> ssize_t state_store(struct device *dev, if (rproc->state ==
>> RPROC_RUNNING) return -EBUSY;
>> 
>> +		/* +		 * prevent underlying implementation from being removed +
>> * when remoteproc does not support auto-boot +		 */ +		if
>> (!rproc->auto_boot && +
>> !try_module_get(dev->parent->driver->owner)) +			return -EINVAL; + 
>> ret = rproc_boot(rproc); -		if (ret) +		if (ret) { 
>> dev_err(&rproc->dev, "Boot failed: %d\n", ret); +			if
>> (!rproc->auto_boot) +				module_put(dev->parent->driver->owner); +
>> } } else if (sysfs_streq(buf, "stop")) { if (rproc->state !=
>> RPROC_RUNNING) return -EINVAL;
>> 
>> rproc_shutdown(rproc); +		if (!rproc->auto_boot) +
>> module_put(dev->parent->driver->owner); } else { 
>> dev_err(&rproc->dev, "Unrecognised option: %s\n", buf); ret =
>> -EINVAL; -- 2.18.0
>> 

