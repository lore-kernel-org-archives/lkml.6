Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0C9C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC72120645
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:03:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC72120645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbeIFSil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:38:41 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39984 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728929AbeIFSil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:38:41 -0400
Received: by mail-qk1-f193.google.com with SMTP id c126-v6so7368365qkd.7;
        Thu, 06 Sep 2018 07:02:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=01pgAJzweQ2loKxEE/dxoQvD0AUzXjx4RUmkbSAmClc=;
        b=hj8XCcjSVebtKO7ySbMHLiH8RABQxK8/oR2V9mQHN0UaXXqobigaRnBbqxLGIms5cM
         orV5AQIM1uzrGL600ZDDu/pElZPqdoY0EsIMG1I1neui4Bv8DvZSrAaqM13fibWxgh5Q
         RYAbMkvBkAjcVGoP/VC6b7Kg6MvudiVfd1U6l9Gs1QM9UtMJNQ3k5LdEFhGpn7sbrN0B
         7uoEkhCia0r3uhpjKhLyiPiVcvwDfTX0r8o2BCFl1YtqjWromHc9sB8nknlYFidaDTOD
         RzcMVfWSJ8Qk3LEYEnzaoJkTI5+45DUvLzw/5ELvGnctYtRTZKjSDrEkzywZVBAHcjfy
         jGKw==
X-Gm-Message-State: APzg51AAUFKYEesdC5MSWwcvM68fW/9IWYl9+BqBn+0yYKUMfhPcwnus
        a0HXqRvr/F/wj4D24bN1l7yPDn677YwIWC5h5Cw=
X-Google-Smtp-Source: ANB0VdbEJpYRlpTqW4YktEUudLWzmbL2SPMr123T1X88hWb4QFk34XfooQkfcwOfSJGaut0QFsNNAhXSnZZG4d0xU94=
X-Received: by 2002:a37:1b91:: with SMTP id m17-v6mr2141898qkh.173.1536242578424;
 Thu, 06 Sep 2018 07:02:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536138304.git.ren_guo@c-sky.com> <0f6a6aa2e458df2c3734cf60a68e6f69f0eb1e68.1536138304.git.ren_guo@c-sky.com>
In-Reply-To: <0f6a6aa2e458df2c3734cf60a68e6f69f0eb1e68.1536138304.git.ren_guo@c-sky.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 6 Sep 2018 16:02:42 +0200
Message-ID: <CAK8P3a2z2=0qNWZft6rokx0i=8E5ZbEg1WL5HMYg_DE1wPvZQw@mail.gmail.com>
Subject: Re: [PATCH V3 09/26] csky: VDSO and rt_sigreturn
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 5, 2018 at 2:08 PM Guo Ren <ren_guo@c-sky.com> wrote:

> +
> +       /*
> +        * __NR_rt_sigreturn must be 173
> +        * Because gcc/config/csky/linux-unwind.h use hard code to parse rt_sigframe.
> +        */
> +       err = setup_vdso_page(vdso->rt_signal_retcode);
> +       if (err) panic("Cannot set signal return code, err: %x.", err);

__NR_rt_sigreturn is 139

I think you need to update the comment, and probably check your gcc sources
to ensure it still does the right thing.

         Arnd
