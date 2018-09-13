Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D11C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 18:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E6DF20866
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 18:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qAAwKXoL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E6DF20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbeIMXcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 19:32:08 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:25957 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbeIMXcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 19:32:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1536862890; x=1568398890;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=yzYEl/g8Zu0F+QIYe4jICa4Us7bNfLEsmkqW2dz9gzI=;
  b=qAAwKXoLuXKeNM7elSl5HVmbeA7G2g1TXWUAIgUuexpoIifQPlJijP+s
   Rp6wImmm2ovDYbyLjiiOeU8GP/f0E7giqrcVORJLpbzx1SAZ+0PZjmS5G
   Bx6lckY2rC1DPDY1oi0kNBIk3wKTVwwhOPVv71zGSDN5aQ4+9OUJJ3I4H
   TEdjRswDwEyF3wDvPfp4ER8O5gqI68LucKHImXT7NEtqnk5IvRiRtITh2
   shyxpkCGAd0nMba/gqKfURnO6/kpGqfsP3a4u3ZN+jOZaR8+Jm5H4cy4V
   7ZFZkeIpQq90gDYAp5tiKYK86y5J0TtD2FZSGKhBHI0SzbsTgq7dRVrIL
   Q==;
X-IronPort-AV: E=Sophos;i="5.53,370,1531756800"; 
   d="scan'208";a="89711104"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Sep 2018 02:21:29 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 13 Sep 2018 11:07:50 -0700
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.196.159.148]) ([10.196.159.148])
  by uls-op-cesaip01.wdc.com with ESMTP; 13 Sep 2018 11:21:29 -0700
Subject: Re: [PATCH v4 10/12] RISC-V: User WRITE_ONCE instead of direct access
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     "palmer@sifive.com" <palmer@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "jeremy.linton@arm.com" <jeremy.linton@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "dmitriy@oss-tech.org" <dmitriy@oss-tech.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>
References: <1536696339-15204-1-git-send-email-atish.patra@wdc.com>
 <1536696339-15204-11-git-send-email-atish.patra@wdc.com>
 <87o9d3vkp3.fsf@igel.home>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <d8b0c26e-2438-3a2c-ba7d-98431396a659@wdc.com>
Date:   Thu, 13 Sep 2018 11:21:29 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87o9d3vkp3.fsf@igel.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/18 1:33 PM, Andreas Schwab wrote:
> s/User/Use/
> 
> Andreas.
> 
Fixed. Thanks.

Regards,
Atish
