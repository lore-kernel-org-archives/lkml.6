Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB911C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 22:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8129C20873
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 22:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="f4erISSE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8129C20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbeK1Jtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 04:49:52 -0500
Received: from mail-lj1-f182.google.com ([209.85.208.182]:34371 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbeK1Jtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 04:49:51 -0500
Received: by mail-lj1-f182.google.com with SMTP id u6-v6so21611049ljd.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 14:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aOvCWGaG+QwdWQnwx64Hl42p81ImXtRWxbsAGCUP7FE=;
        b=f4erISSE49NhPNad62QpCBMPcTkIfjMzxMyZf/uyV4h2Oqi5lRzqMS6ILpUZubXyx9
         UvimG4zUs2DYtbgTcsMrMhZhwkdW57EZAbV11MWEW5EhVQ01czGUk8FJNpKeb/rvP+uv
         PgoTK6TpO259UKlUE7ocAvBx3pvwzQdJkhB+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aOvCWGaG+QwdWQnwx64Hl42p81ImXtRWxbsAGCUP7FE=;
        b=MSF74YXGMU7i0K3Up6hdOzDg+Az4f6CJRnxK2XWB5aBnnvKEC7jcmUTQ4K5OCzENSJ
         MKzlcGVPOgXYbDd7K4xY/M99eoNv8TBXWxSLJ9JEIWvGYv76gs2b3vVgMnYIcfdBBhth
         JRsZsImfgSWf/E/J0xRxDYRSP/k1sib04jukF/URChfzxmPbWBlUUjosigIBWFYiqb0W
         mXwqJScMC5THh+CYyF+VvWR9FLTkhnzL8soGh0uNxJ+8xOrplvZsgp4+OqpHllWeHa8i
         PvgyzwSZ7Gw3szg0FYBB4Glw8Y41xcRMvuOUQxoiiCnYorDF1+dLvEo5KTmZhIC/uKKS
         m0NA==
X-Gm-Message-State: AA+aEWbv51XpYNz5C+ttNNUC/aOeQgrqCYlo93iD8TQnE9C+hPcwQpw/
        t2eVZjXzSBeZMQ66rkd9/y0G9r3+0uk=
X-Google-Smtp-Source: AFSGD/Vv1fwGMBL1shib4SQsUzQ3PCBYtsb/1yZUpz1dX1zhijcKgBDMDeTypjGN7WEm2pG+2DpmKQ==
X-Received: by 2002:a2e:9e95:: with SMTP id f21-v6mr21254273ljk.128.1543359023778;
        Tue, 27 Nov 2018 14:50:23 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id b17sm877341lfc.21.2018.11.27.14.50.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 14:50:22 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id c19-v6so21624464lja.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 14:50:22 -0800 (PST)
X-Received: by 2002:a2e:9819:: with SMTP id a25-v6mr23475934ljj.6.1543359021483;
 Tue, 27 Nov 2018 14:50:21 -0800 (PST)
MIME-Version: 1.0
References: <20181127062503.GH6163@shao2-debian> <CAHk-=wiq9eTzenOPh9srdB=Y8NcP6NJxh7o8Y5SfSjfqZ20-RA@mail.gmail.com>
 <20181127205737.GI16136@redhat.com>
In-Reply-To: <20181127205737.GI16136@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 27 Nov 2018 14:50:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiEUPBzAOPkH1aHypnxW6+vVtmCw_vsOPgNZtOvQnrG8w@mail.gmail.com>
Message-ID: <CAHk-=wiEUPBzAOPkH1aHypnxW6+vVtmCw_vsOPgNZtOvQnrG8w@mail.gmail.com>
Subject: Re: [LKP] [mm] ac5b2c1891: vm-scalability.throughput -61.3% regression
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     rong.a.chen@intel.com, Michal Hocko <mhocko@suse.com>,
        s.priebe@profihost.ag, alex.williamson@redhat.com,
        mgorman@techsingularity.net, zi.yan@cs.rutgers.edu,
        Vlastimil Babka <vbabka@suse.cz>, rientjes@google.com,
        kirill@shutemov.name, Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        lkp@01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 12:57 PM Andrea Arcangeli <aarcange@redhat.com> wrote:
>
> This difference can only happen with defrag=always, and that's not the
> current upstream default.

Ok, thanks. That makes it a bit less critical.

> That MADV_HUGEPAGE causes flights with NUMA balancing is not great
> indeed, qemu needs NUMA locality too, but then the badness caused by
> __GFP_THISNODE was a larger regression in the worst case for qemu.
[...]
> So the short term alternative again would be the alternate patch that
> does __GFP_THISNODE|GFP_ONLY_COMPACT appended below.

Sounds like we should probably do this. Particularly since Vlastimil
pointed out that we'd otherwise have issues with the back-port for 4.4
where that "defrag=always" was the default.

The patch doesn't look horrible, and it directly addresses this
particular issue.

Is there some reason we wouldn't want to do it?

               Linus
