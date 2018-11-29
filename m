Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5ADC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1876E20834
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="iriT1DhT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1876E20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbeK2X6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 18:58:55 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:57404 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbeK2X6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 18:58:54 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id EA17C24E0B36;
        Thu, 29 Nov 2018 04:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1543496018; bh=PuCfmfY4tvjiz/t7rBqpzaa3FzVztjAU/rfpwNVOpkc=;
        h=Subject:To:References:CC:From:Date:In-Reply-To:From;
        b=iriT1DhTJMIZZOgwgXvGCqgpDnourjXY35/uSAPBRp4qXGsc/Oslz97b6npX/mY6e
         XksWgNkZprlH2+tI9aELOhwpcKCANiNxzQjDOb8yIaCqJh/lHZIvbTNcOPc+XRe2rZ
         qxzapRGuvAcHyVuMYOCKYXsFlS5rfevMfqiLzKueLzJVHE+2vnfugh4UMOnlhpoCEh
         GGC5Q3UC5VujxXgFMJ/SF5JmBY4MVwSxc4cHilulrgwTGeOXtwO+NBF4/4aT1AkhNy
         2W9FtLcO4qpbSxb2NmEMMUYAopeJXLkUMvu6x3zf5IYhKN7gky6d8n5L0oiAsiD7OL
         frL0Sh03IQ3zw==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id CAF375A4D;
        Thu, 29 Nov 2018 04:53:38 -0800 (PST)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 29 Nov 2018 04:53:38 -0800
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 29 Nov 2018 13:53:36 +0100
Received: from [10.0.2.15] (10.107.19.26) by DE02WEHTCB.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 29 Nov
 2018 13:53:36 +0100
Subject: Re: [PATCH] ARC: io.h: Implement reads{x}()/writes{x}()
To:     David Laight <David.Laight@ACULAB.COM>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <bdcc49c9eab45bda6815b1419590943e603d8dc2.1543484040.git.joabreu@synopsys.com>
 <f634eb3e39284e48923552a0c21562c6@AcuMS.aculab.com>
CC:     Vineet Gupta <vineet.gupta1@synopsys.com>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Joao Pinto <joao.pinto@synopsys.com>,
        "Vitor Soares" <vitor.soares@synopsys.com>
From:   Jose Abreu <jose.abreu@synopsys.com>
Message-ID: <2d58c25b-60d0-4616-d2d2-ea490a7261f5@synopsys.com>
Date:   Thu, 29 Nov 2018 12:53:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <f634eb3e39284e48923552a0c21562c6@AcuMS.aculab.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.19.26]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-11-2018 12:47, David Laight wrote:
> From: Jose Abreu
>> Sent: 29 November 2018 12:42
>>
>> Some ARC CPU's do not support unaligned loads/stores. Currently, generic
>> implementation of reads{b/w/l}()/writes{b/w/l}() is being used with ARC.
>> This can lead to misfunction of some drivers as generic functions do a
>> plain dereference of a pointer that can be unaligned.
>>
>> Let's use {get/put}_unaligned() helper instead of plain dereference of
>> pointer in order to fix this.
> Is it worth adding a check for the pointer being aligned?

We could but then we would need to know which CPU version is
currently running because some ARC processors support unaligned
accesses.

Thanks and Best Regards,
Jose Miguel Abreu

>
> 	David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
>

