Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A4AC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 06:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48C72206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 06:11:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48C72206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lynx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbeIKLIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 07:08:44 -0400
Received: from [216.100.252.242] ([216.100.252.242]:38853 "EHLO asmtp.lnxw.com"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726569AbeIKLIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 07:08:43 -0400
X-Greylist: delayed 472 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Sep 2018 07:08:43 EDT
Received: from [10.21.42.214] ([10.21.42.214])
        (authenticated bits=0)
        by asmtp.lnxw.com (8.13.8/8.13.8) with ESMTP id w8B62jqj009943
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
        Mon, 10 Sep 2018 23:02:47 -0700
Subject: Re: x86/apic: MSI address malformed for "flat" driver
To:     Thomas Gleixner <tglx@linutronix.de>,
        Philipp Eppelt <philipp.eppelt@kernkonzept.com>
Cc:     linux-kernel@vger.kernel.org
References: <d407ee89-3d6c-b55d-d633-abf7644e9766@kernkonzept.com>
 <alpine.DEB.2.21.1809072012310.1402@nanos.tec.linutronix.de>
From:   Cyril Novikov <cnovikov@lynx.com>
Message-ID: <27bccfd2-0ede-cd3a-2717-741d3dffebdf@lynx.com>
Date:   Mon, 10 Sep 2018 23:02:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1809072012310.1402@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/2018 12:11 PM, Thomas Gleixner wrote:
> On Thu, 6 Sep 2018, Philipp Eppelt wrote:
>>
>> The "flat" driver defines the MSI addressing scheme to be used as
>> logical addressing in flat mode. The MSI msg address is composed
>> accordingly, but sets MSI_ADDR_REDIRECTION_CPU which is a zero at bit[3].
> 
> Correct. That's what it means:
> 
>    * When RH is 0, the interrupt is directed to the processor listed in the
>      Destination ID field.
> 
> So for DM:
> 
>    * If RH is 0, then the DM bit is ignored and the message is sent ahead
>      independent of whether the physical or logical destination mode is
>      used.
> 
> which is means that the delivery does not do any magic redirections,
> because the Redirection Hint is off. If RH is set, then the delivery can
> redirect according to the rules in the DM section. We are not using that
> because we want targeted single CPU delivery.
> 
> The interpretation of the DID field is purely depending on the local APIC
> itself by matching the APIC ID against the DID field. And the local APIC ID
> of CPU0 is 1 << 0, i.e. 0x1 which matches the MSI message you see.

I believe you are wrong here and the local APIC ID of CPU0 is 0.

processor       : 0
vendor_id       : GenuineIntel
...
physical id     : 0
siblings        : 8
core id         : 0
cpu cores       : 4
apicid          : 0

The fact that the code works means that DM is not ignored when RH is 0. 
In other words, RH=0 DM=1 means logical destination mode.

--
Cyril
