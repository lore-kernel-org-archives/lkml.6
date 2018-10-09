Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C6EC64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 21:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 229812085B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 21:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTdPYTPf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 229812085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbeJJEZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 00:25:02 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36939 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbeJJEZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 00:25:01 -0400
Received: by mail-pl1-f194.google.com with SMTP id az3-v6so1422608plb.4;
        Tue, 09 Oct 2018 14:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m5nTVLW/ULM23Dvh4j+mPr9MI2lRz49mubRjYCA+Qvo=;
        b=hTdPYTPffh12oXSvPQhVM6lt3T1K8d8/WmUb3rugqb+BFTSUuyIu2l2SVDWIRaVAAq
         4wKXMSE2/gd4UWZmoOoxGYmzF40fx5x8GNmEAzIRwc8ZM1zo1hf4W2BXQlfGwGpvmtd5
         nDH6e4gnrYCaGetpUhjGRgT9SxiEfXbyFXvaEqcImrUwmaOBIm+rZkxMVMYPwOFe/HUL
         Zva8RpLJrJZAB2CmNuD/yqVyvJ77rhSdEwh/EqAX3yFyg+M1RyiUKTeNrt77Zz5DA8Lo
         CwhyzgFOW9YqIVvqzkfzCSs+m0FMqQAUQin/Sr+V1LSYc92+PyOokG36rwCuerL038QU
         xx7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=m5nTVLW/ULM23Dvh4j+mPr9MI2lRz49mubRjYCA+Qvo=;
        b=KL5t7q8YhdTBAPQjsHTMzS8R1EDw0aX1lFKIKskgPKpnv+FuNtZ1VB2sZWw3W4HReB
         XesIkOIaIBa87z1iL6djhp2SPDuU5jdLdFIhcw9c2xKqNplp2k1LmSF62igBn//cNL3F
         60UHSeDFhSUX7U55z+Z4cuEsSqXNr+NDDDzJ65lFUHrRBec0O5UCMEgGV1kuIMKmcIgl
         WkvC3iFH0xnbcgQ0ETRydVLu/mrpGvL6Tdtn4610mK20F9tZ3OrkTRWve5yFbnojusxx
         S8taGvgRalUY5HXNetckfgd1lg3maJqH/txRLChPPf7zaHvo7LaIds6RnFqdbuFAhtpT
         b38Q==
X-Gm-Message-State: ABuFfohNQ4+mdKFiT4702h0aMZbyFfy+VV5PiWjRQAQ2VpwBsJ8AHB2A
        OJvbeTuyVSSNfviT4Pd0OoA=
X-Google-Smtp-Source: ACcGV63iP8b9IJxiYNUMTVXS67yyoZbz3KS5hZXaU7lrNw1gXzMOcvaqjKVNE/wU/RwL6/3Ec7m5RA==
X-Received: by 2002:a17:902:8481:: with SMTP id c1-v6mr30748373plo.158.1539119172891;
        Tue, 09 Oct 2018 14:06:12 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id o2-v6sm26389445pgi.62.2018.10.09.14.06.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 14:06:12 -0700 (PDT)
Date:   Tue, 9 Oct 2018 14:06:11 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/94] 4.14.75-stable review
Message-ID: <20181009210611.GC12203@roeck-us.net>
References: <20181008175605.067676667@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008175605.067676667@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 08:30:41PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.75 release.
> There are 94 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Oct 10 17:55:37 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 150 pass: 150 fail: 0
Qemu test results:
	total: 318 pass: 318 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
