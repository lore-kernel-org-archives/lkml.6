Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B13C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57B3320868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:22:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57B3320868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybernetics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbeLFPWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:22:19 -0500
Received: from mail.cybernetics.com ([173.71.130.66]:43336 "EHLO
        mail.cybernetics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbeLFPWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 10:22:19 -0500
X-Greylist: delayed 617 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Dec 2018 10:22:19 EST
X-ASG-Debug-ID: 1544109118-0fb3b01fb3c5a6c0002-xx1T2L
Received: from cybernetics.com ([10.157.1.126]) by mail.cybernetics.com with ESMTP id up9TucNETYmhGcU7 (version=SSLv3 cipher=DES-CBC3-SHA bits=112 verify=NO); Thu, 06 Dec 2018 10:11:58 -0500 (EST)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-ASG-Whitelist: Client
Received: from [10.157.2.224] (account tonyb HELO [192.168.200.1])
  by cybernetics.com (CommuniGate Pro SMTP 5.1.14)
  with ESMTPSA id 8569752; Thu, 06 Dec 2018 10:11:58 -0500
Subject: Re: dmapool regression in next
To:     Krzysztof Kozlowski <krzk@kernel.org>, tony@atomide.com
X-ASG-Orig-Subj: Re: dmapool regression in next
Cc:     akpm@linux-foundation.org, Stephen Rothwell <sfr@canb.auug.org.au>,
        andy.shevchenko@gmail.com, hch@lst.de, john.garry@huawei.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
References: <20181206013054.GI6707@atomide.com>
 <CAJKOXPcoK5SsXfXjdAWPHLX2KZRCqOv61HVf2DK9wm4_m+vJ0w@mail.gmail.com>
From:   Tony Battersby <tonyb@cybernetics.com>
Message-ID: <09e73d24-467a-52bb-0433-a9596d4d6f02@cybernetics.com>
Date:   Thu, 6 Dec 2018 10:11:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAJKOXPcoK5SsXfXjdAWPHLX2KZRCqOv61HVf2DK9wm4_m+vJ0w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Barracuda-Connect: UNKNOWN[10.157.1.126]
X-Barracuda-Start-Time: 1544109118
X-Barracuda-Encrypted: DES-CBC3-SHA
X-Barracuda-URL: https://10.157.1.122:443/cgi-mod/mark.cgi
X-Barracuda-Scan-Msg-Size: 2200
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/18 4:25 AM, Krzysztof Kozlowski wrote:
> On Thu, 6 Dec 2018 at 02:31, Tony Lindgren <tony@atomide.com> wrote:
>> Hi,
>>
>> Looks like with commit 26abe88e830d ("mm/dmapool.c: improve scalability
>> of dma_pool_free()") I'm now getting spammed with lots of "(bad vaddr)"
>> on at least omap4 pandaboard, see below.
>>
>> Any ideas what might be going wrong?
>>
>> Regards,
>>
>> Tony
>>
>> 8< ---------------------
>> omap-dma-engine 4a056000.dma-controller: dma_pool_free 4a056000.dma-controller, (ptrval) (bad vaddr)/0xbe800000
>> omap-dma-engine 4a056000.dma-controller: dma_pool_free 4a056000.dma-controller, (ptrval) (bad vaddr)/0xbe80001c
>> omap-dma-engine 4a056000.dma-controller: dma_pool_free 4a056000.dma-controller, (ptrval) (bad vaddr)/0xbe800038
>> ...
> I see it as well on all my Exynos boards, since yesterday's next. In
> my case it is the USB EHCI driver:
> exynos-ehci 12110000.usb: dma_pool_free ehci_qtd, (ptrval) (bad
> vaddr)/0xb8844180
> Full log here:
> https://krzk.eu/#/builders/1/builds/2937/steps/12/logs/serial0
>
> Best regards,
> Krzysztof
>
Here is the prototype:

void dma_pool_free(struct dma_pool *pool, void *vaddr, dma_addr_t dma);

With the old code, the 'dma' value had to be correct for use with
pool_find_page(), or else you would get an error.  If the 'vaddr' value
was incorrect, it would corrupt the dmapool freelist, but you wouldn't
get an error unless DMAPOOL_DEBUG was enabled.

With my patch applied, 'vaddr' has to be correct for virt_to_page().  My
code also checks that 'dma' is consistent with 'vaddr' even if
DMAPOOL_DEBUG is disabled, since the check is fast and it will prevent
problems like this in the future.

So if a buggy driver passes in a good value for 'dma' but a bad value
for 'vaddr', then it may have appeared to work previously (but with
possible data corruption, depending on the circumstances), but my patch
will expose the problem.  You can confirm by reverting my dmapool
patches and enabling DMAPOOL_DEBUG, which is at the top of mm/dmapool.c:

#if defined(CONFIG_DEBUG_SLAB) || defined(CONFIG_SLUB_DEBUG_ON)
#define DMAPOOL_DEBUG 1
#endif

Tony Battersby


