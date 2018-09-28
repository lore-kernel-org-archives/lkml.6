Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC00BC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 20:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BF29206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 20:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DZKUYu7s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BF29206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbeI2C0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 22:26:53 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:33093 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbeI2C0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 22:26:53 -0400
Received: by mail-yw1-f66.google.com with SMTP id r187-v6so2349010ywg.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 13:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Ppb5IRdyzvtQQyB2FU+l6L5Ti22we2J9D6v64Iqw9UI=;
        b=DZKUYu7sM4zdQyT3GgAUGCAw8Y/7k/PhNqMQRqFBQMneh5C2Yly9R9ncqGnezDL4CO
         capMDA5FUjYp/bk9Qi7xbeysh8Snbl7JxB67PE9zUx2CRoFwga0rkIJ6ltLVlqdAzmU3
         pXh8QYyQ0royQIZ7Hp/1zzkmlQzhqOuAzrRP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Ppb5IRdyzvtQQyB2FU+l6L5Ti22we2J9D6v64Iqw9UI=;
        b=Rx/AT1ZRQOloH0MWEVlpjXS4v6mYESzRxiuk0yGtTPLYjmL+1YBg0EnRs2STra62yP
         btWzAhFmeJetTjo9F0DrM1EXxHrPpTYkU8AXtZ+RRGTfKfsmKum/l+5BPYHisStBoaNS
         nS1ARLRBYYUglfcjfN23ceMHizeadu3T+Ebj8g+LwXJYdzlwPPNabHXa7J8w3C/FTBlM
         fVLSjAc428KgxB1nCokhYpT5b/GXkDJ2MRzVr79rawWIvoZzoegDWUYPMVYmFHpiVkDO
         pqk1dIh6JXW7QpL+LzF/SOYJ54odUrlxxsYTbHVlFPggebtU4yOMgynI7jVKpwXGa0jE
         Ks5A==
X-Gm-Message-State: ABuFfogpJWlyxi47C52K4pTKNUSUeLividQ1zxIWAf7AD1JTcOp0iAgI
        ftO/4VlLRkPlLLZ+gkRDHndGEn+4zKY=
X-Google-Smtp-Source: ACcGV61xYAr6gtNsuK2vh/skusPHqhRG+YVM1CEyBCz+3QNI6OVLAsizoxi8Pa0WG6GGPK1PtCDg0A==
X-Received: by 2002:a81:5055:: with SMTP id e82-v6mr119954ywb.232.1538164893131;
        Fri, 28 Sep 2018 13:01:33 -0700 (PDT)
Received: from mail-yw1-f46.google.com (mail-yw1-f46.google.com. [209.85.161.46])
        by smtp.gmail.com with ESMTPSA id z125-v6sm2558888ywg.57.2018.09.28.13.01.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 13:01:31 -0700 (PDT)
Received: by mail-yw1-f46.google.com with SMTP id h134-v6so3130985ywc.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 13:01:31 -0700 (PDT)
X-Received: by 2002:a81:98d7:: with SMTP id p206-v6mr84151ywg.353.1538164890789;
 Fri, 28 Sep 2018 13:01:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Fri, 28 Sep 2018 13:01:30
 -0700 (PDT)
In-Reply-To: <e6122c7d-bd29-d081-3c1e-96b7c369d4fe@schaufler-ca.com>
References: <20180925001832.18322-1-keescook@chromium.org> <e6122c7d-bd29-d081-3c1e-96b7c369d4fe@schaufler-ca.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 28 Sep 2018 13:01:30 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKQVDW8Wp0ESv2raa0xJnHCCMNqFCzZ5jSVXQ=Dp7FF8A@mail.gmail.com>
Message-ID: <CAGXu5jKQVDW8Wp0ESv2raa0xJnHCCMNqFCzZ5jSVXQ=Dp7FF8A@mail.gmail.com>
Subject: Re: [PATCH security-next v3 00/29] LSM: Explict LSM ordering
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     James Morris <jmorris@namei.org>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 8:55 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 9/24/2018 5:18 PM, Kees Cook wrote:
>> v3:
>> - add CONFIG_LSM_ENABLE and refactor resulting logic
>
> Kees, you can add my
>
>         Reviewed-by:Casey Schaufler <casey@schaufler-ca.com>
>
> for this entire patch set. Thank you for taking this on, it's
> a significant and important chunk of the LSM infrastructure
> update.

