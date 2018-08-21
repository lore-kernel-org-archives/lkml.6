Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96847C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 565BE21837
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="D7dQ8k68";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Njt+cdoH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 565BE21837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbeHUUuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:50:21 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59058 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbeHUUuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:50:21 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 708E760C7E; Tue, 21 Aug 2018 17:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534872556;
        bh=mcYwkC2sv/kazNmU5yj78aSm5tr5j5ZQoRL+e8Z++Yk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=D7dQ8k68TGC2L8Ist2a9X9RlAUQB2mW9gblJwNTMU89waxsLmwgCGmAKEWJiuQZ+c
         WJ0w13LVq+n4q6khh1JhTF5tuTMXcOXnPV3vAo81IM30fiYMYetLIx3YlnlqcopJGK
         KU137Bdl0t9xFQNFmcTQkG4wGBO9075WlBmKubZU=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id A0C1060585;
        Tue, 21 Aug 2018 17:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534872555;
        bh=mcYwkC2sv/kazNmU5yj78aSm5tr5j5ZQoRL+e8Z++Yk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Njt+cdoHtH2TAdocq+Yw5gWOQ7/4My/V2PIWKQiV1HvZicGTPcABBbemmcwXwQZvE
         tM8DeskSgG4KNGz7wU7DWe/pSo3kuVt2CrrthPzR7bDkeu7EVNH3jnZ6jR2ncCHcGx
         u6osNvjLGaSTZw8Ro9DNbn13P6wQQSMNMtLBiBsM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 21 Aug 2018 22:59:15 +0530
From:   Vikash Garodia <vgarodia@codeaurora.org>
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     hverkuil@xs4all.nl, mchehab@kernel.org, robh@kernel.org,
        mark.rutland@arm.com, andy.gross@linaro.org, arnd@arndb.de,
        bjorn.andersson@linaro.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        acourbot@chromium.org, linux-media-owner@vger.kernel.org
Subject: Re: [PATCH v4 2/4] venus: firmware: move load firmware in a separate
 function
In-Reply-To: <8ffd63d9-ba9f-44b2-e1c0-7edce167fd9c@linaro.org>
References: <1533562085-8773-1-git-send-email-vgarodia@codeaurora.org>
 <1533562085-8773-3-git-send-email-vgarodia@codeaurora.org>
 <8ffd63d9-ba9f-44b2-e1c0-7edce167fd9c@linaro.org>
Message-ID: <4ad5d921a54256bccfd7030a3f0893d8@codeaurora.org>
X-Sender: vgarodia@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stanimir,

On 2018-08-21 17:38, Stanimir Varbanov wrote:
> Hi Vikash,
> 
> On 08/06/2018 04:28 PM, Vikash Garodia wrote:

<snip>

>> -int venus_boot(struct device *dev, const char *fwname)
>> +static int venus_load_fw(struct venus_core *core, const char *fwname,
>> +			phys_addr_t *mem_phys, size_t *mem_size)
> 
> fix indentation
Please let me know which indentation rule is missed out here. As per 
last
discussion, the parameters on next line should start from open 
parenthesis.
I see the same being followed above.
Also i have been running checkpatch script and it does not show up any 
issue.
Any other script which can be executed to ensure the coding guidelines ?

<snip>

>> 
>> -	ret = qcom_mdt_load(dev, mdt, fwname, VENUS_PAS_ID, mem_va, 
>> mem_phys,
>> -			    mem_size, NULL);
>> +	if (core->no_tz)
>> +		ret = qcom_mdt_load_no_init(dev, mdt, fwname, VENUS_PAS_ID,
>> +					mem_va, *mem_phys, *mem_size, NULL);
>> +	else
>> +		ret = qcom_mdt_load(dev, mdt, fwname, VENUS_PAS_ID,
>> +				mem_va, *mem_phys, *mem_size, NULL);
> 
> Please fix the indentation issues above.
Please specify here as well.

>> 
>>  	release_firmware(mdt);
>> 
>> -	if (ret)
>> -		goto err_unmap;
>> -
>> -	ret = qcom_scm_pas_auth_and_reset(VENUS_PAS_ID);
>> -	if (ret)
>> -		goto err_unmap;
>> -
>>  err_unmap:
>>  	memunmap(mem_va);
>>  	return ret;
>>  }
>> 
>> +int venus_boot(struct venus_core *core)
>> +{
>> +	phys_addr_t mem_phys;
>> +	struct device *dev = core->dev;
> 
> move this one row upper.
> 
>> +	size_t mem_size;
>> +	int ret;
>> +
>> +	if (!IS_ENABLED(CONFIG_QCOM_MDT_LOADER) ||
>> +		(!core->no_tz && !qcom_scm_is_available()))
>> +		return -EPROBE_DEFER;
> 
> fix indentation
Please specify here as well.

Thanks,
Vikash
