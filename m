Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8D5C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 532422083C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:09:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 532422083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbeHaSRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 14:17:32 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43531 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727404AbeHaSRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 14:17:32 -0400
Received: by mail-qk1-f194.google.com with SMTP id 130-v6so1455992qkd.10
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 07:09:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QlqunTzw1AZE+0hYlMbmWmLxRG8G3jzolZ90fjqhEuw=;
        b=ZotjzPo5lTsdy1KBtJxkhgHytFQOSvQivJB6TMh6K1mWzAhShuLZqKgEwurJ0BakUE
         rUCLwq3jNC8H5PvT2vh5lwvKKzVu9vnZY8LuGbufRgo8Vj2jSy/2FfVTcTmz7czdJ0cu
         sL8Gki+mReaFLolHeeSzx2QVTeVlNXjGYfqd7NLPuiU3zJKOvipm5GjLy2KWTFT3WcG0
         DXC0VoDxecRqUdyKtNuMyGAPPK2BfgebRb5+trWFIgLjDLX95CWS/zDUT/eR/uEc+OIL
         ZbkOrMAQFw3RvVB56S7CljLF6t2QW8mjY30SEN1lF+Xa89mVQ2JXdCvhGOy6SzMeLEV8
         8C3A==
X-Gm-Message-State: APzg51D+FaFYJ3X9hfRpR58eJq3QLKozerJPwoF8kmc21Ro9PxaJ7ifF
        4Ic466BcJCHQYwvbqgD/c4Ce9oSmWyTa31svh3U=
X-Google-Smtp-Source: ANB0VdYPyC0gOf24GDvxF6Uo79BQoK0t/JBn4Ozr281+SOs8X2uZ2lQQK4s9e+XLxhcQVJiN9oQQNW5HJNL9DvkS/HU=
X-Received: by 2002:a37:1b91:: with SMTP id m17-v6mr15698910qkh.173.1535724590633;
 Fri, 31 Aug 2018 07:09:50 -0700 (PDT)
MIME-Version: 1.0
References: <20180830223429.30051-1-igor.stoppa@huawei.com>
In-Reply-To: <20180830223429.30051-1-igor.stoppa@huawei.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 31 Aug 2018 16:09:34 +0200
Message-ID: <CAK8P3a2JasKXtXYoV7KsSZt4TwkffsBjrf=LK1HZJx0KFKCcow@mail.gmail.com>
Subject: Re: [PATCH 00/23] Make use of unlikely() more consistently.
To:     igor.stoppa@gmail.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        igor.stoppa@huawei.com, Aaro Koskinen <aaro.koskinen@iki.fi>,
        Alasdair Kergon <agk@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Jeffery <andrew@aj.id.au>,
        Archit Taneja <architt@codeaurora.org>, asolokha@kb.kras.ru,
        bvanassche@acm.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        chien.tin.tung@intel.com, chunkeey@googlemail.com,
        Christoph Lameter <cl@linux.com>,
        David Airlie <airlied@linux.ie>,
        David Daney <ddaney@caviumnetworks.com>,
        Dennis Zhou <dennisszhou@gmail.com>, dima@arista.com,
        Doug Ledford <dledford@redhat.com>,
        "Latif, Faisal" <faisal.latif@intel.com>,
        gregkh <gregkh@linuxfoundation.org>,
        Daode Huang <huangdaode@hisilicon.com>,
        Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        James Hogan <jhogan@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, ejt@redhat.com,
        Kalle Valo <kvalo@codeaurora.org>,
        Kees Cook <keescook@chromium.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Madalin-Cristian Bucur <madalin.bucur@nxp.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Michael S. Tsirkin" <mst@redhat.com>, michal.kazior@tieto.com,
        Mike Snitzer <snitzer@redhat.com>,
        Paul Burton <paul.burton@mips.com>,
        Paul Mackerras <paulus@samba.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Clark <robdclark@gmail.com>, rolandd@cisco.com,
        Salil Mehta <salil.mehta@huawei.com>,
        Shuah Khan <shuah@kernel.org>,
        srivatsa.bhat@linux.vnet.ibm.com, sviau@codeaurora.org,
        Tejun Heo <tj@kernel.org>, yisen.zhuang@huawei.com,
        zijun_hu@htc.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 12:35 AM Igor Stoppa <igor.stoppa@gmail.com> wrote:
>
> In some cases, checks that are expected to not fail, do not take advantage
> of specifying that the condition being tested is unlikely().
>
> Ex:
>
> #define assert(condition)
> ...
>         if (!(condition))
>                 error_action()
> ...
>
> should be
>
> #define assert(condition)
> ...
>         if (unlikely(!(condition)))
>                 error_action()
> ...

There is a potential that this introduces false-postive -Wmaybe-uninitialized
warnings when CONFIG_PROFILE_ANNOTATED_BRANCHES is
set, since that turns unlikely() into a complex operation that in turn
confuses the compiler so it no longer keeps track of which variables
are initialized or not.

It's possible that none of your patches do that, but one needs to be aware
of the problem, and possibly revert some of your patches if it does cause
warning regressions in drivers that don't actually benefit from the
micro-optimization.

> In other cases, the hint is given twice: once explicitly and once inside
> whatever test is being performed: assert(), BUG_ON(), WARN_ON(), etc.
>
> Ex:
>
> if (unlikely(WARN_ON(condition, message)))
> ...

Removing those is definitely fine.

        Arnd
