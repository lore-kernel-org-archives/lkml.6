Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6ABC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A438820877
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vw87XF1c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A438820877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbeIYPsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:48:36 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34326 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728815AbeIYPsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:48:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id t15so14687241wrx.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 02:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FXPFb51iJhDWHlD62HL8jFORdU4n9IT6Gs5SKiNCaXA=;
        b=Vw87XF1crgq+C9bZcq5mky5F56JOMPmjjbo6pBiBJZqJ+ogr2hPySUZkqpkRvlI5VH
         4Tg/hcHQ6iw7yu626AvsvMG5mlBaRixPLAtQ7SbTW1bcEAgGt9RAaRHjmkFGRYcUa3tP
         2WNITNWYTAM/5dnHXS5E3jN2TDyXVAb555CwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FXPFb51iJhDWHlD62HL8jFORdU4n9IT6Gs5SKiNCaXA=;
        b=UGXIr9p7PYfK7FhgXPLBx30QTrBE+AVef6Y4xpC+ZlVnU6uDk9s221VfRf0G8cphM2
         jaHMj7GswYdBFs3Q6YP8ql6/Jaee2gY61QGGUtqu5WHEawrHBloNGpWsYeEVXyNIfg7E
         5eMhIQNJU6tWpm3LA47RueMvToJ28R2I0ZefI6rkEfUaJ9Jo2HI4Hp8Qg9eOeiCkbVOF
         +0GtT6LLBrkF7L/OMAMSBe/S85w2pQmDfk1ptRISqOb/8l4X4xjiG/Ag6PpEHUsLh7mf
         ATWc3feKwNWDyjOAtQoDAAhqFw8aaOmxLWehKKqBfrGhApd2gy4kjOvq6h1y3swllRRS
         qbHA==
X-Gm-Message-State: ABuFfogAV7a/zkSGLuRXcuGhQCcSUN8UeuvpL2ccPs/1sQtr3SYP3Uqx
        42iiEvUV+Cea6qxeyLW0BmmUph4P7yY=
X-Google-Smtp-Source: ACcGV62hZTcnb68V/w83PG/Y2SfGF8tR6Qev4B+x7A1dWAHVUZ8yh5YqGp6AccZjMSA54jFJTgvM5A==
X-Received: by 2002:a5d:5450:: with SMTP id w16-v6mr241273wrv.4.1537868512456;
        Tue, 25 Sep 2018 02:41:52 -0700 (PDT)
Received: from [192.168.27.123] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id 1-v6sm2229474wmf.47.2018.09.25.02.41.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 02:41:51 -0700 (PDT)
Subject: Re: [PATCH] venus: vdec: fix decoded data size
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     vgarodia@codeaurora.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <1530517447-29296-1-git-send-email-vgarodia@codeaurora.org>
 <01451f8e-aea3-b276-cb01-b0666a837d62@linaro.org>
 <4ce55726d810e308a2cae3f84bca7140bed48c7d.camel@ndufresne.ca>
 <92f6f79a-02ae-d23e-1b97-fc41fd921c89@linaro.org>
 <33e8d8e3-138e-0031-5b75-4bef114ac75e@xs4all.nl>
 <36b42952-982c-9048-77fb-72ca45cc7476@linaro.org>
 <051af6fb-e0e8-4008-99c5-9685ac24e454@xs4all.nl>
 <CAPBb6MVupMsdhF6Rtk4fm8JeVurrK+ZsuxAQ-BwrTzdSP1xP0Q@mail.gmail.com>
 <6d65ac0d-80a0-88fe-ed19-4785f2675e36@linaro.org>
 <bec2edfda26ecbac928871ad14d768790e3175a8.camel@ndufresne.ca>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <72bce7dc-ceef-cc81-1edb-8034495684ae@linaro.org>
Date:   Tue, 25 Sep 2018 12:41:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <bec2edfda26ecbac928871ad14d768790e3175a8.camel@ndufresne.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

On 09/19/2018 06:53 PM, Nicolas Dufresne wrote:
> Le mercredi 19 septembre 2018 à 18:02 +0300, Stanimir Varbanov a
> écrit :
>>> --- a/drivers/media/platform/qcom/venus/vdec.c
>>> +++ b/drivers/media/platform/qcom/venus/vdec.c
>>> @@ -943,8 +943,7 @@ static void vdec_buf_done(struct venus_inst
>>> *inst,
>>> unsigned int buf_type,
>>>                 unsigned int opb_sz =
>>> venus_helper_get_opb_size(inst);
>>>
>>>                 vb = &vbuf->vb2_buf;
>>> -               vb->planes[0].bytesused =
>>> -                       max_t(unsigned int, opb_sz, bytesused);
>>> +                vb2_set_plane_payload(vb, 0, bytesused ? :
>>> opb_sz);
>>>                 vb->planes[0].data_offset = data_offset;
>>>                 vb->timestamp = timestamp_us * NSEC_PER_USEC;
>>>                 vbuf->sequence = inst->sequence_cap++;
>>>
>>> It works fine for me, and should not return 0 more often than it
>>> did
>>> before (i.e. never). In practice I also never see the firmware
>>> reporting a payload of zero on SDM845, but maybe older chips
>>> differ?
>>
>> yes, it looks fine. Let me test it with older versions.
> 
> What about removing the allow_zero_bytesused flag on this specific
> queue ? Then you can leave it to 0, and the framework will change it to
> the buffer size.

This is valid only for OUTPUT type buffers, but here we bother for
CAPTURE buffers.

-- 
regards,
Stan
