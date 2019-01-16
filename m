Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F36FC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 23:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5382720866
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 23:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547682692;
	bh=V+8dJcUg9SsrzJCzQ6Sot65yqPn4sSuG8kzCtdNByQ8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=e+E871aMzifwQ43m2pQKHL6qvMFum98hXGDnmvaXMIdJlev75OckVWecM644qJHzx
	 pjW69Ax2okBqCGhZN6ZpOdcGzXxSXBP+tNT4+aIvKwtgkSDoMh8cpx0tdcOkVkfTFB
	 Jy2OTTZJ64TgSaDqynQZ66mJtN+elTTN+/Odk1GY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbfAPXva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 18:51:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:40686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727477AbfAPXva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 18:51:30 -0500
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 514A12087E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 23:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547682689;
        bh=V+8dJcUg9SsrzJCzQ6Sot65yqPn4sSuG8kzCtdNByQ8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HoBFURniO7u7r45mANBzYRgPRdSP9atLsUyy45Wx4enTRhnziQKWQD6b/0gmJgX1m
         /USs5jXlzYok9t3qJXblV2yXnNjAZq4monOy+HTwDATJow4Rvb0OKTMJl3s5Q1draW
         Wxr5DJof4AJQ/c+IXZPs1LpM/SGYAx+5tPdyWNiE=
Received: by mail-wr1-f45.google.com with SMTP id p4so8975829wrt.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 15:51:29 -0800 (PST)
X-Gm-Message-State: AJcUukcjFEkMT/2MzgjGx0dqNaNmcdxxTGU3mI8GKxVWbAoednbA2aam
        jSbIWTb9oGSjU77IoRNYdvmK/7VY6+uvhV59MxkvNw==
X-Google-Smtp-Source: ALg8bN5+DCI+Udt25iRZPiVFBAwwNPCeTDnLbO9VVUR0H2wjuIhYXNBrjkq4Eba9ap+OP29oVzGF+9+gTHnqNKmLrAc=
X-Received: by 2002:a5d:550f:: with SMTP id b15mr9908316wrv.330.1547682687706;
 Wed, 16 Jan 2019 15:51:27 -0800 (PST)
MIME-Version: 1.0
References: <1547673522-226408-1-git-send-email-fenghua.yu@intel.com> <1547673522-226408-3-git-send-email-fenghua.yu@intel.com>
In-Reply-To: <1547673522-226408-3-git-send-email-fenghua.yu@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 16 Jan 2019 15:51:16 -0800
X-Gmail-Original-Message-ID: <CALCETrWQMg8BEk4fZ5-GyP=VL2zEk_UQr67iQt-fqf4cC8nHcQ@mail.gmail.com>
Message-ID: <CALCETrWQMg8BEk4fZ5-GyP=VL2zEk_UQr67iQt-fqf4cC8nHcQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] x86/umwait: Setup umwait C0.2 state
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        H Peter Anvin <hpa@zytor.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 1:24 PM Fenghua Yu <fenghua.yu@intel.com> wrote:
>
> UMWAIT or TPAUSE called by user process makes processor to reside in
> a light-weight power/performance optimized state (C0.1 state) or an
> improved power/performance optimized state (C0.2 state).
>
> IA32_UMWAIT_CONTROL MSR register allows OS to set global maximum umwait
> time and disable C0.2 on the processor.
>
> By default C0.2 is enabled so user wait instructions can enter the state
> if user wants to save more power but wakeup time is slower. In some cases
> e.g. real time, user wants to disable C0.2 and all C0.2 requests revert
> to C0.1.
>
> A new "/sys/devices/system/cpu/umwait_control/umwait_enable_c0_2" file is
> created to allow user to check if C0.2 is enabled or disabled and also
> allow user to enable or disable C0.2. Value "0" in the file means C0.2 is
> disabled. Value "1" means C0.2 is enabled.

Do you have any sense as to what the actual C0.2 entry and exit latency is?

--Andy
