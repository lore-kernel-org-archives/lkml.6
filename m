Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DAB9ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 18:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11DED207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 18:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CumG42IU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11DED207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbeJYDVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 23:21:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:45014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727120AbeJYDVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 23:21:03 -0400
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5646720831
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 18:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540407111;
        bh=1HfwgJIi8hw/hMiHNFzpXrgUfITmh8nfNXREaDD3U9s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CumG42IUeQYduq1dTJuRxpYleA0C8iXevSBer3q9tOjMgA+Zi0hTDZ/DWV+lKRfRZ
         W1aZWgCMXsgZutjS5tlEWrJEsDGqSQcSK7EDi20sv2XjoBQ8K4jnhxErdrVfVuTysF
         ji+rMf+IZUkmNdxhgVh2KPHabUL0NEetm7wwFwPI=
Received: by mail-wm1-f49.google.com with SMTP id w186-v6so6469444wmf.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 11:51:51 -0700 (PDT)
X-Gm-Message-State: AGRZ1gL8VjHa5wKpQDMfDN6BDN9W+o+FVUUZgYl7PvV/O/MlN6Ir6rh2
        CStT5LaV957CZyIiI+PJSTY763SJ2SzE7YJo0hjyOQ==
X-Google-Smtp-Source: AJdET5euhv16fqxukbpT/LsKzmrqU9d//x1Y9ZfzLpIwNrd83UsUB8Fp5HdHi5LDr3NtEZjhwaauBCdLcnCmy1avaU4=
X-Received: by 2002:a1c:507:: with SMTP id 7-v6mr3696432wmf.82.1540407109844;
 Wed, 24 Oct 2018 11:51:49 -0700 (PDT)
MIME-Version: 1.0
References: <20181023184234.14025-1-chang.seok.bae@intel.com> <20181023184234.14025-3-chang.seok.bae@intel.com>
In-Reply-To: <20181023184234.14025-3-chang.seok.bae@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 24 Oct 2018 11:51:38 -0700
X-Gmail-Original-Message-ID: <CALCETrUNm23OuwM_TuigU9_HFfc2-EopM-Mj9V59Cr5=wRYugA@mail.gmail.com>
Message-ID: <CALCETrUNm23OuwM_TuigU9_HFfc2-EopM-Mj9V59Cr5=wRYugA@mail.gmail.com>
Subject: Re: [v3 02/12] x86/fsgsbase/64: Add 'unsafe_fsgsbase' to enable CR4.FSGSBASE
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 11:43 AM Chang S. Bae <chang.seok.bae@intel.com> wrote:
>
> From: Andy Lutomirski <luto@kernel.org>
>
> This is temporary.  It will allow the next few patches to be tested
> incrementally.
>
> Setting unsafe_fsgsbase is a root hole.  Don't do it.
>
> [ chang: Minor fix. Add the TAINT_INSECURE flag. ]

Reviewed-by: Andy Lutomirski <luto@kernel.org>

although reviewing code that I mostly wrote seems a bit odd...
