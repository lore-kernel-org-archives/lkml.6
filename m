Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56591C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AEE02088E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="FOH3e5Ir"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AEE02088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbeGZJK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 05:10:56 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:53810 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbeGZJK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 05:10:56 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id B45415C06D3;
        Thu, 26 Jul 2018 09:55:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1532591716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X0YXUnHZOhT8QBodmQ8THjsw/D1H/MDjXL2W1tCmpEM=;
        b=FOH3e5Ir60kkZSjW2pV8fAeLcp+kip/RHfcv/F6N5WY3/xJAR1YAA7LcpkAtQMoTgKjDBq
        ioR7N+zqXWxPNqs+luwQ5TnWF4T57jFfLWr0pyfZ0yQErO/kiWa0KhYA5bMyAIwNqvWTjH
        g7/AL+BKajH5SaC3y2h89CK4emFsqVQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Thu, 26 Jul 2018 09:55:16 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Marcel Ziswiler <marcel@ziswiler.com>,
        Peter Geis <pgwipeout@gmail.com>, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-tegra-owner@vger.kernel.org
Subject: Re: [PATCH] clk: tegra: probe deferral error reporting
In-Reply-To: <153259028259.48062.10565668407094066922@swboyd.mtv.corp.google.com>
References: <20180720075422.26563-1-marcel@ziswiler.com>
 <153256109511.48062.12389268791907553857@swboyd.mtv.corp.google.com>
 <b202fe11-108f-c62c-bb6d-9e3a7de5a964@gmail.com>
 <153259028259.48062.10565668407094066922@swboyd.mtv.corp.google.com>
Message-ID: <13595e6b8bfb364023648297cad7da1b@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
X-Spamd-Result: default: False [-0.10 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[13];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         RCVD_TLS_ALL(0.00)[];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.07.2018 09:31, Stephen Boyd wrote:
> Quoting Peter Geis (2018-07-25 16:42:34)
>> On 7/25/2018 7:24 PM, Stephen Boyd wrote:
>> > Quoting Marcel Ziswiler (2018-07-20 00:54:22)
>> >> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>> >>
>> >> Actually report the error code from devm_regulator_get() which may as
>> >> well just be a probe deferral.
>> >>
>> >> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>> >>
>> >> ---
>> >>
>> >>   drivers/clk/tegra/clk-dfll.c | 5 +++--
>> >>   1 file changed, 3 insertions(+), 2 deletions(-)
>> >>
>> >> diff --git a/drivers/clk/tegra/clk-dfll.c b/drivers/clk/tegra/clk-dfll.c
>> >> index 48ee43734e05..b2123084e175 100644
>> >> --- a/drivers/clk/tegra/clk-dfll.c
>> >> +++ b/drivers/clk/tegra/clk-dfll.c
>> >> @@ -1609,8 +1609,9 @@ int tegra_dfll_register(struct platform_device *pdev,
>> >>
>> >>          td->vdd_reg = devm_regulator_get(td->dev, "vdd-cpu");
>> >>          if (IS_ERR(td->vdd_reg)) {
>> >> -               dev_err(td->dev, "couldn't get vdd_cpu regulator\n");
>> >> -               return PTR_ERR(td->vdd_reg);
>> >> +               ret = PTR_ERR(td->vdd_reg);
>> >> +               dev_err(td->dev, "couldn't get vdd_cpu regulator: %d\n", ret);
>> >
>> > Do you want to know that a probe defer is happening? Usually patches are
>> > sent to make that error path silent.
>> >
>>
>> Just asking as the newbie here, but shouldn't probe deferral be
>> regulated to dev_debug?
>> Then pass any other error code as dev_err.
> 
> Yes probe defer should be relegated to debug level prints. Or really, we
> should introduce a more complicated system to make debugging probe defer
> errors simpler by informing us which driver is probe defering on what
> resource by putting debug prints in each framework that returns probe
> defer errors instead of updating each driver that uses these frameworks
> and thinks it needs to print errors in these cases. And hide all that
> behind some kernel commandline parameter and/or Kconfig option that lets
> us turn the prints off all the time if we're not developing drivers or
> testing things.

Afaict, that is already there in:
drivers/base/dd.c:really_probe()

So I suggest to just silence the EPROBE_DEFER case, e.g.\


	if (IS_ERR(td->vdd_reg)) {
		ret = PTR_ERR(td->vdd_reg);
		if (ret != -EPROBE_DEFER)
			dev_err(td->dev, "couldn't get vdd_cpu regulator: %d\n", ret);

		return ret;
	}

--
Stefan


> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
