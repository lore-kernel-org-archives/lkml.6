Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31CAECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D84A20858
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KeFidf8n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D84A20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730828AbeGQQeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:34:13 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:44121 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730172AbeGQQeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:34:12 -0400
Received: by mail-lf0-f66.google.com with SMTP id g6-v6so1217865lfb.11;
        Tue, 17 Jul 2018 09:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=krAqb8Hxy6FrwhIjRa6kpTXqsVbYZrOvkRRhmcLdnO4=;
        b=KeFidf8n/dlQZrCdyBix2FrdOYkW50k8PO3ZpCM8YnV7QY5XPZVQs4x7EtTnvVeOia
         NEMqlOzPzoLNGrNlf59pa35cYgu8El+nB8XJ/I306MqQnzpVnqplkBdCX1ooREhUUyoK
         S53a4+bN31hHswQYAdAW985+z8nP+yyvYfw7Jno1A0CrNvgx/pNuTOhNAoxJJn/myb5U
         JezYkaFA76y2iQoTKfqsJAInNpQh07fXcJg9nMywPT0JOFyJBCGMmYMU+7qMmVbw/Qtq
         b02WxCfWaNt3/qJJexWm2bZRrLGevSgAmVag/2oqp7rUa5i+V5/aK0sYTsfdRuK0nlF2
         B7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=krAqb8Hxy6FrwhIjRa6kpTXqsVbYZrOvkRRhmcLdnO4=;
        b=P6Ia3r+m8JfaSrrpkZq9Q6JdNJl3pbXspz829TYoWaimq0ecrZgWQgS2QFeseHZ0Jx
         7sShfSvtgbnPi0RPzZFZl0sVhDSS1ZX2mqnABOmBnKXkAgRti/Kkv2bigUAlwX5JcFpN
         WtwcKCRlGCSAdEEKRtL2uIx5TrWog5kXbrGeopa/xUKUuQfrcdWOCcenlddUi3cVIy4Q
         zlfajdmj7UttJx1bVPZe3Y9LSxb2F5EKBLAUP2djJHqFQhdx2Xf3GoZOlwR1ab/3Ut0T
         Z3lvfsPd3BFFQUnDa7v/H8EV428M4zwpLl1zVKL/jzpPX3gXHETMfLoMg4SJED3D8oum
         yphw==
X-Gm-Message-State: AOUpUlHIEBb9t2uZO0+aT53k71UODYxSNjAuLnrmJnyuGun/w6mXx9xQ
        GNLTceAb4J1uZ0tw7yzy9OvDaSX+0B+IkcJ15h0=
X-Google-Smtp-Source: AAOMgpc5/ItulneW3JY4Cy7P5gh/6+AJ2wOH34nDZFabudnj02NRdZs66TNrUkgwEpU/LdCgRPt5ekO6b1A/2LCFlzg=
X-Received: by 2002:a19:ea5c:: with SMTP id i89-v6mr1623813lfh.19.1531843251029;
 Tue, 17 Jul 2018 09:00:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 09:00:50
 -0700 (PDT)
In-Reply-To: <f1cc2710-2bd5-4a55-1a40-67cb2f4e0798@nokia.com>
References: <20180717134756.3447762-1-arnd@arndb.de> <f1cc2710-2bd5-4a55-1a40-67cb2f4e0798@nokia.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 17 Jul 2018 18:00:50 +0200
X-Google-Sender-Auth: Pz323a31XC0CK6BpcoWG7j4qWGQ
Message-ID: <CAK8P3a2ZnATY2ZgcV6bDz0bxNhvU3FQCJ5RdNVpanmo5CBy6zw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: cavium: add missing PCI dependencies
To:     Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Aleksey Makarov <aleksey.makarov@cavium.com>,
        Radoslaw Biernacki <rad@semihalf.com>,
        Felix Manlunas <felix.manlunas@cavium.com>,
        Sunil Goutham <sgoutham@cavium.com>,
        Vijaya Mohan Guvva <vijaya.guvva@cavium.com>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 4:31 PM, Alexander Sverdlin
<alexander.sverdlin@nokia.com> wrote:

>> @@ -35,7 +35,7 @@ config      THUNDER_NIC_BGX
>>       tristate "Thunder MAC interface driver (BGX)"
>>       depends on 64BIT
>>       select PHYLIB
>> -     select MDIO_THUNDER
>> +     select MDIO_THUNDER if PCI
>>       select THUNDER_NIC_RGX
>>       ---help---
>>         This driver supports programming and controlling of MAC
>
> I believe this hunk should look exactly as the previous one, i.e. 64BIT && PCI,
> BGX itself depends on PCI as well.

That would work as well. My approach was to allow compiling that driver
with PCI because I got no build failures other than the MDIO_THUNDER
issues.

> I've actually sent v2 to fix the above, but got no reply on it up to now...

Your patch was applied into net-next already, so you need to send
a fix relative to your first patch rather than a replacement.

      Arnd
