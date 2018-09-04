Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4C5C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1AB32077C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Qv7/RTvL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1AB32077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbeIECKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 22:10:16 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:13043 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbeIECKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 22:10:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1536097396; x=1567633396;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=CH8kUEjCOKxcIunxSfUkZn7BzJobc/mJAdG1xBXg8jk=;
  b=Qv7/RTvLdEC1fLcs8fyXoakY4vwCupmNWSaYR3Yz+hr4udVCd0vJOirJ
   V1ws79s+LXuhJB03SzXzwdO+boTKOqd/CBZKQDRkGYjb1Z8wZD+u24Zkt
   0FhF+mK0vR8u1kMyzKDjt+pTNqPQEXrUAN8VuBhYn1nWlw4LKtpKIIl+y
   eVdNdqjp4G2+w0pyytrap9aguJpeI4Gldz9pYmZ0Oxhno4pkVsCDJ9m/y
   3hqr7x92zYOfeCNigJBqCxr5CFnz+VEDqy4oljkN0M8dHXJvPK2VSFKST
   qFIs5925OVNtDRLZe3bHODvdjbIvDcjbxxgO3YS2ZM/OBIoEp63XxQgvr
   A==;
X-IronPort-AV: E=Sophos;i="5.53,330,1531756800"; 
   d="scan'208";a="193175022"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Sep 2018 05:43:15 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 04 Sep 2018 14:30:00 -0700
Received: from use204589.ad.shared (HELO [10.86.59.178]) ([10.86.59.178])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Sep 2018 14:43:15 -0700
Subject: Re: [PATCH v2 2/3] RISC-V: Use Linux logical cpu number instead of
 hartid
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "palmer@sifive.com" <palmer@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "damein@vger.kernel.org" <damein@vger.kernel.org>
References: <1535445370-19004-1-git-send-email-atish.patra@wdc.com>
 <1535445370-19004-3-git-send-email-atish.patra@wdc.com>
 <20180831061104.GB19292@infradead.org>
 <ec0819d5-9dc6-6b25-47a9-cd9d9e5099a8@wdc.com>
 <20180904213654.GB2078@infradead.org>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <d79833a8-98ae-fa19-9a7c-0afeb3d0bb92@wdc.com>
Date:   Tue, 4 Sep 2018 14:43:13 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180904213654.GB2078@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/18 2:36 PM, Christoph Hellwig wrote:
> On Tue, Sep 04, 2018 at 01:35:10PM -0700, Atish Patra wrote:
>> sure. How about this ?
> 
> That would work, but why not just keep calling sbi_remove_sfence_vma
> directly from flush_tlb_all?
> 
I guess that's fine too. I just wanted to keep all flush_tlb_* same 
format to make it more coherent.

Regards,
Atish
