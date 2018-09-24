Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45921ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 012C02086B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/3/VOMV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 012C02086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388016AbeIYBCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 21:02:42 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:35715 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727665AbeIYBCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 21:02:41 -0400
Received: by mail-lj1-f177.google.com with SMTP id p10-v6so19284525ljg.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 11:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/A94Ts3MbIRFIPdjR6j7rabHQCsko9Y0DmTiH278bd4=;
        b=R/3/VOMVmACgpcwZj7UFWURWoLIZ9igeFjvozoSz0q/9NLmurAHSgD9rbndAH+pRux
         DQvOKZ29A1DIPAkovgS90ileqsoy/b4dQQAhVdV8gnz0ho9NTpc/0dF0vN80+mflB/MT
         oMl0TA81AT8osu8+PJb7jzSDnpzeXbJZuNRotm62rfrPR5C000imkpMTBmm15yndQdzb
         CQxX7DdCg2B6ZTvR2WLX6uLeSH/NBnOa0IvPDD5btr6xJB2chV6AZQdykBFgwYm1YeKC
         oAbayRVyDaUgXz5sKQvzEGvtGyocTrk/AR+Dw+CVqxPRtKj7CrpCMMH9nHHWEu2/cmA+
         gu7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/A94Ts3MbIRFIPdjR6j7rabHQCsko9Y0DmTiH278bd4=;
        b=UHBiNxRCh6XNdQYmsSzMKeNeHKCYgjEeHG/6JmTslbW1/p/G+sbENlxmaK/bANhM4D
         UwxILo1ovJvHWENVdSfcZ6DEji9hG2oBiefL2wypllYgu5BoYs/FDvrj39gC4++GWVuB
         /c960+gY1ra4uPdMttyX9LQp2KpaiSP1DooIcjLRhvUbnl677ws+zzD3aMWzQ297ZKz7
         etaUCbeP+OwcKv5a0xPr86XjX4ErY0/41puLTpxqRu/Kws91/IfP0S4EZpbDmsY4BxmH
         aIBLfA71EnHZDcl2dr+5qL6ccogzle0dt1jvYiCwoW0ngHWuUpnwiFiQOORPk74T/2tF
         RkTA==
X-Gm-Message-State: ABuFfohsiSOgZ72Zq4XtHjt35s47cDJSpkO6vlWnROguhh2iW85+liPB
        hG8FdJt0BRMrn88b3I0B614GG5CLq6gsNL6lgM0=
X-Google-Smtp-Source: ACcGV61LEya9RuSuQHN+JjYIGNBEJLEkYXuBy0K8Wc3fogee+icqrY0DGQb3dcWfwspaDaey7Rad6PbJd61uTd5lnpY=
X-Received: by 2002:a2e:82c9:: with SMTP id n9-v6mr112620ljh.111.1537815546235;
 Mon, 24 Sep 2018 11:59:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:278e:0:0:0:0:0 with HTTP; Mon, 24 Sep 2018 11:59:05
 -0700 (PDT)
In-Reply-To: <d364f33b-fbb4-57e0-78f5-302cd5c9050f@petrovitsch.priv.at>
References: <e223b198-af0e-123d-49bf-fad7e0f9126e@cantab.net>
 <20180919081812.020f19e3@lwn.net> <72dadc76-44fe-ecb5-e142-0a9129082c93@cantab.net>
 <CAOesGMjgo5zwKvsbi8txGQbvFHR2N7xKphzhTSGOrruN3+RC-Q@mail.gmail.com>
 <93b77a9a-12c3-6f7d-d2c3-0e0d7875a28b@cantab.net> <589966d9cd0ddccc88f33fcb7975bb4464be7696.camel@surriel.com>
 <87zhwbj8xe.fsf@redhat.com> <CAMjeLr-mWag=iO=CoNHeK9pkCu4y6vZUp03_zpJOG+e=n85j+g@mail.gmail.com>
 <20180921231545.GC2966@thunk.org> <CAKON4Oy3=7H+9WxzK-xK=T7t7rN7L3_PsJ+cdUWTjiKN=BGSRg@mail.gmail.com>
 <d364f33b-fbb4-57e0-78f5-302cd5c9050f@petrovitsch.priv.at>
From:   "\\0xDynamite" <dreamingforward@gmail.com>
Date:   Mon, 24 Sep 2018 13:59:05 -0500
Message-ID: <CAMjeLr-a4cCrs0cF0aBRoeeXXLwiM835BXqhP9ZoeLB8=w=YKw@mail.gmail.com>
Subject: Re: Code of Conduct: Let's revamp it.
To:     Bernd Petrovitsch <bernd@petrovitsch.priv.at>
Cc:     "jonsmirl@gmail.com" <jonsmirl@gmail.com>,
        Theodore Tso <tytso@mit.edu>, fche@redhat.com,
        riel@surriel.com, ec429@cantab.net,
        Olof Johansson <olof@lixom.net>,
        Jonathan Corbet <corbet@lwn.net>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> * Publishing others=E2=80=99 private information, such as a physical or
>> electronic
>> address, without explicit permission
>
> I need an (explicit) permission to "publish" an already published email
> address which is already world-wide known because it can be found by the
> simplest and worst search engine as the email address is in public
> mailing list archives and git repos?
>
> Sounds pretty absurd as the people themselves already published their
> email address.
>
> IMHO you cannot "publish" already published stuff.

The notion of being "published" means at least these two things:  1)
you INTEND it to be PUBLIC, 2) you made it available to the PUBLIC.

A semi-private email list is a boundary area of being public.  Just
like a memo distributed within a university department.  Participants
in the latter have some reasonable expectation that the material is
not being published in the larger public sphere beyond actions of the
trusted participants involved (which might share it in a limited
fashion as a personal note).

So, is code a *published* item?  Most of the public can't read it.
It is often not intended for the public, per se, only a specialized
COMMUNITY.  Because once published, it belongs to copyright and fair
use (THAT sticky little wicket).

Mark
