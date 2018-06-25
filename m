Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE6DC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3143A25DDA
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBGWONEA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3143A25DDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932802AbeFYQJ5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 12:09:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:59482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752415AbeFYQJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 12:09:54 -0400
Received: from mail-wr0-f172.google.com (mail-wr0-f172.google.com [209.85.128.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E163925DE2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 16:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529942994;
        bh=3cf21v2rm+c/iUacBJtSh/xDuIiTubUDUtyr/HBLYHc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CBGWONEAAhBNiseK7fRaObqflctZstbaTpYVvED84+KRCV+smPJhH8h4PPX9WG2xO
         CUClNowAsh01yqrrtM/YNlLb+q9hBIvIEc/jBICSMaS9rOxM5r2cCO/fGbFT1AMIuu
         g1Bp38Qg815WW94Nlf4vWpqeopmEvM+pHdEnsRHs=
Received: by mail-wr0-f172.google.com with SMTP id a12-v6so14283474wro.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 09:09:53 -0700 (PDT)
X-Gm-Message-State: APt69E3dTeoz7wBFCT3F5aafUj7V+4KvVonslP64KXC0yYm3raJxlJ9c
        KEEludcIGB3fn91wfn0mty9IZuEzqx3z2P31F4i38w==
X-Google-Smtp-Source: AAOMgpeeHPmZdZpi7AFgz1W/X07yE+ajc1U3k18EyXk1KpTGEywlyeGngIzQCvPGa/yGB/uRCHz7jaCUT8pOkeF1KIU=
X-Received: by 2002:adf:be03:: with SMTP id n3-v6mr2639025wrh.267.1529942992322;
 Mon, 25 Jun 2018 09:09:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180625140754.GB29102@dhcp22.suse.cz>
In-Reply-To: <20180625140754.GB29102@dhcp22.suse.cz>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 25 Jun 2018 10:09:41 -0600
X-Gmail-Original-Message-ID: <CABGGisyVpfYCz7-5AGB-3Ld9hcuikPVk=19xPc1AwffjhsV+kg@mail.gmail.com>
Message-ID: <CABGGisyVpfYCz7-5AGB-3Ld9hcuikPVk=19xPc1AwffjhsV+kg@mail.gmail.com>
Subject: Re: why do we still need bootmem allocator?
To:     mhocko@kernel.org
Cc:     linux-mm@kvack.org, hannes@cmpxchg.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arch@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 8:08 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> Hi,
> I am wondering why do we still keep mm/bootmem.c when most architectures
> already moved to nobootmem. Is there any fundamental reason why others
> cannot or this is just a matter of work?

Just because no one has done the work. I did a couple of arches
recently (sh, microblaze, and h8300) mainly because I broke them with
some DT changes.

> Btw. what really needs to be
> done? Btw. is there any documentation telling us what needs to be done
> in that regards?

No. The commits converting the arches are the only documentation. It's
a bit more complicated for platforms that have NUMA support.

Rob
