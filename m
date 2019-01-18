Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A48C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 07:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE8EB20850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 07:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="X7IeL9GG";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hO0rdoEf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfARHEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 02:04:41 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:60640 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbfARHEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 02:04:41 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 889876085C; Fri, 18 Jan 2019 07:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547795079;
        bh=YUOHSqKMaevgPNmykeclViTfddduB4i6ykqJgNiPR9E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X7IeL9GGLwH6zE3/G9WBh4Wgge1xyxxhoLYGUICPj56zkCgaC0s8A1CCWdtkfdRJT
         OGmboRFmKP3ztbPIPPmin/gxO38MOcoKWJ8erggbULP+631agnUlWJ5QNIXEUXIJHX
         mGdN3HGCYjugK/qDlICHU9jf/pd3EIqS2gwpRweU=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id D4EE860591;
        Fri, 18 Jan 2019 07:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547795078;
        bh=YUOHSqKMaevgPNmykeclViTfddduB4i6ykqJgNiPR9E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hO0rdoEfPkHmNxRPYTAkPRvQ7i155vK2Dy5ieQO8jl5OaSKof05QlkV3fTqB3Lxpg
         r9FOOZWjJXa0u3n5d0HE/AoE0DoZVn/Bh5mJf0KZYqwOKxQ1/U7UopScYr+IXr7bFc
         r8Bz3n07FGmVXG9tUUan87aB/ROC4K7KHAR18osc=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 18 Jan 2019 12:34:38 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Ramon Fried <ramon.fried@gmail.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-owner@vger.kernel.org,
        "<Brian Norris>" <briannorris@chromium.org>
Subject: Re: [PATCH] remoteproc: qcom_q6v5: don't auto boot remote processor
In-Reply-To: <20180529042047.GE2259@tuxbook-pro>
References: <20180524192141.20323-1-ramon.fried@gmail.com>
 <20180529042047.GE2259@tuxbook-pro>
Message-ID: <e554b7e525554d49d193ff1f8ca51359@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-29 09:50, Bjorn Andersson wrote:
> On Thu 24 May 12:21 PDT 2018, Ramon Fried wrote:
> 
>> Sometimes that rmtfs userspace module is not brought
>> up fast enough and the modem crashes.
>> disabling automated boot in the driver and triggering
>> the boot from user-space sovles the problem.
>> 
>> Signed-off-by: Ramon Fried <ramon.fried@gmail.com>
> 
> Thanks for your patch Ramon. While this nudges the behavior to make
> things work slightly better I think we need to describe the explicit
> dependency between the mss firmware and the existence of rmtfs.
> 
> As our remoteprocs are essentially always-on I would prefer that they
> start "automatically" and not through use of the sysfs interface.
> 
> But we're at the point where this is a real problem on 410, 820 and 
> 845,
> so we have to come up with some way to tie these pieces together. If
> your patch suits that solution I will happily take it.
> 
> Regards,
> Bjorn

After experimenting with in kernel solutions for
three revisions and observing problems on graceful
shutdown usecase, switching to controlling the
remoteproc mss through rmtfs seems to solve all
the known issues.

https://patchwork.kernel.org/patch/10662395/

we should probably get this merged in, now that
we are planning to start/stop mss through
rmtfs.


Acked-by: Sibi Sankar <sibis@codeaurora.org>

> 
>> ---
>>  drivers/remoteproc/qcom_q6v5_pil.c | 2 ++
>>  1 file changed, 2 insertions(+)
>> 
>> diff --git a/drivers/remoteproc/qcom_q6v5_pil.c 
>> b/drivers/remoteproc/qcom_q6v5_pil.c
>> index cbbafdcaaecb..719ee96445b3 100644
>> --- a/drivers/remoteproc/qcom_q6v5_pil.c
>> +++ b/drivers/remoteproc/qcom_q6v5_pil.c
>> @@ -1133,6 +1133,8 @@ static int q6v5_probe(struct platform_device 
>> *pdev)
>>  		return -ENOMEM;
>>  	}
>> 
>> +	rproc->auto_boot = false;
>> +
>>  	qproc = (struct q6v5 *)rproc->priv;
>>  	qproc->dev = &pdev->dev;
>>  	qproc->rproc = rproc;
>> --
>> 2.17.0
>> 

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
