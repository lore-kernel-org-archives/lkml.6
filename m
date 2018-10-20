Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99ABEC67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 13:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51AC12152D
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 13:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="rFbJR6MB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51AC12152D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbeJTV6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 17:58:44 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:41523 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727343AbeJTV6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 17:58:44 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id deff0599;
        Sat, 20 Oct 2018 13:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=G9Q1xZmEluf3yMJHQkYVHKazJj4=; b=rFbJR6
        MBPrjGyApRO108++vL4MW1sqh1xItFO87CKU4g9PE7d9UU5YPAmFNyJZkaXzWunj
        oKHB2sz9k4vHG10lztZxv0JsD2LEaxSPWgKFxobT40dSl3w6D2fJ+2obMCGEq3Fy
        Ly3Go7a8+Aq5juUPKL69i8qwdXYC8zT+Qxnv1yVQP9Kpk0glqefy5h1SJiEeSKeV
        GfXH/usNEfdKntHfdsKj7a/vB22X8eAlo/I955pzO7RPhlBC0AcqfsnzY4DwY/bz
        pUI7uoowJdq3O+Q9t5/gNZUiGQXVUbifCqMalExQcbh0J80BH2ubKokpXM1xJ7s0
        i3BJasfipL3O6DOQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 2e64aa9e (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Sat, 20 Oct 2018 13:45:54 +0000 (UTC)
Received: by mail-oi1-f173.google.com with SMTP id u74-v6so28922010oia.11;
        Sat, 20 Oct 2018 06:48:09 -0700 (PDT)
X-Gm-Message-State: ABuFfohdPEyH5IL/1Yw/nASxUTME+D/Hmk6vKmcMsiYJEq0WbiUjpW7t
        22BfAMZ4GkLrCPtCNDNZDgtMLiWrNnMw3/8/2Jc=
X-Google-Smtp-Source: ACcGV63wOmKetYwphhoUQYmMFOlOIOD7kgFVBZRSAKkddAdK3fC6Wf9QIUxdq/DT70umvLQ3yfNbSKloGkjaRc44mqY=
X-Received: by 2002:aca:3f87:: with SMTP id m129-v6mr19508131oia.228.1540043288358;
 Sat, 20 Oct 2018 06:48:08 -0700 (PDT)
MIME-Version: 1.0
References: <20181015175424.97147-1-ebiggers@kernel.org> <CAHmME9p1aiqWZ4+viaLscO8+qmixdVhMA1MAtMAFEHPG36DcPg@mail.gmail.com>
 <20181019190411.GB246441@gmail.com> <1f65ce09-93b3-f43e-49d5-9d9d6c0bb9e0@gmail.com>
In-Reply-To: <1f65ce09-93b3-f43e-49d5-9d9d6c0bb9e0@gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sat, 20 Oct 2018 15:47:57 +0200
X-Gmail-Original-Message-ID: <CAHmME9qf9OAuFaHvyT7du9Dce7vESLgHt-KewTLsttpS9UxNeg@mail.gmail.com>
Message-ID: <CAHmME9qf9OAuFaHvyT7du9Dce7vESLgHt-KewTLsttpS9UxNeg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/12] crypto: Adiantum support
To:     Milan Broz <gmazyland@gmail.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-fscrypt@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Paul Crowley <paulcrowley@google.com>,
        Greg Kaiser <gkaiser@google.com>,
        Michael Halcrow <mhalcrow@google.com>,
        Samuel Neves <samuel.c.p.neves@gmail.com>,
        Tomer Ashur <tomer.ashur@esat.kuleuven.be>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Milan,

On Sat, Oct 20, 2018 at 12:53 PM Milan Broz <gmazyland@gmail.com> wrote:
> Does it mean, that if Adiantum is based on Zinc, it can be no longer used
> for FDE (dm-crypt)? IOW only file-based encryption is possible?

No, don't worry. All I had in mind was the software implementations of
chacha12 and so forth. There aren't any current plans at this point to
change the scafolding underlying dm-crypt.

Jason
