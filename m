Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B35C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 872AA21B68
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSCk+tNZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438299AbfBNTQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 14:16:52 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44883 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388100AbfBNTQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 14:16:51 -0500
Received: by mail-pf1-f195.google.com with SMTP id u6so3556115pfh.11;
        Thu, 14 Feb 2019 11:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PmyFZEHQLF1EqNuT9lziw0DN1mBYyDMKxUGMaC6Qf88=;
        b=OSCk+tNZPOBtutiOnM6CRLKf1OjFf3QnD6taGn2Kj9faXE6sOfNJTxB0G2kmbaadcb
         IPN82TVcmZBOFXb7/Jqw3bIwzxnLSw9yHwF1ytnEqz+IEg2v+WVyyDNFjT86WkhHTA+Z
         MshZg36RoZ0rDddsbJJQ/QKHzHE34Ycj0SwtqW89zD4OgUiNJVCNtz9fVzcLgYWEtWwB
         L57GR2BJhS3iU6ha2lz7SQG71j+s4Sz4zan5Ky2LenqHrec4a5OAorTHPswdJE7bs1cd
         NeuWOfDPRauUtSA50nvKh0e6aEWNMRtpMseVMZNG6aRnsmcjuXYSoexElEj0HQzRzVhk
         jhlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=PmyFZEHQLF1EqNuT9lziw0DN1mBYyDMKxUGMaC6Qf88=;
        b=ddsMoB6XGELYuZkEDK5PCwW5lezt3dFK/k9lK15nYTh0gI8wzqA8CjUHKb/m+IFhX6
         0aCx3TjDCP6E3QXdekJapvsoqfHWho2pAPysuwuWu7qMpVTXp74tq/Ar2vQVqp3f+LjH
         Q0V3jrrgjiCptktAxPxezs8Sd5wl7NMZOsMkNcyz42MRsbOWeRlj2526DQaJymkBs0YB
         EaPMtZYX/5gUWwHLyA+NX7NAk1fgY4wYDy1oyGROYsZuH5oCez4anJcrQ7pTbByktqjJ
         +FG/FVkzBuf+zyV1/cjZqImHb4kYOGmFb4spmL6wivgEWPiIqvJdoZO3WFuVhWflwlq5
         yiEA==
X-Gm-Message-State: AHQUAuaR5M634bmcigwMH3+Rtos5vaCWivQWEcXLGS+q0lhou+p5LrtF
        gcbuNeSkSnquHOYf8xwtxjk=
X-Google-Smtp-Source: AHgI3IZWc3mwLA9aeN6eTGn+QdXRL5AcqSMU/0hI3njgwe5sSBr7RM794oRcq4mxONoeorIC3/U+YA==
X-Received: by 2002:a62:2008:: with SMTP id g8mr5585522pfg.121.1550171810705;
        Thu, 14 Feb 2019 11:16:50 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o23sm10759664pfa.140.2019.02.14.11.16.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 11:16:49 -0800 (PST)
Date:   Thu, 14 Feb 2019 11:16:47 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/24] 4.9.157-stable review
Message-ID: <20190214191647.GA29429@roeck-us.net>
References: <20190213183647.333441569@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213183647.333441569@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 07:37:57PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.157 release.
> There are 24 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri Feb 15 18:36:26 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 172 pass: 172 fail: 0
Qemu test results:
	total: 315 pass: 315 fail: 0

Guenter
