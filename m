Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD89C43444
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 23:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D07FA2084D
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 23:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3/7XDlf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbfAHXFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 18:05:46 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35687 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728839AbfAHXFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 18:05:45 -0500
Received: by mail-pf1-f196.google.com with SMTP id z9so2657820pfi.2;
        Tue, 08 Jan 2019 15:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ed2w+etZS4d1SGAzQz0tt6spdSHRHAzOXqMBM9x1N/k=;
        b=W3/7XDlfsHbd+f3cVzXS+n0C0dXYQfx98vpqOhoK3aYixXYZ7UiM+jUBgA0Jvb6On3
         xSc7p2jGcn5Uut+mOW65kaAPoqixD3RZyGmvClBWBHZvRt0BfPmKqTV/ISFu7945CNPn
         3d+5SPuN1HNyvzVN7Qh8FT1A0DBJ53QvlRHfwuiYO+jQ6uTF/D9foiDIaoQIkDFtYesd
         uXNXPisk05aKqrbJ8Xwc48/uBm4jG3ArIePpiTCDkDw8Wg+w7L5RQfX4FXtqfojrF0tX
         fXVOjQsACs9UY9E37HTEyHLggLTSOZ7oJ5Edg1wFbg4Ii9PUJLadH35LqM4H5nMU5/Pd
         e0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ed2w+etZS4d1SGAzQz0tt6spdSHRHAzOXqMBM9x1N/k=;
        b=ZKKOxO2woe+xzGW2Tt9JXSCBjFg3Mums9UvtjWmKONA6CJrC8yMp6sz7bznL1YUX4i
         raLdNiVN/6bi5Z6/RMzOSXoMX9Tv8yRvmLj8TNj5QKepfizU9X6mxpykI0eWYdHz8mgM
         zweZvONLS4UPXO2nL7+BD3sdCTyA2xm0upZPPqZBTUiJ3qEEA4Vb4iLCG1gaEgW1Bipu
         aoCpMXNLl1XA3R+1nIEvVsBnaBf8HjvN8/7zu9BjIGb23qoNQQ2hwsSpGv/WgolpJr3Z
         /qALbQ3OZfPNwPNlII3KAiwlccMcpY2HObMxfia482qHad0oyzVVRP1hUoLpKDAh0Hs8
         bj+g==
X-Gm-Message-State: AJcUukdjxvabSjoRjy5kXTTecNrQsZ/NmnR09y8RPSYLVHhppj3UaPVU
        h6ej36XIY9CDoWcqEKR7RecScqxj
X-Google-Smtp-Source: ALg8bN5KrOaSWKZS+qkMoMBFeg7xuFeCSkkTKE7cnr64zYPlPdJ/zdnd64JJs6w4hBW/7Bj9uC6Y+Q==
X-Received: by 2002:a63:6704:: with SMTP id b4mr3267595pgc.100.1546988744274;
        Tue, 08 Jan 2019 15:05:44 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u8sm103629079pfl.16.2019.01.08.15.05.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 15:05:43 -0800 (PST)
Date:   Tue, 8 Jan 2019 15:05:42 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/101] 4.14.92-stable review
Message-ID: <20190108230542.GB20519@roeck-us.net>
References: <20190107105330.372621917@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107105330.372621917@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 01:31:48PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.92 release.
> There are 101 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Jan  9 10:53:00 UTC 2019.
> Anything received after that time might be too late.
> 

For v4.14.91-100-gd6799087d56c:

Build results:
	total: 171 pass: 171 fail: 0
Qemu test results:
	total: 317 pass: 317 fail: 0

Guenter
