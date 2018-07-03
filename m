Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E206AC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9129A249C1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jW8GA+AP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9129A249C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934335AbeGCRou (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 13:44:50 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:46823 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934004AbeGCRot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 13:44:49 -0400
Received: by mail-oi0-f66.google.com with SMTP id y207-v6so5482377oie.13;
        Tue, 03 Jul 2018 10:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=q/9M66YpIpe0eoZashQlmaMpZSNQx3gimEaulgG1Bfg=;
        b=jW8GA+APzSIMfPAdFdOW080fSSZeqM8rBmtn3fVxOHAnPL3L5SytIW3Z02r14oEpvQ
         KZKdqZSODpggmVkThrWIYA9VsIkkXX1qQet+SAPgnWoQ0Ki8LNsh3iBqYtGIauD43HpB
         zH4DVIQpL8ludziIjVuQAP8bWQTsdT5s2g+pjE22az9eOFcriE/j7syW/XSB5UHi6gCx
         SStQUktE5+3bKlEy6C3pI+uT+OPLbsZTf4QQFU9fPKcASz16zU88nF+0hMIEWKiqsHdq
         PBW2T++Gxjr4WYtKG3Njt5rnnD/TzTfGNf+BWDopJsJluMHoaN/oLEdxYouS9EkQ1w9A
         2l3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=q/9M66YpIpe0eoZashQlmaMpZSNQx3gimEaulgG1Bfg=;
        b=PI5Rs0jCMj5dGD24fiK0W2z2tXbIZiqbEhuWW/FeIt7gt98GljX3DlZcELeSrfw0aT
         TbhSENC5P7puVf7yHCn0Pn3AeqFfnrwytYTb/hurAkLx/hoU6F6UuismWSEV9QihXaUD
         UBK9wmnH9acS0WENfbSrlA52mBzzUoDfV0WMoDkf5FYTduM6vNurG4RzNmNwZHTOwmhI
         dSM9uRoCH5ZVUzLdcH9t8OhB3Fgb+8vpjh2rDDIIMZSXHjSwMNAt0iyc+jYei99L0zWf
         625Z6ovCrQ8zruXxZCKJeGP7jxIg6DstLgosnUKK/oXwmyVyPrNXnn9AmdlFBPjbGr+P
         Zhqg==
X-Gm-Message-State: APt69E0TjeNmwMxhixrWhqbZPs3YCsC5kg7AIjhvXJIztbY/U+AThmCm
        DABPsZyOPadv/uQaMsrC+4Nh+NhSDzUTTZYUXro=
X-Google-Smtp-Source: AAOMgpewTe+Q3oIlGez4F4xEslXBp4fK5ppHEGODLQlUWahX5e9VwcA5B6FPdV5Ay8FwP8dCUkAuf4mKQwnNO0gr03E=
X-Received: by 2002:aca:3ac6:: with SMTP id h189-v6mr22912001oia.336.1530639888286;
 Tue, 03 Jul 2018 10:44:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:ea3:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 10:44:47 -0700 (PDT)
In-Reply-To: <CAHp75VcCNsx2sHcYG2aNiw354exTvO=NUOS9P_BTmcM3siAepg@mail.gmail.com>
References: <20180622194752.11221-1-logang@deltatee.com> <20180622194752.11221-7-logang@deltatee.com>
 <CAOMZO5DpwPsidKQ9wfe8mNTgdOpkdHHgqHMa4yQBx9uRrfFmww@mail.gmail.com> <CAHp75VcCNsx2sHcYG2aNiw354exTvO=NUOS9P_BTmcM3siAepg@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 3 Jul 2018 14:44:47 -0300
Message-ID: <CAOMZO5DpOG5G750gYXdVJWwwtOi4BF0wSBxfuVPdFJqnJonD7Q@mail.gmail.com>
Subject: Re: [PATCH v18 6/7] crypto: caam: cleanup CONFIG_64BIT ifdefs when
 using io{read|write}64
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-ntb@googlegroups.com,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>,
        Dan Douglass <dan.douglass@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Tue, Jul 3, 2018 at 2:36 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:

> Oops, first of all the header should be hi-lo instead of lo-hi.
> Does it fix it?

I tried as you suggested:

--- a/drivers/crypto/caam/regs.h
+++ b/drivers/crypto/caam/regs.h
@@ -10,7 +10,7 @@

 #include <linux/types.h>
 #include <linux/bitops.h>
-#include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/io-64-nonatomic-hi-lo.h>

 /*
  * Architecture-specific register access method

but it still crashes the kernel.

Thanks
