Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F43FC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F44620833
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LufAisQr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbfA3XNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:13:14 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45870 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbfA3XNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 18:13:13 -0500
Received: by mail-pf1-f193.google.com with SMTP id g62so519457pfd.12;
        Wed, 30 Jan 2019 15:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HTL+dCe9u7ZNnULrvR7iVUcYjFrId+zHzmpmzqawh88=;
        b=LufAisQr5im18/wbn8LeJOi23TsyINeos9yLSMB57Hk6JjiV0K6rw79bzVoEzTNCH5
         G/3HDrCKdh3N21RhaLx68yfROBVVzp2wgi/DjtT1NcJxAZvIF2aFMJAF4Yb67dZPsPMh
         MoJ2SPEVBN6NG1nAg5X82hTkLPAZgUtG4O5DIVmc0NCIbC01tH3Geqs8j/zsiC88Lo1k
         R7T93uuIHh9NWMU/9reVvSi1THd3TVL94Gkosv2FGCaNztg2CaFNuk7+umXrzJsExqFf
         Axwo47AzKl4zmTRFiNPeAxjOUEoylkKJQFjJeh2vmgNiTxcsK7T25uQhhL4SiJnBFzFs
         TZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=HTL+dCe9u7ZNnULrvR7iVUcYjFrId+zHzmpmzqawh88=;
        b=jWJE/OqgnRE2P2BEh6GSN2MlRk762vfu2bWiaWKYaWjENO3ReG2QJbwHkmVGw3ybBS
         txJwYdNkhmK5jYhlZOE4bbZIOVzKcYXpvUtlJ+erzriL6IyCTeGRxQupp7JHI+waIg+K
         LlDPsTIeDnjkCicxqoF9Cl6nFGDC2xvyrfuxPWx2X14leJfv35oNVk/Srvw6LsDSxfTI
         /UyAG6u+RRYMLmLH0fdWVYfsAOOL7IxOLAtqUDaa4DjvwbOhZMxt6EAt9cWI69jsOsRC
         +Fy1VSY9/mjdLISoRyWPacK3XzXXxMgLir7d5BQsVh562UuvQwjIi+Hl1LpGuldkcqW/
         AjlA==
X-Gm-Message-State: AJcUukfB9DjlCBi+7C04M5Kuxm7wWL4ecg+HFPYuQBmZiunTxfin9ZxZ
        coKYJ8l2T0ZKnTf8Qs6cdVBdXQGc
X-Google-Smtp-Source: ALg8bN5JTqEa+7mhS9kFNw4G1tREO/XXxJwwXWDAvLeF3JOnBr5Q2VaKInpHN7KZgCTI7g+JxUAFfQ==
X-Received: by 2002:aa7:8542:: with SMTP id y2mr32741817pfn.83.1548886447003;
        Wed, 30 Jan 2019 14:14:07 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u186sm3477364pfu.51.2019.01.30.14.14.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 14:14:06 -0800 (PST)
Date:   Wed, 30 Jan 2019 14:14:05 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 000/103] 4.19.19-stable review
Message-ID: <20190130221405.GC26954@roeck-us.net>
References: <20190129113159.567154026@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129113159.567154026@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 12:34:37PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.19 release.
> There are 103 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Jan 31 11:31:30 UTC 2019.
> Anything received after that time might be too late.
> 

For v4.19.18-104-gd0a51a4dd99a:

Build results:
	total: 156 pass: 156 fail: 0
Qemu test results:
	total: 343 pass: 343 fail: 0

Guenter
