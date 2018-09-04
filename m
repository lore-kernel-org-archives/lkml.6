Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96DDC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5567720658
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SmdduMb2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5567720658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbeIECHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 22:07:44 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:56449 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbeIECHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 22:07:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1536097292; x=1567633292;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=XmgPAlKyoEM9jsC7V/aXgjkPJCBpj1AqnfLdFdxhWpQ=;
  b=SmdduMb28A9cN1VXDyYr5YPwlktejxBZ3I/+BV8zKviAfdik/TKZrYoy
   ysgC+oq/7AaHzHVmbC5SyutzoUrqPjKnLEmysPoJpJ4h9WXoHQ0GhFiH8
   LcwZ9Sc1juvx++k3073yKaV0f/Ie68s/buLHzswOtit9ts8mLh/cLvCgF
   Q2wq+Yu5PMAmrh/5045z6DqpzhVYza8Syma8Asqn+sUhIAKTn0B6wLdP9
   ZDvuJfSGLYLR/RItvv0Nh+ogWm/9worVXhwXrnVuMyh5sfj3iKYLgYWCw
   HCorxGQuS65nC35jrqc2qJj91cay+/HkoqoBmN96i+6xNgzF9LNuZpLpZ
   g==;
X-IronPort-AV: E=Sophos;i="5.53,330,1531756800"; 
   d="scan'208";a="186537548"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Sep 2018 05:41:31 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 04 Sep 2018 14:27:28 -0700
Received: from use204589.ad.shared (HELO [10.86.59.178]) ([10.86.59.178])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Sep 2018 14:40:42 -0700
Subject: Re: [PATCH v2 3/3] RISC-V: Support cpu hotplug.
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "palmer@sifive.com" <palmer@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "damein@vger.kernel.org" <damein@vger.kernel.org>
References: <1535445370-19004-1-git-send-email-atish.patra@wdc.com>
 <1535445370-19004-4-git-send-email-atish.patra@wdc.com>
 <20180831061859.GC19292@infradead.org>
 <0d439b9d-b3d0-7d2c-117b-abb37adf769c@wdc.com>
 <20180904213623.GA2078@infradead.org>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <54571707-fd28-3258-fbec-4612f62ad2ad@wdc.com>
Date:   Tue, 4 Sep 2018 14:40:41 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180904213623.GA2078@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/18 2:36 PM, Christoph Hellwig wrote:
> On Tue, Sep 04, 2018 at 11:08:35AM -0700, Atish Patra wrote:
>>
>> I have kept it here to match all other arch. Same goes for all hotplug
>> functions in smpboot.c
>>
>> I can move them to a separate file if you think that provides better code
>> readability and structure.
> 
> I don't really have a strong opinion, but keeping this code together
> and reducing the ifdef maze seems worthwile to me.
> 
Sure. I will move it a new file accordingly in v3. If nobody else has 
objection for that, we will keep it that way.

Regards,
Atish
