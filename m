Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01A7C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 16:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68F7E2081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 16:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RqKqgkFr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68F7E2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbeKCBWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 21:22:49 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42021 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbeKCBWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 21:22:49 -0400
Received: by mail-lf1-f65.google.com with SMTP id q6-v6so1698259lfh.9
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 09:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T1ZLS/k8UCAenrnOpeIYJTMeU7f68faZYEvIFC7BSwo=;
        b=RqKqgkFrR/SMxTNgjp+V8lFISbp1vMagYZELURKydXYnkMFjr8gBNJ+J710DMCYIpV
         qTYFPTYrO04WFZJf7tfx7gy7P2xxp6aVqQw2zqC5R/2tOF0RmUu5QO1AjfeCJIWAArbm
         BUkhkJq4RwhODpybfQm6oC81+QN798t/HOdI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T1ZLS/k8UCAenrnOpeIYJTMeU7f68faZYEvIFC7BSwo=;
        b=cmF4fmjnGhtwvf6uocxYMuTolSbt2vut/HgGcTeNJfzHFwaVT6Ccu6oeJtJLfk801a
         EiIOnWbPkpHs6niWy1aEk2cm86+df9wngOCfoCr72FL6MLEw/1ptg5VJtvEvaIDjR03Z
         9AgT9N7fZD5Bl/JAPC8834OOvIAixN7UA48BabVICGIbepaw6+E8hpT+E95ifDUC5a6+
         1eSVB/BO2wFwevhkMO9/xnbs0VWBf+QrH2t0uJrIXNZt7XAH75cUmovj3eccmsJapbNE
         IlIe29TR9BbghBu8/Td+SXY0Vz9jK41TpJLhp3npG2vsGcfDhwzD5TGgsHDi8vhthQ1Q
         wgRQ==
X-Gm-Message-State: AGRZ1gI/ebqWfsrxCMykcW5us3z4Pg2QmSIskKlNi7QYM5n+F5XMcEJm
        A8+1aYhjYD7rLU8yk9ev+tn7lPnBKEGVZw==
X-Google-Smtp-Source: AJdET5dVdEKjvI15YeTt3b/F1om8bJIzFRPbTakzC32PionN12OFW+/K4VRq78amqrNHz6E4pw60Ww==
X-Received: by 2002:a19:2a4b:: with SMTP id f72mr6798663lfl.139.1541175309350;
        Fri, 02 Nov 2018 09:15:09 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id c5-v6sm2048439lja.62.2018.11.02.09.15.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 09:15:08 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id c16so1694733lfj.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 09:15:08 -0700 (PDT)
X-Received: by 2002:a19:982:: with SMTP id 124mr1660875lfj.138.1541175307489;
 Fri, 02 Nov 2018 09:15:07 -0700 (PDT)
MIME-Version: 1.0
References: <20181101171938-mutt-send-email-mst@kernel.org>
 <CAGXu5jJ0HgV2qN=wohEgro6ixqXHOHBTsvS5a9Dcpz8gxVo3bA@mail.gmail.com>
 <CAHk-=wicvws38JqzVF6oNEZ0jGzP6RecR6yAGtyzX3AkoJ321g@mail.gmail.com>
 <20181102114635.hi3q53kzmz4qljsf@lakrids.cambridge.arm.com> <20181102083018-mutt-send-email-mst@kernel.org>
In-Reply-To: <20181102083018-mutt-send-email-mst@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 2 Nov 2018 09:14:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh_bQK5zs+CwQ5eyodq4sQT0eOPp60qzvVL2_EtgETP-g@mail.gmail.com>
Message-ID: <CAHk-=wh_bQK5zs+CwQ5eyodq4sQT0eOPp60qzvVL2_EtgETP-g@mail.gmail.com>
Subject: Re: [PULL] vhost: cleanups and fixes
To:     mst@redhat.com
Cc:     mark.rutland@arm.com, Kees Cook <keescook@chromium.org>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        bijan.mottahedeh@oracle.com, gedwards@ddn.com, joe@perches.com,
        lenaic@lhuard.fr, liang.z.li@intel.com, mhocko@kernel.org,
        mhocko@suse.com, stefanha@redhat.com, wei.w.wang@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 6:04 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> I've tried making access_ok mask the parameter it gets.

PLEASE don't do this.

Just use "copy_to/from_user()".

We have had lots of bugs because code bitrots.

And no, the access_ok() checks aren't expensive, not even in a loop.
They *used* to be somewhat expensive compared to the access, but that
simply isn't true any more. The real expense in copy_to_user and
friends are in the user access bit setting (STAC and CLAC on x86),
which easily an order of magnitude more expensive than access_ok().

So just get rid of the double-underscore version. It's basically
always a mis-optimization due to entirely historical reasons. I can
pretty much guarantee that it's not visible in profiles.

                  Linus
