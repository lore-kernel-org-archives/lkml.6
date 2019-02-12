Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4B4C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87AAD21773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hTHlFZki"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbfBLJUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 04:20:06 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:34341 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfBLJUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 04:20:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1549963206; x=1581499206;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=0u22az8QufOyM/1E8fitgYFXGVFr+R6CmRAnfANUXRc=;
  b=hTHlFZkin7gwbXPgwB8cIXBEFdApvHfT/aAnyh9kBk+u48uXrlP0JL99
   hG+CXmXD6PAEXB/kV9DXqw5WOfdCH/NH/IH6e+Ee50/Jew8txkUZo2CBm
   kt3o4aIWTDLQsGpSQUkdWGKYpAJrXuffa6+CmFvudAayldhZjfO73b89J
   hnaiwJQIujWuit5YHI2T+9PkmPgVTG8YBXDFGq/j9HDGqmNePfujV6Kdj
   rOK6cpzQU7iVgnNwRAxFKP1eSdTpd+9xAYzuAgaDgUhlCOQhwiWxrJQTu
   lcS6jvLgCqXxNLAEQUWLDUnNk7BOywEVNFtCj3UVOXx6FHo1HC5xQBRrN
   g==;
X-IronPort-AV: E=Sophos;i="5.58,361,1544457600"; 
   d="scan'208";a="102300598"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2019 17:20:05 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 12 Feb 2019 01:00:41 -0800
Received: from ds141g2.ad.shared (HELO [10.86.48.95]) ([10.86.48.95])
  by uls-op-cesaip02.wdc.com with ESMTP; 12 Feb 2019 01:20:05 -0800
Subject: Re: [PATCH 5/5] riscv: use for_each_of_cpu_node iterator
To:     Johan Hovold <johan@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@suse.de>,
        Palmer Dabbelt <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <anup@brainfault.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
References: <20190118140308.9599-1-johan@kernel.org>
 <20190118140308.9599-6-johan@kernel.org>
 <20190212071339.GL26747@infradead.org> <20190212082621.GA26912@localhost>
 <6518a7ff-0586-be7a-4a43-6c9a35194a05@wdc.com>
 <20190212085345.GA28278@localhost>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <3ceda2a6-72f1-bbab-96bd-5c1e91fff50a@wdc.com>
Date:   Tue, 12 Feb 2019 01:20:03 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190212085345.GA28278@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/19 12:53 AM, Johan Hovold wrote:
> On Tue, Feb 12, 2019 at 12:47:09AM -0800, Atish Patra wrote:
>> On 2/12/19 12:26 AM, Johan Hovold wrote:
>>> On Mon, Feb 11, 2019 at 11:13:39PM -0800, Christoph Hellwig wrote:
>>>> On Fri, Jan 18, 2019 at 03:03:08PM +0100, Johan Hovold wrote:
>>>>> Use the new for_each_of_cpu_node() helper to iterate over cpu nodes
>>>>> instead of open coding. Note that this will allow matching also on the
>>>>> node name instead of the (for FDT) deprecated device_type property.
>>>>>
>>>>> Signed-off-by: Johan Hovold <johan@kernel.org>
>>>>
>>>> I think this is going to conflict with the ELF caps changes from
>>>> Atish.  Maybe the riscv_fill_hwcap hunk should be included in his
>>>> patch?
>>>
>>> Since that patch had some issues (e.g. the node reference underflow) it
>>> may be better to rebase it on top of this series. The changes are
>>> otherwise distinct after all.
>>>
>>
>> I have fixed the node reference underflow issue and made some more
>> changes based on comments.
>>
>> Some other patches(1,3,4,5) in this series may conflict with my series
>> as well. I can rebase my series on top of yours and send it as one
>> series if that's okay with you and Palmer.
> 
> No need for you to resend these patches as they are reviewed any ready
> to be merged. Just rebase your series and mention the dependency in the
> cover letter as I did with Andreas's patch which this series depended
> on.
>

Sure. I will do that.

Regards,
Atish
> Thanks,
> Johan
> 

