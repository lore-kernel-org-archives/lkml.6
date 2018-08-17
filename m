Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB495C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 22:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F579218F9
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 22:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FmZyzup1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F579218F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbeHRB2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 21:28:23 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:44105 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbeHRB2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 21:28:23 -0400
Received: by mail-yw1-f66.google.com with SMTP id l9-v6so4919692ywc.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 15:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Dvvu7vM6+o7lDZ5Qtwu4fua/KLlx9gRIYgPpT3R8G3U=;
        b=FmZyzup1JUp4TDNQtenQ76Lb30L41N8iKbB3YVdOWq6YDm4iNkRFQXy140S0BPsOqW
         cJMgiZx9llQ7JlBm84/ApY/lcucmC1ebRTNpMm7ISjeYm+i8BknKR6k5KNUQRec3uqUj
         TU2T8WUHmT2/MZKG56JiO9tqAdu1lKdPQ8PSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Dvvu7vM6+o7lDZ5Qtwu4fua/KLlx9gRIYgPpT3R8G3U=;
        b=foFikM9mVT4eXc9b0u7eeVw0e1kIOUaIau6K7utxK/e03TiuqlFRd27sq60pcQgbG0
         9gBP1MS6J6bgg1ELI8BXqa8NEskdQBqKiJHN8FgoFbPuxaKiI4BCL31gmpmHKLBvS9/v
         6Qq6az3m/Dfn1uRXi3KciF03Ag82lPvtUBNC5yt0OCqLPtGQbStt+cQwLa7mYA7LkdQq
         zG69PNFhW/5fBqvaL/N9gkUGrvlQcRuCRm9l8VhT8jCN8/5ib6vNuyBg84LsRO8J0BOQ
         LjVNbj/9Vj/ubeiQfttfxzhXVrQBMteJUeb0OrxvLejR4fT/1fOcUDg7gqMNt/gtbw7w
         VJMw==
X-Gm-Message-State: AOUpUlFAiWC7a1WIluv/PAWNraO5PILQytQwXVL46Dx7jF2rzGvDUjql
        OrkkOEFlCfgFwk/MXPZ6xhELN8STPsU=
X-Google-Smtp-Source: AA+uWPw9tjdI/qNuPq5yMNfJQtukrbUpZojrcnDeT3CUSkM84aQF2RBLbm59zD+fCUS8QiA/Qw+JwA==
X-Received: by 2002:a81:5fd7:: with SMTP id t206-v6mr19335234ywb.278.1534544593106;
        Fri, 17 Aug 2018 15:23:13 -0700 (PDT)
Received: from mail-yb0-f175.google.com (mail-yb0-f175.google.com. [209.85.213.175])
        by smtp.gmail.com with ESMTPSA id e134-v6sm3129714ywa.59.2018.08.17.15.23.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 15:23:11 -0700 (PDT)
Received: by mail-yb0-f175.google.com with SMTP id c1-v6so864688ybq.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 15:23:10 -0700 (PDT)
X-Received: by 2002:a25:7797:: with SMTP id s145-v6mr2905037ybc.137.1534544590300;
 Fri, 17 Aug 2018 15:23:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:aa31:0:0:0:0:0 with HTTP; Fri, 17 Aug 2018 15:23:09
 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.999.1808162319420.3196@trent.utfs.org>
References: <20180803200551.GA47157@beast> <alpine.DEB.2.21.999.1808162319420.3196@trent.utfs.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 17 Aug 2018 15:23:09 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+_qOcnJjwXX9mop++Bs7HCA7QMXCs5VXofewZ7XOwddw@mail.gmail.com>
Message-ID: <CAGXu5j+_qOcnJjwXX9mop++Bs7HCA7QMXCs5VXofewZ7XOwddw@mail.gmail.com>
Subject: Re: [Jfs-discussion] [PATCH] jfs: Expand usercopy whitelist for
 inline inode data
To:     Christian Kujau <lists@nerdbynature.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bart Massey <bart.massey@gmail.com>,
        jfs-discussion@lists.sourceforge.net,
        David Windsor <dave@nullcore.net>,
        Dave Kleikamp <shaggy@kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 11:56 PM, Christian Kujau <lists@nerdbynature.de> wrote:
> On Fri, 3 Aug 2018, Kees Cook via Jfs-discussion wrote:
>> Bart Massey reported what turned out to be a usercopy whitelist false
>> positive in JFS when symlink contents exceeded 128 bytes. The inline
>> inode data (i_inline) is actually designed to overflow into the "extended
>
> So, this may be a stupid question, but: is there a way to disable this
> hardened usercopy thing with a boot option maybe?
>
> Apparently, CONFIG_HARDENED_USERCOPY_FALLBACK was disabled in Debian's
> 4.16.0-0.bpo.2-amd64 (4.16.16) kernels[0] and I have a VMware guest here
> that prints a BUG message (below) whenever a certain directory is being
> accesses. ls(1) is fine, but "ls -l" (i.e. with stat()) produces the splat
> below. And indeed, the target of one of the symlinks inside is 129
> characters long, and every attempt to stat it prints the splat below.
>
> Going back to 4.16.0-0.bpo.1-amd64 (4.16.5) helps, but I was wondering if
> there was a magic boot option to disable it while I wait for 4.18 to land
> in Debian? I booted with hardened_usercopy=off, but it doesn't seem to
> have an effect and the directory is still inaccessible.

Precisely this was just added upstream[1] for 4.19 but isn't available
in 4.16. It should be trivial to backport it, though, if Ben wants to
do that? (The JFS fix is in the 4.17 and 4.18 -stable trees now, too,
BTW.)

-Kees

[1] https://git.kernel.org/linus/b5cb15d9372a

-- 
Kees Cook
Pixel Security
