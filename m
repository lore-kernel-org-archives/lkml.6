Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14377C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 13:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D36972075A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 13:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kinvolk.io header.i=@kinvolk.io header.b="O8MC509q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfBVNPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 08:15:08 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42504 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbfBVNPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 08:15:07 -0500
Received: by mail-oi1-f194.google.com with SMTP id s16so1641257oih.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 05:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fRfkbToKv+b7yDFcB+4r6684B7I+gtcuiYdWKbyseiM=;
        b=O8MC509qWJMK4qfCKuMSO9wyIuCSCnJSwt3nmg7XZOhNrHFPPmwUkSagEUx19tP5i6
         hUoh6MRJv9MJ3dfCEMa/p9HjuDXSMx/tAzW1+NF1Yfezcu7itnx72iEjNnwGU78wT2OY
         AGK1ZsHRQPA/jNb/bypt7G+EVBuCQDeNuJz7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fRfkbToKv+b7yDFcB+4r6684B7I+gtcuiYdWKbyseiM=;
        b=kX4YIlbm2QvLFu+NxlvB93zAgDpjSrLteAQEZGtloMzs2XLIPIub8sT1sxy0OTBbNK
         IMYqyptf4FF2BgZmDkalQsvu0VhRa+hVDliok9DKQ7cfl7+3KPLrb0Cld00p9Cvh5zVN
         rBHyiES+SVSLhTPrloPIfdCaJK37eh27g5jC6uUz5ZCYSdAWkfLmOzv9w1euG5QXJyGe
         ibjFHeXb+WjkUpnovS+7SWgO9HHiQcqE5/tKjpMdtqp9/huKo7AN3LidieMy3hwje7q8
         rrbCna2waorcb2R2dvB7nF9QUmUv4Hq0v65GXaPWHRhDAUzKy7Dsev+vwUq88jGTtYq6
         Xu5A==
X-Gm-Message-State: AHQUAuZzGmhx/jz+Z2jP3uGfIBpomJJm+KP9xJqcc8qq74nOVZiGjAVy
        D9aOtOWugVrSbJhXbjxAD2nPEU6KqbbXqmS61mnnqA==
X-Google-Smtp-Source: AHgI3IZTjj/UN9TEx0z4VAKqoxnFKtGHzjAvkr68r8i2+mNoWZeBEEnA4CJmQm9Hj4q9C/lx4N7Wy+gtXwBYlrmLzzM=
X-Received: by 2002:aca:4c58:: with SMTP id z85mr2403275oia.140.1550841306522;
 Fri, 22 Feb 2019 05:15:06 -0800 (PST)
MIME-Version: 1.0
References: <20190221163926.15221-1-alban@kinvolk.io> <20190221222350.6u2jbtias2c3mgyy@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20190221222350.6u2jbtias2c3mgyy@kafai-mbp.dhcp.thefacebook.com>
From:   Alban Crequy <alban@kinvolk.io>
Date:   Fri, 22 Feb 2019 14:14:55 +0100
Message-ID: <CADZs7q6J-uQCJt77txyHNUR9_7F75-x26fx=A5gyYB4KO+i8Nw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] bpf, lpm: fix lookup bug in map_delete_elem
To:     Martin Lau <kafai@fb.com>
Cc:     Alban Crequy <alban.crequy@gmail.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iago@kinvolk.io" <iago@kinvolk.io>,
        Craig Gallek <kraig@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 11:24 PM Martin Lau <kafai@fb.com> wrote:
>
> On Thu, Feb 21, 2019 at 05:39:26PM +0100, Alban Crequy wrote:
> > From: Alban Crequy <alban@kinvolk.io>
> >
> > trie_delete_elem() was deleting an entry even though it was not matching
> > if the prefixlen was correct. This patch adds a check on matchlen.
> >
> > Reproducer:
> >
> > $ sudo bpftool map create /sys/fs/bpf/mylpm type lpm_trie key 8 value 1 entries 128 name mylpm flags 1
> > $ sudo bpftool map update pinned /sys/fs/bpf/mylpm key hex 10 00 00 00 aa bb cc dd value hex 01
> > $ sudo bpftool map dump pinned /sys/fs/bpf/mylpm
> > key: 10 00 00 00 aa bb cc dd  value: 01
> > Found 1 element
> > $ sudo bpftool map delete pinned /sys/fs/bpf/mylpm key hex 10 00 00 00 ff ff ff ff
> > $ echo $?
> > 0
> > $ sudo bpftool map dump pinned /sys/fs/bpf/mylpm
> > Found 0 elements
> The change makes sense to me.  Can you add this reproducer to
> tools/testing/selftests/bpf/test_lpm_map.c?
>
> Bug fix should be for the "bpf" tree instead of "bpf-next"
> Fixes tag is also required, like
>
> Fixes: e454cf595853 ("bpf: Implement map_delete_elem for BPF_MAP_TYPE_LPM_TRIE")
> Cc: Craig Gallek <kraig@google.com>

Thanks! I'll send a v2 shortly with the selftest and the tags, based
on "bpf" tree.

Cheers,
Alban

> > Signed-off-by: Alban Crequy <alban@kinvolk.io>
> > ---
> >  kernel/bpf/lpm_trie.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
> > index abf1002080df..93a5cbbde421 100644
> > --- a/kernel/bpf/lpm_trie.c
> > +++ b/kernel/bpf/lpm_trie.c
> > @@ -471,6 +471,7 @@ static int trie_delete_elem(struct bpf_map *map, void *_key)
> >       }
> >
> >       if (!node || node->prefixlen != key->prefixlen ||
> > +         node->prefixlen != matchlen ||
> >           (node->flags & LPM_TREE_NODE_FLAG_IM)) {
> >               ret = -ENOENT;
> >               goto out;
> > --
> > 2.20.1
> >
