Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,GAPPY_SUBJECT,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B6CC04AB8
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 00:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11B362086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 00:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kflDmLcD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11B362086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbeINFPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 01:15:02 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:38512 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbeINFPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 01:15:02 -0400
Received: by mail-yw1-f68.google.com with SMTP id n21-v6so1938387ywh.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 17:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PGMyLGOKWFCdq4C7vfGyO1VxcUIAuRD+Go9wY1N8Vjk=;
        b=kflDmLcDLbEQmpAQ4DIez7lAhxb5heBlFmEfpPQDJA+Smz9G/33Vgz76x6trCobSiC
         6QWUOB94Cavb2k2LuFySt1u6+dQ4gQpnG5JYSkWWdVpPYTFcxHOda4I/1mx2UQU9TVUS
         C1mEAUvg/d38nFZAP/YTcmj8PBEufaIq0Zuiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PGMyLGOKWFCdq4C7vfGyO1VxcUIAuRD+Go9wY1N8Vjk=;
        b=p6yNZ1p81b+TVVcvqbmg+saMYbYlBv2SfrMfnJFptazpBFk/EN5vPw+hY1uLb9g8v3
         +Bo6auIPoJ7kKVPYjUMbKG/lRo5ZnjXmWFpMA4pDUXH5QFDSnsRyBUxMBZnkYO+VMuqR
         kyZLn1qaOYd02zZRCGNVCt/S07+awqcgPfPG/RTfMm1AEJKwtpeE581M4D30HJsl6Iis
         vDKgpc1B3se6IwxxxEL6+zMoV79DC6jwVWoP6Js6Kq72DF2kWZvRXf3pqGAmEMuPqgbK
         sNc17AIkE0igWvF4aVG1d8vPrgSzMg1nAP4eEvNSGgBpsrU+VesF816A7Ok7SxYTaUUQ
         vxmQ==
X-Gm-Message-State: APzg51A9eUIIRpGTORI42fVJB9qdNExHFlm1wewKealCJaCKZzgavNMN
        KlsWrQ8rr6h1049epavIjIdfxCLW+zY=
X-Google-Smtp-Source: ANB0VdY6Hpch+XhASjvTujm4eoa4KgIwMGSv7JdVhRBbXrMauSYxz1mBgE7nWSWjXLfFPdytbkY8Gw==
X-Received: by 2002:a81:4e17:: with SMTP id c23-v6mr4774240ywb.229.1536883395965;
        Thu, 13 Sep 2018 17:03:15 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id l69-v6sm1882772ywe.40.2018.09.13.17.03.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 17:03:15 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id k5-v6so4052104ybo.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 17:03:14 -0700 (PDT)
X-Received: by 2002:a25:e5c3:: with SMTP id c186-v6mr4602818ybh.209.1536883393169;
 Thu, 13 Sep 2018 17:03:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Thu, 13 Sep 2018 17:03:12
 -0700 (PDT)
In-Reply-To: <d1d12866-d557-8c15-6506-a54b9d927952@schaufler-ca.com>
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
 <99cb1ae7-8881-eb9a-a8cb-a787abe454e1@schaufler-ca.com> <CAGXu5jLONSfPHYYYTLSma-+arVHSQKaEWb9JxpOn6TNKtyLNhw@mail.gmail.com>
 <CAHC9VhQN0wq0zZS5BYU9jBomaWvCaJ_BqJjHF3AT7FG8Z0nLDQ@mail.gmail.com>
 <CAGXu5jJs6kmd6Tjgwqb2Zx7e-jNbHqfJ57poZuyz4Qj=AKVfmQ@mail.gmail.com>
 <CAHC9VhQ20tBAMwOJ9mg0tBHYUoxjh0Szr3d62HuPw2SyT4XDLw@mail.gmail.com>
 <CAGXu5jKec1JTsoqwKGThcJoamdL618AHu4jfFbqqQiauz1kjyg@mail.gmail.com>
 <CAHC9VhQwT4d3wC37cVrrX-hZq1L3e6=TEAse4m-YH9SiFnkieA@mail.gmail.com>
 <CAGXu5jLapViSK-j08Tq8cCZodiZXFsXze71xFPg6MQhDWDHDAA@mail.gmail.com>
 <CAGXu5j+j47FH5RF2vrJh95=YFX76oSBFo8O6GZqa0utcfE1AVA@mail.gmail.com> <d1d12866-d557-8c15-6506-a54b9d927952@schaufler-ca.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 13 Sep 2018 17:03:12 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKpq3z5e+SE+oRsfatUB02cFb7SOwixueSJhXiDxrq31g@mail.gmail.com>
Message-ID: <CAGXu5jKpq3z5e+SE+oRsfatUB02cFb7SOwixueSJhXiDxrq31g@mail.gmail.com>
Subject: Re: [PATCH 10/10] LSM: Blob sharing support for S.A.R.A and LandLock
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 4:51 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 9/13/2018 4:06 PM, Kees Cook wrote:
>> If security= is
>> specified, all other major LSMs are disabled (i.e. it is not possible
>> to switch between SELinux/AppArmor/SMACK without also disabling
>> TOMOYO).
>
> Correct.

If we assume patch 10 is the way forward, how could we go about fixing
this specific problem?

-Kees

-- 
Kees Cook
Pixel Security
