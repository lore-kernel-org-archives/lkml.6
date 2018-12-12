Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F327C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E710120672
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwisbkZT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E710120672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbeLLWUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 17:20:22 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39021 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbeLLWUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 17:20:21 -0500
Received: by mail-pl1-f195.google.com with SMTP id 101so6527pld.6;
        Wed, 12 Dec 2018 14:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1MU/+LZP801WPf/Pi3NW5HdoV2O5ihpIlDU8kpWMcws=;
        b=UwisbkZTAtq+QaoJ82S+S82mLKZnqP3YwTBHQTmCIuEaLTBLAQQ2ks+R8n57y3bm58
         sZ4UczjC4M76xdne06sjcw4/Djn6tsCoh3S1gOdZ9EnWIA6bkSkBMCM3uNwhm8hx1aoO
         5geLTkRqGpSc3hlK06UN70xvyNvgVlUmXbtEWhhUXp2VLPZY4LUZ/kZJVVJGfgM5M3LP
         LRRWL/Kh8gU1YxXE3zwWckOE3MkIKLQAOtZaAym766GI3k3JVrWtfkNCFnvouy3SStJJ
         tRKj6Mz8pUryYc5/vM2u/OL5HsR2vM5b1YLzhzI4nSBCk+XS+a2S4Zr5NNkHRK5byO9i
         Y/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=1MU/+LZP801WPf/Pi3NW5HdoV2O5ihpIlDU8kpWMcws=;
        b=Jg7y5wtPSL8B7ZnOoHd0lBvEqQ6PhXkJBMA0rKYzen1Ls5zRPPvRVL7nlgn24aofMy
         c/I68+APkSOBeC5NOOomL+T8+EC22Hl8YpYV2vNmt3W3iPHqtd+vGD3vkxtPPBKz9S2n
         WA81IRTtFdwLzhNAs9w5kHfax30QffwKjjDYNw4Auv2WiNaNvK+NJJtKpmwcbdKOhVKL
         6qPnHCihkS4Ab0x0N5/zVjkhmyRckOWjtp4eQ7U3Ve6tpNh9RIE0Y3LF+bwo3IOOklnv
         PIkhDLxIIYGHvK1IymuTO8BZYOVuRAB/HcV5lFeb0dGhu5rYVqSkneBABLxri3cQE458
         0Pfw==
X-Gm-Message-State: AA+aEWbgCaOnU6wvYSmxWP/reCtHFBz+A2oc7HcaVyLVBiXNcEKlmkkE
        8wnVN5KvRIkSaBnMjjpwRH0=
X-Google-Smtp-Source: AFSGD/VfyOC1jKTmEYOLjl12zq5PaGNEgiYWSDozogQUW8cS5LSsjklafFtG/71PGN8eSZF23VdO4A==
X-Received: by 2002:a17:902:29ab:: with SMTP id h40mr21303518plb.238.1544653221435;
        Wed, 12 Dec 2018 14:20:21 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g2sm16539pfi.95.2018.12.12.14.20.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 14:20:20 -0800 (PST)
Date:   Wed, 12 Dec 2018 14:20:19 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/91] 4.4.167-stable review
Message-ID: <20181212222019.GB2290@roeck-us.net>
References: <20181211151606.026852373@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211151606.026852373@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 04:40:19PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.167 release.
> There are 91 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Dec 13 15:15:44 UTC 2018.
> Anything received after that time might be too late.
> 

For v4.4.166-91-gf16ad7a4b88c:

Build results:
	total: 170 pass: 170 fail: 0
Qemu test results:
	total: 288 pass: 288 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
