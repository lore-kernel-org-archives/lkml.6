Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D00C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 04:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EA6120684
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 04:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VbNZXoJm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EA6120684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbeJBLa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 07:30:58 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:39441 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbeJBLa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 07:30:57 -0400
Received: by mail-yb1-f193.google.com with SMTP id c4-v6so281958ybl.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 21:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=L/iz8UGDhqnhQj14wynEEGVGj6CSwWszHDf61Vdh6eA=;
        b=VbNZXoJmnWC1w45hkLStsc8iddHSdBp2k4Mt/MM+ztPG8n/P3SWUZUltyFVtGDCw6P
         W8XX+xcaxke590MdOoIZix3BaFn6cwJpqP1Ss828Tig1csdWOSdA+TQHK2ntxvzfTM23
         tJYCzp5T/G3FXZylyqTiq/5E3xXK4sJV7whi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=L/iz8UGDhqnhQj14wynEEGVGj6CSwWszHDf61Vdh6eA=;
        b=YH3B9W/W8T7Hz5mN1KsmxygGwBwJvhQPNMbE5YJ2ff2yoEPCTZgKfIP9/7eLqR22JL
         QHprm6ugR2sDtyxX3K5J0PuizL/cM5Qxm5OqH5fcxrs9S4/ev2JRWntVYZA/VexpQYsc
         pA+Q5RA/ebVrJbVZx2vs68leSXzhL/C/kPh2qZYcoUsFjQnVB5SXANTbNGyl1lsxfyXa
         BuluzbqZgkX3CW7kbGntmOtBhHHTgf2bTGf7UcjTSARxmFclxUc0t6tBAWwfinNRX9ri
         9bfUkHbs5sgYgqvrwwRRu9PUahjO0Y/lvZKPY7fB3wvjfn+sMzGDQO7/DVbpC5J8TC+7
         0q4g==
X-Gm-Message-State: ABuFfoibIjQ0Ak/dXZ0C6a0zq3DbfCw7M4VCyzfsiSh9eGdUaIAaN5tW
        MIs1TMY2+7VyRWPynT/JqwR/GREOrJo=
X-Google-Smtp-Source: ACcGV62eKn97Q/8JOW/xow5OtoN3P7bh0i73slDyT0PpCjXNzUa0Y0Eu5Kjo/ENEmDI6XBTz1LUO3w==
X-Received: by 2002:a25:ae28:: with SMTP id a40-v6mr7849056ybj.365.1538455781214;
        Mon, 01 Oct 2018 21:49:41 -0700 (PDT)
Received: from mail-yw1-f52.google.com (mail-yw1-f52.google.com. [209.85.161.52])
        by smtp.gmail.com with ESMTPSA id 189-v6sm5627543ywf.4.2018.10.01.21.49.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 21:49:39 -0700 (PDT)
Received: by mail-yw1-f52.google.com with SMTP id e201-v6so274329ywa.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 21:49:38 -0700 (PDT)
X-Received: by 2002:a81:2908:: with SMTP id p8-v6mr7682701ywp.407.1538455778198;
 Mon, 01 Oct 2018 21:49:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Mon, 1 Oct 2018 21:49:37 -0700 (PDT)
In-Reply-To: <ccfbe049-392d-4df5-5eb5-ea18576d4afd@infradead.org>
References: <20181002005505.6112-1-keescook@chromium.org> <20181002005505.6112-22-keescook@chromium.org>
 <ccfbe049-392d-4df5-5eb5-ea18576d4afd@infradead.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 1 Oct 2018 21:49:37 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+ND4K5GvxJ1ieLr5E=Zsfb6mGQL8yTegOXv4V4qmuZUA@mail.gmail.com>
Message-ID: <CAGXu5j+ND4K5GvxJ1ieLr5E=Zsfb6mGQL8yTegOXv4V4qmuZUA@mail.gmail.com>
Subject: Re: [PATCH security-next v4 21/32] LSM: Finalize centralized LSM
 enabling logic
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     James Morris <jmorris@namei.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
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

On Mon, Oct 1, 2018 at 6:18 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 10/1/18 5:54 PM, Kees Cook wrote:
>> Prior to this patch, default "enable" behavior was unchanged: SELinux
>> and AppArmor were controlled separately from the centralized control
>> defined by CONFIG_LSM_ENABLE and "lsm.enable=...". This changes the
>> logic to give all control over to the central logic.
>>
>> Instead of allowing SELinux and AppArmor to override the central LSM
>> enabling logic, by having separate CONFIG and boot parameters, this
>> forces all "enable" variables to disabled, then enables any listed in
>> the CONFIG_LSM_ENABLE and "lsm.enable=..." settings, and finally disables
>> any listed in "lsm.disable=...".
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  .../admin-guide/kernel-parameters.txt         |  6 ++--
>>  include/linux/lsm_hooks.h                     |  2 +-
>>  security/security.c                           | 32 +++++++------------
>>  3 files changed, 15 insertions(+), 25 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 67c90985d2b8..f646cfab5613 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -2279,14 +2279,12 @@
>>       lsm.disable=lsm1,...,lsmN
>>                       [SECURITY] Comma-separated list of LSMs to disable
>>                       at boot time. This overrides "lsm.enable=",
>
> better:                               This overrides "lsm.enable=" and

Eek, yes! Thank you. :)

-Kees

>
>> -                     CONFIG_LSM_ENABLE, and any per-LSM CONFIGs and boot
>> -                     parameters.
>> +                     CONFIG_LSM_ENABLE.
>>
>>       lsm.enable=lsm1,...,lsmN
>>                       [SECURITY] Comma-separated list of LSMs to enable
>>                       at boot time. This overrides any omissions from
>> -                     CONFIG_LSM_ENABLE, and any per-LSM CONFIGs and
>> -                     boot parameters.
>> +                     CONFIG_LSM_ENABLE.
>>
>>       machvec=        [IA-64] Force the use of a particular machine-vector
>>                       (machvec) in a generic kernel.
>
>
> --
> ~Randy



-- 
Kees Cook
Pixel Security
