Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C1DC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 20:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F5862147C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 20:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="R+SINxdL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F5862147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbeHUXo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 19:44:57 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:50767 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbeHUXo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 19:44:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1534883000; x=1566419000;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=lMRA7J0a47S1I5Q40j8vr87/G15GiTpsp7monYKReYs=;
  b=R+SINxdLE6ohMpOBx9w9ii05dwwVOlQ87BhBbzsBrZ5q/PlTov64nWHE
   ngzpBg+amh++yCnIuVGWym92USzdouoyMKflS+uVOdK2xSLpKt4j2ljvz
   5y/RN8oWEQlBayXWzxxQMvEvcptVwYj38OcCjJKlwaE4/M9HCbzNPKuGF
   WuTG9bKKUZ/LbO2TUAhankbxqtsHwq+FvfgZLkHDk/28lIxjFD2QoCc0u
   /v9V8hA+IfWNI5yhhPbQqNYGoSEpFsmDnkn9q7hgE6XPuDPgVJqbYUWGH
   4GPIcgLKo53KQagXXqiSTYIxrMXf49jio97a17Hi2fDzyIzmSUreaVpKM
   Q==;
X-IronPort-AV: E=Sophos;i="5.53,271,1531756800"; 
   d="scan'208";a="91986636"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Aug 2018 04:23:19 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 21 Aug 2018 13:10:32 -0700
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.196.159.148]) ([10.196.159.148])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Aug 2018 13:23:19 -0700
Subject: Re: [RFC PATCH 5/5] RISC-V: Support cpu hotplug.
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "palmer@sifive.com" <palmer@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1534377377-70108-1-git-send-email-atish.patra@wdc.com>
 <1534377377-70108-6-git-send-email-atish.patra@wdc.com>
 <20180821075452.GC28079@infradead.org>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <2f9a09fa-a334-1910-843b-067537960c24@wdc.com>
Date:   Tue, 21 Aug 2018 13:23:18 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180821075452.GC28079@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/18 12:55 AM, Christoph Hellwig wrote:
>>   	if (!err) {
>> +
>> +#ifdef CONFIG_HOTPLUG_CPU
>> +		arch_send_call_function_single_ipi(cpu);
>> +#endif
> 
> Please just provide a stub version of arch_send_call_function_single_ipi
> for the !CONFIG_HOTPLUG_CPU case instead of the ifdef here.
> 

Done.

>> +#ifdef CONFIG_HOTPLUG_CPU
>> +int can_hotplug_cpu(void)
> 
> This should be a bool.
> 
>> +{
>> +	if (cpu_ops.cpu_die)
>> +		return 1;
>> +	else
>> +		return 0;
>> +}
> 
> 	return cpu_ops.cpu_die != NULL;
> 
>> +void default_cpu_die(unsigned int cpu)
>> +{
>> +	int sipval, sieval, scauseval;
>> +
>> +	/* clear all pending flags */
>> +	csr_write(sip, 0);
>> +	/* clear any previous scause data */
>> +	csr_write(scause, 0);
>> +
>> +	do {
>> +		wait_for_interrupt();
>> +		sipval = csr_read(sip);
>> +		sieval = csr_read(sie);
>> +		scauseval = csr_read(scause);
>> +	/* only break if wfi returns for an enabled interrupt */
>> +	} while ((sipval & sieval) == 0 &&
>> +		 scauseval != INTERRUPT_CAUSE_SOFTWARE);
>> +
>> +	boot_sec_cpu();
>> +}
> 
> I suspect all of this except for the boot_sec_cpu() should go into
> a helper in irq.c.  

ok. I will try that. That will also solve interrupt cause declarations 
issue. So I can drop patch 4.

Also as-is this probably doesn't work as scauseval
> will have INTERRUPT_CAUSE_FLAG set, making the comparism never true.
> 

Oops. Thanks for catching that. scauseval is declared as int which made 
this code to work. Fixed it.


Regards,
Atish

