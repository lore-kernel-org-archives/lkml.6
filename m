Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2D5C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E959F2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="t05iqgdZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E959F2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbeH2R2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 13:28:14 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41450 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728151AbeH2R2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 13:28:13 -0400
Received: by mail-pl1-f194.google.com with SMTP id b12-v6so2299010plr.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 06:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xVqb5vhHz3nQ8N4NnmZbonUojpVrx3o4ReYrs3r4Qxw=;
        b=t05iqgdZoceNGuMBhhvlQ98pe5qB9tRKA2TMjfyocYQ9bUPX3w+1CrgVuEnuK26LJr
         DYE2DYriElVDnCfl+RLCMQyV02VMujLGpjZc/P76CJ8zzQywoSGGsclzcnoeK9DKE2X7
         +rK3nRIhOt3sk8Itx++MjzxTRRc+iHqBzxDHy8HRurpI2MKckKCGNkvSMfHCgVNJJOi6
         mwqJ6LflJovXQbqIIih8FyOJimmXavlC81CeW1vzjnw8/GGXvhXvyhlEOYvVRm69dMTi
         RwelRhn/z+Vh3h4LhxRANVK/8eWFVDZlN6i4B9cgzRJImvlWbrGd5PMIWsB389M+Fz5a
         af2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xVqb5vhHz3nQ8N4NnmZbonUojpVrx3o4ReYrs3r4Qxw=;
        b=gnZl8oj0ALeF0bUXSLgx4Lkii/Lc5uvW492fLrEnQ0R5tm0FCgCN0/TUTt182zY9Fk
         9WaOYul82De3m8/GtMzi7rV0TTmY7WZ0kV2AaWSinf1CTWkPMf5Gh5lMDd+OhseOp/yC
         ZPhetQ43G8Rd4K/3QjWsxeK+bCnf/MeSOmvpxI3NxAC9Dk39BkPDt2HxuwH0HxTHWWcB
         tfFJNYJi7ZFmyS2y8WloNJdxqp6cj++cuz6q2gXB1hWQbJf7r+rbP2ZPHSpXPGMH8mvk
         NSvyAbWWBN4A3TJBgeT/ozb1e4th22AYNgp4P6cFhe1uUE7T9C8G77SzLtVhgidyLFW2
         Ru1A==
X-Gm-Message-State: APzg51CeDr45iqtLqeX0Wel1ILY22C3WAhwoNZh3eyypGcrj4Ip+7sCi
        DW9Vh9ccJ+O/xccNpSeML+sRZg==
X-Google-Smtp-Source: ANB0VdYtClkdufaS28Y0D2FYHIyQg/uM4xGKMiGcaTe5kPWkryiFS1aarZrxzIG845R4nsFByJvZ7A==
X-Received: by 2002:a17:902:3324:: with SMTP id a33-v6mr5938838plc.221.1535549475247;
        Wed, 29 Aug 2018 06:31:15 -0700 (PDT)
Received: from [10.86.62.45] (rap-us.hgst.com. [199.255.44.250])
        by smtp.googlemail.com with ESMTPSA id q85-v6sm7018497pfa.151.2018.08.29.06.31.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 06:31:13 -0700 (PDT)
Subject: Re: [PATCH 0/7] pblk fixes
To:     hans.ml.holmberg@owltronix.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier@cnexlabs.com, hans.holmberg@cnexlabs.com
References: <1535545414-550-1-git-send-email-hans.ml.holmberg@owltronix.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <f768c3a1-49b2-7477-ee69-f965e742e323@lightnvm.io>
Date:   Wed, 29 Aug 2018 15:31:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1535545414-550-1-git-send-email-hans.ml.holmberg@owltronix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/29/2018 02:23 PM, Hans Holmberg wrote:
> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
> 
> This patchset contains a bunch of cleanups and bugfixes for 4.20.
> The patches depend on some of Javier's for-4.20 patches.
> 
> For ordering, see:
> 
> Branch: for-4.20/pblk
> Remote: ssh://github.com/OpenChannelSSD/linux
> 
> Hans Holmberg (7):
>    lightnvm: introduce nvm_rq_to_ppa_list
>    lightnvm: pblk: fix mapping issue on failed writes
>    lightnvm: pblk: allocate line map bitmaps using a mempool
>    lightnvm: pblk: move global caches to module init/exit
>    lightnvm: pblk: remove unused parameters in pblk_up_rq
>    lightnvm: pblk: fix up prints in pblk_read_check_rand
>    lightnvm: pblk: fix write amplificiation calculation
> 
>   drivers/lightnvm/core.c          | 14 +++------
>   drivers/lightnvm/pblk-core.c     | 25 +++++++++------
>   drivers/lightnvm/pblk-init.c     | 60 ++++++++++++++++++++++-------------
>   drivers/lightnvm/pblk-map.c      | 10 +++---
>   drivers/lightnvm/pblk-read.c     | 13 +++-----
>   drivers/lightnvm/pblk-recovery.c | 11 ++++---
>   drivers/lightnvm/pblk-sysfs.c    |  3 +-
>   drivers/lightnvm/pblk-write.c    | 68 +++++++++++++++++++++++++++-------------
>   drivers/lightnvm/pblk.h          | 11 ++++---
>   include/linux/lightnvm.h         |  5 +++
>   10 files changed, 134 insertions(+), 86 deletions(-)
> 

Thanks. I've picked up 1,3,5-7 for 4.20.
