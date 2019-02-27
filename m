Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921E2C10F01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61241213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="His8f3pj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730290AbfB0UMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 15:12:23 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43235 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729825AbfB0UMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 15:12:22 -0500
Received: by mail-qk1-f195.google.com with SMTP id f196so10658839qke.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 12:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZTxkyP7MX2AvS9u1TFjA+FXPrStBYSRU8F/HnJNz8r8=;
        b=His8f3pjjg9z3yTcOTRS1nqVxgQzrIguuuVsWBVL9CXK3UYQ+fzUxfi/AfrtujyIs6
         uzXXVHJdJPn3mnbJ2HTUxZZaDtfY/i/2e1DUzDvgz4A26v0JWTRC7QngEnIFoCDg0CKC
         tduYVbavNEPNgMwlpMB/wuI1isdNpLgtzAUF3Yzd/LwxWdCRcgnFLk5h4aC89WKG4Cz9
         YH2n1geJfgZZBMTri2o73/gMeF9Ydbwj5hBGCn0zV23fYaSNcK6K4fNzUUzINaovRQ6s
         5hpgG5OUaRWMGzv4XMpOcigjpgRZc5Eyvlj1gJctIOjxzl7+rRlAv01/nM3jr+57V8c8
         CqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZTxkyP7MX2AvS9u1TFjA+FXPrStBYSRU8F/HnJNz8r8=;
        b=tqf2FFv3zVgiV0M0NVEAtptqNCrOASbNBuZNUwg8r9gG9amzlu6hQNqBI7W4U0zK+Z
         9JU55bYHAPsc/anaa+umSsLiwj1rY0uZn/4VSZXNrgKzSlc4BVNoHiP4PQPkVNX7Vn4a
         iXFzDzEHDGcq0MXDpIxlf27tZGv22OxOf8e4OkpQuBjEcdNHKN+vvizqnemH2JS9BNio
         JWxxCZDSZEotPZZcjkYUpAWGylDmnDszpk6aNIt/sZcEizRZ536fIGd5qPCtPDVtuBxe
         nkt5Lpa2fq55koQB5PJGQVnVuDUsOg5zqb7XkIh2w/r33YZLpYlmqLVh/atfQ+NJzJDN
         pV0Q==
X-Gm-Message-State: APjAAAWtx3XpH/X5+TVG6s6CUjVozlK9jwVJyFBZM5aJ80XP+/A7eEiE
        3vTklnkobhwaGhxCOh762S14PQ==
X-Google-Smtp-Source: AHgI3IZpEx4+Dk35xm0gudLF7+nvka/QYL7y/lhNAmqZvg4YCx2SGwWvIS0FRcp9tH1jhVAiK0vMBg==
X-Received: by 2002:a37:4f45:: with SMTP id d66mr3695557qkb.81.1551298341321;
        Wed, 27 Feb 2019 12:12:21 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id o51sm7294040qta.24.2019.02.27.12.12.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 12:12:20 -0800 (PST)
Message-ID: <1551298338.7087.5.camel@lca.pw>
Subject: Re: [PATCH] tmpfs: fix uninitialized return value in shmem_link
From:   Qian Cai <cai@lca.pw>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matej Kupljen <matej.kupljen@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Date:   Wed, 27 Feb 2019 15:12:18 -0500
In-Reply-To: <1551276580.7087.1.camel@lca.pw>
References: <20190221222123.GC6474@magnolia>
         <alpine.LSU.2.11.1902222222570.1594@eggly.anvils>
         <CAHk-=wgO3MPjPpf_ARyW6zpwwPZtxXYQgMLbmj2bnbOLnR+6Cg@mail.gmail.com>
         <alpine.LSU.2.11.1902251214220.8973@eggly.anvils>
         <CAHk-=whP-9yPAWuJDwA6+rQ-9owuYZgmrMA9AqO3EGJVefe8vg@mail.gmail.com>
         <CAHk-=wiwAXaRXjHxasNMy5DHEMiui5XBTL3aO1i6Ja04qhY4gA@mail.gmail.com>
         <86649ee4-9794-77a3-502c-f4cd10019c36@lca.pw>
         <CAHk-=wggjLsi-1BmDHqWAJPzBvTD_-MQNo5qQ9WCuncnyWPROg@mail.gmail.com>
         <1551276580.7087.1.camel@lca.pw>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-02-27 at 09:09 -0500, Qian Cai wrote:
> On Mon, 2019-02-25 at 16:07 -0800, Linus Torvalds wrote:
> > On Mon, Feb 25, 2019 at 4:03 PM Qian Cai <cai@lca.pw> wrote:
> > > > 
> > > > Of course, that's just gcc. I have no idea what llvm ends up doing.
> > > 
> > > Clang 7.0:
> > > 
> > > # clang  -O2 -S -Wall /tmp/test.c
> > > /tmp/test.c:46:6: warning: variable 'ret' is used uninitialized whenever
> > > 'if'
> > > condition is false [-Wsometimes-uninitialized]
> > 
> > Ok, good.
> > 
> > Do we have any clang builds in any of the zero-day robot
> > infrastructure or something? Should we?
> > 
> > And maybe this was how Dan noticed the problem in the first place? Or
> > is it just because of his eagle-eyes?
> > 
> 
> BTW, even clang is able to generate warnings in your sample code, it does not
> generate any warnings when compiling the buggy shmem.o via "make CC=clang".
> Here is the objdump for arm64 (with KASAN_SW_TAGS inline).
> 

Ah, thanks to the commit 6e8d666e9253 ("Disable "maybe-uninitialized" warning
globally"), it will no longer generate this type of warnings until using "make
W=1" due to the commit a76bcf557ef4 ("Kbuild: enable -Wmaybe-uninitialized
warning for 'make W=1'"). Anyway, the generated code is the same using clang
with and without this patch.

    d_instantiate(dentry, inode);
4eec:       94000000        bl      0 <d_instantiate>
            ret = shmem_reserve_inode(inode->i_sb);
4ef0:       2a1f03e0        mov     w0, wzr             <---- ret = 0
    return ret;


