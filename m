Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CE3C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C543520672
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TnQJtvTi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C543520672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbeLDVlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 16:41:51 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38390 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbeLDVlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 16:41:51 -0500
Received: by mail-oi1-f193.google.com with SMTP id a77so15668242oii.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 13:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h/yIvXNygN2qOUzK4IHRGbbks0fPHhysMhBDT+oPC6I=;
        b=TnQJtvTi4JAllcMCQncwal1hkGzVvsn2hBaD3DZ2vT4P6nWXF+JTU9nhpeTT2XCLrh
         mT8+AN561sfkmi7K2OrA1MUB+DGxeXCCamUeV31xM1aKX2605hqYkvM6Kv5QjVtIpaKH
         gTO/COg0p3EXYjWkReXvMP135zdCGevxz4xw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h/yIvXNygN2qOUzK4IHRGbbks0fPHhysMhBDT+oPC6I=;
        b=SCdmGCgoXqNjLrH3q3MQJ9t6DYWAbyV2VMGc/jxun3jZ0UTLT6gJD5+t/1Z9AgsxVs
         7X5PyWhZSwtKQ0UnXT+3MxbVoNPjgKXrBkBaFFWkGR0HvwvtJtADZ6fSuuMOkBtjb5Oo
         YT8NID3hOJhFH82XAMM54Vfl8hPj5rflZvbaz8Sx/yxLt5ojw48kvxE1BPvBSR0dgVco
         e4wOpdPU9SYPnCPWLy0ZekathYHc56e/INIccaZ+uIiyJCq993ugh/qRzUc48TFooUP5
         IfnBFAlaMkHIZ99zNCAyiTvOWJ9/KKLNuQrNdqUEvE7sK9i2V49LbklTRMpD1aWcjGih
         FVfA==
X-Gm-Message-State: AA+aEWbV+WXkSN5b/HrNTzhLsWHZv+E9qeWDhuObLCzFF5UqV/MPEmer
        TDmmyC7MdyOY/Mq4IoIe+0a4Ig==
X-Google-Smtp-Source: AFSGD/XyYPpIDtinLCr9z9lIU3LoY4RU1er9A1kZFbcKiDFA6MadfFhIVDDXjWm0twx5Fav/hlLnSA==
X-Received: by 2002:aca:33c2:: with SMTP id z185mr13820066oiz.4.1543959709649;
        Tue, 04 Dec 2018 13:41:49 -0800 (PST)
