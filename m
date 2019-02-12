Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF33C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0612921773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="h6o7hcoA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbfBLIrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 03:47:11 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:5637 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728413AbfBLIrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 03:47:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1549961231; x=1581497231;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ENil7zF+PPj1b6qFv3BM0qe4X7ih7B4qbmKtHMoybvA=;
  b=h6o7hcoA0mzR/jR8cJnaJvGx77eahS2XibZE9Xbhtne+HwxXehZm7fze
   Tf6HJ0uo+AXAi6u1juQjaW84OMijIxP0TalBpNWbjfvgO6LmcRnwf6WsZ
   96cpXWz3BDJI/wpNOv8OnNn5LRN0teoM+z+Os6NLBnMhbEqHCgFoHvudj
   h237Anpmx+QGNxCgQBnsYz9m1g3zpU59UYPBGbq/ZG3+GFjMB8YNPFXuv
   2idCXoicuCOtNyJV8kIBNha0vkYJD+lqA2KkGg4YEqJC2OmrO5C6Esxhe
   L5Mgw6h2rBllXzQkYlF9EwHlAxFrZK7XVjnta2asI2Buzr7sFClVHgHzU
   w==;
X-IronPort-AV: E=Sophos;i="5.58,361,1544457600"; 
   d="scan'208";a="102771675"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2019 16:47:11 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 12 Feb 2019 00:27:47 -0800
Received: from ds141g2.ad.shared (HELO [10.86.48.95]) ([10.86.48.95])
  by uls-op-cesaip02.wdc.com with ESMTP; 12 Feb 2019 00:47:10 -0800
Subject: Re: [PATCH 5/5] riscv: use for_each_of_cpu_node iterator
To:     Johan Hovold <johan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <anup@brainfault.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
References: <20190118140308.9599-1-johan@kernel.org>
 <20190118140308.9599-6-johan@kernel.org>
 <20190212071339.GL26747@infradead.org> <20190212082621.GA26912@localhost>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <6518a7ff-0586-be7a-4a43-6c9a35194a05@wdc.com>
Date:   Tue, 12 Feb 2019 00:47:09 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190212082621.GA26912@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/19 12:26 AM, Johan Hovold wrote:
> On Mon, Feb 11, 2019 at 11:13:39PM -0800, Christoph Hellwig wrote:
>> On Fri, Jan 18, 2019 at 03:03:08PM +0100, Johan Hovold wrote:
>>> Use the new for_each_of_cpu_node() helper to iterate over cpu nodes
>>> instead of open coding. Note that this will allow matching also on the
>>> node name instead of the (for FDT) deprecated device_type property.
>>>
>>> Signed-off-by: Johan Hovold <johan@kernel.org>
>>
>> I think this is going to conflict with the ELF caps changes from
>> Atish.  Maybe the riscv_fill_hwcap hunk should be included in his
>> patch?
> 
> Since that patch had some issues (e.g. the node reference underflow) it
> may be better to rebase it on top of this series. The changes are
> otherwise distinct after all.
> 

I have fixed the node reference underflow issue and made some more 
changes based on comments.

Some other patches(1,3,4,5) in this series may conflict with my series 
as well. I can rebase my series on top of yours and send it as one 
series if that's okay with you and Palmer.

Regards,
Atish
>> Otherwise looks good:
>>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Thanks for reviewing!
> 
> Johan
> 

