Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C96AC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 19:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C832D20663
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 19:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551037551;
	bh=gkoetyKKtrcsSAwt0R49llWeAXh/gqNtg+z9C+/LStM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YWYBoh4v/xaGYfj3aIcTLT3Sq6HQGPAvlA6N2fD8UaRefz9ZLSy4/RygNeCqe9w/t
	 6xkbb54VE+XnRwyaJ1XgAcEfgx7rfhoV4EPnY9JhD4pbYxalRAnIyv+y9sB8AUobq8
	 91iDf4LL6zE4mdYNED48LvGZ+I0TcQbdqZV6I1fQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbfBXTpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 14:45:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:53156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727909AbfBXTpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 14:45:50 -0500
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7414220989
        for <linux-kernel@vger.kernel.org>; Sun, 24 Feb 2019 19:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551037548;
        bh=gkoetyKKtrcsSAwt0R49llWeAXh/gqNtg+z9C+/LStM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=alJZ0BEl5cBq1zj8Z2RwSgjChK2413fcq/GRXQbblvzgBGkpMP2NXsc2CGz9vwom0
         /C2cDmQTIxW22KpBqKt1Z4xnMkEEvqhwnYfxtY1IrSp9ySJ0KXh+cyIziIkEotHAL3
         OwoDnTu+5V0V181+/ZOVJzZQBLnxpcyixu+mB4oQ=
Received: by mail-wm1-f47.google.com with SMTP id x7so6154048wmj.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Feb 2019 11:45:48 -0800 (PST)
X-Gm-Message-State: AHQUAuaGXv2MR2WtDV8A3PzcSOtaB0+jlozoQPP6NpLzyrW9d/ivM9cq
        XjuJF1NB5ZU8dErTqoRzECK5z/OdTGZNhOgmVea6zw==
X-Google-Smtp-Source: AHgI3IbAyZS9ZeMVPG65nDERFoRqxkEn3RJNDKAySa7HBeI6mPFBRaddsyDa0eRyECtfn225g111AvrhyuSa5pNX+sg=
X-Received: by 2002:a1c:9ad3:: with SMTP id c202mr4032919wme.83.1551037546852;
 Sun, 24 Feb 2019 11:45:46 -0800 (PST)
MIME-Version: 1.0
References: <1547673522-226408-1-git-send-email-fenghua.yu@intel.com>
 <1547673522-226408-6-git-send-email-fenghua.yu@intel.com> <CALCETrWCJAzRj7BUBX=O2qdHXucNWz=z0uEQ5asskTbw8CGW5w@mail.gmail.com>
 <20190221192424.GA158428@romley-ivt3.sc.intel.com> <3E5A0FA7E9CA944F9D5414FEC6C712209D877F3A@ORSMSX106.amr.corp.intel.com>
In-Reply-To: <3E5A0FA7E9CA944F9D5414FEC6C712209D877F3A@ORSMSX106.amr.corp.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 24 Feb 2019 11:45:35 -0800
X-Gmail-Original-Message-ID: <CALCETrVJsCAWYSnUE+Ju_VmZfZBUBwUq-uFjV9=Vy+wddtJVCw@mail.gmail.com>
Message-ID: <CALCETrVJsCAWYSnUE+Ju_VmZfZBUBwUq-uFjV9=Vy+wddtJVCw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] x86/cpufeatures: Enumerate user wait instructions
To:     "Yu, Fenghua" <fenghua.yu@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>, "Xu, Tao3" <tao3.xu@intel.com>,
        "Liu, Jingqi" <jingqi.liu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        H Peter Anvin <hpa@zytor.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 2:57 PM Yu, Fenghua <fenghua.yu@intel.com> wrote:
>
> > From: Fenghua Yu [mailto:fenghua.yu@intel.com]
> > On Wed, Feb 20, 2019 at 10:37:27PM -0800, Andy Lutomirski wrote:
> > Or to simplify the situation, how about we still use zero as global max=
 wait
> > time (i.e. no limitation for global wait time) as implemented in this p=
atch
> > set? User can still change the value to any value based on their usage.=
 Isn't
> > this a right way to take care of any usage?
>
> Plus, if scheduler timers works, umwait will be forced time out by timer =
in HZ anyway.

Indeed.  But, on some configs, the scheduler timer intentionally will
*not* fire.

>
> Only for case without scheduler timer, sysadmin may need to set a small m=
ax umwait time to force timout. But in this case (real time), I doubt user =
app really wants to call umwait to save power with long latency of waking u=
p from umwait. So likely in this case, user app won't call umwait and there=
 is no usage to set a small value for max umwait time.

I don't really know why an application would use umwait at all.  About
the only legitimate use I can think of is to treat it as a somewhat
power-saving variant of REP NOP.  What I want to avoid is the case
where it works dramatically differently on NO_HZ_FULL systems as
compared to everything else.  Also, UMWAIT may behave a bit
differently if the max timeout is hit, and I'd like that path to get
exercised widely by making it happen even on default configs.

So I propose setting the timeout to either 100 microseconds or 100k
"cycles" by default.  In the event someone determines that they save
materially more power or gets materially better performance with a
longer timeout, we can revisit the value.

--Andy
