Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA9DECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86F3E20671
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJyqu4kT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86F3E20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbeINT0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:26:53 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46654 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeINT0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:26:53 -0400
Received: by mail-lj1-f195.google.com with SMTP id 203-v6so7627369ljj.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 07:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ePQgkVZPViyhTeSFta7HvnkC/pww6M4sihjdB7v9eyA=;
        b=XJyqu4kTpLtwYmTuoq51wKeWUGMbcSwGi1cYaBUr5pWH+UCk1NSOtp1uzjW9/givfs
         ZoLF5wo+XzOq5o6Z3p/tw396zW72U7ijfDpZOVyPtvwqIYO3chRE1Ms1BvTxeThk+mnw
         CIHiGJ5HOUX+pZlFNOtRLKPCjvepLZI6B+piah/ARZY4sGy4kFlGW6klMzmBE+6wl79C
         dAKSDwM/7oHP4SxsGNGUs4FsUgC5B6vIrVNcr5NU32kVsy48UZ0SKhRXj967OLBudMLj
         Q8kE3K58PprQ00NxmQwhO8IrSHdN8+y2h73t4iDIg/Ir6pFOFJs2mdSuFgLkr+W8qA38
         KFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ePQgkVZPViyhTeSFta7HvnkC/pww6M4sihjdB7v9eyA=;
        b=jFbwDWfU6D7ifYrH/DrCZihK1v2JXyqqd+dOH9+qznG6JBrB2cE9JfoUlpbeIBbIkv
         gs7QxKQRV3g8jaPmZii0MrSiER2HkcHKDfnR+Ig1T19c6ulUpXYQSpR+fehEySSN8Sva
         pd/2t4n9gmPyfjDlFN53JxGEzaU65Nngy0PWgey1dj8yF2ITyCAZKVioxwwrHSn8sGSw
         pDEQpDRZLqIKEog+Ove2Ix+11iuY+CYL0EWg2uEbcliKwYrVwGJQMxLqF09ghctUCJfs
         hxNvsMCZGuaAzcmMCsMYwk+r8ltHonZImlzVIjOFu2NnvnGHhkbTwPpriit3fECKVR9S
         LX8Q==
X-Gm-Message-State: APzg51CJWfFsQNrXXBubrkH1ySxiVsuSqMhS9rrXNxL7uP1hgo32IgDG
        rn1HGhHXCCfyqo29In3RPBc=
X-Google-Smtp-Source: ANB0VdZBFqM1fRaJ7DSfZmICRreFsUU02f/ZVwxV5E9ko4soOUnJqcGwWRw2AMz5xHbLvXDOCI5Pxw==
X-Received: by 2002:a2e:1c4:: with SMTP id f65-v6mr7953287lji.58.1536934330130;
        Fri, 14 Sep 2018 07:12:10 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id x14-v6sm1285470lff.7.2018.09.14.07.12.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 07:12:09 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1g0opP-0005rn-TH; Fri, 14 Sep 2018 16:12:11 +0200
Date:   Fri, 14 Sep 2018 16:12:11 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 31/50] ti_usb_3410_5052: switch to ->[sg]et_serial()
Message-ID: <20180914141211.GS1362@localhost>
References: <20180913023119.GQ19965@ZenIV.linux.org.uk>
 <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
 <20180913024049.24567-31-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913024049.24567-31-viro@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 03:40:30AM +0100, Al Viro wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Reviewed-by: Johan Hovold <johan@kernel.org>
