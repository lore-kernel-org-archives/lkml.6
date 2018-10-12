Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80ADC71122
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 19:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2CF22147C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 19:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WLP2DKZo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2CF22147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbeJMCfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 22:35:16 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:37609 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbeJMCfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 22:35:16 -0400
Received: by mail-yb1-f193.google.com with SMTP id h1-v6so5310381ybm.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 12:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SV1l6xGR0dH7KR9WlPOaU/bxiRwjWoygMAKTjMPmH00=;
        b=WLP2DKZoVXREMElMyoDQ9Mgwy5nTWtF75q946kO2NOd58IwNFh4fUsntFAlt7QrWME
         pWTs66GZF+kvgDnZBvOxPA41Dw0j2+TypN84k3ws6WpEc0TDvwzld7Ha5b100UoMlulU
         Cc7CyPlAmaRYgCHrZNCs4VnZ23MuDNbjklGQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SV1l6xGR0dH7KR9WlPOaU/bxiRwjWoygMAKTjMPmH00=;
        b=L/DAjGMa1z/t/4D/UeSTd4HXkEZ+J+bGJCczZgkMWpEWLU8+/lehXxIVNZLTCKZ82l
         rGgSK5TIARkdp6tD6HpwA6jWejcYlj3U+MYn8bA1ejG9st8Eo/cpIxsI77A/Eb2rIGgk
         +sw7QVJXFT+EdSS7jtWbt/6eM2Tgf7OrFTPETTXstIgWkImXLs4ndNFEAumDhnZhu/T+
         lGkgilKscUuDFxu/1+w4uOW3TiNKJO6kVEDdYXLc+4GC8a7j957oQX76uMuJgqKbwvL8
         OthPosgU+sEcRr/CPvh6bepV03KqDKtcEj/cnqCh283ksVtAX4R1n/wqPuMqZM4gB8+9
         K7lA==
X-Gm-Message-State: ABuFfohM8fKpZ97OM0l/lAHFvUO3XzXBz02d7g+eV9MORO8W6bIyFa+u
        gOC8HR9m8Mtfu6TwfyV6k71uKPmPrzY=
X-Google-Smtp-Source: ACcGV63vNeo7WUsbuNgZv1+2h+BLnreS/qePCyABP9BciezsRVC/fVCVunWR+EBbfbYMOgP2yMiAeA==
X-Received: by 2002:a25:ba0f:: with SMTP id t15-v6mr3822577ybg.334.1539370881802;
        Fri, 12 Oct 2018 12:01:21 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id s15-v6sm19483ywa.62.2018.10.12.12.01.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 12:01:21 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id w7-v6so5307106ybm.7
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 12:01:19 -0700 (PDT)
X-Received: by 2002:a25:3617:: with SMTP id d23-v6mr4152480yba.141.1539370878865;
 Fri, 12 Oct 2018 12:01:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Fri, 12 Oct 2018 12:01:17
 -0700 (PDT)
In-Reply-To: <8251564f-ba7a-1777-a606-dec472b32f35@canonical.com>
References: <20181011001846.30964-1-keescook@chromium.org> <CAGXu5jLBaHj5MhXaK-8zdu6Rgo2B6rEq+at17xZ1Puct+YUajQ@mail.gmail.com>
 <ZhaXhoElmWQlsxHmgFHpB2xSWzJYFZWBasrSKQNjGj4_T2A4AY2F9v1rP9LkUfilUbZ0ExWXX9koLNjUM8S6baX6xfSSMPXY_CpihbCetVc=@protonmail.ch>
 <CAGXu5j+kekUdcE2EhUu__8MXJ1O+D=-zTXLGNCRVa_VyDxePpw@mail.gmail.com>
 <f68e5f4b-6360-a9e7-597f-89d1d3ca73c1@canonical.com> <32stV62RmME8Dj5jKB8Z03zPe_Et72kMo71D8SpgSOHUo6SaROc8DomMWdk5jDGpyqVd8T63NIIK2NdDw95clpF8Uj47Wca2FBFItXDRh7E=@protonmail.ch>
 <38dde301-d77e-35fd-88d4-5cdc5b570ee8@canonical.com> <_CkJnKYmEZ4ZF0JtsSYuahAd9sgnX9OtcstjXaeqb8wn5uxfimc6S4jomly7If9VqnOXqXwaiCbJ9ttS6NiqE7n6cQUlwLvfO53paLmacvU=@protonmail.ch>
 <8251564f-ba7a-1777-a606-dec472b32f35@canonical.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 12 Oct 2018 12:01:17 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+2yVZ5DQHyqvJKnSYYqRCzeMtEabBwYFOWkTcwMUWhEw@mail.gmail.com>
Message-ID: <CAGXu5j+2yVZ5DQHyqvJKnSYYqRCzeMtEabBwYFOWkTcwMUWhEw@mail.gmail.com>
Subject: Re: [PATCH security-next v5 00/30] LSM: Explict ordering
To:     John Johansen <john.johansen@canonical.com>
Cc:     Jordan Glover <Golden_Miller83@protonmail.ch>,
        James Morris <jmorris@namei.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        LSM <linux-security-module@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, October 12, 2018 3:19 AM, John Johansen
<john.johansen@canonical.com> wrote:
> It isn't perfect but it manages consistency across distros as best as
> can be achieved atm.

Yeah, this is why I'm okay with the current series: it provides as
consistent a view as possible, but leaves room for future improvements
(like adding "+" or "!" or "all" or whatever).

I'm curious to see what SELinux folks think of v5, though. I *think* I
addressed all the concerns there, even Paul's "I want my distro
default to not have extreme stacking" case too.

-Kees

-- 
Kees Cook
Pixel Security
