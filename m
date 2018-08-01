Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFADC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E69872083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="f8LVhPgn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E69872083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733075AbeHAULH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:11:07 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42373 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730449AbeHAULG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 16:11:06 -0400
Received: by mail-ed1-f67.google.com with SMTP id r4-v6so2686edp.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 11:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Fvh2H4JSxbPu2GIVWeEdWu381yxmbCu0qRDCdjiFp3g=;
        b=f8LVhPgnRIyxFKXTx4I5bvZknoGWuIoSnXkAhJwTbXulP2rFxCRsSl0WOfcJduEbY9
         U3GQrZmV7JbrXd2tnA4WCbkjm7nDea93/iPskG/L4xrre5QaChY8+FPLSLpnJlgamOtY
         93kPloyv31OD/TJYVWAggJY3qOZQwXVzjtyYvYq4CSlRHC+DombQCpi4RhnDNdscac7T
         Shv0fuu2Rch1PlsdFzaHrPmiM5S04JCVL4K2J3JPNwWW1tzUzcvP2w0fuLVsYJTEl1Z7
         Qj2t/itqLV3YeJS9hD6ZJXnBUD7JUJtqmsvvdEefbMSONCCsLTzYcevQgIG77pzBTyKp
         CCqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Fvh2H4JSxbPu2GIVWeEdWu381yxmbCu0qRDCdjiFp3g=;
        b=WZa47o32LettL1b6U5PbpbmMmjCDzKhfmn5t38jG1kCn6/ORU9TjuzTs2Uqt6le0xQ
         uvapdqDKKcBNA1B9lkizaz4lbvdq8EZy9ymDGbjeQdjyB2a6NzyhN84JdDZ4j+vJlPKO
         mqu01cNj3q+T+FRi/8MmVInCMuROH+2M2Nz1iGz9VEXzggwka6FT8lM7DQQDj9+6Cdw3
         h7P9kVb9c8ZnDKWTzsO552YrMHyyTv5reID0cgragC+b1qwxTvQKMhzRMP1mf/CM4TJu
         26WZ7cRKskH5eBHhRMVv1AnEL+FZcAZPYGaBOixVfufe0E9k0zfYopUFcbFpYh61BHyH
         ukWQ==
X-Gm-Message-State: AOUpUlHPdCTGoWk8gjE3SnXn7FCgvHBuVLIeDPetQjHn+7/rS1m1aDxI
        /ZCktbQj+tckebQAl+4D6x3YVxK4hs8=
X-Google-Smtp-Source: AAOMgpdtuy6IsK5SpP7NxWHmONf0VCIue4vF20NAmJbF05iveeUEC86JB1igtugVKFs47k764k/bJA==
X-Received: by 2002:aa7:d993:: with SMTP id u19-v6mr4871034eds.125.1533147845171;
        Wed, 01 Aug 2018 11:24:05 -0700 (PDT)
Received: from mail-wm0-f48.google.com (mail-wm0-f48.google.com. [74.125.82.48])
        by smtp.gmail.com with ESMTPSA id t44-v6sm13245edh.18.2018.08.01.11.24.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 11:24:04 -0700 (PDT)
Received: by mail-wm0-f48.google.com with SMTP id c14-v6so34170wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 11:24:03 -0700 (PDT)
X-Received: by 2002:a1c:ee15:: with SMTP id m21-v6mr3556754wmh.112.1533147843693;
 Wed, 01 Aug 2018 11:24:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:3644:0:0:0:0:0 with HTTP; Wed, 1 Aug 2018 11:23:43 -0700 (PDT)
In-Reply-To: <mhng-47d9ea80-a0c6-4cde-be65-75046c5d49d2@palmer-si-x1c4>
References: <1530073346-5341-1-git-send-email-alankao@andestech.com> <mhng-47d9ea80-a0c6-4cde-be65-75046c5d49d2@palmer-si-x1c4>
From:   Andrew Waterman <andrew@sifive.com>
Date:   Wed, 1 Aug 2018 11:23:43 -0700
X-Gmail-Original-Message-ID: <CA++6G0AMXC0ZeTZ+tkLh_5QGoPMR+3YD8Ed=DR8-G=6FL1yDSw@mail.gmail.com>
Message-ID: <CA++6G0AMXC0ZeTZ+tkLh_5QGoPMR+3YD8Ed=DR8-G=6FL1yDSw@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: Add support to no-FPU systems
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     alankao@andestech.com, Albert Ou <albert@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        Darius Rad <darius@bluespec.com>, greentime@andestech.com,
        Zong Li <zong@andestech.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 10:55 AM, Palmer Dabbelt <palmer@sifive.com> wrote:
> On Tue, 26 Jun 2018 21:22:26 PDT (-0700), alankao@andestech.com wrote:
>>
>> This patch adds an option, CONFIG_FPU, to enable/disable floating
>> procedures.  Also, some style issues are fixed.
>>
>> Signed-off-by: Alan Kao <alankao@andestech.com>
>> Cc: Greentime Hu <greentime@andestech.com>
>> Cc: Zong Li <zong@andestech.com>
>> ---
>>  arch/riscv/Kconfig                 |  9 ++++
>>  arch/riscv/Makefile                | 19 +++----
>>  arch/riscv/include/asm/switch_to.h |  6 +++
>>  arch/riscv/kernel/entry.S          |  3 +-
>>  arch/riscv/kernel/process.c        |  7 ++-
>>  arch/riscv/kernel/signal.c         | 82 +++++++++++++++++++++---------
>>  6 files changed, 90 insertions(+), 36 deletions(-)
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index 6debcc4afc72..6069597ba73f 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -232,6 +232,15 @@ config RISCV_BASE_PMU
>>
>>  endmenu
>>
>> +config FPU
>> +       bool "FPU support"
>> +       default y
>> +       help
>> +         Say N here if you want to disable all floating-point related
>> procedure
>> +         in the kernel.
>> +
>> +         If you don't know what to do here, say Y.
>> +
>>  endmenu
>
>
> Sorry for letting this slide for a bit.  While I'm not opposed to a solution
> that requires a FPU Kconfig option, it'd be a bit better if we could detect
> this at boot time.  I think this should be possible because at one point
> this actually worked and we could boot the same kernel on FPU and no-FPU
> systems.

I believe it would suffice to have start_thread set sstatus.FS to OFF
for no-FPU systems (vs. INITIAL for systems with FPU).   The ISA
string in the devicetree should indicate whether F/D extensions are
present.

That said, it makes sense to me to additionally provide the Kconfig
option.  This would elide the sstatus.SD check for no-FPU systems,
shaving a couple instructions off the context-switch path.  It would
also enable mimicking the behavior of a no-FPU system even when the
FPU is present.

>
> If that's not possible then we'll have to take something like this.  There
> were some comments on this v2 but I don't see a v3, did I miss one?
