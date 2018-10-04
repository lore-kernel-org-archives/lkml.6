Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C910C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 021B72084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="N8vk14G0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 021B72084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbeJDU6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 16:58:09 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45619 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbeJDU6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 16:58:08 -0400
Received: by mail-pg1-f194.google.com with SMTP id t70-v6so3188030pgd.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 07:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qNVC8MrDkQHjY3MSQaWv1TVmONwrni96QU6uW/4bWYc=;
        b=N8vk14G0NRz4K1HsYhmhqf2o7+YzV8xQ9CJ0V8j8PTd6TGNKKV8O2vByuhpqQgveoz
         5QLMoTcFp+dGeAINtv9SVqtiPJJIvmucGSvDQm8n/z4elhO5HJ7GTmTKMq07HsVAnzJh
         8Q5W39S4UmGJ+eocYuBxZv22hENggoMPPk9oH1TRhOwM4MOYtDYh22CNLQO7Uj2North
         lJ/1sARp0lAYnVpQ7pMS5ZcD6SieSHoblIpZhojBSHsPOmT/q5zR4HTItn23EG2XRow+
         h1f24N3nkhtSZ+46SsTMmVhkYGllfr5/gPpQtL/dudoh4gTvPONtV5thQzAe4+qJD8KC
         Y6qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qNVC8MrDkQHjY3MSQaWv1TVmONwrni96QU6uW/4bWYc=;
        b=KtXRVGuPifW18jVCO0P4VBl4xzHblUsVNMC3EyXOddleuz717LOtL4vnXo+7for191
         9Kd9Wfq0x2/38BYwzTxYAOxnQj6MvYioqUx9zlpgSZHgnCoPb8VzpxGtiUjnW0SBI9SL
         zb80jGGCkSQKm5bBLntEjjlPNf/avfJ3/ByPiMc2n9qj3AKpa+bUi+Lk75bP6rCZVIE2
         dmgNO45yrRYMwsZuVgSZvBM7wjTtgg98hIyrGR2kV6s3vQo4jdc4Rd+xyf0faY7xnzJd
         fbdVZnKsbdU0Dqqjr0Y+XsHaqNoskj2JD4i+fiGkGklosob71EJzMwLgun4gNYcle4Mn
         olhA==
X-Gm-Message-State: ABuFfojQn+HtHZGx5k4Z4/5lvN45etKNOK5X2nq5WE7kGZ1V359GCpG9
        Jrkum/XCZH0F8wjNbGjHIUQ1Lw==
X-Google-Smtp-Source: ACcGV62RE6xH6b14Qsum+5ukD3TQ1vgS0Tn7zdixzpm9YzPnYveoa5aAHmpVhHNUTijm9k1m25faZQ==
X-Received: by 2002:a63:31c8:: with SMTP id x191-v6mr5703195pgx.229.1538661881282;
        Thu, 04 Oct 2018 07:04:41 -0700 (PDT)
Received: from ?IPv6:2600:1010:b02c:cbf4:5532:1d8f:efe5:8aa? ([2600:1010:b02c:cbf4:5532:1d8f:efe5:8aa])
        by smtp.gmail.com with ESMTPSA id c8-v6sm6212391pfi.142.2018.10.04.07.04.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 07:04:40 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [patch 00/11] x86/vdso: Cleanups, simmplifications and CLOCK_TAI support
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A366)
In-Reply-To: <1832e2af-3189-cb50-f4b6-45e74cdcf4b4@redhat.com>
Date:   Thu, 4 Oct 2018 07:04:38 -0700
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Matt Rickard <matt@softrans.com.au>,
        Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Florian Weimer <fweimer@redhat.com>,
        KY Srinivasan <kys@microsoft.com>,
        devel@linuxdriverproject.org,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Juergen Gross <jgross@suse.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6FC84115-1FB9-4386-86EE-71A8A53EA0F7@amacapital.net>
References: <20180914125006.349747096@linutronix.de> <CALCETrU+jP2hPLoJWTYJKTvr7-=YLwtk1=cZ_uizHYQZ1z4P-w@mail.gmail.com> <87sh1ne64t.fsf@vitty.brq.redhat.com> <20181003190617.GC21381@amt.cnet> <87k1mycfju.fsf@vitty.brq.redhat.com> <1832e2af-3189-cb50-f4b6-45e74cdcf4b4@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Oct 4, 2018, at 5:00 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
>> On 04/10/2018 09:54, Vitaly Kuznetsov wrote:
>> - Check if pure TSC can be used on SkyLake+ systems (where TSC scaling
>> is supported).
>=20
> Not if you want to migrate to pre-Skylake systems.
>=20
>> - Check if non-masterclock mode is still needed. E.g. HyperV's TSC page
>> clocksource is a single page for the whole VM, not a per-cpu thing. Can
>> we think that all the buggy hardware is already gone?
>=20
> No. :(  We still get reports whenever we break 2007-2008 hardware.
>=20
>=20

Does the KVM non-masterclock mode actually help?  It=E2=80=99s not clear to m=
e exactly how it=E2=80=99s supposed to work, but it seems like it=E2=80=99s t=
rying to expose per-vCPU adjustments to the guest. Which is dubious at best,=
 since the guest can=E2=80=99t validly use them for anything other than sche=
d_clock, since they aren=E2=80=99t fully corrected by anything KVM can do.=
