Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1207CECDE47
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 20:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B92AB207DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 20:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NOS/avSw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B92AB207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbeJ0FDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 01:03:48 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45222 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbeJ0FDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 01:03:48 -0400
Received: by mail-lf1-f66.google.com with SMTP id c24-v6so1840531lfi.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 13:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GOiijbCg+uXy2wIwP3kyk+BVBIFGQNq9w47q/SOLiyc=;
        b=NOS/avSw16pVK1Tf2rGyKBIiZxHdE7DAhh8KjAkMSXL3JEZWRYsDZXMJIsb2JwqKkQ
         0fdt7LP8heIavDEIRJapfFUWZ1floUH3NdMA1dEW/L3VQ9cklrc8LUUZS+2a/aRmP5DP
         eq24E2yr1HHfmuqcaTbti0J3IE5wFIdkh7Vv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GOiijbCg+uXy2wIwP3kyk+BVBIFGQNq9w47q/SOLiyc=;
        b=X6QsSntDXDonmypvat/HeTFoPKRYFnwaqGeZkzeQQBG81yp53SK2lYEDYRQdAOjpqB
         S9q1M3p19V3G0rxlBd5mLxm/Mef1/w/9Q3NG2ImID5c2M08e4VYjEGrK8gsq7jZhv043
         9juuuQ8okKmTh/vDVGrqv65414SS5MzwAe+R5INe1wMGqdT/9SlnoU9y1Wv+SW3J5vRu
         BUCIGaHmvOimycrD1EJ2by4Hcb1aSlU6qi7WK7Gemg/OX8oefHKiT2RySYSu6/gFKGpY
         hOvsh2l3oVPIAbmtEYGc0Y9Uic3VM+5RoVj9h/tOOkk8F2nHnVUS3zMvtbcFjN5qmkNa
         CawQ==
X-Gm-Message-State: AGRZ1gJ9YUykM4PQZqNVEXbH6cJiYsXHar1bOQhrJgTAMAe6RSFYlKjL
        5Z/NHqjZoKA8wCZETrSI1O9T0mY+No5BZg==
X-Google-Smtp-Source: AJdET5d7ki68gYKcWfbx7VJXUj0ni92ezUMVu1icBu1ko65UogvqXYW4XsJCXXvysLgQw2l0XpXqPw==
X-Received: by 2002:a19:e601:: with SMTP id d1mr3251462lfh.71.1540585520611;
        Fri, 26 Oct 2018 13:25:20 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id 9-v6sm1705882lju.61.2018.10.26.13.25.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 13:25:19 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id m18-v6so1844368lfl.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 13:25:19 -0700 (PDT)
X-Received: by 2002:a19:288c:: with SMTP id o134-v6mr3276283lfo.124.1540585519180;
 Fri, 26 Oct 2018 13:25:19 -0700 (PDT)
MIME-Version: 1.0
References: <6bbed95d83465dde644c6f66acc73e3cd94f123e.camel@hammerspace.com>
 <CAHk-=wheW3hFQ8Jy5YYnNL1V+ZqA_qQoA63q2uK9ngz4=pXCqw@mail.gmail.com> <bafa9f6ca7da84e710bc9e1af8fa7428a8331bb6.camel@hammerspace.com>
In-Reply-To: <bafa9f6ca7da84e710bc9e1af8fa7428a8331bb6.camel@hammerspace.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 26 Oct 2018 13:25:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi9j8SzN3nvVaCU=5c4J=Z3Xom0W59DhBRAR+YbY+wQXQ@mail.gmail.com>
Message-ID: <CAHk-=wi9j8SzN3nvVaCU=5c4J=Z3Xom0W59DhBRAR+YbY+wQXQ@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull NFS client changes for Linux 4.20.
To:     trondmy@hammerspace.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 1:21 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> We agreed about a year or so ago to take turns maintaining the linux-
> next branches.

Heh. That was a simpler pattern than I thought. It was just hidden by
the fact that there are sometimes more than one pull request during
the merge window, and then a variable number of "fixes" pull requests
during the rc's..

But now that you mention it I can see that yeah, it just alternates by
releases..

                   Linus
