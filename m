Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_SBL,
	URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53421C07E85
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 165CE20850
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pvPM5PS9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 165CE20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbeLDVmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 16:42:50 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34915 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbeLDVmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 16:42:50 -0500
Received: by mail-pl1-f193.google.com with SMTP id p8so8961809plo.2;
        Tue, 04 Dec 2018 13:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wlqCTg9yY5O8S7rUwfLMs4/cpLF9sOyQUus0We1zLNk=;
        b=pvPM5PS96RWH8NnDMIvE7ninM4maFdYaaIceEL6+KjCUph6L76jvZgT3jjL0DhYYDa
         EauAYzma9kIzusTuKIlxYIOZJtzxmCRrn5VOzOsNJwM8EcKzWOuwFZxiI9/vK4SNG6qs
         mmqEdvTK1CQGuxS9pqOWleZsyO5lneuTK4pgJmB7HzIj1xuufuMuYrHgEYWKwHS8fOeJ
         GCRvDZNmLltM8A42V/UxbV8b28XceUuXXS/eF7JMO8y20TJdb02nYv7cotqY86IeamHh
         kIIBPfVBXHtqbc5cWJqn+SS9kJUUXeota6Zlwx4+uQKqiHO3rjIUipK9a5QqpJM05s0o
         0UaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wlqCTg9yY5O8S7rUwfLMs4/cpLF9sOyQUus0We1zLNk=;
        b=JoWENSkB/lgsb+8rZqGmG3V59Zw+/kYmr/U0xKO+LhCm5EglbsVVAa1CqCSY8lU8Yx
         BD8TUB7hKlJiqD5l4jwMBKDRDG1NCNn5y0SnxpRXqfJgPlwKLDItHhfbcXzWxqf9IOJ/
         dneYdxsBaL8qNCvu+A1Sqt24wKighsGdzGTS3cXP/pv2x1eI913XdDEar3m+TRfFoj8V
         2UYgex4XHqlSwPEI5UbtDss0p5tQjE567Js/1BmYYI98hHaaXq+qnrdRGVAeNN0ooiTr
         hwQ5w45Ap9zJ0Hspmim6PZXxV8koL1ZX3JdF0S5mMNu4cJrYTzmvlSnzQFMxQgw91ufu
         4RSw==
X-Gm-Message-State: AA+aEWbUKX8OkY7JTIVi4D2EHz27BCQl94kl5mFdw4ocOyqqoDJD+NfO
        1K6524r+nOG0VzQ5O3rm0J9/Iqco
X-Google-Smtp-Source: AFSGD/UV+ZR2+Cit4eYcJuevvIrz2rTeCUFyCPkk6jG1yUcVJKmhz4ad1N99tDTJzekX3PzU2G4n3Q==
X-Received: by 2002:a17:902:9f93:: with SMTP id g19mr21208877plq.195.1543959769426;
        Tue, 04 Dec 2018 13:42:49 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o13sm26908312pfk.57.2018.12.04.13.42.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 13:42:48 -0800 (PST)
Subject: Re: [PATCH 4.19 000/139] 4.19.7-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20181204103649.950154335@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <d6f93f1a-7882-1df6-679a-130244f7da1f@roeck-us.net>
Date:   Tue, 4 Dec 2018 13:42:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181204103649.950154335@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/18 2:48 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.7 release.
> There are 139 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Dec  6 10:36:22 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 159 pass: 159 fail: 0
Qemu test results:
	total: 337 pass: 337 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
