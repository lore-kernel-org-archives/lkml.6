Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4FDC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 00:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 554FA208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 00:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=appneta.com header.i=@appneta.com header.b="o5N/oFWK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 554FA208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=appneta.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbeK0LuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 06:50:15 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34921 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727468AbeK0LuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 06:50:14 -0500
Received: by mail-pf1-f196.google.com with SMTP id z9so7459257pfi.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 16:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=appneta.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=GiUkHUVQ1U2xSif8m+lRoLX8p7RLwhqi5H1knmE9KYo=;
        b=o5N/oFWKx58nqYMeeMnVtNYnDcPCxp1ceGUy8IMRV8zglmdHM+8mrvmJc4Art3DtH0
         x/K3g0NnjlEnTQQhLCcM8s96M/YioWhnq9CGPJkN0r2XzFKMP0ifjuNNz92L3U1WIenX
         A5ByZtkqhOdBFPUXikmGBMbmNxrrwzIx2F6ik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=GiUkHUVQ1U2xSif8m+lRoLX8p7RLwhqi5H1knmE9KYo=;
        b=ri0ua3AnylXyXD3pX7FbvlepWstXcVw/4gKgpSnv1PheKCv8pOSt/56u+AWqgIUDwd
         gOSLL2VVc1pGVfZfhMWUblX9HE+XbvNSLHaeH/zDFTfGSCg/GhqGj2lN2Z1yNffMwU5s
         cvRrgMuATw3vPH9aIKH5N/KAFGMQJkZEBE6pLSFoZ2p+B6DQZfj/SoZHIfmj8167ttn8
         pMEUwgaBBvakH+WjGrEIhH5NVsdz8OZZkJKtLH9wThXX36a5wqRbdfJBad+Sodz77Rzr
         jIU3YjevNDvaDvPWhBD7+etRrcZB7rb5PizZZQuMhqtrn0p3Cyb4tMqa1vte5NlgMalV
         7wlQ==
X-Gm-Message-State: AA+aEWYjc8phYe2aWN6NIaNxRmfL8Dx7gnHlJPlbBI0/ofYMxMwGpvIs
        M4RUpIja3pFWtnphu63c/unj
X-Google-Smtp-Source: AFSGD/WlxNs4FzAvCQQjQe/H0vJC9R3v65+1UI6Rf5eZPfuFb5z2/6i+Zf8rheEZEu6q1ZoMAYnwqA==
X-Received: by 2002:a62:4181:: with SMTP id g1mr7158981pfd.45.1543280052790;
        Mon, 26 Nov 2018 16:54:12 -0800 (PST)
Received: from ?IPv6:2001:4958:15a0:24:6935:96c7:a649:f2b6? ([2001:4958:15a0:24:6935:96c7:a649:f2b6])
        by smtp.gmail.com with ESMTPSA id i189-v6sm2058931pfc.16.2018.11.26.16.54.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 16:54:12 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [Intel-wired-lan] [PATCH net] ixgbe: recognize 1000BaseLX SFP
 modules as 1Gbps
From:   Josh Elsasser <jelsasser@appneta.com>
In-Reply-To: <937675447ad1ec2665d0b6f70390d498a01255d0.camel@intel.com>
Date:   Mon, 26 Nov 2018 16:54:11 -0800
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F6168EB4-8C74-456F-B571-6492162CFA0F@appneta.com>
References: <20181124205801.67828-1-jelsasser@appneta.com>
 <87efb92z5w.fsf@miraculix.mork.no>
 <40FD0CE5-973C-4A7F-91BD-66C1A1699223@appneta.com>
 <937675447ad1ec2665d0b6f70390d498a01255d0.camel@intel.com>
To:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan@lists.osuosl.org
X-Mailer: Apple Mail (2.3445.101.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Kirsher <jeffrey.t.kirsher@intel.com> wrote:

> No need to re-spin the patch, just reply with the additional "Fixes"
> tag and if patchwork does not pick it up, I will add it to the patch I
> have in my tree for validation and review.

Thanks, let=E2=80=99s try that.

Fixes: e23f33367882 ("ixgbe: Fix 1G and 10G link stability for X550EM_x =
SFP+=E2=80=9D)=
