Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2226C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 13:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C03620879
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 13:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="JzalDuzS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C03620879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbeK3AZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 19:25:19 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:44686 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbeK3AZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 19:25:19 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 9753710C161E;
        Thu, 29 Nov 2018 05:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1543497598; bh=kAII+TXC4tw7GSqbqaMZIjroc1X3v6MCb0FxsbUL8Yg=;
        h=Subject:To:References:CC:From:Date:In-Reply-To:From;
        b=JzalDuzSQ09o02ep+3eMpI3EzgLWw1F2ITFWSJ6kP8Thf4dlN2cOuQE8Q0P3w8xrX
         sk29/cTX8ATo3Es5z3Qmq87m96xE+Jv0uExcbehu3Xl3iDvFZ/eChaLKXyZ8NvnYu/
         SjMXdsVA8T6xRIog7dwlSsu34LNMgiGLClzmcOdCWP0XOg9BaI3etmlEHUq1JqAhVn
         KcwOMrzM/GoG2pDByIeMwnHBiH9hlUZgxWu0C7U4uHxWPz18Rbwp+wHXHDsooR/S9C
         qh2FoZ0pamyq1bHW3VDwWWvcbS0jxlBXtr7gZadKJSHAYygDR3W6KE89WEEftPw0H/
         jQYlSBmshTMyg==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id 86E9F5725;
        Thu, 29 Nov 2018 05:19:58 -0800 (PST)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 us01wehtc1.internal.synopsys.com (10.12.239.231) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 29 Nov 2018 05:19:58 -0800
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 29 Nov 2018 14:19:56 +0100
Received: from [10.0.2.15] (10.107.19.26) by DE02WEHTCB.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 29 Nov
 2018 14:19:56 +0100
Subject: Re: [PATCH] ARC: io.h: Implement reads{x}()/writes{x}()
To:     David Laight <David.Laight@ACULAB.COM>,
        'Jose Abreu' <jose.abreu@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <bdcc49c9eab45bda6815b1419590943e603d8dc2.1543484040.git.joabreu@synopsys.com>
 <f634eb3e39284e48923552a0c21562c6@AcuMS.aculab.com>
 <2d58c25b-60d0-4616-d2d2-ea490a7261f5@synopsys.com>
 <a35837f403f54d058dd31c901a007923@AcuMS.aculab.com>
 <e2c8c8e0-ae78-053f-0a80-311cd55927e1@synopsys.com>
CC:     Vineet Gupta <vineet.gupta1@synopsys.com>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Joao Pinto <joao.pinto@synopsys.com>,
        "Vitor Soares" <vitor.soares@synopsys.com>
From:   Jose Abreu <jose.abreu@synopsys.com>
Message-ID: <1fef03c6-05cb-cc9b-ffdd-cb5f7d790322@synopsys.com>
Date:   Thu, 29 Nov 2018 13:19:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <e2c8c8e0-ae78-053f-0a80-311cd55927e1@synopsys.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.19.26]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-11-2018 13:11, Jose Abreu wrote
>> I was thinking of the (probably likely) case where the pointer is
>> actually aligned.
>> An extra check for ((pointer) & 3) is almost certainly a 'win'
>> over the byte accesses and shift/mask/or use by get/put_unaligned().

Oh, sorry. I was misunderstanding. You mean like adding a check
for unaligned and use get/put_unaligned() only in that case right ?

Sorry.

>>
>> The IO accesses probably dominate making more complex optimisations
>> less likely to have any benefit.
>>
>> 	David
>>
>> -
>> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
>> Registration No: 1397386 (Wales)

