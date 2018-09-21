Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50662ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 18:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFEEF20877
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 18:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j/BkhFos"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFEEF20877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391206AbeIVAgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 20:36:52 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:43907 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732114AbeIVAgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 20:36:52 -0400
Received: by mail-yb1-f196.google.com with SMTP id w80-v6so5836107ybe.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 11:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qCK72VeMWE/9vyG/fGb20p9vYpUoxqRNNblAZ0ZuoQE=;
        b=j/BkhFoswnA5OKnkLMCzOPAUb98dNSyi6khX/bcWBmPMK9p2uOF1ogq17Eevrpkcro
         Hv2uqlvfFWC0prTdxxyGZI0IWArHYGVdqFViAaWnBlosKy6xn8LLQ21V+aclofH9Z7y0
         wzO8Sn+xFBvUETTbO9SpSaFqPVAnb8YlL9iHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qCK72VeMWE/9vyG/fGb20p9vYpUoxqRNNblAZ0ZuoQE=;
        b=anzB7RY4i9j/ZH0AMmLIgNFSBhVVP9gxmqC+e638GPljjagdYnP7NTx0bhhjzZOxez
         lF5aPkESrsDbOc9vll35/G/PUDgM9SqyrtURNFPliznforlvjSQuz3Cbk67EEs6ngOmz
         eJwvnSre+mA0N96JugIBPMckSQtS7NH3XCRAVBLYQljjvvSogIFI+iS2e5nUZsGtWnCe
         9Rt4RuCcCtigEzu5chGKaze53l2hgBtZMRXf85FEifdx+O/f2bWUP1nVZh315D2gkNGR
         WfieRNmPZDWNwC7oOR/jNjZhpzrZxHBC6UogbbdysZ418G26v4uMRtRs+9RbzTz8lBFR
         px9w==
X-Gm-Message-State: APzg51C+O8Zc9cbqgenvYSmhQkS6/I/PtIsPPJu/Ui+jcy/cnyJ1P7ly
        W1mRa2P3SgdoSUgCF4sAB/ATTj2wnNE=
X-Google-Smtp-Source: ANB0VdY1R347mAWVLs+UAB41DTOUJZ/9jB2+9kLnkHf9D2GvjR+EgR8+ODMUgy9fAVpIegnKuzE8/w==
X-Received: by 2002:a25:2042:: with SMTP id g63-v6mr21929101ybg.123.1537555602131;
        Fri, 21 Sep 2018 11:46:42 -0700 (PDT)
Received: from mail-yw1-f45.google.com (mail-yw1-f45.google.com. [209.85.161.45])
        by smtp.gmail.com with ESMTPSA id g126-v6sm5407634ywd.41.2018.09.21.11.46.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 11:46:40 -0700 (PDT)
Received: by mail-yw1-f45.google.com with SMTP id z143-v6so5577744ywa.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 11:46:40 -0700 (PDT)
X-Received: by 2002:a0d:fe87:: with SMTP id o129-v6mr4507067ywf.237.1537555600000;
 Fri, 21 Sep 2018 11:46:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Fri, 21 Sep 2018 11:46:39
 -0700 (PDT)
In-Reply-To: <1536874298-23492-2-git-send-email-rick.p.edgecombe@intel.com>
References: <1536874298-23492-1-git-send-email-rick.p.edgecombe@intel.com> <1536874298-23492-2-git-send-email-rick.p.edgecombe@intel.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 21 Sep 2018 11:46:39 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKTiPioDjC7rrjN+fG=ZK8mdQ542GwEJW6Fa7GUA8x2uQ@mail.gmail.com>
Message-ID: <CAGXu5jKTiPioDjC7rrjN+fG=ZK8mdQ542GwEJW6Fa7GUA8x2uQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] vmalloc: Add __vmalloc_node_try_addr function
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jann Horn <jannh@google.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 2:31 PM, Rick Edgecombe
<rick.p.edgecombe@intel.com> wrote:
> Create __vmalloc_node_try_addr function that tries to allocate at a specific
> address and supports caller specified behavior for whether any lazy purging
> happens if there is a collision.
>
> This new function draws from the __vmalloc_node_range implementation. Attempts
> to merge the two into a single allocator resulted in logic that was difficult
> to follow, so they are left separate.
>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

I'd love to get some more mm folks to look this over too.

-Kees

-- 
Kees Cook
Pixel Security
