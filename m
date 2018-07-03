Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CEC7C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C440621A36
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:01:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C440621A36
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934394AbeGCSBy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 14:01:54 -0400
Received: from ale.deltatee.com ([207.54.116.67]:35640 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934187AbeGCSBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 14:01:50 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1faPcM-0008AA-9L; Tue, 03 Jul 2018 12:01:35 -0600
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-ntb@googlegroups.com,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>,
        Dan Douglass <dan.douglass@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
References: <20180622194752.11221-1-logang@deltatee.com>
 <20180622194752.11221-7-logang@deltatee.com>
 <CAOMZO5DpwPsidKQ9wfe8mNTgdOpkdHHgqHMa4yQBx9uRrfFmww@mail.gmail.com>
 <CAHp75VcCNsx2sHcYG2aNiw354exTvO=NUOS9P_BTmcM3siAepg@mail.gmail.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <13ea3f97-4a33-3a24-1b7e-b819be73d867@deltatee.com>
Date:   Tue, 3 Jul 2018 12:01:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VcCNsx2sHcYG2aNiw354exTvO=NUOS9P_BTmcM3siAepg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: davem@davemloft.net, herbert@gondor.apana.org.au, dan.douglass@nxp.com, horia.geanta@nxp.com, gregkh@linuxfoundation.org, arnd@arndb.de, linux-crypto@vger.kernel.org, linux-ntb@googlegroups.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, festevam@gmail.com, andy.shevchenko@gmail.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v18 6/7] crypto: caam: cleanup CONFIG_64BIT ifdefs when
 using io{read|write}64
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/07/18 11:36 AM, Andy Shevchenko wrote:
>> This is now in linux-next as commit 46e4bf08f6388 and it breaks
>> booting imx6 (32-bit ARM):
> 
> 
>> Any ideas on how to fix this issue?
> 
> Oops, first of all the header should be hi-lo instead of lo-hi.
> Does it fix it?
> 
> Otherwise I didn't (briefly) see what can be the issue.

I had to dig to find this: but Horia had said[1] that the HW was
specified to use lo-hi and I think we ended up changing to that for this
commit based on his feedback. This is also mentioned in the commit message.

Besides that, it looks like we are hitting an undefined instruction. So
my best guess is that we are somehow now calling a proper 64bit read
when we should be calling two 32-bit reads.

Fabio, can you send your configuration?

Thanks,

Logan

[1]
http://lkml.kernel.org/r/VI1PR0401MB259145C2DFDB5E4084EA5DFC98D20@VI1PR0401MB2591.eurprd04.prod.outlook.com


