Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D138DC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F4C120863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrclN6Pp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F4C120863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbeLAJiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 04:38:11 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41504 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbeLAJiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 04:38:11 -0500
Received: by mail-pf1-f194.google.com with SMTP id b7so3462584pfi.8;
        Fri, 30 Nov 2018 14:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MQexAcTG4aJnH5cG1pcBd757aUKqtw3ey4Aj2Ahum18=;
        b=GrclN6PptRiFM1aQlXskU2u50RjuWGLahC6HbrfxfqwFSGNgesWXKlCJd49oAWnS4Y
         Ni4sTOpseblm2kVBa+hDJJBiDSTclaszQv9R4KwDWFGgwqfT7OWDzvC1gQcaIeey7pR4
         XM++gRJp0tiZqLz38ExJQ6CL8XwViv4mS063UxJA9eAoTc1vzJ3uOnBcstraRegp+z2A
         48r6ToMfQ7uh1ia9QV6kKi3TtDWypiaiPXzKlNA7gEcCdDmV/KQiqJfsy3b4EX7k97Pu
         WbLkZLAZi3ar+oceMrLHqovZCTBjQKMh77X5bU8OXMax2Mq1x1q9ZMeyoTzyMqpgArzx
         buCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=MQexAcTG4aJnH5cG1pcBd757aUKqtw3ey4Aj2Ahum18=;
        b=Pbx3iGeA7X4rgo/ilQD2TeB9ckj1DqfGZF/26EC6spUUdixYcdQkaLC4NpZYzH6UT/
         g8ssvz6EyZ6sDImX10Vt4NWZpnsS1uGMWnhJlQ9H31SA76f+T78WwgO7Ty2/ycStiFXS
         j0bbct88m8QmeZtD8y/VX674Qu219Q61WhJ4YHWDtIg+jQ7im4uoWgR7iqmjUwk+vwAz
         LWFN1g14qfblGYfEa81DobhJGz1GkPqreUlmX/uRRBg4qFv4+2Dn9GlE82M9pk00xUSQ
         KzhdT0VSnZqlngJyWfUbx8ka02+jRGS4vwfYg/mDGj1MdBKzeTqnoIIvD2pDxeeWnRNy
         q8YA==
X-Gm-Message-State: AA+aEWYGdRtmNYAyTarmZuByQ38y9WYaHloStgaCoR1AtW95hZ5/ZyZi
        QFk163kau633lAo+cS4+LIw=
X-Google-Smtp-Source: AFSGD/Xo+6v66R5iK6p54cltex7+Usju1BCLmiY3eEa49k2KNrxBgGrUgZP/OjzoQfG/kZi4E7R2hw==
X-Received: by 2002:a63:85c6:: with SMTP id u189mr6030783pgd.156.1543616843351;
        Fri, 30 Nov 2018 14:27:23 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x19sm10302727pfk.14.2018.11.30.14.27.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 14:27:22 -0800 (PST)
Date:   Fri, 30 Nov 2018 14:27:21 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/86] 4.4.166-stable review
Message-ID: <20181130222721.GB13361@roeck-us.net>
References: <20181129140109.832117862@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129140109.832117862@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 03:11:25PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.166 release.
> There are 86 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Dec  1 14:00:43 UTC 2018.
> Anything received after that time might be too late.
> 

For v4.4.165-85-gf00ba91:

Build results:
	total: 174 pass: 174 fail: 0
Qemu test results:
	total: 288 pass: 288 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
