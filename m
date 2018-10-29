Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B64AC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 21:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E2120824
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 21:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eNNsrd8B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05E2120824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbeJ3Gd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 02:33:56 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:32956 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbeJ3Gd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 02:33:56 -0400
Received: by mail-lf1-f66.google.com with SMTP id i26so2949607lfc.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 14:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xl2Hv8Km6YRU3qoWeObklIb/xA7wX2/hEByQePF/gtw=;
        b=eNNsrd8BDSkg72/6s8WqzD09gfImlyhFb9oVNNLb4z5rJUCQGVduJkkIM/E6BbTD9L
         96wWXaW57cYFyNkeDNWPsuBDYN4/HDmsancrDAKITQ+cBJrb2eAri9/vaZXEosNewd6H
         hAakas2c4nG42nxFYyWjdiLRBUajqni6tIQ0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xl2Hv8Km6YRU3qoWeObklIb/xA7wX2/hEByQePF/gtw=;
        b=QXvIHR48qrTZOdRW1UAGS7nbIdgXCxHtm+OhHkwkQDGAAyhFm3yD5Z+MyogpoHbYfg
         A/CQfhXfYIWbK/PN2xsAcSBu7HbOShsPn0Eg1IkIDgz82P7Bljk8AvZ++sTz5UPotDHG
         wP0FroUFjmq4HpoklahyA7Wyckst7pXZuSubFCQCd1B89maWawgbMDTr/AhM2sI0vkgD
         dUHK0bgv4ylT9hYXEezpiDUlcedsOrQLzpIIB3V1Mfj+ZlU7QzQSVWrxMYq2DPpNwWW4
         wQSGHZY/AzNmpEX9X2BhR2q+aLuH1IyS16GdIYCc2wV2zDexMenwiaPsXAdIhi8NLJA1
         339g==
X-Gm-Message-State: AGRZ1gJrhT/4LErvWFT8wZ4QMfuQB+iJRxhgfvNCv7LE1aimZ8+yLt6z
        BGdfVz/3kKX6JKba7EZtjXBRWGp4FUGjWw==
X-Google-Smtp-Source: AJdET5dDY2u2VLgr1Om8LtGv8pM3Z05SyCfsN4zdH8Swua2s2T90pF6OX6jkm3Mqhu946rECyMvPqA==
X-Received: by 2002:a19:a7c1:: with SMTP id q184-v6mr245647lfe.37.1540849401916;
        Mon, 29 Oct 2018 14:43:21 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id x29-v6sm1971149ljb.69.2018.10.29.14.43.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 14:43:21 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id n26-v6so7288715lfl.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 14:43:20 -0700 (PDT)
X-Received: by 2002:a19:7019:: with SMTP id h25-v6mr250859lfc.147.1540849400384;
 Mon, 29 Oct 2018 14:43:20 -0700 (PDT)
MIME-Version: 1.0
References: <20181029173424.35da7deb@coco.lan>
In-Reply-To: <20181029173424.35da7deb@coco.lan>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 29 Oct 2018 14:43:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh_rPB=Z1=JzH6zetq5GCs_vqTCYqi_hshhhBdjmvK4ZA@mail.gmail.com>
Message-ID: <CAHk-=wh_rPB=Z1=JzH6zetq5GCs_vqTCYqi_hshhhBdjmvK4ZA@mail.gmail.com>
Subject: Re: [GIT PULL for v4.20-rc1] media updates
To:     mchehab+samsung@kernel.org
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-media@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 1:34 PM Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
>
> media updates for v4.20-rc1

Pulled,

                             Linus
