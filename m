Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F65C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4590320823
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="urF6Jm+f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbfBCOJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:09:33 -0500
Received: from mail-lj1-f171.google.com ([209.85.208.171]:36976 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727947AbfBCOJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:09:33 -0500
Received: by mail-lj1-f171.google.com with SMTP id t18-v6so9560111ljd.4
        for <linux-kernel@vger.kernel.org>; Sun, 03 Feb 2019 06:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=XEtncgH7aq9xulkaJRCdo2avhFx8kQbGQS0JvuSyCD0=;
        b=urF6Jm+f3NpvzSyMVMZxAJ5Dxbkx2t7GzyusyVDrfNVQe7I1xWzkmGOAThyji24ZvY
         xTPrJjMZbV6x1w/rPbbWIPguSv4BeZhOca0r5hgCLW58mfWPsWMsF0W0vN4F4dpNIz86
         AYNwxAaPy5HBGtz6IhEX8C4p6eMEWimRH0S6d4BQvCh+RzxMVVlRfZZn2VhQOSnW9zRE
         J7AULWJfnzvFaax69cceJi9oZxUE6tVCAHXzOARJ2wIvfbC7eI6gYgwExZlJSMAF10j3
         1iCi0ZIaOComb1aaeGpbesocORHyqnORiglBNR2vWX69E9lLstvlBjPfvIeMllngm0GA
         EYbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=XEtncgH7aq9xulkaJRCdo2avhFx8kQbGQS0JvuSyCD0=;
        b=nw2sWVDKpafRX0KgyczOan87JkKtrWMnYwNSKgYYuAL9p/H5oMSRDgkOqUdccvtLk6
         2C6ytmWT1n+jaCl+z52+dywRGkX5xD3X1BAgPObREeWMRV93aT7fXao6lo4jqqJLsVqh
         gcy/eq/eWG1gYu4seGTF7WxDCJvyZH1Uw6jV0no+lwWe85mV8NnGx5V/1mg3z6cLSG7+
         dpvMXsoHn6UVdbSAINPbZadr5Y2C/V6GCPa/uJitCvxb37xCY7hHvlOFuRBYkSVlmhLj
         BWzh3rSXuMMOGxj8/q+axUOeFnws/XG0GTZjqE1MbAVQPqIxpKb95vdpLNaeUh3xMDRy
         7s6g==
X-Gm-Message-State: AJcUukeRBHk9rVDvUSTssTcz0J06eq77uwRONVsGASPZbtmYrti+Tv9z
        rGbudtU+90lushnGkjZ+IH8wUOd7hqYVpCypCl3fzXTA
X-Google-Smtp-Source: ALg8bN6z/+Pv4ciJ/QsylFlQVYgOwVVU0/deXloi5yMrn6SJkYTgkW7nGmW1QoJfULphlnvnBQEOes6y3jJ2/Qq5X0g=
X-Received: by 2002:a2e:5dd9:: with SMTP id v86-v6mr37017172lje.86.1549202970765;
 Sun, 03 Feb 2019 06:09:30 -0800 (PST)
MIME-Version: 1.0
From:   Chris Rankin <rankincj@gmail.com>
Date:   Sun, 3 Feb 2019 14:09:19 +0000
Message-ID: <CAK2bqV+YhN7L=NYOMEkOvzRSa7-p51RnsRxR_=inNt+6OcsKvw@mail.gmail.com>
Subject: [BUG] What is "__ptrval__" in my dmesg logs? Bad "%p" expansion?
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I've suddenly realised that my kernel dmesg logs contain lines like:

[    0.000000] found SMP MP-table at [mem 0x000f5c20-0x000f5c2f]
mapped at [(____ptrval____)]
[    0.000000] Base memory trampoline at [(____ptrval____)] 98000 size 24576

and

[    0.000000] percpu: Embedded 41 pages/cpu @(____ptrval____) s129112
r8192 d30632 u262144

This seems to have started ~ Linux 4.15.x, and it does look like it
might be a macro expansion problem.

This is also happening for me on a different machine which uses the
radeon.ko driver (vs the amdgpu.ko driver):

drivers/gpu/drm/radeon/radeon_fence.c:862
     dev_info(rdev->dev, "fence driver on ring %d use gpu addr
0x%016llx and cpu addr 0x%p\n"

Does the kernel have a problem expanding "%p"?

Cheers,
Chris
