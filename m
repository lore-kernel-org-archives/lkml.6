Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0660FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8C7F21917
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="dbdhsJmG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730462AbeLUP0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 10:26:06 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:34769 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729898AbeLUP0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 10:26:06 -0500
Received: by mail-io1-f67.google.com with SMTP id l22so730712ioh.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 07:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/MOIU7hCsgrd/rUq3ud9ch+X2/+EbU8ewisM4YIgtGY=;
        b=dbdhsJmGsOSB+AA63/Q6jCU3vqxbAlLr63XWlj390FEt8OOeuM8ZmgoHB9RvePlScG
         VCowq9+tpRgDDO1iJVDD643fvYoqdq6iVvwwElexMCjsSp8f8eYI5Un57Jgrr1izJqbS
         eO+ZoyGAjGIBk8XE3ZfS+DsOiFW2VkOcDXFSWGCA26RPrXbFZi2HLP15TXbj578glYcL
         j+XqEX6bz+cccsuhirxecTJIRP7QvDp/NGjFO+VssqVRkDvEUkso2Qy+3X9qKez3lvd1
         pB1jOso2VDpT1GLcb9c81ge/FimYGArb3SyvrJxVE4MUfLVtgWxPENFGAEJdTt45+FqJ
         uCpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/MOIU7hCsgrd/rUq3ud9ch+X2/+EbU8ewisM4YIgtGY=;
        b=FjhVOnnTOWVoRm0U3dtysU+ceqziWLowBSNRNY04SKek0UbIUBLwFbGXbIOn5d7XKz
         3sjW0/VGw0KDz1G/1wQX8cuMRI7ksq7f00s7RkjkPxh1dgYYe5klE7dOg2ecr6eK84FE
         8Z9CkiRLo1TlLgtodAMh15WZ2bKFw3H7NQmBqPYATsoVjzOY+4qhnHzByCTddO0uv+mu
         p0MpkRlHmcRfPM01HTPzmoxd82zaOf0+2AXGNvntVJTE0dtkATpYHL1jsnyH5MYcIOvV
         Vh7zvUi8zWHplibkup+iK+6v/IHsixlA0x/nNs7sh+jBZ2ZuVRiJVGxydV1EckNn+SJn
         feyg==
X-Gm-Message-State: AJcUuke59FRShrthJa+bm1owJSPg7dkIZ6N3Mg382cnjii5huMBVU03t
        z6Vd3F0EbHDvZbejDLf3lGzW+qrK3p8NrQ==
X-Google-Smtp-Source: ALg8bN7eb4DsG7be1azb0kU80jXkAxew9Aky/32eIZBv1A2iAPECCzCmdxuWsAcCaQgH4XWgIH03fg==
X-Received: by 2002:a6b:3bc8:: with SMTP id i191mr1974794ioa.23.1545405964947;
        Fri, 21 Dec 2018 07:26:04 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id p19sm9205231itp.13.2018.12.21.07.26.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 07:26:03 -0800 (PST)
Subject: Re: [PATCH] blkcg: add rcu lock to bio_clone_blkg_association()
To:     Dennis Zhou <dennis@kernel.org>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181221145441.13814-1-dennis@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f1dacd9e-7c3d-44e5-aff1-923d9e7a374c@kernel.dk>
Date:   Fri, 21 Dec 2018 08:26:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181221145441.13814-1-dennis@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/18 7:54 AM, Dennis Zhou wrote:
> I cleaned up blkg_tryget_closest() to require rcu_read_lock() earlier.
> However, this was a subtle case too which clearly was too subtle for me.
> The idea was the src bio should be holding a ref to the blkg so rcu
> wasn't technically needed. If it doesn't hold a ref, it should be %NULL
> and the blkg->parent pointers are unused.
> 
> This adds the appropriate read lock in bio_clone_blkg_association().

Shall I just fold this with the previous? I staged it in a
later-in-merge-cycle branch, so that's not an issue to amend.

-- 
Jens Axboe

