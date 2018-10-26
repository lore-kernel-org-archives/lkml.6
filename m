Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3E7C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83D2F20651
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NOoVA4ah"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83D2F20651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbeJZX1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 19:27:50 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:43882 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbeJZX1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 19:27:50 -0400
Received: by mail-lf1-f44.google.com with SMTP id u18so1111787lff.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 07:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T9WXY3sKGxX/0H0/CxqPYfAosSsj/FF5MfUxTXwGkqA=;
        b=NOoVA4ahsfe3+HOhvvJYaeqli6MvCLFTl0znwkP49IjpenRGRIkj1PsESAExAe4ycH
         waIupocx1yfhsR5hzmcjW/lBdZzGXGOHm3UzP9pL5jy/Us4ef8/gl8zfEyX1933q8jNP
         /yKi2VsznmShuoH35xdGeoQxUBPDzl2Hg/BXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T9WXY3sKGxX/0H0/CxqPYfAosSsj/FF5MfUxTXwGkqA=;
        b=dGuG9DBcWgouLv1IZZSmujNlgBbDBjQ4jFrvf+vtRA53QOIpG6fZfrnFN2syd5gBps
         O0TOggSW43vZKBmP1xTpaK1W83/0NGwy1rEzmqf2RJbC9mYS2lY54/qX1ujW3gXXJeS5
         5caklWY6MmneodAnbtCWAlkQXs98aoqxmGwloO2Cil6b8gYBKIKi1BOKu3iYSeflLKAu
         idXox1weHJh1OmH+TK27KhZaNkAb5yDE7HIvUJCHzk/jTRtuxdx2pWIe7q9/VNwA6XYS
         aIvhWLDhiYvhyM4zF5rd7sFTHNlA7l6955ZH5LgGIKkGfGv3X5xLE3Oa+faImrfVEUhY
         Jkew==
X-Gm-Message-State: AGRZ1gL7B4cXOsY0YnMEhNDQXnvQbMpWEkbhfrHJ/8olfNhWtQfVj+y9
        Dm0GuZK7GbpxC7F0vQufe1xVLWLC5u97hQ==
X-Google-Smtp-Source: AJdET5dp1uve0GaN3eX7W/+URUW0HldTY9O639wiVQS7XGJ6x8kyTOk3DeTfoaNYRfSD5zDPrLsnXw==
X-Received: by 2002:a19:e01e:: with SMTP id x30mr2355064lfg.89.1540565425975;
        Fri, 26 Oct 2018 07:50:25 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id f95-v6sm1650193lji.76.2018.10.26.07.50.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 07:50:24 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id c21-v6so1423324ljj.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 07:50:24 -0700 (PDT)
X-Received: by 2002:a2e:9584:: with SMTP id w4-v6mr2688995ljh.118.1540565424074;
 Fri, 26 Oct 2018 07:50:24 -0700 (PDT)
MIME-Version: 1.0
References: <20181025212112.GA1747@ziepe.ca>
In-Reply-To: <20181025212112.GA1747@ziepe.ca>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 26 Oct 2018 07:50:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi+fn7y9Ya-2-Q01FdrwfC4YxLhc4Cujfe=0StzuMDKAw@mail.gmail.com>
Message-ID: <CAHk-=wi+fn7y9Ya-2-Q01FdrwfC4YxLhc4Cujfe=0StzuMDKAw@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
To:     jgg@mellanox.com
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 2:21 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> This pull request is following your recommendation from 4.19, the
> for-linus tag has no merge, a for-linus-merged tag has my merge
> resolution for your reference, and the diffstat below has been
> replaced with the diffstat from the for-linus-merged tag.

Thanks, looks good.  Pulled,

                Linus
