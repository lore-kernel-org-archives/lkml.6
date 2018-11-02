Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3F8C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4053A2081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TpD+ryRd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4053A2081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbeKCDSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:18:40 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:38535 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbeKCDSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:18:39 -0400
Received: by mail-lj1-f179.google.com with SMTP id q186-v6so2528887ljb.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 11:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Oh1wOgeMYWgTHa2RtNlimqURKrkG1ArVIwrVHUhsXD8=;
        b=TpD+ryRdzSkTfle94HFYAKpt/Uqn8dy8aJCKdDhn0KvTFS/DqiUTk2jggJWGBTlVPY
         e9J+rFmnpfGw99cKt8Y+tbtwKFVXJhcvh3bB187w0rEmyrdcKcvI4+6sRQS0k7fdijRV
         N14Alnik3l77TDvZjm8P58Rb8StmW142WSQaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oh1wOgeMYWgTHa2RtNlimqURKrkG1ArVIwrVHUhsXD8=;
        b=dxsSasfTT5WFaoT48ReG/vclupUaOLVRKSS8nEe9tAcJT1CMxrdkc6iwjojr+5tB/A
         2Nu/5Ub+UfB00gZvBaaIVfycBnrgSAWcfosdUWwqQ267n96jQitslQeBifQG5NSHKyD7
         gFFKmCWqVJCo1NR0z6+764P/vBPX0tfBoxvZ0qk1hTDQekKPO94g35Zl+3Nhd9qTaGjz
         +UYQOZCnVcJ6x0F8xYnhWbvynV6rdZOWjTy4q+6ONarCxtkAGGWb2oM+9EE5DnQX/aqG
         buHmvTopDcMfKb7P8jnnA7WpBOYY4rAk3DRzFTeRyNiPZ7PfyBbKpwgmFUSXx4RT/St9
         6QjQ==
X-Gm-Message-State: AGRZ1gLYuJDgZvojWDgrGHZ0N1GQiuW7zcJfswZyTn7PAGCXNvNImXKq
        MkF54Z/nPjvpZT/lGM8cUMbTVTxMvSTD7A==
X-Google-Smtp-Source: AJdET5cs7hdwd3u1n90FlWutMhTIdQ8BW4l0GfEMumYOK8dImpxDEji6anftAV+PojC+TIVBh6KLCA==
X-Received: by 2002:a2e:719:: with SMTP id 25-v6mr8370082ljh.128.1541182234002;
        Fri, 02 Nov 2018 11:10:34 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id v19-v6sm5455013lji.10.2018.11.02.11.10.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 11:10:33 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id z80-v6so2515285ljb.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 11:10:33 -0700 (PDT)
X-Received: by 2002:a2e:2416:: with SMTP id k22-v6mr2595398ljk.80.1541181771232;
 Fri, 02 Nov 2018 11:02:51 -0700 (PDT)
MIME-Version: 1.0
References: <20181101171938-mutt-send-email-mst@kernel.org>
 <CAGXu5jJ0HgV2qN=wohEgro6ixqXHOHBTsvS5a9Dcpz8gxVo3bA@mail.gmail.com>
 <CAHk-=wicvws38JqzVF6oNEZ0jGzP6RecR6yAGtyzX3AkoJ321g@mail.gmail.com>
 <20181102114635.hi3q53kzmz4qljsf@lakrids.cambridge.arm.com>
 <20181102083018-mutt-send-email-mst@kernel.org> <CAHk-=wh_bQK5zs+CwQ5eyodq4sQT0eOPp60qzvVL2_EtgETP-g@mail.gmail.com>
 <20181102122937-mutt-send-email-mst@kernel.org> <CAHk-=wibzqo7C+mS+BgZxRbgdWe2w5F39EhuFUhZUxvotoGLuA@mail.gmail.com>
 <20181102131334-mutt-send-email-mst@kernel.org>
In-Reply-To: <20181102131334-mutt-send-email-mst@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 2 Nov 2018 11:02:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjAvx_rWKct5RtqRrVEgNxrFF=1qQwkz+AegDvd4yXW=g@mail.gmail.com>
Message-ID: <CAHk-=wjAvx_rWKct5RtqRrVEgNxrFF=1qQwkz+AegDvd4yXW=g@mail.gmail.com>
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

On Fri, Nov 2, 2018 at 10:21 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> it seems that it depends on current not on the active mm.

Yes, see my other suggestion to just fix "use_mm()" to update the address range.

Would you mind testing that?

Because that would seem to be the *much* less error-prone model..

           Linus
