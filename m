Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56940ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16BCB20684
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMCssMWN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16BCB20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731140AbeGQS1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 14:27:21 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43760 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729709AbeGQS1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 14:27:20 -0400
Received: by mail-ed1-f68.google.com with SMTP id b20-v6so1931454edt.10;
        Tue, 17 Jul 2018 10:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=41Z91/MXjfQHcAVCDW1mkadMZC7WIDawmTrHG8kyZMA=;
        b=IMCssMWNAOgslx8a89M7fHFUGRcOp0Puc+cKsKkvLrKHmNib93MlpxBiSrDmHW5H7u
         0WBI+D4CWCGlB29Txz8M8balJ+Dj1FRMRmQ1VcydYn+UsOwmUUKVUhoYXsmFG4yjOVqO
         q66X8AcAkHcKfB07b9pfrtMCQw70QLvsRBJCymHUE1rbH45mCZPN4atEgsKlyS3nHIMY
         ybIZRw9kbeQGf8t0ad7OSwz2GUFwzZsKsNAuqiN7SoXpTUl/nuAw6Rg6BadHcHFeYBxb
         +YDIN5x5X9rQdt3R9vsolBsStVGGEO4j+Z+qE6dTtPVvktoPAq5Cf/soisz0mJt91Cj8
         TS3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=41Z91/MXjfQHcAVCDW1mkadMZC7WIDawmTrHG8kyZMA=;
        b=Aga1g/9Zz0gMUKQ5JZ0abfpTRINrZX6+W7O9/bByADQWWRl7ruKimH8C7NYruWO4Tx
         1oFdFB4J18ee7ANdu0N/ynVG82v2fmYnNkCLgktyKr/4iDIkhKBbwj5U/w3PXD1UEH8R
         +m7KN1hny4zOk8N8/gcgmsbFlso0FMQuZr8biblz/YPLsixXP5b25CeTG2GXZ09ueeG1
         k3sjzZOS9A4Y+e1rrPbjc1AhpZZ4/V4LdadPhoZq5NDIeAMt556XiT/bRYkA8sf8hdcH
         gpcFZuEdVejallR+bYuEzMtReEa9GVhHLGk0afj2G0ej+PkuPsDjltDGWQIU5b5Z8qm9
         pCew==
X-Gm-Message-State: AOUpUlERfiZHaGqnKOpbb/FKji5ytgrfgzkPpPIqUPmSL+IfjZfsanha
        fg7u0qM9hnVz4W9HJ1Hpr4zLnWBQWAnCAjkvOr4=
X-Google-Smtp-Source: AAOMgpc/TwZAhLN/6GQqw4PyKtWK60dUY+jTlAqqKPirmypzoFKBD/vyMdT5x2WflJVs9RFPNQ8AHgj3MUEKDjElg2A=
X-Received: by 2002:a50:95ab:: with SMTP id w40-v6mr3517045eda.33.1531850013930;
 Tue, 17 Jul 2018 10:53:33 -0700 (PDT)
MIME-Version: 1.0
References: <20180717120651.15748-1-dsahern@kernel.org> <CAM_iQpW4g2v6xk49Gz+WBasKaO9VUk3Q-umX7iBRK-mAhn21Fw@mail.gmail.com>
 <1a3f59a9-0ba5-c83f-16a6-f9550a84f693@gmail.com>
In-Reply-To: <1a3f59a9-0ba5-c83f-16a6-f9550a84f693@gmail.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Tue, 17 Jul 2018 10:53:21 -0700
Message-ID: <CAM_iQpWabZorkMNswyfHyS4KT=f_bgMtK8K35=84uah6Kfqxew@mail.gmail.com>
Subject: Re: [PATCH RFC/RFT net-next 00/17] net: Convert neighbor tables to per-namespace
To:     David Ahern <dsahern@gmail.com>
Cc:     Linux Kernel Network Developers <netdev@vger.kernel.org>,
        nikita.leshchenko@oracle.com,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Ido Schimmel <idosch@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>, alex.aring@gmail.com,
        linux-wpan@vger.kernel.org,
        NetFilter <netfilter-devel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 10:43 AM David Ahern <dsahern@gmail.com> wrote:
>
> On 7/17/18 11:40 AM, Cong Wang wrote:
> > On Tue, Jul 17, 2018 at 5:11 AM <dsahern@kernel.org> wrote:
> >>
> >> From: David Ahern <dsahern@gmail.com>
> >>
> >> Nikita Leshenko reported that neighbor entries in one namespace can
> >> evict neighbor entries in another. The problem is that the neighbor
> >> tables have entries across all namespaces without separate accounting
> >> and with global limits on when to scan for entries to evict.
> >
> > It is nothing new, people including me already noticed this before.
> >
> >
> >>
> >> Resolve by making the neighbor tables for ipv4, ipv6 and decnet per
> >> namespace and making the accounting and threshold limits per namespace.
> >
> >
> > The last discussion about this a long time ago concluded that neigh
> > table entries are controllable by remote, so after moving it to per netns,
> > it would be easier to DOS the host.
> >
>
> There are still limits on the total number of entries and with
> per-namespace limits an admin has better control.

Per-netns limit is *exactly* the problem here.

Quote from David Miller:
"
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 25 Jun 2014 18:17:08 -0700

> I disagree that removing a global DOS prevention check is a benefit.
> Certainly large semantics changes like that should not happen without
> being discussed in the patch description.

Agreed, this is the most important core issue.

If we just make these things per netns, then as a result if you create
N namespaces we will allow N times more neighbour entries to be
sitting in the system at once.

Actually, I'm really surprised the limits get hit and this actually
causes problems.
"

You can see the original discussion here:
https://marc.info/?l=linux-netdev&m=140356141019653&w=2
