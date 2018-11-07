Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA13C46465
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 01:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71A2621104
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 01:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rCCo1xfr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71A2621104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388915AbeKGKtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 05:49:13 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:38953 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388065AbeKGKtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 05:49:13 -0500
Received: by mail-it1-f193.google.com with SMTP id m15so20573160itl.4;
        Tue, 06 Nov 2018 17:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OqeHolx5+EMags5iHWTP+Kh+wk5HkWDi0zhO6B0UKNE=;
        b=rCCo1xfrGeUbrBhBghBXSbTjwFRtkwZjOzXYXCThEevGnmJfPCCUNBg43Jxv1rkUq2
         b7XSvPOWJ2KnSBhrho0HP1r60Em42hH9FPg9mpgHgv+zHioY/V8oQgWIiXmcHOzm3zcc
         xdOt+pjJudqmyXPboSON56ZgTfyOxiRGHld/dXY+UD5KIcWVpzKpU//bamTrlJoj3uWr
         KJRT0LFMhRWge5xYnydR5TRy5neTvUpcduOgWlx5sR80A6l8ZOCmT+mNl6X455+eQWeK
         4Jmb77ZYZJG06bdQ9zTfr3lQrO8e1Dn6nG+3CF/CxFWT1Y0RPYKu901W08jxXnZkXgCH
         UZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OqeHolx5+EMags5iHWTP+Kh+wk5HkWDi0zhO6B0UKNE=;
        b=GCZrGC4lNuc9o815e1WRQ5TdaxHx3mJUFWoWfSZle56CXimgczNeWv8NY3xzPJQah5
         TmGspujHFOLAN70HaMUQNQdiVt8aGpS5rXZcKGpfcVUcy73Y+t4sYqCIxbA61Gq8x04U
         g2ewIiPUKCUpgoP4t9APgv0dfa5OjUoeW0FwuGdcdQEOoUUgqtT25sIXr2V8CUuhYYUJ
         jt9dzNcrCmg9haKfjn9d1ZHylgVOVOGl734is21apTT+VTAFCy99AClcz26jYhBcX1JE
         ObJmFqVKvaT4WKD2neO3PMq8QAUyhjr2v3J7inJUj8sP4biXwbKOT8J6A35UVNumx3a1
         lNVg==
X-Gm-Message-State: AGRZ1gLcy+cpDRtI6Lq10M0rIf2CIMBYxSpKXh9l9/+ZAstoeLYAsVgU
        8n96LHbu/i3salvr95ehBEVYjwvT8Kb1yBe/WiA=
X-Google-Smtp-Source: AJdET5d5RvBUlgAUW2QN5PwJCc3b9kXzuJkKA8WgWdGyVqHmiJW9C8N3Q3bTJq2XoXrv5+623Ke9wWYs5UghixdbKIM=
X-Received: by 2002:a24:7acd:: with SMTP id a196-v6mr210950itc.95.1541553667882;
 Tue, 06 Nov 2018 17:21:07 -0800 (PST)
MIME-Version: 1.0
References: <20181106143227.8287-1-tiny.windzz@gmail.com> <201811070933.bt7EaOFh%fengguang.wu@intel.com>
In-Reply-To: <201811070933.bt7EaOFh%fengguang.wu@intel.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Wed, 7 Nov 2018 09:20:17 +0800
Message-ID: <CAEExFWuvTo_iukVjzNvATm0L=t4YkbU2mjwd47-FUZYSqNXFpQ@mail.gmail.com>
Subject: Re: [PATCH] apparmor: Change to use DEFINE_SHOW_ATTRIBUTE macro
To:     lkp@intel.com
Cc:     kbuild-all@01.org, John Johansen <john.johansen@canonical.com>,
        jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry,I will send the second version of the patch.
--Yangtao
On Wed, Nov 7, 2018 at 9:17 AM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Yangtao,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on security/next-testing]
> [also build test ERROR on v4.20-rc1 next-20181106]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Yangtao-Li/apparmor-Change-to-use-DEFINE_SHOW_ATTRIBUTE-macro/20181107-004056
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-testing
> config: ia64-allmodconfig (attached as .config)
> compiler: ia64-linux-gcc (GCC) 8.1.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=8.1.0 make.cross ARCH=ia64
>
> All errors (new ones prefixed by >>):
>
> >> security/apparmor/apparmorfs.o:(.data.rel+0x110): undefined reference to `aa_sfs_seq_file_ops'
>    security/apparmor/apparmorfs.o:(.data.rel+0x228): undefined reference to `aa_sfs_seq_file_ops'
>    security/apparmor/apparmorfs.o:(.data.rel+0x250): undefined reference to `aa_sfs_seq_file_ops'
>    security/apparmor/apparmorfs.o:(.data.rel+0x278): undefined reference to `aa_sfs_seq_file_ops'
>    security/apparmor/apparmorfs.o:(.data.rel+0x2c8): undefined reference to `aa_sfs_seq_file_ops'
>    security/apparmor/apparmorfs.o:(.data.rel+0x2f0): more undefined references to `aa_sfs_seq_file_ops' follow
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
