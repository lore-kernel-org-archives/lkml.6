Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557DDC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A50A2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DAHievYQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A50A2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731457AbeK1EHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 23:07:45 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44523 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbeK1EHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 23:07:45 -0500
Received: by mail-lf1-f66.google.com with SMTP id z13so17016830lfe.11
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 09:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1I7vnWmQJAYIQJDiVb2pS/7gkIHOlWRw8H1OGt9VlSg=;
        b=DAHievYQSg6+sm74rPv9BMjGXXCJYT9IRzEh3yWzswl9EsxRAefZ/LLsk5cG9E3Upn
         Jad2YBEzstlyVdTpbcPWklKRrCh4HOVS8tn2VMRpZ+KNZXoGUFvSTIrGq2HP+yaU9yRL
         1+6wEJatiAKgAgzEbw+ntJXMWEljT6JFj2aS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1I7vnWmQJAYIQJDiVb2pS/7gkIHOlWRw8H1OGt9VlSg=;
        b=hO7vje8+d5A3KjjXSVyddBBfKCmKeal3i2TDZi8ZnbxXZBPdh6jsPZSjChzPMNwlEn
         RKdOIXYGsBcyBbbOK1NO93zqIxvnJfKmXslwfhtIJAcOZcawK96ODGvmM0zmFoHehj+3
         6qjG97E9VHgCAiPskiq6BydHUQcyBkSt7q2uGI8noC5T73e8y4kcbvroRhcUBlZWcle6
         CkDtWt1tYDyHKSxf2lfv1cVxb0t+ev9GnBSwBqkG9zh3Ccul5Tr5cEV1Uy/FjDkugsnm
         zrnjJ6WcfxKREy8hjIVFuG5WCrCxqcvDQmru3LKfolPp/DI3osQTB0buDEFl4armPrNY
         q0tQ==
X-Gm-Message-State: AGRZ1gKhuDZ559XXRPt3rjLp0/gUNhePoenOhooG5eQhTNhSA7xle9yH
        nw6ZY8HPeBixzN+FquuZgH+kr93ofLw=
X-Google-Smtp-Source: AJdET5eBcmh9UNW+nNcL0SrPL6kJpW3oiZsQJjLb3J8OhjYFowcIE+poXIrWUxz0E5goieKDjCY64Q==
X-Received: by 2002:a19:c650:: with SMTP id w77mr20005832lff.56.1543338550170;
        Tue, 27 Nov 2018 09:09:10 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id g17sm699373lfg.78.2018.11.27.09.09.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 09:09:08 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id p6so17050055lfc.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 09:09:07 -0800 (PST)
X-Received: by 2002:a19:c014:: with SMTP id q20mr18156264lff.16.1543338546686;
 Tue, 27 Nov 2018 09:09:06 -0800 (PST)
MIME-Version: 1.0
References: <20181127062503.GH6163@shao2-debian>
In-Reply-To: <20181127062503.GH6163@shao2-debian>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 27 Nov 2018 09:08:50 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiq9eTzenOPh9srdB=Y8NcP6NJxh7o8Y5SfSjfqZ20-RA@mail.gmail.com>
Message-ID: <CAHk-=wiq9eTzenOPh9srdB=Y8NcP6NJxh7o8Y5SfSjfqZ20-RA@mail.gmail.com>
Subject: Re: [LKP] [mm] ac5b2c1891: vm-scalability.throughput -61.3% regression
To:     rong.a.chen@intel.com
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@suse.com>, s.priebe@profihost.ag,
        alex.williamson@redhat.com, mgorman@techsingularity.net,
        zi.yan@cs.rutgers.edu, Vlastimil Babka <vbabka@suse.cz>,
        rientjes@google.com, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        lkp@01.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 10:24 PM kernel test robot
<rong.a.chen@intel.com> wrote:
>
> FYI, we noticed a -61.3% regression of vm-scalability.throughput due
> to commit ac5b2c18911f ("mm: thp: relax __GFP_THISNODE for
> MADV_HUGEPAGE mappings")

Well, that's certainly noticeable and not good.

Andrea, I suspect it might be causing fights with auto numa migration..

Lots more system time, but also look at this:

>    1122389 =C2=B1  9%     +17.2%    1315380 =C2=B1  4%  proc-vmstat.numa_=
hit
>     214722 =C2=B1  5%     +21.6%     261076 =C2=B1  3%  proc-vmstat.numa_=
huge_pte_updates
>    1108142 =C2=B1  9%     +17.4%    1300857 =C2=B1  4%  proc-vmstat.numa_=
local
>     145368 =C2=B1 48%     +63.1%     237050 =C2=B1 17%  proc-vmstat.numa_=
miss
>     159615 =C2=B1 44%     +57.6%     251573 =C2=B1 16%  proc-vmstat.numa_=
other
>     185.50 =C2=B1 81%   +8278.6%      15542 =C2=B1 40%  proc-vmstat.numa_=
pages_migrated

Should the commit be reverted? Or perhaps at least modified?

                     Linus