Thanks!

John, you'd looked at this a bit too -- do the results line up with
your expectations?

Any thoughts from SELinux, TOMOYO, or IMA folks?

-Kees

>
>
>> ...
>> Breakdown of patches:
>>
>> Infrastructure improvements (no logical changes):
>>   LSM: Correctly announce start of LSM initialization
>>   vmlinux.lds.h: Avoid copy/paste of security_init section
>>   LSM: Rename .security_initcall section to .lsm_info
>>   LSM: Remove initcall tracing
>>   LSM: Convert from initcall to struct lsm_info
>>   vmlinux.lds.h: Move LSM_TABLE into INIT_DATA
>>   LSM: Convert security_initcall() into DEFINE_LSM()
>>   LSM: Record LSM name in struct lsm_info
>>   LSM: Provide init debugging infrastructure
>>   LSM: Don't ignore initialization failures
>>
>> Split "integrity" out into "ordered initialization" (no logical changes):
>>   LSM: Introduce LSM_FLAG_LEGACY_MAJOR
>>   LSM: Provide separate ordered initialization
>>
>> Provide centralized LSM enable/disable infrastructure:
>>   LoadPin: Rename "enable" to "enforce"
>>   LSM: Plumb visibility into optional "enabled" state
>>   LSM: Lift LSM selection out of individual LSMs
>>   LSM: Prepare for arbitrary LSM enabling
>>   LSM: Introduce CONFIG_LSM_ENABLE
>>   LSM: Introduce lsm.enable= and lsm.disable=
>>   LSM: Prepare for reorganizing "security=" logic
>>   LSM: Refactor "security=" in terms of enable/disable
>>
>> Provide centralized LSM ordering infrastructure:
>>   LSM: Build ordered list of ordered LSMs for init
>>   LSM: Introduce CONFIG_LSM_ORDER
>>   LSM: Introduce "lsm.order=" for boottime ordering
>>
>> Move minor LSMs into ordered LSM initialization:
>>   LoadPin: Initialize as ordered LSM
>>   Yama: Initialize as ordered LSM
>>   LSM: Introduce enum lsm_order
>>   capability: Initialize as LSM_ORDER_FIRST
>>
>> Move major LSMs into ordered LSM initialization:
>>   LSM: Separate idea of "major" LSM from "exclusive" LSM
>>   LSM: Add all exclusive LSMs to ordered initialization
>>
>> -Kees
>>
>>  .../admin-guide/kernel-parameters.txt         |  20 +
>>  arch/arc/kernel/vmlinux.lds.S                 |   1 -
>>  arch/arm/kernel/vmlinux-xip.lds.S             |   1 -
>>  arch/arm64/kernel/vmlinux.lds.S               |   1 -
>>  arch/h8300/kernel/vmlinux.lds.S               |   1 -
>>  arch/microblaze/kernel/vmlinux.lds.S          |   2 -
>>  arch/powerpc/kernel/vmlinux.lds.S             |   2 -
>>  arch/um/include/asm/common.lds.S              |   2 -
>>  arch/xtensa/kernel/vmlinux.lds.S              |   1 -
>>  include/asm-generic/vmlinux.lds.h             |  25 +-
>>  include/linux/init.h                          |   2 -
>>  include/linux/lsm_hooks.h                     |  43 ++-
>>  include/linux/module.h                        |   1 -
>>  security/Kconfig                              |  61 ++-
>>  security/apparmor/lsm.c                       |  16 +-
>>  security/commoncap.c                          |   8 +-
>>  security/integrity/iint.c                     |   5 +-
>>  security/loadpin/Kconfig                      |   4 +-
>>  security/loadpin/loadpin.c                    |  28 +-
>>  security/security.c                           | 351 +++++++++++++++---
>>  security/selinux/hooks.c                      |  16 +-
>>  security/smack/smack_lsm.c                    |   8 +-
>>  security/tomoyo/tomoyo.c                      |   7 +-
>>  security/yama/yama_lsm.c                      |   7 +-
>>  24 files changed, 438 insertions(+), 175 deletions(-)
>>
>



-- 
Kees Cook
Pixel Security
