Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911EEC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 14:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F168223FF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 14:20:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F168223FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbeHJQua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 12:50:30 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39511 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbeHJQua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 12:50:30 -0400
Received: by mail-ed1-f67.google.com with SMTP id h4-v6so4867548edi.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 07:20:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=pa7FxmbHRRU5r+3YlrzOB2oMF5izfnuxuL2q1fIAuZQ=;
        b=Xs8YNuslNSvGtDKJRJm+OcuLdtS42oBevjRY1dief21eg9Amv2z/XtyiAnLXam0Y0E
         MFJvVptRy77SAgHpVpXm83n3eCWkyZEnEEFg6vUuIL0gYc73TFMDziArGZK/pJ/PPFmD
         wFAlspW1dlNVT/TtSBVIhI4nL5ziDv3zAtD+JbsawxKJx37cVx/FGLU0LwIekxwE9bK+
         p5+LxnP0OX6PTxy3d9e+TrfImlpzcFDJB2KQe/fTodzb9qXUCMkG/wTdlGdAEAKQ9Fny
         ArHlfoxhie2EIWj7k0Wo1+DryqqDDmJH/QOeHib6EQewBTctozllD+QsJCDvsLPDVYbf
         pCYw==
X-Gm-Message-State: AOUpUlGiVH3CMtYh2kioiqAIfItiXMJqs6+ye8OVRCLy+hRMbgFbJajD
        wBntrkP7ulvPICj2wjo4tNcYJ5CXAOY=
X-Google-Smtp-Source: AA+uWPwli7EICCLY2xUissqoNZVlTeUSBZwtAhxH+IhouQuq9vUlZri/Ya5zZi4VJtfSk8AlF8K0eQ==
X-Received: by 2002:a50:ccdb:: with SMTP id b27-v6mr8687949edj.98.1533910822614;
        Fri, 10 Aug 2018 07:20:22 -0700 (PDT)
Received: from mail-wm0-f43.google.com (mail-wm0-f43.google.com. [74.125.82.43])
        by smtp.gmail.com with ESMTPSA id h8-v6sm3963010edi.68.2018.08.10.07.20.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 07:20:21 -0700 (PDT)
Received: by mail-wm0-f43.google.com with SMTP id y9-v6so2105620wma.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 07:20:20 -0700 (PDT)
X-Received: by 2002:a1c:4182:: with SMTP id o124-v6mr1610363wma.101.1533910820744;
 Fri, 10 Aug 2018 07:20:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180810133636.8340-1-efremov@linux.com> <alpine.DEB.2.20.1808101541270.3390@hadrien>
In-Reply-To: <alpine.DEB.2.20.1808101541270.3390@hadrien>
Reply-To: efremov@linux.com
From:   Denis Efremov <efremov@linux.com>
Date:   Fri, 10 Aug 2018 17:20:09 +0300
X-Gmail-Original-Message-ID: <CADKZ3FLsksV8-cCE6aOnZnLbYj3SSAkPnMs_VRQB3g0V3mUYcg@mail.gmail.com>
Message-ID: <CADKZ3FLsksV8-cCE6aOnZnLbYj3SSAkPnMs_VRQB3g0V3mUYcg@mail.gmail.com>
Subject: Re: [PATCH] coccicheck: return proper error code on check fail
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Do you mean that there is an error in the behavior of coccicheck or that coccicheck finds an error in the source code?

An error in the source code.

Here is an example of how the patch changes the behavior of 'make
coccicheck' (my comments after the ###):
Current behavior:
$ make M=mymodule coccicheck
mymodule/file1.c:97:4-14: ERROR: Assignment of bool to non-0/1 constant
mymodule/file2.c:104:4-19: ERROR: Assignment of bool to non-0/1 constant
mymodule/file2.c:577:1-15: code aligned with following code on line 583
mymodule/file3.c:439:5-10: Unneeded variable: "error". Return "0" on line 449
mymodule/file4.c:451:5-7: Unneeded variable: "rc". Return "0" on line 455
mymodule/file5.c:433:5-8: Unneeded variable: "ret". Return "0" on line 607
mymodule/file6.c:433:5-10: Unneeded variable: "error". Return "0" on line 440
mymodule/file7.c:774:2-3: Unneeded semicolon
coccicheck failed     ### <-- Check failed
$ echo $?
0 ### <-- But error code signals that everthing is OK

After this patch:
$ make M=mymodule coccicheck
...
coccicheck failed
make: *** [Makefile:1636: coccicheck] Error 2
$ echo $?
2 ### <-- The patch changes error code

Why does this matter?
1) Because it's clear from the source code that the original intention
was to return an error code of checking command, not the "echo
'coccicheck failed'" command.
2) Automated testing systems (CI, for example) rely on the return code.
