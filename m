Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F75BC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD96A25471
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TRngxVDa";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TRngxVDa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD96A25471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934151AbeGBJfY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 05:35:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60560 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933423AbeGBJfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 05:35:21 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D5DF360B14; Mon,  2 Jul 2018 09:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530524120;
        bh=eJ18xMIPVgnGbrZcVLHcYO23CmazJEqoHMr+9t8p1DA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TRngxVDay4hEx/oIQyqNkpO7aZwDkkG0QE3/rAInsfO28i8Qtdqd2iazJMEDSj2xc
         lCiOfbXJE5UgEbjjZk+s7DDkPJCm5u0Vw45z59VkvD9AR/+odH8yCwCvp64sviEDoi
         GDpB1AcOD2NeNsERKXwavXMZ+ffxNto0X9hnGqIc=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 29AB1601CF;
        Mon,  2 Jul 2018 09:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530524120;
        bh=eJ18xMIPVgnGbrZcVLHcYO23CmazJEqoHMr+9t8p1DA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TRngxVDay4hEx/oIQyqNkpO7aZwDkkG0QE3/rAInsfO28i8Qtdqd2iazJMEDSj2xc
         lCiOfbXJE5UgEbjjZk+s7DDkPJCm5u0Vw45z59VkvD9AR/+odH8yCwCvp64sviEDoi
         GDpB1AcOD2NeNsERKXwavXMZ+ffxNto0X9hnGqIc=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 02 Jul 2018 15:05:20 +0530
From:   Vikash Garodia <vgarodia@codeaurora.org>
To:     Alexandre Courbot <acourbot@chromium.org>
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>,
        linux-media-owner@vger.kernel.org
Subject: Re: [PATCH v4 24/27] venus: helpers: move frame size calculations on
 common place
In-Reply-To: <CAPBb6MVPrparfoAMaVwsDrwPO1K8cnWb24WdZFGeU5aoEqDt5w@mail.gmail.com>
References: <20180627152725.9783-1-stanimir.varbanov@linaro.org>
 <20180627152725.9783-25-stanimir.varbanov@linaro.org>
 <CAPBb6MVPrparfoAMaVwsDrwPO1K8cnWb24WdZFGeU5aoEqDt5w@mail.gmail.com>
Message-ID: <4e22af7d7ef9037996b606892ed25b36@codeaurora.org>
X-Sender: vgarodia@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-02 14:16, Alexandre Courbot wrote:
> On Thu, Jun 28, 2018 at 12:28 AM Stanimir Varbanov
> <stanimir.varbanov@linaro.org> wrote:
>> 
>> This move the calculations of raw and compressed buffer sizes
>> on common helper and make it identical for encoder and decoder.
>> 
>> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
>> ---
>>  drivers/media/platform/qcom/venus/helpers.c | 98 
>> +++++++++++++++++++++++++++++
>>  drivers/media/platform/qcom/venus/helpers.h |  2 +
>>  drivers/media/platform/qcom/venus/vdec.c    | 54 ++++------------
>>  drivers/media/platform/qcom/venus/venc.c    | 56 ++++-------------
>>  4 files changed, 126 insertions(+), 84 deletions(-)
>> 
>> diff --git a/drivers/media/platform/qcom/venus/helpers.c 
>> b/drivers/media/platform/qcom/venus/helpers.c
>> index 6b31c91528ed..a342472ae2f0 100644
>> --- a/drivers/media/platform/qcom/venus/helpers.c
>> +++ b/drivers/media/platform/qcom/venus/helpers.c
>> @@ -452,6 +452,104 @@ int venus_helper_get_bufreq(struct venus_inst 
>> *inst, u32 type,
>>  }
>>  EXPORT_SYMBOL_GPL(venus_helper_get_bufreq);
>> 
>> +static u32 get_framesize_raw_nv12(u32 width, u32 height)
>> +{
>> +       u32 y_stride, uv_stride, y_plane;
>> +       u32 y_sclines, uv_sclines, uv_plane;
>> +       u32 size;
>> +
>> +       y_stride = ALIGN(width, 128);
>> +       uv_stride = ALIGN(width, 128);
>> +       y_sclines = ALIGN(height, 32);
>> +       uv_sclines = ALIGN(((height + 1) >> 1), 16);
>> +
>> +       y_plane = y_stride * y_sclines;
>> +       uv_plane = uv_stride * uv_sclines + SZ_4K;
>> +       size = y_plane + uv_plane + SZ_8K;
> 
> Do you know the reason for this extra 8K at the end?

As explained about the hardware requirement over bug [1], 8k is not 
needed.
I am working on a patch to fix the alignment requirement for ubwc format 
as
well.
In downstream driver, this 8k was added to accomodate the video 
extradata.

[1] https://partnerissuetracker.corp.google.com/u/1/issues/110448791