Received: from [172.22.22.26] (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.googlemail.com with ESMTPSA id 187sm15104411oic.12.2018.12.04.13.41.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 13:41:48 -0800 (PST)
Subject: Re: [RFC PATCH] clk: qcom: clk-rpmh: Add IPA clock support
To:     Stephen Boyd <sboyd@kernel.org>,
        David Dai <daidavid1@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        evgreen@google.com, tdas@codeaurora.org
References: <1543895413-1553-1-git-send-email-daidavid1@codeaurora.org>
 <1543895413-1553-2-git-send-email-daidavid1@codeaurora.org>
 <154395145491.88331.1174781210192403998@swboyd.mtv.corp.google.com>
From:   Alex Elder <elder@linaro.org>
Message-ID: <8dafe631-4b16-94cd-392e-84728f2bb382@linaro.org>
Date:   Tue, 4 Dec 2018 15:41:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <154395145491.88331.1174781210192403998@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/18 1:24 PM, Stephen Boyd wrote:
> Quoting David Dai (2018-12-03 19:50:13)
>> Add IPA clock support by extending the current clk rpmh driver to support
>> clocks that are managed by a different type of RPMh resource known as
>> Bus Clock Manager(BCM).
> 
> Yes, but why? Does the IPA driver need to set clk rates and that somehow
> doesn't work as a bandwidth request?

The IPA core clock is a *clock*, not a bus.  Representing it as if
it were a bus, abusing the interconnect interface--pretending a bandwidth
request is really a clock rate request--is kind of kludgy.  I think Bjorn
and David (and maybe Georgi? I don't know) decided a long time ago that
exposing this as a clock is the right way to do it.  I agree with that.

					-Alex

>> Signed-off-by: David Dai <daidavid1@codeaurora.org>
>> ---
>> diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
>> index 9f4fc77..42e2cd2 100644
>> --- a/drivers/clk/qcom/clk-rpmh.c
>> +++ b/drivers/clk/qcom/clk-rpmh.c
>> @@ -18,6 +18,32 @@
>>  #define CLK_RPMH_ARC_EN_OFFSET         0
>>  #define CLK_RPMH_VRM_EN_OFFSET         4
>>  
>> +#define BCM_TCS_CMD_COMMIT_MASK                0x40000000
>> +#define BCM_TCS_CMD_VALID_SHIFT                29
>> +#define BCM_TCS_CMD_VOTE_MASK          0x3fff
>> +#define BCM_TCS_CMD_VOTE_SHIFT         0
>> +
>> +#define BCM_TCS_CMD(valid, vote) \
>> +       (BCM_TCS_CMD_COMMIT_MASK |\
> 
> Nitpick: Add space before the \ and align them all up on the right side
> of the page.
> 
>> +       ((valid) << BCM_TCS_CMD_VALID_SHIFT) |\
>> +       ((cpu_to_le32(vote) &\
>> +       BCM_TCS_CMD_VOTE_MASK) << BCM_TCS_CMD_VOTE_SHIFT))
>> +
>> +/**
>> + * struct bcm_db - Auxiliary data pertaining to each Bus Clock Manager(BCM)
>> + * @unit: divisor used to convert Hz value to an RPMh msg
>> + * @width: multiplier used to convert Hz value to an RPMh msg
>> + * @vcd: virtual clock domain that this bcm belongs to
>> + * @reserved: reserved to pad the struct
>> + */
>> +
> 
> Nitpick: Please remove the newline between comment and struct.
> 
>> +struct bcm_db {
>> +       u32 unit;
>> +       u16 width;
>> +       u8 vcd;
>> +       u8 reserved;
> 
> These would need __le32 and __le16 for the byte swap.
> 
>> +};
>> +
>>  /**
>>   * struct clk_rpmh - individual rpmh clock data structure
>>   * @hw:                        handle between common and hardware-specific interfaces
>> @@ -210,6 +249,91 @@ static unsigned long clk_rpmh_recalc_rate(struct clk_hw *hw,
>>         .recalc_rate    = clk_rpmh_recalc_rate,
>>  };
>>  
>> +static int clk_rpmh_bcm_send_cmd(struct clk_rpmh *c, bool enable)
>> +{
>> +       struct tcs_cmd cmd = { 0 };
>> +       u32 cmd_state;
>> +       int ret;
>> +
>> +       cmd_state = enable ? (c->aggr_state ? c->aggr_state : 1) : 0;
>> +
>> +       if (c->last_sent_aggr_state == cmd_state)
>> +               return 0;
>> +
>> +       cmd.addr = c->res_addr;
>> +       cmd.data = BCM_TCS_CMD(enable, cmd_state);
>> +
>> +       ret = rpmh_write_async(c->dev, RPMH_ACTIVE_ONLY_STATE, &cmd, 1);
>> +       if (ret) {
>> +               dev_err(c->dev, "set active state of %s failed: (%d)\n",
>> +                       c->res_name, ret);
>> +               return ret;
>> +       }
>> +
>> +       c->last_sent_aggr_state = cmd_state;
>> +
>> +       return 0;
>> +}
>> +
>> +static int clk_rpmh_bcm_prepare(struct clk_hw *hw)
>> +{
>> +       struct clk_rpmh *c = to_clk_rpmh(hw);
>> +       int ret = 0;
> 
> Don't initialize variables and then reassign them right after.
> 
>> +
>> +       mutex_lock(&rpmh_clk_lock);
>> +       ret = clk_rpmh_bcm_send_cmd(c, true);
>> +       mutex_unlock(&rpmh_clk_lock);
>> +
>> +       return ret;
>> +};
>> +
>> +static void clk_rpmh_bcm_unprepare(struct clk_hw *hw)
>> +{
>> +       struct clk_rpmh *c = to_clk_rpmh(hw);
>> +
>> +       mutex_lock(&rpmh_clk_lock);
>> +       clk_rpmh_bcm_send_cmd(c, false);
>> +       mutex_unlock(&rpmh_clk_lock);
>> +};
>> +
>> +static int clk_rpmh_bcm_set_rate(struct clk_hw *hw, unsigned long rate,
>> +                                unsigned long parent_rate)
>> +{
>> +       struct clk_rpmh *c = to_clk_rpmh(hw);
>> +
>> +       c->aggr_state = rate / (c->aux_data.unit * 1000);
>> +
>> +       if (clk_hw_is_prepared(hw)) {
> 
> Why do we need to check is_prepared? Add a comment indicating we can't
> send the request when the clk is disabled?
> 
>> +               mutex_lock(&rpmh_clk_lock);
>> +               clk_rpmh_bcm_send_cmd(c, true);
> 
> This function is always inside mutex_lock()/unlock() pair, so push the
> lock into the function?
> 
>> +               mutex_unlock(&rpmh_clk_lock);
>> +       }
>> +
>> +       return 0;
>> +};
>> +
>> +static long clk_rpmh_round_rate(struct clk_hw *hw, unsigned long rate,
>> +                               unsigned long *parent_rate)
>> +{
>> +       return rate;
>> +}
>> +
>> +static unsigned long clk_rpmh_bcm_recalc_rate(struct clk_hw *hw,
>> +                                       unsigned long prate)
>> +{
>> +       struct clk_rpmh *c = to_clk_rpmh(hw);
>> +
>> +       return c->aggr_state * c->aux_data.unit * 1000;
> 
> What is 1000 for?
> 
>> +}
>> +
>> +static const struct clk_ops clk_rpmh_bcm_ops = {
>> +       .prepare        = clk_rpmh_bcm_prepare,
>> +       .unprepare      = clk_rpmh_bcm_unprepare,
>> +       .set_rate       = clk_rpmh_bcm_set_rate,
>> +       .round_rate     = clk_rpmh_round_rate,
>> +       .recalc_rate    = clk_rpmh_bcm_recalc_rate,
>> +};
>> +
>>  /* Resource name must match resource id present in cmd-db. */
>>  DEFINE_CLK_RPMH_ARC(sdm845, bi_tcxo, bi_tcxo_ao, "xo.lvl", 0x3, 2);
>>  DEFINE_CLK_RPMH_VRM(sdm845, ln_bb_clk2, ln_bb_clk2_ao, "lnbclka2", 2);
>> @@ -275,6 +402,21 @@ static int clk_rpmh_probe(struct platform_device *pdev)
>>                                 rpmh_clk->res_name);
>>                         return -ENODEV;
>>                 }
> 
> Nitpick: Please add newline here.
> 
>> +               aux_data_len = cmd_db_read_aux_data_len(rpmh_clk->res_name);
>> +               if (aux_data_len == sizeof(struct bcm_db)) {
>> +                       ret = cmd_db_read_aux_data(rpmh_clk->res_name,
>> +                                                  (u8 *)&rpmh_clk->aux_data,
> 
> Is the cast necessary? And I would just pick out the data you need from
> the aux_data instead of storing it forever (with the padding) in the
> rpmh_clk structure.
> 
>> +                                                  sizeof(struct bcm_db));
>> +                       if (ret < 0) {
>> +                               dev_err(&pdev->dev, "aux data read failure for %s (%d)\n",
>> +                               rpmh_clk->res_name, ret);
>> +                               return ret;
>> +                       }
>> +                       rpmh_clk->aux_data.unit =
>> +                                       le32_to_cpu(rpmh_clk->aux_data.unit);
>> +                       rpmh_clk->aux_data.width =
>> +                                       le16_to_cpu(rpmh_clk->aux_data.width);
>> +               }
> 
> Nitpick: Newline here too.
> 
>>                 rpmh_clk->res_addr += res_addr;
>>                 rpmh_clk->dev = &pdev->dev;
>>  

