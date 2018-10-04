Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982EEC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5194721470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:39:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5194721470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbeJDPcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 11:32:04 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40207 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbeJDPcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 11:32:04 -0400
Received: by mail-ot1-f68.google.com with SMTP id w67so8356697ota.7;
        Thu, 04 Oct 2018 01:39:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=axIFo+cUgSvH1vO5kg9LM4Taav9GMLA9ueuh1F6HlKs=;
        b=CE6lvrW3kzxt1iaZljbfNVLQ6qHQMNVEEI2KXncN59N5p3xeaaetCy86GwEiZOYkC6
         Wo9qkVE+uu9fAJXI/4wXH/RZJx6y58e9VN062IIh+Rm/bN28P5coLelu/YH/3kKtVsm9
         rcvydVJF88xkskM4wOTNCib5ntZOpdaBL2XO33dRqu7Kb64d1YXE5jeRFeavhbFMNNVO
         Ijuhjn0svLYzhyR4f5aHmahJqrQCls7Fv1HTpxcmgU4MUM9KGieovXPPIOwtXvU5gYyc
         rICvd45xQVChMRb7Bju/2ahXnHFB17LDmmWkFARlU1pdrvgWXlbsNT1yLbWFg+PXk+rT
         FoWQ==
X-Gm-Message-State: ABuFfoj4GO69Y8n8Hgl9yIg1B6hCNsUtBKcpbAou+4q4fRxdQfjtImBF
        QdfmElBYUf16/3EMBjoJUjKCmhkk0UJWBhWVfPw=
X-Google-Smtp-Source: ACcGV62gYrcAYdXmoXp8KaUL3IIKvrIvnpySbLXp80gTK41jfj520ie0I6heDJuMrvVrdECRSIU6BtnbPlsaY37Osb4=
X-Received: by 2002:a9d:7594:: with SMTP id s20-v6mr3205449otk.258.1538642393801;
 Thu, 04 Oct 2018 01:39:53 -0700 (PDT)
MIME-Version: 1.0
References: <20181003143824.13059-1-ulf.hansson@linaro.org>
In-Reply-To: <20181003143824.13059-1-ulf.hansson@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 4 Oct 2018 10:39:42 +0200
Message-ID: <CAJZ5v0h7jvoa4oUeM4FgFizF_jbAonoAgP3m417n_TGqfqNsqg@mail.gmail.com>
Subject: Re: [PATCH v9 00/11] PM / Domains: Support hierarchical CPU
 arrangement (PSCI/ARM) (a subset)
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 3, 2018 at 4:39 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> I have digested the review comments so far, including a recent offlist chat
> with with Lorenzo Pieralisi around the debatable PSCI changes. More or less I
> have a plan for how to move forward.
>
> However, to avoid re-posting non-changed patches over and over again, I decided
> to withhold the more debatable part from this v9, hence this is not the complete
> series to make things play. In v9, I have just included the trivial changes,
> which are either already acked/reviewed or hopefully can be rather soon/easily.
>
> My hope is to get this queued for v4.20, to move things forward. I know it's
> late, but there are more or less nothing new here since v8.

I have no problems with the first three patches in this series, so I
can apply them right away.  Do you want me to do that?

As for the rest, the cpuidle driver patch looks OK to me, but the
PSCI-related ones need ACKs.

Thanks,
Rafael
