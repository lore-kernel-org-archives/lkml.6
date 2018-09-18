Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIM_INVALID autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0958C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 427912150D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="DPi4R7jE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 427912150D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730381AbeIRWs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 18:48:26 -0400
Received: from vern.gendns.com ([206.190.152.46]:51607 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729037AbeIRWsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 18:48:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xHzGTq4DcXNV/GYTzo6P0gomws1LCkomiJplLF94/Yo=; b=DPi4R7jEAaBCiDi4759nQ/1f9F
        c8KN2iQC4744RPm57R927i8ToVVGYcqLZy3eHRDfR1I+hjSBbp583e8KoAkx8/3tagnyMlQXNCK5H
        QIeugnaPuiW7eLCs7gXmzuIuUWBfAnfSSZS9gOUz+4X5tFXYo0szu519m/mRK4P2JGKk1VtyN8sj8
        X98kZH9m40w/DVD5LU5GcijFxr32bAJntL86qj9FEjPYYV8uXnGzhzXP8z6WCL7w0sdzyrVg95GVf
        45mQH1yTYRL4K6zubqQ24xeQOZaoPbw/o6HgYeRszzj7PBSJHEHiWb0BTuXsXR5tE36/IQhP9dw5H
        Kz3Vsuow==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:48398 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1g2JaM-0075bH-4b; Tue, 18 Sep 2018 13:14:50 -0400
Subject: Re: [PATCH 3/3] iio: adc: ti-ads7950: use SPI_CS_WORD to reduce CPU
 usage
To:     linux-spi@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org
References: <20180918170850.2749-1-david@lechnology.com>
 <20180918170850.2749-4-david@lechnology.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <7a70711c-5d38-5ba6-ec90-b2506dc0727d@lechnology.com>
Date:   Tue, 18 Sep 2018 12:14:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180918170850.2749-4-david@lechnology.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/18/2018 12:08 PM, David Lechner wrote:
> This changes how the SPI message for the triggered buffer is setup in
> the TI ADS7950 A/DC driver. By using the SPI_CS_WORD flag, we can read
> multiple samples in a single SPI transfer. If the SPI controller
> supports DMA transfers, we can see a significant reduction in CPU usage.
> 
> For example, on an ARM9 system running at 456MHz reading just 4 channels
> at 100Hz: before this change, top shows the CPU usage of the IRQ thread
> of this driver to be ~7.7%. After this change, the CPU usage drops to
> ~3.8%.
> 
> The use of big-endian for the raw data was cargo culted from another
> driver when this driver was originally written. It used an SPI word size
> of 8 bits and big-endian byte ordering to effectively emulate 16 bit
> words.
> 
> Now, in order to inject a CS toggle between each word, we need to use
> the correct word size, otherwise we would get a CS toggle half way
> through each word 16-bit. The SPI subsystem uses CPU byte ordering for
> multi-byte words. So, the data we get back from the SPI is going to be
> CPU endian now no matter what. Converting that to big endian will just
> add overhead on little endian systems so we opt to change the raw data
> format from big endian to CPU endian.
> 
> There is a small risk that this could break some lazy userspace programs
> that use the raw data without checking the data format. We can address
> this if/when it actually comes up.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---

And I just realized I forgot to pick up...


Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

