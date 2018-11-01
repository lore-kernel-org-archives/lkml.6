Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F57EC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5081A20657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SiujZf+1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5081A20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbeKBILj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 04:11:39 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43684 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbeKBILj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 04:11:39 -0400
Received: by mail-lf1-f65.google.com with SMTP id u18so72490lff.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 16:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JK7AVYBL18PspaXDAhKnWR3redHMvvAm28q/cu6N5mc=;
        b=SiujZf+1Ptp1RlRhBVl7UAcrh0NLbUL1ELLokiHM0yUZsN3b3N0/XxSFG2OZwb2PiJ
         7echAW10emwhK9iqLm/DIT5PZDSjWKmLY+Ih/drLvPAqAAc7vFYYBKbEtAdsi8D2obCJ
         BscHl2AzSxkKaELdP2hKG0MEaGTw8irpx8hcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JK7AVYBL18PspaXDAhKnWR3redHMvvAm28q/cu6N5mc=;
        b=SS9nRmH0ArxrD660shhqt99EEs2zWMkTJEh039072SdhqpVJyJPgmMJO2KzIfElmPA
         a/lTVBLTpZTgGuBpQg3WpaHpziJwSsRTbso72sZTpuPWIrakwsyfReFaIFq6Ocu6AZ48
         cuk9ZBU7hl/aoX8C+DlVlZDFrIz9vIrmODKAoTKklh3+Z1CHviCYQdySLc/bD44kzoJv
         QIOqgnKgrNzh50W7PAlHwbILOjQ8LYUgIfCkBduREVD7mGClch2buCEsyLbkiA5TPCEa
         Isx7QsIWRaJcJ2JVfXKGuA7ndymNUUlMTeMMItgLDBbD+yV0qg2udu0EZB/+I3DZBi8B
         wS5Q==
X-Gm-Message-State: AGRZ1gJJKZZep4rSBS54OHt/W5wD5hU7Xp5SqPQahITGQkkdtj9Zd8Qm
        8ffDVmn/fmY/dYcAk5z+c0O18mmvOeU=
X-Google-Smtp-Source: AJdET5c/ke9jZ/Akmv4koVO5RRzW9UiMQgpyOa07MdPUi3X9pVD6htCM5j3ql0gfJMRFMe5w0E1hyg==
X-Received: by 2002:a19:48d0:: with SMTP id v199mr5657292lfa.104.1541113597119;
        Thu, 01 Nov 2018 16:06:37 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id x29-v6sm3523468ljb.69.2018.11.01.16.06.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 16:06:36 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id u6-v6so134215ljd.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 16:06:36 -0700 (PDT)
X-Received: by 2002:a2e:2416:: with SMTP id k22-v6mr217382ljk.80.1541113595783;
 Thu, 01 Nov 2018 16:06:35 -0700 (PDT)
MIME-Version: 1.0
References: <20181101171938-mutt-send-email-mst@kernel.org> <CAGXu5jJ0HgV2qN=wohEgro6ixqXHOHBTsvS5a9Dcpz8gxVo3bA@mail.gmail.com>
In-Reply-To: <CAGXu5jJ0HgV2qN=wohEgro6ixqXHOHBTsvS5a9Dcpz8gxVo3bA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 1 Nov 2018 16:06:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wicvws38JqzVF6oNEZ0jGzP6RecR6yAGtyzX3AkoJ321g@mail.gmail.com>
Message-ID: <CAHk-=wicvws38JqzVF6oNEZ0jGzP6RecR6yAGtyzX3AkoJ321g@mail.gmail.com>
Subject: Re: [PULL] vhost: cleanups and fixes
To:     Kees Cook <keescook@chromium.org>
Cc:     mst@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
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

On Thu, Nov 1, 2018 at 4:00 PM Kees Cook <keescook@chromium.org> wrote:
>
> +       memset(&rsp, 0, sizeof(rsp));
> +       rsp.response = VIRTIO_SCSI_S_FUNCTION_REJECTED;
> +       resp = vq->iov[out].iov_base;
> +       ret = __copy_to_user(resp, &rsp, sizeof(rsp));
>
> Is it actually safe to trust that iov_base has passed an earlier
> access_ok() check here? Why not just use copy_to_user() instead?

Good point.

We really should have removed those double-underscore things ages ago.

Also, apart from the address, what about the size? Wouldn't it be
better to use copy_to_iter() rather than implement it badly by hand?

               Linus
