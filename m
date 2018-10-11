Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED28C28CF8
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 22:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D6E420841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 22:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IguQ+SaA";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VeGCENUB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D6E420841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbeJLFh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 01:37:59 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55348 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbeJLFh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 01:37:59 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 48DE760BF7; Thu, 11 Oct 2018 22:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539295724;
        bh=NP4b1dFqLGYwYskeiFShVHHOKL4KBjc24f/1M92ZCYU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IguQ+SaA57iQrppe2FKFCeerkQ51ch0w/n2HmsHbLLJusrCY9t+jxqlnP6eHW7Rct
         Zh/AN3S6dLa3VNLJeSWj25jlhcpWFSvNETl5uSWvJp58JRmtkDcnj+P50/wT8kNpWO
         fA2K/o0+3hoy/gCS8cSnKrmmL/aPHIH7TewGQGdQ=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 17C0B60A98;
        Thu, 11 Oct 2018 22:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539295723;
        bh=NP4b1dFqLGYwYskeiFShVHHOKL4KBjc24f/1M92ZCYU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VeGCENUBn1VmhwvLz0Gn3iKhk0k6TxKn2a0u41SEMDJu88Uy82XvYxYODY64k2rnb
         y17cr7oPWWoA4htTbkQV8a7hIqYN0ayW4QxzsuY4R+cjqdB2w+3gq3cF+UFDzHoEcB
         OsCUOD+MWnjL6wyPw+fPv/1ljN+430Spy2EM7vgs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 17C0B60A98
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Thu, 11 Oct 2018 16:08:42 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>, andy.gross@linaro.org,
        david.brown@linaro.org, ulf.hansson@linaro.org, khilman@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org,
        dianders@chromium.org, mka@chromium.org
Subject: Re: [PATCH RFC v1 2/8] kernel/cpu_pm: Manage runtime PM in the idle
 path for CPUs
Message-ID: <20181011220842.GE2371@codeaurora.org>
References: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
 <1539206455-29342-3-git-send-email-rplsssn@codeaurora.org>
 <8161939.SRDo8Qx48D@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <8161939.SRDo8Qx48D@aspire.rjw.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11 2018 at 14:56 -0600, Rafael J. Wysocki wrote:
>On Wednesday, October 10, 2018 11:20:49 PM CEST Raju P.L.S.S.S.N wrote:
>> From: Ulf Hansson <ulf.hansson@linaro.org>
>>
>> To allow CPUs being power managed by PM domains, let's deploy support for
>> runtime PM for the CPU's corresponding struct device.
>>
>> More precisely, at the point when the CPU is about to enter an idle state,
>> decrease the runtime PM usage count for its corresponding struct device,
>> via calling pm_runtime_put_sync_suspend(). Then, at the point when the CPU
>> resumes from idle, let's increase the runtime PM usage count, via calling
>> pm_runtime_get_sync().
>>
>> Cc: Lina Iyer <ilina@codeaurora.org>
>> Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
>> (am from https://patchwork.kernel.org/patch/10478153/)
>> ---
>>  kernel/cpu_pm.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/kernel/cpu_pm.c b/kernel/cpu_pm.c
>> index 67b02e1..492d4a8 100644
>> --- a/kernel/cpu_pm.c
>> +++ b/kernel/cpu_pm.c
>> @@ -16,9 +16,11 @@
>>   */
>>
>>  #include <linux/kernel.h>
>> +#include <linux/cpu.h>
>>  #include <linux/cpu_pm.h>
>>  #include <linux/module.h>
>>  #include <linux/notifier.h>
>> +#include <linux/pm_runtime.h>
>>  #include <linux/spinlock.h>
>>  #include <linux/syscore_ops.h>
>>
>> @@ -91,6 +93,7 @@ int cpu_pm_enter(void)
>>  {
>>  	int nr_calls;
>>  	int ret = 0;
>> +	struct device *dev = get_cpu_device(smp_processor_id());
>>
>>  	ret = cpu_pm_notify(CPU_PM_ENTER, -1, &nr_calls);
>>  	if (ret)
>> @@ -100,6 +103,9 @@ int cpu_pm_enter(void)
>>  		 */
>>  		cpu_pm_notify(CPU_PM_ENTER_FAILED, nr_calls - 1, NULL);
>>
>> +	if (!ret && dev && dev->pm_domain)
>> +		pm_runtime_put_sync_suspend(dev);
>
>This may cause a power domain to go off, but if it goes off, then the idle
>governor has already selected idle states for all of the CPUs in that domain.
>
>Is there any way to ensure that turning the domain off (and later on) will
>no cause the target residency and exit latency expectations for those idle
>states to be exceeded?
>
Good point.

The cluster states should account for that additional latency. Just the
CPU's power down states need not care about that.

But, it would be nice if the PM domain governor could be cognizant of
the idle state chosen for each CPU, that way we dont configure the
domain to be powered off when the CPUs have just chosen to power down
(not chosen a cluster state). I think that is a whole different topic to
discuss.

-- Lina

>> +
>>  	return ret;
>>  }
>>  EXPORT_SYMBOL_GPL(cpu_pm_enter);
>> @@ -118,6 +124,11 @@ int cpu_pm_enter(void)
>>   */
>>  int cpu_pm_exit(void)
>>  {
>> +	struct device *dev = get_cpu_device(smp_processor_id());
>> +
>> +	if (dev && dev->pm_domain)
>> +		pm_runtime_get_sync(dev);
>> +
>>  	return cpu_pm_notify(CPU_PM_EXIT, -1, NULL);
>>  }
>>  EXPORT_SYMBOL_GPL(cpu_pm_exit);
>>
>
>
