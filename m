Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506CAC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 23:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06E772075E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 23:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VOCOpSG4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06E772075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbeHRDCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 23:02:25 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:39974 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbeHRDCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 23:02:24 -0400
Received: by mail-io0-f193.google.com with SMTP id l14-v6so8239869iob.7;
        Fri, 17 Aug 2018 16:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GM795fA842yKllXOibWB4zaRF8MaLn0TC00PpwpZ4oM=;
        b=VOCOpSG4OtraPH+VG5FBUb/MB1pbLTxMokegUAXXA1cRd/DczX3AnoJg8VtKXJ+hd/
         scXW1dtb2nKG1NLpgJ+xGg/lZE0y4mTiqNWtUerPJ7Thc/qcG/pber1g+Rd14uOy+9iR
         3ft0OqvZwBgsepFA59zqOm4AstPtAnVJZoKmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GM795fA842yKllXOibWB4zaRF8MaLn0TC00PpwpZ4oM=;
        b=SV8J7Xi3iYW1gjQ3SrCw5ZEx5AuTJgRstNm6FnF7d4oyZi5fZ+g07Hky7ynKoxZ+i5
         f3OrB84oDQmFixpezcOYga1JcbQjvsIQHwnh4uh6BzE3M4rQ7JoDdiq5z2BiK2Cnvbht
         xZWvcJHchOEMRQaYBX66unxp5x03JzyLYwmNzY/pzcxd5u9ca+O1mN3cslRI1KWNC5VH
         WuviGAgFG1+685Et829d7Nsgg0PSm7oKLWHO6JqUlRpNpIveok5x94i9+5dRq4OuCvmn
         QZsuOXR0U85csvItwXeQJjR3FlhqRqLgzJrft2qklzl2LPchj4+CRE2DFZZeCwMYDQCo
         mF/A==
X-Gm-Message-State: AOUpUlFySFpAHqO3QdMwcDH8vruYvglLmON2ABdid2zto6IHRKxiij2r
        8piciX8TFW/6lwwjLytJZLE4XSP9mHojOeX2v4AZjw==
X-Google-Smtp-Source: AA+uWPyN0YWvd1WFLUemZBqAjaQZtdP4dhtyMb/k3orRhIjVYt2ZWJARv4Js1LhtOUTvNfp6cTY7DhvjxnjfcebJkJc=
X-Received: by 2002:a6b:7a08:: with SMTP id h8-v6mr27288235iom.238.1534550217303;
 Fri, 17 Aug 2018 16:56:57 -0700 (PDT)
MIME-Version: 1.0
References: <20180816215726.GA20526@ziepe.ca> <CA+55aFxgT8Hipm6bDrHMZ-nmdk3KZTP=J6D5k10UHTcajXAEHA@mail.gmail.com>
 <CA+55aFxD-Ua_jrrD1X6Y0Wd2gftP9=UVaa0uS=gi53zEEEAf3w@mail.gmail.com>
 <CA+55aFyGLKSzS8O3m4JaE69wUm03tGOf+507jCCViTRQaGBGxw@mail.gmail.com> <20180817211648.GK28676@mellanox.com>
In-Reply-To: <20180817211648.GK28676@mellanox.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Aug 2018 16:56:46 -0700
Message-ID: <CA+55aFyhXDgSVMEhXcEzTSX4oCJEYwKM1vFbjnsOah7F0siGFw@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 2:17 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> Would you like a patch to remove that CONFIG option?

I've definitely considered it and would almost certainly just apply a
patch that removed it.

We haven't had this issue for a while (because people stopped using
the deprecated thing), so it ended up not having been an issue lately.
Yours was the first case of deprecation warnings I've seen in a
longish while.

          Linus
