Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EB7C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 20:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91FBB206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 20:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYlQm/7m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732662AbfAPUht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 15:37:49 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43567 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbfAPUhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 15:37:48 -0500
Received: by mail-pf1-f194.google.com with SMTP id w73so3607974pfk.10;
        Wed, 16 Jan 2019 12:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Rk3MeMik3TfoVgpbz8VYvd5GP2uCd2X3sdNWlzLOdrM=;
        b=NYlQm/7mO8odJJgb0JBYrt5sYgYp/fl7gTgA7AXpfyoan5YTG/CrlZ3uMd4NkFe5LU
         9ToP7auUoou+AjtURh8k0mzHd5Wfj6IOvuFDllLRk1DJhRiD7f7VWG7ktfKmrUvzGwsA
         54PtqLaMqqolJ2+fFhWhlnN2/helt1vJZMen0acIM55RmJiqdBkMrfBqM4CiH2fT2eo5
         DfVL4Awz+BefbesqZZGCSMIG08dnOVL1tiBd3IO+WjJSu3xVrc/yw2CpBa58lptgLV6T
         FoyqOeBb/BpUpBChff4Qrqlcbc0EibXe//kwzhAeEzw9ZL5t87bdF9DsL/+We51gBCNf
         HvlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Rk3MeMik3TfoVgpbz8VYvd5GP2uCd2X3sdNWlzLOdrM=;
        b=sYcOHa9wfPEfSLS47iWdWBgunQhmNOsm2ZEC71ouI2IOMvfmftKBWjMXniOXjc4weQ
         CxyKjsnjJ/NVVpnP6TLWGIe8HJ/oXD1kCAVkq8WaLD/VEATgwZZExlBKsiGVDzPf8SOR
         /czCCxFEZK3ITnF4SPgwf4ieGv5z8qQNwKgs4t/Ii70qhWXD/im9jgeHMgVgtaiFMfOm
         5MhKpD5G9LV/S9YxMms5C2QdSI9QgnaRQ6GOeA3oPSQ6ZWWNkXU1082TdCRiEkRW7MIZ
         YymgpqxgXXrpdDvlwTcN5a8PS41MDNMEDHblNvYjEmz/OZ4kqDATQE8ckEVmv954J2Zj
         AIBg==
X-Gm-Message-State: AJcUukeESqOddJZTsvQ0Fm7oSbUH93GCeGLyrNv78BsIQcJg/0R9hxQt
        ILsvYyrdKFPxAXwUjRJXAIc=
X-Google-Smtp-Source: ALg8bN5DXCt4ysYHr9LebtwtPIhmqj3ZcQVO3xLMPwP+/3gxdu48DOw6+Q3moTHlZv8PNRX7PI5xQQ==
X-Received: by 2002:a62:3888:: with SMTP id f130mr11577944pfa.132.1547671067778;
        Wed, 16 Jan 2019 12:37:47 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l5sm7494730pgu.86.2019.01.16.12.37.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 12:37:47 -0800 (PST)
Date:   Wed, 16 Jan 2019 12:37:46 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/27] 4.14.94-stable review
Message-ID: <20190116203746.GC1302@roeck-us.net>
References: <20190115154901.189747728@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115154901.189747728@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 05:35:49PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.94 release.
> There are 27 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Jan 17 15:48:28 UTC 2019.
> Anything received after that time might be too late.
> 
Build results:
	total: 172 pass: 172 fail: 0
Qemu test results:
	total: 328 pass: 328 fail: 0

Guenter
