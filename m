Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CDDECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2C3220671
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMvDo8rA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2C3220671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbeINTa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:30:28 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35235 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbeINTa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:30:28 -0400
Received: by mail-lj1-f196.google.com with SMTP id p10-v6so7681045ljg.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 07:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7IX9VR2mZD9UneINOTaqRYrmzH2MUsIo/p/BgnSOSS8=;
        b=iMvDo8rAwTP7Wq8ykIkXjLymGbxs3IAUQuqZgtYBX7Vv9z3AFRHpiBr3ex01eX2LIu
         wgbmHpimiuylm8FuxS5u6MiJWcrvz6DVMQxmsu0BDtts7HF8aeXNDwp+CdP8dgC+zoVa
         OSCL9u8E3V5j8Lhh+Gze0Ta6N5ExDw8ArY67lffoGvbJtogTM2dUGST+5oAmtUXfCTfs
         r40qa6lchcNF6r/HAgi7NyJ/Ksx75yYo8Jlubcm1Ho7vxfShbV2VnWe3zyA9dmVkXR1O
         0TAE9JpmkBx33nsZYerCTLa54EYKmFIYFY5BJOfoRicdduJz2AANNdWn8gDxSkYniA2c
         u3xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=7IX9VR2mZD9UneINOTaqRYrmzH2MUsIo/p/BgnSOSS8=;
        b=Gv7jgtivROrT/vdC627YkJeLxo3hz62NxRZLtfjgQ83C8cNfV3gnAb+X5Ean9NaftR
         p0SWBUtVL4kF2LSHCH2cle3WwfpNG4qn9K9PGCRV2H3P2CHgH8sSjXtOeSGFLeBHOEIF
         OIbu/78iug8FGWzMYIttn1KUuxUNA6TvBSh2cAYUe1abltaDO6feHdGZ6mkIHyeypXeD
         9EtUDH4JsY5ZTtO01g8a7mW1c0mXtCxPob5+9PnGrQfZS/OVKQ7qOg/GNLsLu0R14ifb
         /QKxG8johvM0hzEtifs6dR6vzuydlIPCToFwWUTHn5iuFBBAaOXij/6vaXAMWmMtarOx
         Xqdg==
X-Gm-Message-State: APzg51CVYsT8ZoPEhuInqqzwu9jpeD+ETU96ZDVKYHY57Kmw7BNVVDpB
        kbxZ5GDgyGD/VqmmgXXMB/5scQl4
X-Google-Smtp-Source: ANB0Vdbt1OLPp7jq7uHpi/IZQ2r1QrprikAFGkfvSBU7M+dvzYc/EfhZNkcJ93rlo/XsVvTIEFp4uA==
X-Received: by 2002:a2e:2f19:: with SMTP id v25-v6mr2909445ljv.113.1536934544610;
        Fri, 14 Sep 2018 07:15:44 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id c14-v6sm1259614lfi.23.2018.09.14.07.15.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 07:15:44 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1g0oss-0005tX-Ef; Fri, 14 Sep 2018 16:15:46 +0200
Date:   Fri, 14 Sep 2018 16:15:46 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 32/50] whiteheat: switch to ->get_serial()
Message-ID: <20180914141546.GT1362@localhost>
References: <20180913023119.GQ19965@ZenIV.linux.org.uk>
 <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
 <20180913024049.24567-32-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913024049.24567-32-viro@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 03:40:31AM +0100, Al Viro wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> ... and fix the return value - on success it used to have ioctl(2)
> fill the user-supplied struct serial_struct and return -ENOTTY.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Reviewed-by: Johan Hovold <johan@kernel.org>
