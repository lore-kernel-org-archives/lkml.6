Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A19C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 17:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0CE721A39
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 17:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RURrEgFh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0CE721A39
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbeHQUWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 16:22:35 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44474 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbeHQUWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 16:22:34 -0400
Received: by mail-pg1-f193.google.com with SMTP id r1-v6so3850707pgp.11;
        Fri, 17 Aug 2018 10:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EKUTv+KI/4Q3fvjJgo8dg31kmgbYCYbDnp4HkWdmlJo=;
        b=RURrEgFhHp4emi9ionh/5RRVeqghw3cWtzxiXMKBwSHoIr9r3/n/rCIP7oGoiotGNU
         +R8UNRm+zCUAMbJBHJrXifylBm6mMovJEcH1EENzpKh7TxWdDoSObwZkpy4X4HBy/pg7
         V7thCPI3KjNoVRrJmF51GkeLhmyhjuVyIL6LeKlm8nOVL8FeXZVrr7PG8RSt6+v1WbPU
         ejm4W0EwRl8Yq7+WQ6WifJ7RSuMOjdB1HUU4kvozjKyZIu85RxoxPt4clx5SvCAckVVq
         1WZPXSclFNUkhbgJ3gBHRa1ds/DCuE6SnK4ksbLQw1Mqz6PDSJo9Ro1bay91pZOtexKn
         WL3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=EKUTv+KI/4Q3fvjJgo8dg31kmgbYCYbDnp4HkWdmlJo=;
        b=eRSmR4S2m/A+k4KGI2NOwXZPHCBVLFaD6mO4qf+EonBWow1k56dOpmml9+B1B3MwWq
         VFAO+owxINh0kycPuVjAPRQ2tJ7mrIO/ckZUY281297/oCeh3GWzHPTeI6DEWsl6xFxh
         o2WZgSPi4Wdhxj7eEfFgKyibtyvzabo9dqGQl3thTBQQoLM5CSJRCyEhF8b2r6HI64qu
         wfnyezu9FG8htRjSLtvOLPIxrQCsxCn8tKUg7dhENCn/tApTObUWfozgWbW2g8LebT8x
         vy6/iemg0lI/0TsofiRL29pdtsXzH47/4hU8YgKRntiKp+LA45ZjLAZzUBRINfF49oPO
         vsYw==
X-Gm-Message-State: AOUpUlEvuMMQAfyUN2CDoJVQNeWspWQ3llUbDkOU0/au9DIGgQwzSL1Y
        mJcBQzvV0SynfWG457Bbf0c=
X-Google-Smtp-Source: AA+uWPyDy+089fQ6FJhjRaayQWszr64KmNzgGvKI3AlLoLq5Z/+IiRSverxaRnkdmsjxlnW+gHVSvQ==
X-Received: by 2002:a62:201b:: with SMTP id g27-v6mr37648784pfg.253.1534526303763;
        Fri, 17 Aug 2018 10:18:23 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id g2-v6sm3860381pfb.79.2018.08.17.10.18.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 10:18:23 -0700 (PDT)
Date:   Fri, 17 Aug 2018 10:18:22 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.17 00/21] 4.17.16-stable review
Message-ID: <20180817171822.GE11442@roeck-us.net>
References: <20180816171612.136242278@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180816171612.136242278@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 08:45:10PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.17.16 release.
> There are 21 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Aug 18 17:16:02 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 134 pass: 134 fail: 0
Qemu test results:
	total: 302 pass: 302 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
