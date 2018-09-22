Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CBCC433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 02:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A65F21569
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 02:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AKXpM0x/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A65F21569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbeIVIuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 04:50:10 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:36783 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbeIVIuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 04:50:10 -0400
Received: by mail-yb1-f194.google.com with SMTP id 5-v6so6264975ybf.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 19:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fLw5DNn3KWxvKhB6CEeQ8nQV65X7iyHkX0FWs7hYoHk=;
        b=AKXpM0x/xvww27lqOk0zbzbxqUpWYCeJp4EsYIBqr5q7IkjmEt3Jvkp/T60Tr0mfi1
         2OXquogaeXp8TPz0rputtuhkOAZN9I1HrWNTZzm8ZkLVpcdgXJRfbAy/9Yj02Nb7KzT1
         OkN12eftI9Wchd1yMskvMizvmQmOfJjJ2/wnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fLw5DNn3KWxvKhB6CEeQ8nQV65X7iyHkX0FWs7hYoHk=;
        b=j7VJ2MFiPKNu8myNGbNHW2omsaU3anvHsijjrH8do4FCacmU/cpdkY4Af0+H4itjDn
         b7RqcNmEg0xqhkyFhiUPb2euzo4WKHHm84HXKR4jje6U/AjlXveGGvXgrIFQtPkTjVtv
         B6RR/UNFNr93Oo4V6ygOHGsyWX+TCDI/xOAkG67H9bKNo8BGf82pbYLeThdHABu3gD5P
         RNewThFqpMTxasnC+tXTPlSuBV/YDn0RTjbMgITLWyQzH+q4GKy8t043oAVGzsq1ftYp
         FyEYxz/9qL6+MMvIHGRWjaSscfB0jB58u6v+wgqqkBZgRxUvpbywWDxla5womUJ+TFN8
         8I+g==
X-Gm-Message-State: ABuFfoiK1DmsLaj7KRfz9My8jwktHi4ZhmlwSq62WkG0svvYtVr3de0n
        N3Sj7AnBwJGL5Q2aa93oSL0Ux+2rMzM=
X-Google-Smtp-Source: ACcGV62C44VSpaLy1oWbaLYL6Bb+Q1mvSJgM+Zj0N/I3ow64hYwrokXq1F3SBjivzpahavxQE+73+g==
X-Received: by 2002:a25:6892:: with SMTP id d140-v6mr214040ybc.308.1537585098167;
        Fri, 21 Sep 2018 19:58:18 -0700 (PDT)
Received: from mail-yw1-f43.google.com (mail-yw1-f43.google.com. [209.85.161.43])
        by smtp.gmail.com with ESMTPSA id m187-v6sm867697ywb.54.2018.09.21.19.58.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 19:58:17 -0700 (PDT)
Received: by mail-yw1-f43.google.com with SMTP id g3-v6so1348741ywb.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 19:58:16 -0700 (PDT)
X-Received: by 2002:a81:2908:: with SMTP id p8-v6mr202979ywp.407.1537585096185;
 Fri, 21 Sep 2018 19:58:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Fri, 21 Sep 2018 19:58:15
 -0700 (PDT)
In-Reply-To: <4e4a7033-a86d-a30f-7420-acd765f90534@schaufler-ca.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com> <4e4a7033-a86d-a30f-7420-acd765f90534@schaufler-ca.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 21 Sep 2018 19:58:15 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLqvrvTe+RmNs86H0ud+9AW8wT8yEbbWeYxmisuOKZQxw@mail.gmail.com>
Message-ID: <CAGXu5jLqvrvTe+RmNs86H0ud+9AW8wT8yEbbWeYxmisuOKZQxw@mail.gmail.com>
Subject: Re: [PATCH v4 18/19] LSM: Infrastructure management of the ipc
 security blob
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     LSM <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        LKLM <linux-kernel@vger.kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 5:20 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> Move management of the kern_ipc_perm->security and
> msg_msg->security blobs out of the individual security
> modules and into the security infrastructure. Instead
> of allocating the blobs from within the modules the modules
> tell the infrastructure how much space is required, and
> the space is allocated there.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
