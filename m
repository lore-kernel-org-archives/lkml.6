Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C8CC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F3702085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ClzO1YPS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F3702085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730559AbeKFVBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 16:01:40 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:57320 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbeKFVBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 16:01:40 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA6BXsix131859;
        Tue, 6 Nov 2018 11:35:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=pt96XlYz7mklUmKlFwXpE51aXmHGJMS7UZUcs3Bi/NU=;
 b=ClzO1YPS5j6Kt6hbP4NnAXcaqPPmuXSUZYRrWMNzx2+Q6lABh7iSStp9gt7lmeBf0ic9
 B6a9yYAKwnj5kdws1YHdr90t82A7mOnLlQfFtgWYMWaHcvsUWc03qluWZ/nAeXiB6r39
 +Dq20UBgP4da+Gz6dvPBAVQxnXEoQI9sbGmpO0S8l0MkBAIvLq32WnbwEyD5lETw10rK
 ZEXTYCADGAPEVJOBP3kMNFGuetNGb1QoOJW4QQsAh1EWc8UTbAZz2myISyTNfXHgjfTB
 WC5G2CzvLdk4QcpgZrk5TTO1ukp370x9DH937/xmLDyxEPDlr7w1CaJZi2vrybGn84SS gQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2nh4aqmhau-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Nov 2018 11:35:50 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wA6BZmwR017277
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Nov 2018 11:35:48 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wA6BZhfj027513;
        Tue, 6 Nov 2018 11:35:43 GMT
Received: from [10.39.220.171] (/10.39.220.171)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 06 Nov 2018 03:35:43 -0800
Subject: Re: [PATCH v15 23/26] sched: early boot clock
To:     Dominique Martinet <asmadeus@codewreck.org>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>
Cc:     daniel.m.jordan@oracle.com, linux@armlinux.org.uk,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        john.stultz@linaro.org, sboyd@codeaurora.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        hpa@zytor.com, douly.fnst@cn.fujitsu.com, peterz@infradead.org,
        prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com,
        gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org,
        boris.ostrovsky@oracle.com, jgross@suse.com, pbonzini@redhat.com,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        qemu-devel@nongnu.org
References: <20180719205545.16512-1-pasha.tatashin@oracle.com>
 <20180719205545.16512-24-pasha.tatashin@oracle.com>
 <20181106054212.GA31768@nautica>
From:   Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <95c3920e-bf80-0c7e-7854-01a1c3189c23@oracle.com>
Date:   Tue, 6 Nov 2018 06:35:36 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181106054212.GA31768@nautica>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9068 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811060104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel has a new email address, cc'd - steve

On 11/6/2018 12:42 AM, Dominique Martinet wrote:
> (added various kvm/virtualization lists in Cc as well as qemu as I don't
> know who's "wrong" here)
> 
> Pavel Tatashin wrote on Thu, Jul 19, 2018:
>> Allow sched_clock() to be used before schec_clock_init() is called.
>> This provides with a way to get early boot timestamps on machines with
>> unstable clocks.
> 
> This isn't something I understand, but bisect tells me this patch
> (landed as 857baa87b64 ("sched/clock: Enable sched clock early")) makes
> a VM running with kvmclock take a step in uptime/printk timer early in
> boot sequence as illustrated below. The step seems to be related to the
> amount of time the host was suspended while qemu was running before the
> reboot.
> 
> $ dmesg
> ...
> [    0.000000] SMBIOS 2.8 present.
> [    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20180724_192412-buildhw-07.phx2.fedoraproject.org-1.fc29 04/01/2014
> [    0.000000] Hypervisor detected: KVM
> [    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
> [283120.529821] kvm-clock: cpu 0, msr 321a8001, primary cpu clock
> [283120.529822] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
> [283120.529824] tsc: Detected 2592.000 MHz processor
> ...
> 
> (The VM is x86_64 on x86_64, I can provide my .config on request but
> don't think it's related)
> 
> 
> It's rather annoying for me as I often reboot VMs and rely on the
> 'uptime' command to check if I did just reboot or not as I have the
> attention span of a goldfish; I'd rather not have to find something else
> to check if I did just reboot or not.
> 
> Note that if the qemu process is restarted, there is no offset anymore.
> 
> I unfortunately just did that so cannot say with confidence (putting my
> laptop to sleep for 30s only led to a 2s offset and I do not want to
> wait longer right now), but it looks like the clock is still mostly
> correct after reboot after disabling my VM's ntp client. Will infirm
> that tomorrow if I was wrong.
> 
> 
> Happy to try to help fixing this in any way, as written above the quote
> I'm not even actually sure who is wrong here.
> 
> Thanks!
> 
> 
> 
> (As a side, mostly unrelated note, insert swearing here about cf7a63ef4
> not compiling earlier in this serie; some variable declaration got
> removed before their use. Was fixed in the next patch but I didn't
> notice the kernel didn't fully rebuild and wasted time in my bisect
> heading the wrong way...)
> 
>> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
>> ---
>>  init/main.c          |  2 +-
>>  kernel/sched/clock.c | 20 +++++++++++++++++++-
>>  2 files changed, 20 insertions(+), 2 deletions(-)
>>
>> diff --git a/init/main.c b/init/main.c
>> index 162d931c9511..ff0a24170b95 100644
>> --- a/init/main.c
>> +++ b/init/main.c
>> @@ -642,7 +642,6 @@ asmlinkage __visible void __init start_kernel(void)
>>  	softirq_init();
>>  	timekeeping_init();
>>  	time_init();
>> -	sched_clock_init();
>>  	printk_safe_init();
>>  	perf_event_init();
>>  	profile_init();
>> @@ -697,6 +696,7 @@ asmlinkage __visible void __init start_kernel(void)
>>  	acpi_early_init();
>>  	if (late_time_init)
>>  		late_time_init();
>> +	sched_clock_init();
>>  	calibrate_delay();
>>  	pid_idr_init();
>>  	anon_vma_init();
>> diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
>> index 0e9dbb2d9aea..422cd63f8f17 100644
>> --- a/kernel/sched/clock.c
>> +++ b/kernel/sched/clock.c
>> @@ -202,7 +202,25 @@ static void __sched_clock_gtod_offset(void)
>>  
>>  void __init sched_clock_init(void)
>>  {
>> +	unsigned long flags;
>> +
>> +	/*
>> +	 * Set __gtod_offset such that once we mark sched_clock_running,
>> +	 * sched_clock_tick() continues where sched_clock() left off.
>> +	 *
>> +	 * Even if TSC is buggered, we're still UP at this point so it
>> +	 * can't really be out of sync.
>> +	 */
>> +	local_irq_save(flags);
>> +	__sched_clock_gtod_offset();
>> +	local_irq_restore(flags);
>> +
>>  	sched_clock_running = 1;
>> +
>> +	/* Now that sched_clock_running is set adjust scd */
>> +	local_irq_save(flags);
>> +	sched_clock_tick();
>> +	local_irq_restore(flags);
>>  }
>>  /*
>>   * We run this as late_initcall() such that it runs after all built-in drivers,
>> @@ -356,7 +374,7 @@ u64 sched_clock_cpu(int cpu)
>>  		return sched_clock() + __sched_clock_offset;
>>  
>>  	if (unlikely(!sched_clock_running))
>> -		return 0ull;
>> +		return sched_clock();
>>  
>>  	preempt_disable_notrace();
>>  	scd = cpu_sdc(cpu);
