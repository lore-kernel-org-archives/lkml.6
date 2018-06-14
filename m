Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5DF02C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 16:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14168208DD
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 16:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XccGtTvJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14168208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964925AbeFNQwS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 12:52:18 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43469 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964883AbeFNQwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 12:52:16 -0400
Received: by mail-wr0-f193.google.com with SMTP id d2-v6so7143095wrm.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 09:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KpB9FnWs3wUeLUnB/j2eOXcY73XZQo9x3/NiFvH51t8=;
        b=XccGtTvJPRf0jBaxLaxqtYS5+Gx5xcIeYzXsf0ddJKbk+4BeSh9oXLxw5LVihQ2q6p
         mk69o+B5Evz/w3OYWLDRpjhEJoikMtIKwg5LXZLO+gTj3lji6e6d6Nj4aQOaNz02LTuc
         tG3DzJlDfTUJ+ruguCgLTCQHFqSss2QIIwa0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KpB9FnWs3wUeLUnB/j2eOXcY73XZQo9x3/NiFvH51t8=;
        b=MQGfASXUdWQhiq43X9YHUgdiZJY3e/AC9ejPKQ7fmg6BGnJjdMhqYWBYs9KVCynLQz
         VO2yuCk88DU2bNcAahuqbvu7r3Bq0zUPLfNWLqILs4VbougPQGp24gBLkbB4L1kNCnNt
         EacVmFvgz+dfWYcEcl1uk6wBbBxeUrTny0zHWgHNCCOJpQJo0xfZpXqTRiXJJNhcFLAf
         4ixdDVCA+CHAcTHryECccZypZ580pHwzem1socZ/3THsiTz2uAIczVHNfad/0Ng74tB+
         9oBjvQ1RnWlF2aNZOuiqVG4NdYEV/OG8WO7UViSg+QVb6cELe/lXKoRGkzZOmKiuRLEF
         7D7w==
X-Gm-Message-State: APt69E0ejP+mCnPdSRJw13sKRSQzqJe/CfqNkbWwFWvZacQyGvnwOCYn
        jIuo0fFc+2MYuIQUfI7RL5J/R+BqDBs=
X-Google-Smtp-Source: ADUXVKL9/VGp8aBgitUgkZIYjXq6qjzbKTOdfGe7O0aVKT4m06Dn5DvyHVWa3g/in0P3Bubr3Ikiww==
X-Received: by 2002:adf:e6d0:: with SMTP id y16-v6mr3247139wrm.35.1528995133771;
        Thu, 14 Jun 2018 09:52:13 -0700 (PDT)
Received: from [192.168.1.180] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id j13-v6sm7403912wre.38.2018.06.14.09.52.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 09:52:13 -0700 (PDT)
Subject: Re: [PATCH v3 17/27] bindings: nvmem/zii: Fix location of nvmem.txt
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
References: <cover.1528990947.git.mchehab+samsung@kernel.org>
 <fcfc83951a2997c527126af1fdd6fb1e0acbe27d.1528990947.git.mchehab+samsung@kernel.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <c6dd6c36-2b75-cc9e-ea9e-5ee70eb656e6@linaro.org>
Date:   Thu, 14 Jun 2018 17:52:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <fcfc83951a2997c527126af1fdd6fb1e0acbe27d.1528990947.git.mchehab+samsung@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/06/18 17:09, Mauro Carvalho Chehab wrote:
> The location pointed there is missing "bindings/" on its path.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

> ---
>   Documentation/devicetree/bindings/nvmem/zii,rave-sp-eeprom.txt | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/zii,rave-sp-eeprom.txt b/Documentation/devicetree/bindings/nvmem/zii,rave-sp-eeprom.txt
> index d5e22fc67d66..0df79d9e07ec 100644
> --- a/Documentation/devicetree/bindings/nvmem/zii,rave-sp-eeprom.txt
> +++ b/Documentation/devicetree/bindings/nvmem/zii,rave-sp-eeprom.txt
> @@ -18,7 +18,7 @@ Optional properties:
>   Data cells:
>   
>   Data cells are child nodes of eerpom node, bindings for which are
> -documented in Documentation/bindings/nvmem/nvmem.txt
> +documented in Documentation/devicetree/bindings/nvmem/nvmem.txt
>   
>   Example:
>   
> 
