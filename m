Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EE5C46475
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 01:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1218F20834
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 01:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DZVNdeDr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1218F20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbeJZKF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 06:05:26 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:34775 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbeJZKF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 06:05:26 -0400
Received: by mail-lf1-f54.google.com with SMTP id n26-v6so8269423lfl.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 18:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QWjaPZ02LuYmzewknTfhMXGBoGhj8sCA1Tg3TmlW80w=;
        b=DZVNdeDruNjxBdbyTJNSXXixsNQZirbMHMFYOhg6xBn5E9hxjJC4t0PA4zu+LeBjSH
         5DL+ZRXsvg5tsFOrMULXM42IkbY0nsmwBXE7qjKGcYuWH+BoN+v22KqBySakNFU0zXEF
         PWn52DA3K29JHG4DyTDQUu1IzqtWj6yZNghuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QWjaPZ02LuYmzewknTfhMXGBoGhj8sCA1Tg3TmlW80w=;
        b=fv2n2qU+njOuajUQr609gbsD1YDKQWamKKC0DTTO1064YR2OJ4rvgpX9Q6pq/pxLgZ
         df1/YeFOEzU8Lco10l3tsm4A9Cn0A8DBtqJXeKx69OVV2lUMtxfH0IjQ3wF/uKMOlG0s
         0w+eFoJzMB1iauenvzum74sqKCrJchILoItEkDSjO9X4gBs18H07yxMohJ229VAjWljm
         sE0lbiDD2BtrFdwtq+7uZsbqIcyR/Slpb5uuBfYfin8SzPYXMzB22DPdJ0A4QyaKIfNB
         DKOBf0rAOQDnQWF0LNbpSyVk/1/8IlYPAgIJYnkTw41CqL+wkJpFDt6xo74UgUiOAsVd
         /yCA==
X-Gm-Message-State: AGRZ1gLz1mUtesv7W6zFHBCU8c7TqHI3o7bHhDlr+uSGvPq6posXjMlg
        SITJo/f5K4KB0L72cSyybbFPMMFieV/JYw==
X-Google-Smtp-Source: AJdET5caIAET+8DXqZ4PwNGOPMi07ZKKTrWWpSVWwk68tzj+7QUHXMGcZOMbMAtRCoKpxdP4EEgBAg==
X-Received: by 2002:a19:1365:: with SMTP id j98mr823490lfi.55.1540517426636;
        Thu, 25 Oct 2018 18:30:26 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id g79-v6sm1510637lfg.56.2018.10.25.18.30.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 18:30:25 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id d7-v6so8276942lfi.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 18:30:25 -0700 (PDT)
X-Received: by 2002:ac2:41d8:: with SMTP id d24-v6mr828057lfi.138.1540517425058;
 Thu, 25 Oct 2018 18:30:25 -0700 (PDT)
MIME-Version: 1.0
References: <20181025.112809.1174535381380570860.davem@davemloft.net>
In-Reply-To: <20181025.112809.1174535381380570860.davem@davemloft.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 Oct 2018 18:30:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wizjZnXj0LzD3ZfmPWj3eNqXBfvToybw1o+p_BF0fDRNQ@mail.gmail.com>
Message-ID: <CAHk-=wizjZnXj0LzD3ZfmPWj3eNqXBfvToybw1o+p_BF0fDRNQ@mail.gmail.com>
Subject: Re: [GIT] Sparc
To:     David Miller <davem@davemloft.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        sparclinux@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 11:28 AM David Miller <davem@davemloft.net> wrote:
>
> Please pull to get this build regression fix.

Pulled,

              Linus
