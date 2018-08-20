Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3978DC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 12:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D789F2154B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 12:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QKj5OkaB";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fDzlGu5d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D789F2154B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbeHTQAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 12:00:53 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53194 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbeHTQAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 12:00:52 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 515646147D; Mon, 20 Aug 2018 12:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534769122;
        bh=ZNjN8Jhgow3lppAaAFbFL5fQJ4v6dFSpn872iLGQqX0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QKj5OkaBwkrHK09hs7LszISKP85WYwqfp5DOV3y3xXXdQhMk66jaIMIu3K1ZgZ/Cj
         vmat4DCe0Awjjf4BaMkww9dZsqqmvPuxO0B2EYciovXb2cRNl3TUtPgF0RenGS5meu
         KOpzdRyxhipLXWvbFj3Zh2w5d5eqdsmX9tC12UsM=
Received: from [10.201.3.39] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sricharan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2E85161230;
        Mon, 20 Aug 2018 12:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534769121;
        bh=ZNjN8Jhgow3lppAaAFbFL5fQJ4v6dFSpn872iLGQqX0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fDzlGu5d8x/CtnrSEEqwjs0QHkCrdH3D2d2t/CAagW8sBd+qYhcpUEYZahhuCPzr7
         P4917xkjG+73dEcs9FJRhDjNoS7vCzvIghPGuG1foFhnRu08Ok7Nunf6WpoA4ZSFS+
         vAc4VJlapQbsewAvfdt+gKmQ41Jz9r0Nn2VanjPU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2E85161230
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [PATCH v12 13/14] cpufreq: qcom: Re-organise kryo cpufreq to use
 it for other nvmem based qcom socs
To:     Rob Herring <robh@kernel.org>
Cc:     mark.rutland@arm.com, sudeep.holla@arm.com, linux@arm.linux.org.uk,
        ctatlor97@gmail.com, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        mturquette@baylibre.com, linux-pm@vger.kernel.org,
        sboyd@codeaurora.org, linux@armlinux.org.uk,
        thierry.escande@linaro.org, linux-kernel@vger.kernel.org,
        david.brown@linaro.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, andy.gross@linaro.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, niklas.cassel@linaro.org
References: <1534248753-2440-1-git-send-email-sricharan@codeaurora.org>
 <1534248753-2440-14-git-send-email-sricharan@codeaurora.org>
 <20180817150902.GA19164@rob-hp-laptop>
From:   Sricharan R <sricharan@codeaurora.org>
Message-ID: <a89bd80c-bdfc-77ed-1de9-9cad38da7cf5@codeaurora.org>
Date:   Mon, 20 Aug 2018 18:15:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180817150902.GA19164@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 8/17/2018 8:39 PM, Rob Herring wrote:
> Hi, this email is from Rob's (experimental) review bot. I found a couple
> of common problems with your patch. Please see below.
> 
> On Tue, 14 Aug 2018 17:42:32 +0530, Sricharan R wrote:
>> The kryo cpufreq driver reads the nvmem cell and uses that data to
>> populate the opps. There are other qcom cpufreq socs like krait which
>> does similar thing. Except for the interpretation of the read data,
>> rest of the driver is same for both the cases. So pull the common things
>> out for reuse.
>>
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> 
> The preferred subject prefix is "dt-bindings: <binding dir>: ...".
> 

 ok, will change and keep the bindings update part out for this and the next
 patch.

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
