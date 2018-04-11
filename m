Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752571AbeDKHCM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 03:02:12 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:17997 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752068AbeDKHCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 03:02:11 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="38771560"
Subject: Re: [tip:x86/urgent] x86/apic: Fix signedness bug in APIC ID validity
 checks
To: <peterz@infradead.org>, <lirongqing@baidu.com>,
        <linux-kernel@vger.kernel.org>, <mingo@kernel.org>, <hpa@zytor.com>,
        <tglx@linutronix.de>, <linux-tip-commits@vger.kernel.org>
References: <1523322966-10296-1-git-send-email-lirongqing@baidu.com>
 <tip-a774635db5c430cbf21fa5d2f2df3d23aaa8e782@git.kernel.org>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <e66e1b1d-a8d0-ce74-f3c6-4bdc4432efb7@cn.fujitsu.com>
Date: Wed, 11 Apr 2018 15:01:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <tip-a774635db5c430cbf21fa5d2f2df3d23aaa8e782@git.kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: 77B6B4D0EFC7.AAF3F
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

At 04/10/2018 10:51 PM, tip-bot for Li RongQing wrote:
[...]

> x86/apic: Fix signedness bug in APIC ID validity checks
> 
> The APIC ID as parsed from ACPI MADT is validity checked with the
> apic->apic_id_valid() callback, which depends on the selected APIC type.
> 
> For non X2APIC types APIC IDs >= 0xFF are invalid, but values > 0x7FFFFFFF

Today when I am reading "Intel® 64 Architecture x2APIC Specification", I
find that below in chapter 2.4.1:

   The APIC ID value of FFFF_FFFFH and the highest value corresponding to
   the imple-mented bit-width of the local APIC ID register in the system
   are reserved and cannot be assigned to any logical processor.

Seems, FFFF_FFFFH is also invalid for X2APIC types, Shall we also do the
validity check for X2APIC ID?

acpi_parse_x2apic()
	...
	/* Ignore invalid ID */
	if (apic_id == 0xffffffff)
		return 0;
	...

Thanks,
	dou
