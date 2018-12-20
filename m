Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2542C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87A8E218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgeED+Cu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389083AbeLTS3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:29:18 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38303 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389065AbeLTS3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:29:15 -0500
Received: by mail-pf1-f194.google.com with SMTP id q1so1315922pfi.5;
        Thu, 20 Dec 2018 10:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Lv+bJQPAIkowSRq1DJaFnjQc/asERKA3XL1Blldwe/U=;
        b=jgeED+Cu1Or95OkuuNUM8i/JHI5Of7Dj2xdljuA32aQ+BQ0UOHx89FYzbUqTVfQy0/
         nZsXU+s8uFdgo28cDnf5Fv+jKA8w015IwfSU+EWyPYtFmhhn0+QpmbecYATuSO6VMIGd
         bk6hoh7MNKu0kzcKfj0VFkTJ2jHv1ZQL+VsQIiRTZkfl09ki5oNFMv/VMSlk5M1khoHZ
         tUhurMLNIWlNWEuJ3xrZxla6LBkX2YtEvK4Z73By0XnclVfTny61geJv617am1wKfneB
         jPEQb6UNxIMx2XDIFG0k92HCb7L69KhlCROMc8v0qkfYEcH5naWcNrXzV5fh021dzdzX
         2Jjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Lv+bJQPAIkowSRq1DJaFnjQc/asERKA3XL1Blldwe/U=;
        b=ne4vlRfsVSffRT4YZ+eRCM7o156p+ML9twaOY4GCfyR4rMAIU3uDejedBGOma/duli
         mwpITvWthVojcvD4OnrAz4hVk4Yhm0PgKeV3YzSc6IaoGseaCOFRd6F5+GwzgkJ4LTSp
         rrKW8Ct8ghbGHAlhgyVu0cTzmh997ZLr9d4n0+LlkxXGtUbRodqYYiIfNI5oOIAmHlL1
         r1dbLJKR+QSNJFCreEPvxSiO5eyhyCBHr8FGo9LyCNyOp0ZcKahfsku2F+vZw4OjRtbR
         /9w8xWbzapYoJCR+BQOIBVmLepssFanhUbfBnNRnUG7ro/F4I09m0dQY4i/UDB3Csir+
         +QGg==
X-Gm-Message-State: AA+aEWZ1AUdc6mirb34AplRAcRiWMHlcaBboyvLabk00CR9OC9AX0XJW
        fdG1g0r+GAudXKnUVFwz0tE=
X-Google-Smtp-Source: AFSGD/ViDVPGXMD9e1DhWNPC2P8aR5QcQ3LHQMyLcsX7rYNwLo/HztD6HMnP2+MldSl8gmuZpaO88A==
X-Received: by 2002:a65:4b82:: with SMTP id t2mr7601779pgq.189.1545330554700;
        Thu, 20 Dec 2018 10:29:14 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g26sm26518727pfh.61.2018.12.20.10.29.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 10:29:14 -0800 (PST)
Date:   Thu, 20 Dec 2018 10:29:13 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/72] 4.14.90-stable review
Message-ID: <20181220182913.GD12802@roeck-us.net>
References: <20181220085922.332225035@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220085922.332225035@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 10:17:59AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.90 release.
> There are 72 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Dec 22 08:59:06 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 171 pass: 171 fail: 0
Qemu test results:
	total: 315 pass: 315 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
