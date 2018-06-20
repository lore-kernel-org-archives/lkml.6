Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF85EC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D20920874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvDE4rtY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D20920874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754214AbeFTPrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 11:47:42 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:38006 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754065AbeFTPrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 11:47:40 -0400
Received: by mail-lf0-f66.google.com with SMTP id i83-v6so39593lfh.5;
        Wed, 20 Jun 2018 08:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=yiGXQiUCXTqJktqyiZ3wObp6FgmgFoOSoUDckcb1BYY=;
        b=IvDE4rtYpw4U2Rw90H/QKfguNWBkolqaX1NJfDaFSBcU169Eyt9vtMmR/2X91PuiiI
         RUy0UNuNtHsSqJDDxqW3SAzv8VP3rdfumiXLUTq1amiAdsVwJPjpNcUKiD+n5wTyvg91
         r9vGoNrUBD/ysCMWhS4RfcqlFMY5HVDzviTlz2iwEzpsb8IqT/bbXIXo829Owz25tgYL
         1a62GdreJ3eNP2JoNHr8/9FYEXa1J8S/d1SLV63yHyo3Uh8Lsb27YJXbnK2WuT6ysn2c
         RhkCK63taLn3Iha0gz1505raizcnYj7ZrOrW7mPNW9NpbSg+5I43HEQvKDGLR5o32XWV
         guDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=yiGXQiUCXTqJktqyiZ3wObp6FgmgFoOSoUDckcb1BYY=;
        b=tW5SHwoShNH6XIle1fzVzb+MkyrBFRhsnDGS5a+guxoXFCBdAor/fMwp83BWkhmktN
         gsJiU4oRmTCSbF817yhHB/k6+Gu9uKHSm24hP3nVil4w1fKDMgqcNMh2Gz3yV2z8T9jo
         RfFNpNud8XCK4GIlkvE+c1i2BuwDkx6KzA7wqbEW/9OcRRsuKRfGW901EJOaBMnbsnEy
         GUwZwF9MGxeAd1mY9ut2pqnALBnwMYh5C7dh4hgn+d1uDqHChurYsLDLLLkXBqyXHzkM
         sKnj0uzWmncZn8p/il+5XTZ/tO3/xYoCVQwMAf4KH2SW2E4G+Kkz+rNqt5yazw1sXD9B
         wC1g==
X-Gm-Message-State: APt69E2jnHXDWEJvTkyQgwxOr+orf22/1qp6oJBXUF5JN/+dvqKtJiEO
        XbkLkFyvPAwxZQm0GSmESZaJHqU/4PQ184IGV8O+nbJD
X-Google-Smtp-Source: ADUXVKL6m9rPRxNXSMBUeFcCtY7iWWytpHvR5GxHu5obwL8DJ+aruGFtrF+199YJCB1gLW298GBBkhDo+mKACzmt2Po=
X-Received: by 2002:a2e:99c7:: with SMTP id l7-v6mr7386526ljj.148.1529509658641;
 Wed, 20 Jun 2018 08:47:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:56c8:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 08:47:38
 -0700 (PDT)
In-Reply-To: <1529488801-22093-1-git-send-email-allen.lkml@gmail.com>
References: <1529488801-22093-1-git-send-email-allen.lkml@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 20 Jun 2018 17:47:38 +0200
X-Google-Sender-Auth: 5yeWryd0yHWalLzSUVGlAVfP2iQ
Message-ID: <CAK8P3a17ui5QuvPzgWmQby0zVcxSKpU_0hbB7_Gdt6i39oo5hQ@mail.gmail.com>
Subject: Re: [Y2038] [PATCH] ceph: use ktime_get_real_seconds()
To:     Allen Pais <allen.lkml@gmail.com>
Cc:     Networking <netdev@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 12:00 PM, Allen Pais <allen.lkml@gmail.com> wrote:
> Use ktime_get_real_seconds() as get_seconds() is deprecated.
>
> Signed-off-by: Allen Pais <allen.lkml@gmail.com>

I have done a similar patch and will post it soon along with the rest of the
ceph y2038 series. Please have a look at "ceph: use timespec64 in for
keepalive" and comment if you see something that I missed.

       Arnd
