Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D14C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E950320850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GQI+M1nj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E950320850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbeLEXv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 18:51:28 -0500
Received: from mail-lj1-f181.google.com ([209.85.208.181]:39780 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728946AbeLEXv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 18:51:28 -0500
Received: by mail-lj1-f181.google.com with SMTP id t9-v6so19981272ljh.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 15:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9r9WEOTF5ibipZeP0XMLls4gOvbIlCOsgGEU/Xstetk=;
        b=GQI+M1njDOo1EHeh8+65dArmUwOyCo+0Viev2Vwu2hJFFHw2y1D2DdF5ImBcTeJGj4
         adIFhIwQdnvc2PCQufjilus6+snvuNbPohJ6684hnchd95DOl1GCBlEQKVGeePOWx5KF
         iOudYqqaHHqtjgwycTTIzgaywUD5/jtzKa9Zo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9r9WEOTF5ibipZeP0XMLls4gOvbIlCOsgGEU/Xstetk=;
        b=n+KcDFOGLePlJZOo0z17IF+Xqe0EsFfQTjAQ5ePhVxTNrvAE7a+0pOZVvHkdWo+KX6
         Vo4YZWhWuiFBfRh9L1H3TMHOyrwsEUuGXLkM1ZVQsYqEATABh72u9JS5/EVXBFtpN97X
         1vW2+ui0WA/4pi5JbR9S2w8Aoxo9ORStD0XqvydGMerd7BEjVMzPfrBrdDJnUHL6wNX4
         6MNAaPav936TtlcSg89lt2KbCXV3s8SgTEycfLx5sKFi68jm5xqB0ZpgQK4WfeCo5/EV
         6rd0JZB2pUcbUIYf6eyxhkT8kqO0ezhp/h+RXZ4afoxQb2xXBHnCogkmVtOdfZqWQMw8
         yg8Q==
X-Gm-Message-State: AA+aEWYanSsdL2X0W+xHAqILb6kvpIh7C/D+xcH1Um/oSi7WSGMULKvQ
        OrNk4I1vuFdgYYVG8ZRPp6b1Zfuy6q4=
X-Google-Smtp-Source: AFSGD/Vnaelawm3Aa3DGLN2Jk5k0t/H9D6cXS5SD2awfDZfttGgwqE4Lx/ykAtzuLHXcRw1VXwfRjw==
X-Received: by 2002:a2e:4a19:: with SMTP id x25-v6mr16284726lja.19.1544053884816;
        Wed, 05 Dec 2018 15:51:24 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id v17-v6sm3964430ljg.32.2018.12.05.15.51.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 15:51:23 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id u6-v6so20002129ljd.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 15:51:23 -0800 (PST)
X-Received: by 2002:a2e:9983:: with SMTP id w3-v6mr303324lji.133.1544053882771;
 Wed, 05 Dec 2018 15:51:22 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgVL_sxXSbjYTiGhxp6+9wLQ9ZmSN+0R5PCF6_a9pQgWw@mail.gmail.com>
 <20181203185954.GM31738@dhcp22.suse.cz> <CAHk-=wiNKLH2Pbnr9z2SvmDhf7XT==U6NPRkQNX13Sg-FRk0Yw@mail.gmail.com>
 <20181203201214.GB3540@redhat.com> <CAHk-=wg=6uxAJMbvGJC-5CSikC8OdqsjE1vw+DsCMj=2SNSnZg@mail.gmail.com>
 <CAHk-=whDg5+e2-eXYo-jwC1spt2r7JjLQSaLm4OyfGMQHLTrdw@mail.gmail.com>
 <64a4aec6-3275-a716-8345-f021f6186d9b@suse.cz> <20181204104558.GV23260@techsingularity.net>
 <20181205204034.GB11899@redhat.com> <CAHk-=whi8Ju-cTDL4cYtwuLA7BYgGJYyy6HVMoknZaLHnRc83g@mail.gmail.com>
 <20181205233632.GE11899@redhat.com>
In-Reply-To: <20181205233632.GE11899@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 5 Dec 2018 15:51:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wguXjkbK8BUU998s7HD7AXJgBkuc9JmuNxiN7uGQyfSfQ@mail.gmail.com>
Message-ID: <CAHk-=wguXjkbK8BUU998s7HD7AXJgBkuc9JmuNxiN7uGQyfSfQ@mail.gmail.com>
Subject: Re: [LKP] [mm] ac5b2c1891: vm-scalability.throughput -61.3% regression
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     mgorman@techsingularity.net, Vlastimil Babka <vbabka@suse.cz>,
        mhocko@kernel.org, ying.huang@intel.com, s.priebe@profihost.ag,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org,
        David Rientjes <rientjes@google.com>, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 3:36 PM Andrea Arcangeli <aarcange@redhat.com> wrote:
>
> Like said earlier still better to apply __GFP_COMPACT_ONLY or David's
> patch than to return to v4.18 though.

Ok, I've applied David's latest patch.

I'm not at all objecting to tweaking this further, I just didn't want
to have this regression stand.

           Linus
