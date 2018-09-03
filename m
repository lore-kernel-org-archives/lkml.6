Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B3EC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1C4020868
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XPqe70mr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1C4020868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbeICSSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 14:18:44 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:36068 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbeICSSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 14:18:44 -0400
Received: by mail-yw1-f65.google.com with SMTP id w202-v6so208558yww.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 06:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=swB6poe2NqrxhiApBWP16A7AvUfxci4ZxIAsXpvSFSE=;
        b=XPqe70mrUHxhcicg19/X0FrYkz8VYBuzHg3/GoVeHJrSaH6iL6VYwKmG2ySbOqhnF/
         bVnwGsCu/t9xjiozXFod4I65eyo+zQ/+DDP7cBR81tRB3zymSRVoDmyq6X6+K23nmOeQ
         sPhFkiw6ff3Ng5D9MbH8EYrGZV6uA9WcYUSLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=swB6poe2NqrxhiApBWP16A7AvUfxci4ZxIAsXpvSFSE=;
        b=G0TzHdFQRc0hcs9qR2psUDBcDcee6fyiBlG5dNq8Wp7B65BToBSWHcpr6gvBN6ulu6
         DuWLW1LX1qeWpD1ewYLWai7TI6A2GJHw/HlJS9jpUJ4UF4msaVodtyOpnwwesR345/+o
         UFkKa8yWwZ3eYdF9FUXkpr+J6AFJiSr/birDRZapogcefEmRuxh6LeBSSlAmDLAdj8Ui
         gMqUeA8ZzAi7mBB8oqgqp0RXZ9cwlUJpvRJHRH/hl3ajaXVEyWq+RUndi/8eU0x3/WLU
         /+I2d/ahUJxaoGgy0BBX8TnTN/mGY5tFhUL58MBlj11QclCJcde1QAtVYRCllIwxjgz+
         JViQ==
X-Gm-Message-State: APzg51BD+N/HEeAIGTMTwAIutoRXgHNcYk97T2AwoyyAwOCUU5fEnbsA
        4uq97EksyxgKBjsiC/JNTp8mslp/nNEkEQ==
X-Google-Smtp-Source: ANB0VdYW9FGg2Wb4zp9AKUpSuNGhoGfcTfrpu4TMo81RoVD+tA3u1j/bGZ7uxAoNL2HQrDu0/zyuSg==
X-Received: by 2002:a81:9fc2:: with SMTP id w185-v6mr16240557ywg.163.1535983105302;
        Mon, 03 Sep 2018 06:58:25 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id u67-v6sm6812802ywa.56.2018.09.03.06.58.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 06:58:25 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id y20-v6so197098ybi.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 06:58:24 -0700 (PDT)
X-Received: by 2002:a25:348a:: with SMTP id b132-v6mr15901527yba.373.1535982632985;
 Mon, 03 Sep 2018 06:50:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180308094807.9443-1-jacob-chen@iotwrt.com> <6761c936-82c7-e36a-de21-c0e827b68a3e@xs4all.nl>
In-Reply-To: <6761c936-82c7-e36a-de21-c0e827b68a3e@xs4all.nl>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Mon, 3 Sep 2018 22:50:20 +0900
X-Gmail-Original-Message-ID: <CAAFQd5An=Dc5je_pedo+u8USMwtHMSfSBztaSA4G6Abn3xgbsQ@mail.gmail.com>
Message-ID: <CAAFQd5An=Dc5je_pedo+u8USMwtHMSfSBztaSA4G6Abn3xgbsQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/17] Rockchip ISP1 Driver
To:     Hans Verkuil <hverkuil@xs4all.nl>, william.hu@rock-chips.com
Cc:     Jacob Chen <jacob-chen@iotwrt.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        =?UTF-8?B?6ZKf5Lul5bSH?= <zyc@rock-chips.com>,
        Eddie Cai <eddie.cai.linux@gmail.com>,
        Jeffy <jeffy.chen@rock-chips.com>, devicetree@vger.kernel.org,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Chen Jacob <jacob2.chen@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On Mon, Sep 3, 2018 at 10:07 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> Hi Jacob,
>
> What is the status of this patch series? I haven't seen any updates for quite
> some time now, and I thought that it was getting close.
>
> It would be nice to see this go in.

AFAIK, Jacob has left the project. +william.hu@rock-chips.com , who
has been working on addressing the remaining comments for a while.

Best regards,
Tomasz
