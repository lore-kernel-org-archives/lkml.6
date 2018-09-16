Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIM_INVALID autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93576ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 16:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 320732087E
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 16:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="VNTsXIHv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 320732087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbeIPVrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 17:47:46 -0400
Received: from vern.gendns.com ([206.190.152.46]:52051 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726840AbeIPVrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 17:47:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4Qn5P93A1gJi2Oa5WFG4/81ZmPloE2/r+Qg4adOdvQ0=; b=VNTsXIHvJhCV2yM1UKoKq0h2sW
        Pdhw4TRXVF9RJiBHYdwOjGHRbBzGzJJaTKmeCI9xw57xurbYv3VTlFoeHAPnxQpS77puLZr11SAvG
        Ts/XZmkCGbXc3s1DubVILubplFJDU/oUf0dgx5MDdfJm24JvVJhhcd4qvrteUJWU/AwnRjGGJP4p3
        Yss3139ayt+/PxYoUPDKuBr5qJe5u77XsxC/XXOxAUV/bvYVJsgf5Mj3e1EAjlzzxQ//c7n43KYwf
        XEBQ4dzG5/Z8/eLOl4jAfIeb4bkusZE6QbA/vmQu1Z0kAi+MT507cIh5EeDCKXYbQ5XpjLXeNozHV
        pIWoZwyA==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:44598 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1g1ZqK-0022Bw-7m; Sun, 16 Sep 2018 12:24:16 -0400
Subject: Re: [PATCH v2 3/4] iio: adc: ti-ads7950: use SPI_CS_WORD to reduce
 CPU usage
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
References: <20180913003920.30600-1-david@lechnology.com>
 <20180913003920.30600-4-david@lechnology.com>
 <20180916124110.4edfad9d@archlinux>
From:   David Lechner <david@lechnology.com>
Message-ID: <b8b6201c-3574-d383-e3e8-9f162206e505@lechnology.com>
Date:   Sun, 16 Sep 2018 11:24:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180916124110.4edfad9d@archlinux>
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

On 09/16/2018 06:41 AM, Jonathan Cameron wrote:
> On Wed, 12 Sep 2018 19:39:19 -0500
> David Lechner <david@lechnology.com> wrote:
> 
>> This changes how the SPI message for the triggered buffer is setup in
>> the TI ADS7950 A/DC driver. By using the SPI_CS_WORD flag, we can read
>> multiple samples in a single SPI transfer. If the SPI controller
>> supports DMA transfers, we can see a significant reduction in CPU usage.
>>
>> For example, on an ARM9 system running at 456MHz reading just 4 channels
>> at 100Hz: before this change, top shows the CPU usage of the IRQ thread
>> of this driver to be ~7.7%. After this change, the CPU usage drops to
>> ~3.8%.
>>
>> Signed-off-by: David Lechner <david@lechnology.com>
> 
> Hi David,
> 
> I've managed to forget why we are changing any of the endian related code
> at all.  The change SPI_CS_WORD result in changes between words which is
> fine but it doesn't change any ordering within words?  So as such why
> do we no longer need to do the big endian conversions?
> 

The big-endian stuff was cargo culted from another driver when this driver
was originally written. It used an SPI word size of 8 bits and big-endian
byte ordering to effectively emulate 16 bit words.

Now, in order to inject a CS toggle between each word, we need to use the
correct word size, otherwise we would get a CS toggle half way through
each word 16-bit. The SPI subsystem uses CPU byte ordering for multi-byte
words. So, the data we get back from the SPI is going to be CPU endian now
no matter what. Converting that to big endian will just add overhead on
little endian systems.
