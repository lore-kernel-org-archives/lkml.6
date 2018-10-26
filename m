Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0515C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 15:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CBA420665
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 15:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="c6lrOiRm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CBA420665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbeJ0AVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 20:21:16 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]:40067 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbeJ0AVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 20:21:16 -0400
Received: by mail-lf1-f43.google.com with SMTP id n3-v6so1255754lfe.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 08:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KU2qsFtYD0FABc1QKh3mH2GEsC6JpHPmOBllsODTPyQ=;
        b=c6lrOiRmv0K6frTQ0DPtucG987MbRa2sceHshHnVWX3DATFhbR4JgZhSSiQaShn10h
         AghqCTFpxkp4zEQQw21z2KT61flMv+usGuEKflVEDb1y1A/F36aSNUXC62yGCgxuTZ6Z
         N31DOv0vj4y8mhGq7RY6L2LJycxE7k5DcNYWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KU2qsFtYD0FABc1QKh3mH2GEsC6JpHPmOBllsODTPyQ=;
        b=KJX+LRMVjHhkwQAyizpeap4bWw6qD6DG/itQ/zO5OYKb9Dfx6dTihwX3d6BCN+Zqr1
         8UEfXKIdTOOLlfmwP0K6zH+IF3XnA27iXhE2BZ2NPSCXIcHR5m/NdFYaf3np15UPAoIo
         onFIVv8ifnGv0rR6GnNhC7aAalJdJ7AT0uQVK6uIvoRWjWld19MH5TR3XcHoREngiS7M
         lf9uEk0RFzeKZ3Rc271rzqcY6MyA6jqJ7AUarlIsNMTxVpB7rNknYiSEVvi8qaA0yAnP
         zmNezEBhlmhFzb5VSarP328pfK8quTZVm3CsjQJnoNSO1qDVMZLHvim/KWFuQDYu4AuK
         tFYQ==
X-Gm-Message-State: AGRZ1gLlGAHuOXanau41oFoCIZmWv8e7fmgTAjNE7Zh6G48ldE5lqcNj
        FTAugk4ItjPysgODbjMuu6sPLahZG/N6Mg==
X-Google-Smtp-Source: AJdET5dleKgsfXA/oDwnL/tOTLEtrJ15yTvJstWsMO2O+FJNxSCL9KiejzHJo2Nedb9gR3g9nWmXVA==
X-Received: by 2002:a19:13cc:: with SMTP id 73mr2239636lft.79.1540568623208;
        Fri, 26 Oct 2018 08:43:43 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id x6-v6sm1652487lji.36.2018.10.26.08.43.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 08:43:42 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id w16-v6so1278750lfc.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 08:43:42 -0700 (PDT)
X-Received: by 2002:a19:4948:: with SMTP id l8-v6mr2427699lfj.16.1540568621820;
 Fri, 26 Oct 2018 08:43:41 -0700 (PDT)
MIME-Version: 1.0
References: <20181026100257.GA13209@kroah.com>
In-Reply-To: <20181026100257.GA13209@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 26 Oct 2018 08:43:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjRvRcFHjgOB1OV0a2qEJvFkA_FDZrKVbTrFrGkNw415g@mail.gmail.com>
Message-ID: <CAHk-=wjRvRcFHjgOB1OV0a2qEJvFkA_FDZrKVbTrFrGkNw415g@mail.gmail.com>
Subject: Re: [GIT PULL] Driver core patches for 4.20-rc1
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 3:03 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> Driver core patches for 4.20-rc1

Pulled,

                   Linus
