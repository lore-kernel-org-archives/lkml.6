Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7DAC0044C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 00:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A7C52082B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 00:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gXsWGAlW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A7C52082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbeJ3JCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 05:02:17 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46571 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbeJ3JCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 05:02:17 -0400
Received: by mail-lf1-f67.google.com with SMTP id o2-v6so7467359lfl.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 17:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K9j0lRQ1Q144StdQo+znmqaivfGOJcRZVreYfNDC4m4=;
        b=gXsWGAlWu76mA3kBZFA/2p7yGkFjL33QRt2vhzkdKkYbPH91CLh8h3TbOAndnvNGkf
         3rZa0//zfAXDwY2Pp7Aa9oV4A7VXngLrwNdr1y7jBZQA2OzLRVKHppzJROR25f6tRmHG
         UxIPpihSO2PaK778b8xNKAng77tmNxoaxKvWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K9j0lRQ1Q144StdQo+znmqaivfGOJcRZVreYfNDC4m4=;
        b=nBsBp0UhTaJuqPv0mjLT6LGYUc/5LcaaW6JV78e8n8APbID1QePgN/QKPWba1J0Aje
         KBY+MCVox7rCeyaPuc1ONzaJWEfIxfk/xUquX7XnxqkbSLF2a3erc//JhCYiDYt9SSZq
         D2Lk0KVMmrMdoTHGfh/NynptwPCHha7h1NW3Ej1GR73WZXlB8+rkkI9ywmEU5mXTvL3h
         QSWXD5zZPC2RRnV22IkAK1ZW9dEe6gIzppcn65/D+fUBIUb4gGcBewyE2acLyPIz7fff
         uaOSjNp1cEARMVdcVMHxTnGGXn5dBeZyAqE8h7yTfxBSaGu5vqzFdT87h5Ti2XlZYC6Z
         UgpA==
X-Gm-Message-State: AGRZ1gKumTnjueWgvQsjP8I1SKFu7NiOmxSRqKKOKJ3uAWoZ6qm3fDLt
        aoSPeVUKC2GjHF4PaA11pSo9bUXt6mWExg==
X-Google-Smtp-Source: AJdET5ccsNetMD/sYNcb9JRdLe7YnA+GJVJk2w60TddpoCIaBbtCLLvVyIW9nzYjde+8jKxalhensA==
X-Received: by 2002:a19:c203:: with SMTP id l3mr422725lfc.113.1540858269296;
        Mon, 29 Oct 2018 17:11:09 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id a14-v6sm3430565lfb.22.2018.10.29.17.11.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 17:11:08 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id z21-v6so9632445ljz.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 17:11:07 -0700 (PDT)
X-Received: by 2002:a2e:9983:: with SMTP id w3-v6mr5182204lji.133.1540858267477;
 Mon, 29 Oct 2018 17:11:07 -0700 (PDT)
MIME-Version: 1.0
References: <20181029233330.GW12063@builder>
In-Reply-To: <20181029233330.GW12063@builder>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 29 Oct 2018 17:10:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjhbXUoGzbKwLwdVj3xnNMVk-n0_d6iMcx3xmAcEz29uQ@mail.gmail.com>
Message-ID: <CAHk-=wjhbXUoGzbKwLwdVj3xnNMVk-n0_d6iMcx3xmAcEz29uQ@mail.gmail.com>
Subject: Re: [GIT PULL] rpmsg updates for v4.20
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     ohad@wizery.com, linux-remoteproc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        aneela@codeaurora.org, clew@codeaurora.org,
        colin.king@canonical.com, robh@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 4:30 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> rpmsg updates for v4.20

Pulled (along with the remoteproc branch),

            Linus
