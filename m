Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F59ECDE44
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 00:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AA4020843
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 00:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="L37u7iLm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AA4020843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbeJ0I5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 04:57:02 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:40987 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbeJ0I5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 04:57:02 -0400
Received: by mail-lj1-f173.google.com with SMTP id u21-v6so2687714lja.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 17:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RHcEH5QbyoUZmcGK6Zk6eInH5mk5LjPB4FqG/4ve2gU=;
        b=L37u7iLmsVhOeu0eTGtBzZZ64MNMM56adyfer6hBcS10jOedxCLDjSP4GgH/C53wWx
         RlJiZOSMc0C0e0hTmlJE8RVMKvLoK9kULo/mf53YzvTKLeNNkX866DiXI+v1wNGMbZTZ
         aT38uEyzK0jsZuwC3JBF67GNlhPH+TzCjPygk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RHcEH5QbyoUZmcGK6Zk6eInH5mk5LjPB4FqG/4ve2gU=;
        b=NV0FsPCdSvkdnU+M+FfhhdMWtLYwobey7/Ikmx9B4/BoNX0C3lcHMimWC/xvEdJx8Q
         mULmRScSQIhnkAu4iQ1TDZpAOYkZYrC6JIsWQdxgyEfvcldS/hDfLej0/uPHjQxAsP9l
         5tYDq0JRnwfH8o8QC4IyWblv3XFiyEPIIIL0eLZQluwZxaGyDlY2lw7/jkN13338WSeU
         4TiQcyBgNLE1Ki6P6bg/MO9YpuOsqscWugkL7LUMtsZXrgfiQd63EO+DhgPT7XeRp3DZ
         D5MjNmcP3C8Jy/sd75BPIy7ZNCpJAGWfLM+79nyN16mufZBs667AyjYOQa1lSOshiKLg
         /s6Q==
X-Gm-Message-State: AGRZ1gLmUM1OgST3u7f83OwIIs0fsGq6NPqIn5UNm7ic5newpKqOxaoj
        zgurYzuYlMJMSjLr6Xdsyq/MJUWOpv+/mg==
X-Google-Smtp-Source: AJdET5deW+KiMUoaFgSSfBZwbY/nam2wNLzzN+GtMNoPVpl1MHQu9OcZz9flidVtLv0IZOzfY+pGSg==
X-Received: by 2002:a2e:d11:: with SMTP id 17-v6mr4059147ljn.18.1540599473062;
        Fri, 26 Oct 2018 17:17:53 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id f14-v6sm1992292lff.84.2018.10.26.17.17.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 17:17:52 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id h192so2180757lfg.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 17:17:51 -0700 (PDT)
X-Received: by 2002:a19:4287:: with SMTP id p129mr2427685lfa.135.1540599471252;
 Fri, 26 Oct 2018 17:17:51 -0700 (PDT)
MIME-Version: 1.0
References: <20181026.160828.636318063368651002.davem@davemloft.net>
In-Reply-To: <20181026.160828.636318063368651002.davem@davemloft.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 26 Oct 2018 17:17:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=whjWf3YqOOdb8a5C7C9rs+-rKppDZWJKfOm6V5qZiuujA@mail.gmail.com>
Message-ID: <CAHk-=whjWf3YqOOdb8a5C7C9rs+-rKppDZWJKfOm6V5qZiuujA@mail.gmail.com>
Subject: Re: [GIT] Sparc
To:     David Miller <davem@davemloft.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        sparclinux@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 4:08 PM David Miller <davem@davemloft.net> wrote:
>
> Some more sparc fixups, mostly aimed at getting the allmodconfig build
> up and clean again.

Pulled,

                  Linus
