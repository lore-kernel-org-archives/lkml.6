Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8514BC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55B20218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoyVdc8l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730431AbeLSRYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 12:24:01 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33839 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbeLSRYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 12:24:00 -0500
Received: by mail-pf1-f194.google.com with SMTP id h3so10145763pfg.1;
        Wed, 19 Dec 2018 09:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=huA7NIIOR74VFcPexQkVvkLVuQfZFE+lghlmq/LpUPE=;
        b=FoyVdc8lWOWH4Ld83OfY8l1Z/SMJRF50Pr8qXAMuSwl3tfqL1VBZ5CX7EGtEwsd1fy
         67Bkr/rJAamupSGkJBI8neQylvugceH5OM8OmjoA+6n6F8V8tI1jZLeDbGEproNo5Azj
         pI11Brif4nyFYi+RyT96zCTfd9J2hgLQ6D+jJ/GXXKyJ2w7XqQsojzws9obZeyug/JcC
         FNdgU8916QRI+lTs8Vv/uTFDuKYFOx1lHtVF+SLjs2S5+fNxQxc0GLEz3hp+oylcHBpn
         wa87QrbGVlUfvYJv8lsBTEZqRCAoz7p7HyvBncU5b6B0f2w8bgS1ba+BBDlJoHlaj2pV
         svAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=huA7NIIOR74VFcPexQkVvkLVuQfZFE+lghlmq/LpUPE=;
        b=li/pTx/1zk2SAEj8KjCqJ65Nw9lLEd9VUX4epK8kQ4tJ89Xa5PlsCC9Uy+OtMUBaVW
         6Kcn9X0a5FKnnWZqgi2j4Wfd7bzZno8wT6MvTmMd+cNGcakjQjuvTH0vnGj9REEfjN6b
         mCXOuAAF9fJgWCVggy6WwpKmIAlm2IeoTZauEoVtnr/W9mWHSxP8rHWUaeCqBJfENAOr
         u+VyGAa/S2CbZ2cw23Evmye4APyHdY/Koca33ltMmeC8POJg5W9ERhGho68fvoQbvQ0X
         RRr7dsStaQuN0zVJrdMrTQgqDpnD2rFxQO6FvbxsgNkxDgkWO0JcC54Z3s4MT21cs+AI
         +05w==
X-Gm-Message-State: AA+aEWaXCyT/s0+2lkA51A1JyUAN+y7bBHeSsHXPlOB5K7R9COOntUH2
        s5Cj9455V42zjup+FESytn4=
X-Google-Smtp-Source: AFSGD/Uyw7SbxYSN8YwBrnWvI8HLMlxdFwonAbB8eYLRpZKqpsPsgY/2ipas32lK1cXEGsPI1wHNvg==
X-Received: by 2002:a62:6c49:: with SMTP id h70mr1815662pfc.201.1545240239658;
        Wed, 19 Dec 2018 09:23:59 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v9sm28310365pfe.49.2018.12.19.09.23.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 09:23:58 -0800 (PST)
Date:   Wed, 19 Dec 2018 09:23:58 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 00/44] 4.19.11-stable review
Message-ID: <20181219172358.GA26604@roeck-us.net>
References: <20181218163927.119623235@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218163927.119623235@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 05:39:12PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.11 release.
> There are 44 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Dec 20 16:39:02 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 155 pass: 155 fail: 0
Qemu test results:
	total: 338 pass: 338 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
