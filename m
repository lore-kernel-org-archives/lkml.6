Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A10ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 23:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B775220852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 23:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X0tYw9h5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B775220852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388175AbeGXAbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 20:31:23 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49242 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388098AbeGXAbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 20:31:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=o11kUjuzMQNvGr3/6w+Q3pgFOCw7hRVK57TxVUWCmx4=; b=X0tYw9h5miidYDju2YrkIKYVtJ
        6p9sCf7is5oTZqdo2nBblVpVpbaGz9IFF09SvwQJt+A8ZgtmEwA4vP17HeK/W06eqMm5AJm78hzYH
        faAwLMI+T8653YlCi+oaFDsfkhv0CT2RDEuiUKInE6UUCEKuTVaxaCmZwYvsHnWA/nzHTjmU5uUjJ
        Rr0EO8oCPeiRMoIp8KcK2w4P3pD28Q6Uc6SZ1c8M/Kj7k9r47iLAKvAExPJCQCNRXyQJ4350vAOZt
        W4XXRDfcTAbu1Ct2rqh+jljAjX+46YO0I4wmMZLNny3ANxr+s3eXTYlBgIPq+ssUz2dghD/OgtoMx
        FyYG+Nbg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fhkF2-000336-Iw; Mon, 23 Jul 2018 23:27:49 +0000
Subject: Re: [PATCH v2] hexagon: modify ffs() and fls() to return int
To:     Richard Kuo <rkuo@codeaurora.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-hexagon@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <f96af3cd-3316-11a8-d563-dd269f1378a2@infradead.org>
 <20180723225025.GC12771@codeaurora.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <39ac5a3f-b5fa-a928-6caf-a7a01251f5ea@infradead.org>
Date:   Mon, 23 Jul 2018 16:27:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180723225025.GC12771@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/23/2018 03:50 PM, Richard Kuo wrote:
> On Sun, Jul 22, 2018 at 04:03:58PM -0700, Randy Dunlap wrote:
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> Building drivers/mtd/nand/raw/nandsim.c on arch/hexagon/ produces a
>> printk format build warning.  This is due to hexagon's ffs() being
>> coded as returning long instead of int.
>>
>> Fix the printk format warning by changing all of hexagon's ffs() and
>> fls() functions to return int instead of long.  The variables that
>> they return are already int instead of long.  This return type
>> matches the return type in <asm-generic/bitops/>.
>>
>> ../drivers/mtd/nand/raw/nandsim.c: In function 'init_nandsim':
>> ../drivers/mtd/nand/raw/nandsim.c:760:2: warning: format '%u' expects argument of type 'unsigned int', but argument 2 has type 'long int' [-Wformat]
>>
>> There are no ffs() or fls() allmodconfig build errors after making this
>> change.
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Richard Kuo <rkuo@codeaurora.org>
>> Cc: linux-hexagon@vger.kernel.org
>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> ---
>> v2:
>> add hexagon contacts, drop erroneous sh contacts; [thanks, Geert]
>> only change return type for ffs() and fls() [thanks, Geert]
>>   [drop the changes for ffz(), __ffs(), and __fls()]
>>
>>  arch/hexagon/include/asm/bitops.h |    4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
> 
> 
> Acked-by: Richard Kuo <rkuo@codeaurora.org>
> 

Hi Richard,

You are listed as the arch/hexagon/ maintainer.  Can you please merge these
patches?

thanks,
-- 
~Randy
