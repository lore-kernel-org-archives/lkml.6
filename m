Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D39BC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 20:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD812082D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 20:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QjBcxRsq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DD812082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbeKCFss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 01:48:48 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:43009 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbeKCFss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 01:48:48 -0400
Received: by mail-yw1-f65.google.com with SMTP id j75-v6so1270748ywj.10
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 13:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+Jgq1QIk/eMF0hEP86NUtXenU1DTPf58qugXA8kezIo=;
        b=QjBcxRsqRl4vNLorboGZWnzBSjNVD8E3oQZy06bV1/EMxDOQYSzOJwoKqSrjYcqA7P
         XdQL40MvTQCVQ7CwJGPAyx26sdH8OS7+Z2lAp/cVV4aG3kC/bGqg2mtnyHakc3BLKM9l
         YS8OJf1X2Y+/a+oL6pOt8QbIfqYmkjajYxSpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+Jgq1QIk/eMF0hEP86NUtXenU1DTPf58qugXA8kezIo=;
        b=ix4BUVNXVIcD6BmDWVNXbif2BtgIJZXOxOqev3QnX6I1AMkOcOu26izU76/mOZqhuu
         ThQbII4pd6qysb+oLYMaBL1125rGSEvCuTpCskM8E67qTAfEYWR6lbUD7EBfFDCGITMO
         aDuiLz3bgzhaJ9n67mwE0Kvtx9m9DnuNOUAPSpOtQJbb8uNeabQUE/ghjEXIqK/XVUPg
         8Tx3sj00x+owU4NmswprUZhJ4NQXOCcX03XiJHRny7yXCLdC985D5z8/hxNTP3fRNhCa
         9aJtge4LkLftGh720Y62WM+IJRzVibMpT90NnlmTQ48xic1Ce5L1gh033PR+fAlkYdN+
         H28Q==
X-Gm-Message-State: AGRZ1gKSwI0Fxgk9v2khnJ7TS5CTWiNgxc9GKYmmfII3gOlpwkgNSJwB
        CrcGSy9hVM3ZveFhfoqZ+eMnpfmkZ+s=
X-Google-Smtp-Source: AJdET5dcuRWfj6q53vM9cEaLMmUG7BQBDLwa2WaV5oe9KbilY+921BPYHgLoXgIt8UGcegVQajMdIw==
X-Received: by 2002:a0d:cacf:: with SMTP id m198-v6mr13145350ywd.145.1541191210666;
        Fri, 02 Nov 2018 13:40:10 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id a189-v6sm8582967ywf.49.2018.11.02.13.40.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 13:40:09 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id v92-v6so1320229ybi.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 13:40:08 -0700 (PDT)
X-Received: by 2002:a25:3588:: with SMTP id c130-v6mr13271369yba.410.1541191207949;
 Fri, 02 Nov 2018 13:40:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3990:0:0:0:0:0 with HTTP; Fri, 2 Nov 2018 13:40:06 -0700 (PDT)
In-Reply-To: <20181102183204.GC14942@google.com>
References: <20181101235200.28584-1-keescook@chromium.org> <20181101235200.28584-8-keescook@chromium.org>
 <20181102183204.GC14942@google.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 2 Nov 2018 13:40:06 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKNjipB2yWf_7pE+m29Ma8KUOXotz2L=Pc7=wBZC3AGdA@mail.gmail.com>
Message-ID: <CAGXu5jKNjipB2yWf_7pE+m29Ma8KUOXotz2L=Pc7=wBZC3AGdA@mail.gmail.com>
Subject: Re: [PATCH 7/8] pstore: Remove needless lock during console writes
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 11:32 AM, Joel Fernandes <joel@joelfernandes.org> wrote:
> On Thu, Nov 01, 2018 at 04:51:59PM -0700, Kees Cook wrote:
>> Since commit 70ad35db3321 ("pstore: Convert console write to use
>> ->write_buf"), the console writer does not use the preallocated crash
>> dump buffer any more, so there is no reason to perform locking around it.
>
> Out of curiosity, what was the reason for having this preallocated crash
> buffer in the first place? I thought the 'console' type only did regular
> kernel console logging, not crash dumps.

The primary reason is that the dumper needs to write to somewhere and
we don't know the state of the system (memory allocation may not work
for example).

The other frontends tend to run at "sane" locations in the kernel. The
dumper, however, is quite fragile.

> I looked at all the patches and had some minor nits, with the nits addressed
> (if you agree with them), feel free to add my Reviewed-by on future respins:
>
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Thanks!

> Also I wonder if Namhyung is still poking around that virtio pstore driver he
> mentioned in the commit mentioned above. :)

Did that never land? I thought it mostly had to happen at the qemu end?

With nvdimm emulation, we can just use ramoops. :)

-Kees

-- 
Kees Cook
