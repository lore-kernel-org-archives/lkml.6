Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B610EC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F38220880
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="mI9ONQte"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F38220880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729448AbeLMNez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 08:34:55 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:25496 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729281AbeLMNey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 08:34:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1544708092;
        s=strato-dkim-0002; d=xenosoft.de;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=yA2jmna+fcSzxSQBVMdo/qEy3WhSYh8nh4G0IYOjPGc=;
        b=mI9ONQte+k+Z+ftUJIZpK614wvlSCQLwCUAojlAdk1C04b2X+u6PG5lVyQeInHUvSD
        fJVO2DH5tJcaerp/gSZmjS+YcKvYszs1CO+/IDsmf3YmwOWj9WMP2798OXDFe1FfTo2/
        fIqp54pK4832kVHutSvARPTtGBpJ/8Z98bxnLoj2GDdmLnmLO5+p3TPf4oos2gK1zHeV
        TOx5Fscz8Vj8B9XmE/LasOsr1PavLNeCy/uKDzwvSpl4UNIe6SNtsuBhlhRvnUCDfc9H
        aBKFQc88/EdCzoDimAI0YdG6mucgAJm3ZX7ujLc/O+YHKzcskBjwDFeC26Obt4FiJenx
        MFOQ==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5G5MdirQj0WG7CkG2pemksDZxkJaUFnRbOB2TdqZ2g=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:9dbf:d1fd:eaf4:ea5d]
        by smtp.strato.de (RZmta 44.8 AUTH)
        with ESMTPSA id e03c1euBDDYo27i
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 13 Dec 2018 14:34:50 +0100 (CET)
Subject: Re: use generic DMA mapping code in powerpc V4
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-arch@vger.kernel.org,
        Darren Stevens <darren@stevens-zone.net>,
        linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Paul Mackerras <paulus@samba.org>,
        Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
References: <1ecb7692-f3fb-a246-91f9-2db1b9496305@xenosoft.de>
 <6c997c03-e072-97a9-8ae0-38a4363df919@xenosoft.de>
 <4cfb3f26-74e1-db01-b014-759f188bb5a6@xenosoft.de>
 <82879d3f-83de-6438-c1d6-49c571dcb671@xenosoft.de>
 <20181212141556.GA4801@lst.de>
 <2242B4B2-6311-492E-BFF9-6740E36EC6D4@xenosoft.de>
 <84558d7f-5a7f-5219-0c3a-045e6b4c494f@xenosoft.de>
 <20181213091021.GA2106@lst.de>
 <835bd119-081e-a5ea-1899-189d439c83d6@xenosoft.de>
 <76bc684a-b4d2-1d26-f18d-f5c9ba65978c@xenosoft.de>
 <20181213112511.GA4574@lst.de>
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <e109de27-f4af-147d-dc0e-067c8bafb29b@xenosoft.de>
Date:   Thu, 13 Dec 2018 14:34:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181213112511.GA4574@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 December 2018 at 12:25PM, Christoph Hellwig wrote:
> On Thu, Dec 13, 2018 at 12:19:26PM +0100, Christian Zigotzky wrote:
>> I tried it again but I get the following error message:
>>
>> MODPOST vmlinux.o
>> arch/powerpc/kernel/dma-iommu.o: In function `.dma_iommu_get_required_mask':
>> (.text+0x274): undefined reference to `.dma_direct_get_required_mask'
>> make: *** [vmlinux] Error 1
> Sorry, you need this one liner before all the patches posted last time:
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index d8819e3a1eb1..7e78c2798f2f 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -154,6 +154,7 @@ config PPC
>   	select CLONE_BACKWARDS
>   	select DCACHE_WORD_ACCESS		if PPC64 && CPU_LITTLE_ENDIAN
>   	select DYNAMIC_FTRACE			if FUNCTION_TRACER
> +	select DMA_DIRECT_OPS
>   	select EDAC_ATOMIC_SCRUB
>   	select EDAC_SUPPORT
>   	select GENERIC_ATOMIC64			if PPC32
>
Thanks. Result: PASEMI onboard ethernet works and the X5000 (P5020 
board) boots with the patch '0001-get_required_mask.patch'.

-- Christian

