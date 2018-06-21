Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450D9C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 14:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F13FC20652
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 14:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JdveT+u/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F13FC20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933018AbeFUOfi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 10:35:38 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35620 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932514AbeFUOfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 10:35:34 -0400
Received: by mail-wr0-f193.google.com with SMTP id l8-v6so3474298wrr.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 07:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t4VOfh5sAizYqId91xNOzZpTi6F6aHOaUbHf8r1ZB+I=;
        b=JdveT+u/PPjaR9xXg/ms369p4l7a7d+NCeufpvHmN4OGschrg+zkzvLNLED/oMEGh+
         VMN5/Csvm4pPG2Fi61Pr4OpvwSyOcdfnvRhaoLh0q+SziorFewFiht/iM97TodamU7o5
         2HkiFrVe6hHPcKrVsjLImNCmFexekuwV7ij2P7PFie4Fy06Qk++FLxKERqE4CQsE0BES
         Ydu8XLRoRmBSO3zkuX+W+66O7vKz0CxtK6r2ZBX1mt8brWNnUvdMapRJlgLSxu7Ne23x
         UoMvnend99NRAciAxB0WduwGwzKfSI7OJHyeU73ZlThEpFhu2kvxrBWh7A+eptKd9Lt4
         ASaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=t4VOfh5sAizYqId91xNOzZpTi6F6aHOaUbHf8r1ZB+I=;
        b=Pmu2qw3Mrd6r3lf6JB3xcv/0ZCbcSun9hUZCwn70n5fOFzl7j6tiZ9t6QwAiR8dY67
         eBeAIIxmy6QMQUVwhdOESyFkQMzYJ7tARvhkbEqLt909gwKlxGz9un9QKZ1kxd5Rt9j/
         EEBW7b/NdzP7kjB4/xNka2yNrmEbZy5HNnkwPKn9TLo/ob16XG8lxUva6GpmejFiXFF1
         1V64Ik6mktZ1SZEh1+X34H0Y34zN9Vbt6M5RfiKpaZtNUsE7ETFNMFCQleqUyFX5UMhn
         CZ5X7J7/D5FwxRiFpylNXzCSaSS+Fev4IRylePjpReehxtbojpVI/VXPdzCqBFObAmjV
         Nr+w==
X-Gm-Message-State: APt69E0mSV6JlO3EnVduV5VVX/JhBnf5j28Paq8PJDEgC7EvKYy9Kv1M
        UGSt7lUOkfPUqOe+HRP1fWA=
X-Google-Smtp-Source: AAOMgpcl0JJ/4/yDlLf9sWdczSGaqCuwLuoH+5+JKoJcrEeVvrOvN0OJEELTKkXe2lAJmk8OfP1DEA==
X-Received: by 2002:adf:b964:: with SMTP id b33-v6mr2031156wrg.265.1529591733780;
        Thu, 21 Jun 2018 07:35:33 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id d4-v6sm1901477wrp.51.2018.06.21.07.35.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 07:35:33 -0700 (PDT)
Date:   Thu, 21 Jun 2018 16:35:30 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>, mingo@redhat.com,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [PATCH v3 1/6] x86/stacktrace: do not unwind after user regs
Message-ID: <20180621143530.GA14228@gmail.com>
References: <20180518064713.26440-1-jslaby@suse.cz>
 <20180518065547.GA18262@gmail.com>
 <20180518224125.w2ty35wngxbzx6kv@treble>
 <20180519074251.GA2952@gmail.com>
 <20180522160609.yppbfdpfoigoyuxg@treble>
 <20180531134642.sl2ezvng2cdsyklk@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180531134642.sl2ezvng2cdsyklk@treble>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> On Tue, May 22, 2018 at 11:06:09AM -0500, Josh Poimboeuf wrote:
> > On Sat, May 19, 2018 at 09:42:51AM +0200, Ingo Molnar wrote:
> > > 
> > > * Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > > 
> > > > On Fri, May 18, 2018 at 08:55:47AM +0200, Ingo Molnar wrote:
> > > > > 
> > > > > * Jiri Slaby <jslaby@suse.cz> wrote:
> > > > > 
> > > > > > Josh pointed out, that there is no way a frame can be after user regs.
> > > > > > So remove the last unwind and the check.
> > > > > > 
> > > > > > Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> > > > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > > > Cc: Ingo Molnar <mingo@redhat.com>
> > > > > > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > > > > > Cc: x86@kernel.org
> > > > > > Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> > > > > 
> > > > > Josh: an Acked-by or Reviewed-by for the whole series from you would be nice.
> > > > 
> > > > The patches look good, but I want to run it through some testing before
> > > > I give them an ACK.
> > 
> > For the series:
> > 
> > Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
> 
> Ingo,
> 
> Any chance this can make the next merge window?

Applied now - will push it out after testing.

Thanks,

	Ingo
