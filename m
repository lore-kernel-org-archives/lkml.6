Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78570C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43A2220892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dDOT6h9t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43A2220892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbeLFScv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 13:32:51 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:45207 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeLFScv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 13:32:51 -0500
Received: by mail-yb1-f193.google.com with SMTP id f6-v6so1191156ybg.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 10:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mI6l0Fnf9aPw9X8+3mFJjLs23r9ZCBc2ngt0khlo8JE=;
        b=dDOT6h9tHkebE5jadmWnc0RjGj3857W5dvSm+Fe6EXUZhPL4uVuPP+DRTvMJHclw+/
         x+w4pYShmZXFcaqmgsy5QFS3M4RlEG5apFSesXyflKv8IVr+cmezmZQKvsYCFpDpnwjn
         VLjQye+Ilk4ylB5EpgmgX2lJs0PkAcQSxP/vM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mI6l0Fnf9aPw9X8+3mFJjLs23r9ZCBc2ngt0khlo8JE=;
        b=S/QFs2VycVN6MiGpd0d4AX4uvnZh4MGRXKAK3FQ3upJxtuzj++f3IahqJoOEK+y3oX
         AaaNTuYmxXYcSS+aO8R7lEoyEGry/Bi9tUtSgwfCpgTBRd5rHwCPg7me4bIIAOHKU+WB
         54oMb14ZFH2lVGbjOw9WVlG05BvJL5Sk8sG6bevZY3KN6HJTU4pFlgvKcxL32n2x+nxH
         KpvzIL5Octd/qjlnN8oRXbYvaE3O7xUoqAZyzFbJHgq8L1bCWFQogrd9YjL1jhzrsTIG
         nkYRIBbYAOU32iY/YscITAmurCl6LBv9LCWe6ooEiioE97VsmycZ/0IFv/7ejpXjOoZd
         Xreg==
X-Gm-Message-State: AA+aEWZjJeCNopFXfpURltvxHhu+x17TW6pG7/9N01dbpNXFnZ2AipsM
        4Hd+7E99Xtiv0ZYF9L3ukvWMPnNTQJk=
X-Google-Smtp-Source: AFSGD/Ury7jMzVEx28lHUDmmv5LWDKUQYkibj7s1xvIXBcm34XnVUV2jsyNUKiDUZngZq/DMdFIPwA==
X-Received: by 2002:a81:ad8:: with SMTP id 207mr6690134ywk.188.1544121170571;
        Thu, 06 Dec 2018 10:32:50 -0800 (PST)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id c140sm713593ywa.74.2018.12.06.10.32.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 10:32:49 -0800 (PST)
Received: by mail-yb1-f174.google.com with SMTP id l126so1186087ybf.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 10:32:48 -0800 (PST)
X-Received: by 2002:a25:2347:: with SMTP id j68mr20346207ybj.137.1544121167686;
 Thu, 06 Dec 2018 10:32:47 -0800 (PST)
MIME-Version: 1.0
References: <20181206150156.28210-1-david.abdurachmanov@gmail.com>
 <20181206150156.28210-2-david.abdurachmanov@gmail.com> <CAGXu5jKfnE_RJL7aA5x-qqYdA9zoTTtKwahg0r5fyW5GqFLgdA@mail.gmail.com>
 <CAEn-LTrhGAX2+V5r1kdBQw33M4Sre8P5e7wfRcwFruT5Y-WeXw@mail.gmail.com>
In-Reply-To: <CAEn-LTrhGAX2+V5r1kdBQw33M4Sre8P5e7wfRcwFruT5Y-WeXw@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 6 Dec 2018 10:32:36 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJAb0QMxvAjS+BxVOx02bHDtxFdu1V1kRjOz8K5xxTSqA@mail.gmail.com>
Message-ID: <CAGXu5jJAb0QMxvAjS+BxVOx02bHDtxFdu1V1kRjOz8K5xxTSqA@mail.gmail.com>
Subject: Re: [PATCH 1/2] riscv: add support for SECCOMP incl. filters
To:     David Abdurachmanov <david.abdurachmanov@gmail.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, green.hu@gmail.com,
        deanbo422@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 10:26 AM David Abdurachmanov
<david.abdurachmanov@gmail.com> wrote:
>
> On Thu, Dec 6, 2018 at 5:52 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Thu, Dec 6, 2018 at 7:02 AM David Abdurachmanov
> > <david.abdurachmanov@gmail.com> wrote:
> > > The patch adds support for SECCOMP and SECCOMP_FILTER (BPF).
> >
> > Can you add support to tools/testing/selftests/seccomp/seccomp_bpf.c
> > as well? That selftest finds a lot of weird corner-cases...
>
> I hate it locally and will include in v2.

I hate it too. ;) But seriously (reading through the "have" typo),
that's awesome. Thanks!

> The results see fine (tested in QEMU).

Great!

-- 
Kees Cook
