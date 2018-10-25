Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72476ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 13:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28E992083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 13:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="N5x63xjT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28E992083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbeJYWCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:02:10 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43302 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbeJYWCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:02:09 -0400
Received: by mail-lf1-f65.google.com with SMTP id p34-v6so6779947lfg.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 06:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Nc/59QmCpddwSBjBIU9Sf7LrqzG7lNd8pUyVSBiZXU=;
        b=N5x63xjT+xLoIMNFRzpW86FavIVnoJHxQKzvuluGS3Ary57+d/gd42QnXp8sfmAZel
         l2bGbYeSRfvHnLJ/PwL0A44FKSzeGX69fwhnTwygN53Nxu/mILn/tRpmP6RW3A00HRb7
         3xYSzgiOz7HgAFuZJ20AyH2AqOAfwWNQJNTSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Nc/59QmCpddwSBjBIU9Sf7LrqzG7lNd8pUyVSBiZXU=;
        b=IKCu4HstXwOTzw5CI04uyICoI/h7IkT1JdOhT9asHG7n+0RKO1KEa/t+tqWtXHtPlH
         JSD07grWFbix9UDBIvQNgoiUEl8jUcUtOVmZtVArKyMPqaadAIKINHx90tRWgSqd7E44
         vBiVyEl9EO5D6ZqyxWYFH1Y/cDLbsKIzSOUWaZyqaateaMeZhIXoapS/OHYvE9+SBZTp
         FEW8T+1jLcixg1Ypbj4JHV5qk3t0fOy7eAKrFa06FO+fSdJVkYXRP90tp1E5CFpMCi85
         bNY3QHiTK5hW8d3oe+9c2A2GwdF011V1kViJs3j3WmuzJAZxTLuUcpEVb2Wxg3bsqidD
         yueA==
X-Gm-Message-State: AGRZ1gKZstNiFgiW+FQt5vYK7gLC7amTEyxZNdPeSWviKUeTnvLUotVs
        1bRGF+HU0e4Jsnd1XYRD3kNB/XYcRn1MfV0A
X-Google-Smtp-Source: AJdET5d9qwmWVWXGM2xF9ZTNy4yqKrxFOfQXU55KyU373al9YpQntkqaOTzWwLgdzOjaLn9IyZu91A==
X-Received: by 2002:a19:be16:: with SMTP id o22mr1206149lff.22.1540474162527;
        Thu, 25 Oct 2018 06:29:22 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id t7-v6sm1132549ljh.1.2018.10.25.06.29.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 06:29:21 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id x3-v6so8199394lji.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 06:29:21 -0700 (PDT)
X-Received: by 2002:a2e:7f14:: with SMTP id a20-v6mr1264657ljd.148.1540474161171;
 Thu, 25 Oct 2018 06:29:21 -0700 (PDT)
MIME-Version: 1.0
References: <20181024181121.3pw6o3qqcx6zd7ob@earth.universe>
In-Reply-To: <20181024181121.3pw6o3qqcx6zd7ob@earth.universe>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 Oct 2018 06:29:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=whRnOwTLrOO98CexTChnBeoVRFELoEUinvmXECwuOLTHA@mail.gmail.com>
Message-ID: <CAHk-=whRnOwTLrOO98CexTChnBeoVRFELoEUinvmXECwuOLTHA@mail.gmail.com>
Subject: Re: [GIT PULL] power-supply changes for 4.20
To:     sre@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 11:11 AM Sebastian Reichel <sre@kernel.org> wrote:
>
> power supply and reset changes for the v4.20 series

Pulled,

                  Linus
