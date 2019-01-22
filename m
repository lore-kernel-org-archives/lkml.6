Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C513C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63B0021721
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbfAVIdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 03:33:43 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:53487 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727062AbfAVIdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 03:33:43 -0500
X-IronPort-AV: E=Sophos;i="5.56,505,1539619200"; 
   d="scan'208";a="52564129"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 22 Jan 2019 16:33:41 +0800
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
        by cn.fujitsu.com (Postfix) with ESMTP id 5EF224B7D665;
        Tue, 22 Jan 2019 16:33:37 +0800 (CST)
Received: from [10.167.226.222] (10.167.226.222) by
 G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 22 Jan 2019 16:33:37 +0800
Subject: Re: rcutorture: meaning of "End of test: RCU_HOTPLUG"
To:     <paulmck@linux.ibm.com>
CC:     <linux-kernel@vger.kernel.org>, <josh@joshtriplett.org>,
        <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
        <jiangshanlai@gmail.com>, "Li, Philip" <philip.li@intel.com>,
        <lkp-developer@eclists.intel.com>
References: <996df745-8434-b92c-bad9-334cc6bf4b7f@cn.fujitsu.com>
 <20190122040144.GB4240@linux.ibm.com>
From:   Su Yue <suy.fnst@cn.fujitsu.com>
Message-ID: <c2cf5125-2545-c325-0393-0dba4aab379d@cn.fujitsu.com>
Date:   Tue, 22 Jan 2019 16:42:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20190122040144.GB4240@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.222]
X-yoursite-MailScanner-ID: 5EF224B7D665.AC901
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: suy.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your quick reply! Paul

On 1/22/19 12:01 PM, Paul E. McKenney wrote:
> On Tue, Jan 22, 2019 at 11:40:53AM +0800, Su Yue wrote:
>> Hi, guys
>>    While running rcutorture tests with "onoff_interval", some tests
>> failed and results show like:
>>
>> =====================================================================
>> [  316.354501] srcud-torture:--- End of test: RCU_HOTPLUG:
>> nreaders=1 nfakewriters=4 stat_interval=60 verbose=2
>> test_no_idle_hz=1 shuffle_interval=3 stutter=5 irqreader=1 fq\
>> s_duration=0 fqs_holdoff=0 fqs_stutter=3 test_boost=1/0
>> test_boost_interval=7 test_boost_duration=4 shutdown_secs=0
>> stall_cpu=0 stall_cpu_holdoff=10 stall_cpu_irqsoff=0 n_ba\
>> rrier_cbs=0 onoff_interval=3 onoff_holdoff=0
>> ====================================================================
>>
>> I am wondering that meaning of "RCU_HOTPLUG". Is it expected because
>> cpu hotplug is enabled in the test? Or just represents another type of
>> failure?
> 
> This says that at least one CPU hotplug operation failed, that is,
> the CPU didn't actually come online or go offline as requested.  If you
> are introducing CPU hotplug to an architecture, this usually indicates
> that you have bugs in your CPU-hotplug code.  Or it nmight be that

It should hit the case since there is no RCU CPU stall warnings.

> RCU grace periods failed to progress -- though this would normally
> also result in RCU CPU stall warnings.
> 
> There should be lines containing "ver:" in your console output.  What
> does one of the later one of these say?
> 

The line says:
======================================================================
[  318.850175] busted_srcud-torture: rtc:           (null) ver: 27040 
tfle: 0 rta: 27040 rtaf: 0 rtf: 27027 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 
rtbf: 0 rtb: 0 \
nt: 9497 onoff: 2639/2639:2640/5310 40,373:10,355 162868:67542 (HZ=1000) 
barrier: 0/0:0

=====================================================================

And here are useful errors:
=====================================================================
kern  :info  : [  135.379693] KVM setup async PF for cpu 1
kern  :info  : [  135.381412] kvm-stealtime: cpu 1, msr 23fd16180
kern  :alert : [  135.386897] busted_srcud-torture:torture_onoff task: 
onlined 1
kern  :alert : [  135.408241] busted_srcud-torture:torture_onoff task: 
offlining 1
kern  :info  : [  135.423310] Unregister pv shared memory for cpu 1
kern  :info  : [  135.427940] smpboot: CPU 1 is now offline
kern  :alert : [  135.430106] busted_srcud-torture:torture_onoff task: 
offlined 1
kern  :alert : [  135.436404] busted_srcud-torture:torture_onoff task: 
offlining 0
kern  :alert : [  135.446173] busted_srcud-torture:torture_onoff task: 
offline 0 failed: errno -16
kern  :alert : [  135.453076] busted_srcud-torture:torture_onoff task: 
offlining 0
kern  :alert : [  135.457461] busted_srcud-torture:torture_onoff task: 
offline 0 failed: errno -16


=====================================================================
There are only two CPUs on the VM. Torture try to offline the last one
but -EBUSY occured.

I spent time to understand kernel/torture.c.
There is torture_onoff():

225        while (!torture_must_stop()) {
226                cpu = (torture_random(&rand) >> 4) % (maxcpu + 1);
227                if (!torture_offline(cpu,
228                                     &n_offline_attempts, 
&n_offline_successes,
229                                     &sum_offline, &min_offline, 
&max_offline))
230                        torture_online(cpu,
231                                       &n_online_attempts, 
&n_online_successes,
232                                       &sum_online, &min_online, 
&max_online);
233                schedule_timeout_interruptible(onoff_interval);
234        }
235

torture_offline() and torture_offline() don't pre judge if the current
cpu is only one usable.

Our test machines are configured with CONFIG_BOOTPARAM_HOTPLUG_CPU0. If
there are only one oneline and hotplugable cpux, then
n_offline_successes != n_offline_attempts which caused "End of test:
RCU_HOTPLUG".

Does I misunderstand something above? Feel free to correct me.


Thanks,
Su

> 							Thanx, Paul
> 
> 
> 


