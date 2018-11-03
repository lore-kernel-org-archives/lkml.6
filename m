Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993C6C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 17:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5037420843
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 17:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hEHL8k4w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5037420843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbeKDDHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 23:07:17 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35108 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbeKDDHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 23:07:16 -0400
Received: by mail-lj1-f195.google.com with SMTP id x85-v6so4482141ljb.2
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 10:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8xzp9XayaUOdChQWA0gXY481mnczl4Xcimp8o82mMxE=;
        b=hEHL8k4w5JEZYvRG56Xiq7NDEE5ocvtM3P+874Gh+Y1K0Hg/P7d34eHSiGPxN7ym7d
         AL0VAhTDw4oeX2T+7ggSzsT6ijeghPNcOsjzmpanqT5bCzE3/YBGSgQlCrv+0tZ7CF6/
         4qAbLAfoNavPRHeamw/q+H0+wxiVlgXOxS40E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8xzp9XayaUOdChQWA0gXY481mnczl4Xcimp8o82mMxE=;
        b=e7/6XErHN8WEyAauiEXg0cBqVY5RKaQ0Ug1w3qCA1fL5clkgyAwyEmHnhJEinTbGr8
         W9Db8iWjmWIjCNeuJGc3F3yT+AywBbtSytdepxKyMB32U3gYypgx3ffM1tcBwgU1RQU5
         GeMZFrg1wG3o4IXLJAZ7unebXN4EjYJfLhv+Gidz1URlY+YQZR4yKUfePLcmKuDjWz2K
         rJiwwlaEUV1XHLgVn0wTVXCJkgxT5zL3lu5mV1IZ1Lcom400TDUA5PDX3ZK6Rc9zrIEc
         LlMuV76xpdE1zYrtZtDg5aQVf623CKAMAlJ4dYta125ZYtAevLkYJ89Kyo+uMpJzrnYB
         HO2A==
X-Gm-Message-State: AGRZ1gIaneltcfJ49OeBir7SwmVqBr+uVwbnD/IevDbR2DZCoSCC5lXh
        xCk18gDg7dVS03Ax1O8y9mmE10lMeMywjg==
X-Google-Smtp-Source: AJdET5cLuPoKz9lNNZ/G+PJDNUv4iiSHciwaNtSnc5xD/ejZVCNWNRwRxeKIQsUTMWDn7geCb8BOgQ==
X-Received: by 2002:a2e:9d86:: with SMTP id c6-v6mr10314160ljj.146.1541267717785;
        Sat, 03 Nov 2018 10:55:17 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id i3-v6sm2172267lji.11.2018.11.03.10.55.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 10:55:16 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id n18so3404871lfh.6
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 10:55:16 -0700 (PDT)
X-Received: by 2002:a19:7019:: with SMTP id h25-v6mr9781176lfc.147.1541267716118;
 Sat, 03 Nov 2018 10:55:16 -0700 (PDT)
MIME-Version: 1.0
References: <20181103084210.GA1429@infradead.org>
In-Reply-To: <20181103084210.GA1429@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 3 Nov 2018 10:55:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg6PrCK6CBx3khgt5Pv3NX3JadtNVgJiN0_E8aHO=-ziw@mail.gmail.com>
Message-ID: <CAHk-=wg6PrCK6CBx3khgt5Pv3NX3JadtNVgJiN0_E8aHO=-ziw@mail.gmail.com>
Subject: Re: [GIT PULL] dma-mapping fix for 4.20
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>, will.deacon@arm.com,
        iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 3, 2018 at 1:42 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> Avoid compile warnings on non-default arm64 configs

Pulled,

                   Linus
