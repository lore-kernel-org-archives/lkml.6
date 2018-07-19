Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED79ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 22:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4470820673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 22:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Rrqcc9yl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4470820673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731571AbeGSXZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 19:25:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59906 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730897AbeGSXZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 19:25:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fDUfU8kStFG9Gdz6vR+M13BiqnkZ1GfiVYzzcVW0Y1Y=; b=Rrqcc9ylAo4m7MRyqpzQsCXkg
        aGkS4TZ7EAihxuf1K6MR06MV40LOXBLg2ItvCTa68WjqDsBiN8BhHYkjCdxkRrIJE69S9dCOYeDFK
        N5DZD1/7Uq402pryjFbmbiMgeSgQM2syn3sLN+Lmi3gQ7Ze4F02hB8LNCN7/vBkytdFe/BXzDSxgy
        dFVJnHbr/XKNnZhwHCsHqniwuWLriR1dv4HVUJFuVUpf58fDvjA1CLLKK3FrXRS22Ib/yX5ActW+k
        2f4rSQZ0ciFJPxA39Cqt+vxxnREzripjmVcRZVARmTc1C6aOAtGZ6DxO1bmeu4VKpXnpU0Ifg2DV3
        q3ArUX67A==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fgHb2-0007ys-1s; Thu, 19 Jul 2018 22:40:28 +0000
Subject: Re: [PATCH] security: export security_kernel_load_data to fix
 firmware_loader build
To:     Mimi Zohar <zohar@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <7a8dd892-39ec-3973-5f41-5ec23f1feb3f@infradead.org>
 <1532039957.4196.2.camel@linux.ibm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <41df8eb0-865f-3e53-eb13-cde642396cf7@infradead.org>
Date:   Thu, 19 Jul 2018 15:40:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1532039957.4196.2.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/19/2018 03:39 PM, Mimi Zohar wrote:
> Thanks, Randy.
> 
> On Thu, 2018-07-19 at 13:15 -0700, Randy Dunlap wrote:
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> Fix build error when CONFIG_FW_LOADER=m, CONFIG_FW_LOADER_USER_HELPER=y,
>> CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y, and CONFIG_SECURITY=y:
>>
>> ERROR: "security_kernel_load_data" [drivers/base/firmware_loader/firmware_class.ko] undefined!
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: James Morris <jmorris@namei.org>
>> Cc: "Serge E. Hallyn" <serge@hallyn.com>
>> Cc: linux-security-module@vger.kernel.org
>> Cc: Luis R. Rodriguez <mcgrof@kernel.org>
>> ---
>>  security/security.c |    1 +
>>  1 file changed, 1 insertion(+)
>>
>> --- linux-next-20180717.orig/security/security.c
>> +++ linux-next-20180717/security/security.c
>> @@ -1121,6 +1121,7 @@ int security_kernel_load_data(enum kerne
>>  		return ret;
>>  	return ima_load_data(id);
>>  }
>> +EXPORT_SYMBOL_GPL(security_kernel_load_data);
> 
> Arnd Bergmann already posted a similar patch, which is now staged in
> James' tree.
> 
> Mimi

Good.  Thanks.

-- 
~Randy
