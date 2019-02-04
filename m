Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C142C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 21:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA3852083B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 21:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s73X0AXA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfBDVin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 16:38:43 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43656 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbfBDVim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 16:38:42 -0500
Received: by mail-pg1-f196.google.com with SMTP id v28so493873pgk.10;
        Mon, 04 Feb 2019 13:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X3XmTS6Kghac3AqDDKCm5rlmyE4Glsdlj180t+ZTEDw=;
        b=s73X0AXA0WDVOGJdmHLHOjJmfGQ1g1JZ+St2oD8AR/fpD+hGRtacWzV3DFzq7KFoiL
         CUDuhDKmMi8NfC6Y+iEKR2UvnXSs+f51pdGXMOgFKAFwuLDJUWP5SZyQesyxHkgFoJ42
         hd4yvnbnejOzbhs5DBHcH5uEYg0+Ctwesn4mrkCq1mOT2WUgwGplmHxjsMODI+Hn6dgd
         uSF8vuzezdfRopkAtF00xzS2a69bCQIsITinCP+zzDEDDVt2txep9R+rH887sKybCQdn
         7WdfLSVxiZMHi/J2bX1KmWknDVtmGDNT4K6Epx/uGGpso9/R55AXDRJgoNveUT2WKhBk
         gtaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=X3XmTS6Kghac3AqDDKCm5rlmyE4Glsdlj180t+ZTEDw=;
        b=tC3TpLhmSCxa3T4yKitQt5ykKsSoNkv0lQToPrO2W/UM2U5kDCLNhNwfQGi50vuBWt
         IyPVoFZ3AFyrJ+LgfJvQzqKbd0sQ923SiDL6J4FUV+D2M2ukN5IJleD047kJcRISQSOE
         OFquc3Q0LF+IQyF2GAWWLN5iw5wVqxch8pTiXvOeb0YjW2s8uKsILzvrpspCIyTfD8bw
         BauLPv5ZxGMi6l21uaAlKr0Dhbn/pPZgNu39vEUZ089sQz+dG2MZwtqf6CvQG2nxse3V
         saFA4G7Ntz7rUPlWj46ovYeIW8sK3Sb1oFrOm+BZXEnzAuTtBUM9DW5wB0FJ93g1wlE+
         vt6A==
X-Gm-Message-State: AHQUAuYQ87u0+BxUVNr9/7ZK/BFWYwGkR7VGW3/vjm40E0diUEQ4Itf4
        pb4xkjpNWargUg/QOiKGVTCRdYB7
X-Google-Smtp-Source: AHgI3IZFhFJNkfN8K2fvLNMscxMh32njTeGmzTNVZKDgpuoE5AtDic+jtJh2c66Z2eeaAnH+c6jI8w==
X-Received: by 2002:a63:5b19:: with SMTP id p25mr1356129pgb.424.1549316322027;
        Mon, 04 Feb 2019 13:38:42 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i184sm1219777pfc.41.2019.02.04.13.38.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 13:38:40 -0800 (PST)
Date:   Mon, 4 Feb 2019 13:38:39 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org,
        Denis Kirjanov <kda@linux-powerpc.org>,
        akpm@linux-foundation.org
Subject: Re: [PATCH 3.16 000/305] 3.16.63-rc1 review
Message-ID: <20190204213839.GA18895@roeck-us.net>
References: <lsq.1549201507.384106140@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 03, 2019 at 02:45:07PM +0100, Ben Hutchings wrote:
> This is the start of the stable review cycle for the 3.16.63 release.
> There are 305 patches in this series, which will be posted as responses
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri Feb 08 18:00:00 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 137 pass: 136 fail: 1
Failed builds: 
	i386:tools/perf 
Qemu test results:
	total: 222 pass: 222 fail: 0

Guenter
