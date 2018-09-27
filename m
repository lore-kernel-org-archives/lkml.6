Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E417C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 21:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F132152F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 21:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=percona.com header.i=@percona.com header.b="Yh8zpG4U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1F132152F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=percona.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbeI1DVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 23:21:54 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:35823 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbeI1DVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 23:21:53 -0400
Received: by mail-wm1-f47.google.com with SMTP id o18-v6so194553wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 14:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=percona.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WBz03yuexB8J1CjKn61uY6pVAgVZq8pavNpRm43Jya0=;
        b=Yh8zpG4UTR6FhOVZABWDo/dE4D6+MjChssOz2VZEflRD1A4i+L5Jf0/s/7Y+Xs1mwL
         2kJEazsDkPoLmK8sWRbt2snMRfR5lcmrsaISkXtc4s6F/o5WYp8zju/M/Qov7K9CTx8Z
         vfT19291ob/H6pXDuAEJqynIIGAsFygiBqpDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WBz03yuexB8J1CjKn61uY6pVAgVZq8pavNpRm43Jya0=;
        b=Fk0dVfg/VDUeWFneBHTOkSQ0bx5LE22cJ3B/1PKCnGRZkGnrNLiiyY3pzaBSCAcN/I
         SQVxRajtbdU8ANzZ1f43CXHnTC9jefipJ86Zw2I4hOLduQ9nELfEP2BOB5gY3MRR+pN/
         Fv5fW+PHyfBCuRBWu2d966hk/XFMchsiH4Wd4zsWzhTUkn7w6MYoR2JQY0DZrBT0J/z4
         jNNd5vgILFyMeDfqCIUqQcQ6CPRHspCmWwl415UqWgIzDvKCe88cBc7mwcEXTCe7n0i3
         V+Kujro8qaGcpyQuRkJlSuW5D2RQrLgsblyyIAh6QHPDiiEd4CR1CEMAk7xFoTE/pFQV
         2gsQ==
X-Gm-Message-State: ABuFfohCUZ6jJhgdOG+85qHn0gE4VQS9nEHM+aE0stGXs9+m0oKKf/gJ
        N6ULQfixHa09qno0AKyJP1nNCLNL1DW5dTKDnCznhHZoLOc=
X-Google-Smtp-Source: ACcGV63vhDTHtAUYzYDTHdJXXPyTd3c/8TxTgUtF3wEEMVJMVVj592gwLEiBH6fa9qagYKz16Aaf9Ln7LiMm3fQFgb4=
X-Received: by 2002:a1c:bc86:: with SMTP id m128-v6mr200236wmf.147.1538082101591;
 Thu, 27 Sep 2018 14:01:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:1444:0:0:0:0:0 with HTTP; Thu, 27 Sep 2018 14:01:01
 -0700 (PDT)
In-Reply-To: <04f4b19f-2990-6ad3-1ae4-b41da1ca089f@schaufler-ca.com>
References: <CAGQTitMPcrHRhFVLfApe21T7hYyeX05ffuSJj452+f+ZksmQqg@mail.gmail.com>
 <CAGQTitONf2L_p9JQ7oMac+Sw2wdJZg_z2MHucpdf87vvBBgF0g@mail.gmail.com> <04f4b19f-2990-6ad3-1ae4-b41da1ca089f@schaufler-ca.com>
From:   Roel Van de Paar <roel.vandepaar@percona.com>
Date:   Fri, 28 Sep 2018 07:01:01 +1000
Message-ID: <CAGQTitOKGj_+DDxaGnfRRdZ+TJxhZ8SxBLcZzLF-vtxYDZXbEA@mail.gmail.com>
Subject: Re: Bug: getcwd: cannot access parent directories
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Casey,

On 28 September 2018 at 05:46, Casey Schaufler <casey@schaufler-ca.com> wrote:

> Please try doing this under strace, in particular
>
>         strace mv 3 /dev/shm
>
> What you will see is that the mv command does a copy/delete
> when changing filesystems. The original "2" directory, which
> is your current working directory, will have no parent as the
> original "1" will have been removed.
>
>>>
>>> Back to session 1
>>>   cd ..   # fail
>>>   cd ..   # fail
>>>   cd ..   # fail
>>>   cd ..   # fail
>>>   cd ..   # fail
>>>   cd ..   # fail
>>>   cd ..   # works, but to completely incorrect directory given the
>>> many 'cd ..'```
>>>
>>> The problem is made more clear here by using 3/4/5/6/7 but you can
>>> also just use a single subdir to see it
>> Roel Van de Paar, Technical Director - Quality Assurance, Percona
>
> The system is working properly.

Thank you for the analysis.

I can see your point, but it looks like this could be improved by
matching the behavior when not changing filesystems.

Also, there is a difference between working when it is a different
filesystem or not - so there is inconsistency in operation.
