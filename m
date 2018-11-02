Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978B6C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 17:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EC9F2081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 17:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fh/2QPYV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EC9F2081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbeKCC0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 22:26:55 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39355 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbeKCC0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 22:26:55 -0400
Received: by mail-lf1-f68.google.com with SMTP id n18so1829186lfh.6
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 10:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7mzEsLKarnAPlT52QMIUPR4InFc78QhESCHV+bCouTg=;
        b=fh/2QPYVJXnUZqhNPSC3Py8rsv4byEbk/Jt70tUhf7aHeKl/7Hwfbz91wJGOE/Hma4
         SYat+RgNMeD0n/eiNpOGDirTDqUb1gLfVVIcpeRPKhnbsVpnTlhl1x0MxGmWkeKvUzKS
         EnCYAJO5jBeG+MKFzp9ANvl8WKktMbEFphRew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7mzEsLKarnAPlT52QMIUPR4InFc78QhESCHV+bCouTg=;
        b=U4rVIpeRT9HeAenXbwVrtOIrxlhxhsyPPV0CGWxbSoCFPh3z2Qc5F4bpq+lPNg59mw
         Ms06BSs4ObucRfwdqzSLg+4jfGRzg0VJssBR4d24516v1/S0HGiDlmmrpn6ngMIEDQFM
         +Fvu94bKBPUVp/G2sJHKDVGyukPxvAV09MX4kvWZf22hnM+9Ir8DPMXrvO1L/gQm8rKd
         3gc+A3adc1DiC4CjGBAacvbJ6EmpmHiSNOaRTdb5f3NtnLzA4Br5I9qpvmL5BoSm/kY+
         dyv+Sx2uCUSzCrZmFyNxcDAgiWo9JJbuA7yeiNiBEvly/GIPb6MA2TyQ0N44B2O/CCOI
         s8hg==
X-Gm-Message-State: AGRZ1gLM4hjQa7sDpQBxFL/eG+muFBE/k7pjhQeHQ7ewpnyO82DmGnYC
        EipqFSxFxHUfUDyeyRHNNiN6q7BY1QMfMQ==
X-Google-Smtp-Source: AJdET5f93zkdzUblkv2QbzxrBI/y4efjB2PDWi/8bbsVhZ8+ynf391QS5UlGqYSrJYUvqZwU9vzJDg==
X-Received: by 2002:a19:ee08:: with SMTP id g8mr7269001lfb.72.1541179140996;
        Fri, 02 Nov 2018 10:19:00 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id g72-v6sm5331986lfl.21.2018.11.02.10.19.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 10:19:00 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id n18so1829138lfh.6
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 10:19:00 -0700 (PDT)
X-Received: by 2002:a19:3fcf:: with SMTP id m198mr7130991lfa.106.1541178661753;
 Fri, 02 Nov 2018 10:11:01 -0700 (PDT)
MIME-Version: 1.0
References: <20181101171938-mutt-send-email-mst@kernel.org>
 <CAGXu5jJ0HgV2qN=wohEgro6ixqXHOHBTsvS5a9Dcpz8gxVo3bA@mail.gmail.com>
 <CAHk-=wicvws38JqzVF6oNEZ0jGzP6RecR6yAGtyzX3AkoJ321g@mail.gmail.com>
 <20181102114635.hi3q53kzmz4qljsf@lakrids.cambridge.arm.com>
 <20181102083018-mutt-send-email-mst@kernel.org> <CAHk-=wh_bQK5zs+CwQ5eyodq4sQT0eOPp60qzvVL2_EtgETP-g@mail.gmail.com>
 <20181102122937-mutt-send-email-mst@kernel.org>
In-Reply-To: <20181102122937-mutt-send-email-mst@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 2 Nov 2018 10:10:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wibzqo7C+mS+BgZxRbgdWe2w5F39EhuFUhZUxvotoGLuA@mail.gmail.com>
Message-ID: <CAHk-=wibzqo7C+mS+BgZxRbgdWe2w5F39EhuFUhZUxvotoGLuA@mail.gmail.com>
Subject: Re: [PULL] vhost: cleanups and fixes
To:     mst@redhat.com
Cc:     mark.rutland@arm.com, Kees Cook <keescook@chromium.org>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        bijan.mottahedeh@oracle.com, gedwards@ddn.com, joe@perches.com,
        lenaic@lhuard.fr, liang.z.li@intel.com, mhocko@kernel.org,
        mhocko@suse.com, stefanha@redhat.com, wei.w.wang@intel.com,
        jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 9:59 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> Just for completeness I'd like to point out for vhost the copies are
> done from the kernel thread.  So yes we can switch to copy_to/from_user
> but for e.g. 32-bit userspace running on top of a 64 bit kernel it is
> IIUC not sufficient - we must *also* do access_ok checks on control path
> when addresses are passed to the kernel and when current points to the
> correct task struct.

Don't you take over the VM with "use_mm()" when you do the copies? So
yes, it's a kernel thread, but it has a user VM, and though that
should have the user limits.

No?

          Linus
