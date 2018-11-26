Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B907AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82E7720663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=appneta.com header.i=@appneta.com header.b="YidMr749"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82E7720663
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=appneta.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbeK0EtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 23:49:21 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43760 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbeK0EtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 23:49:21 -0500
Received: by mail-pl1-f193.google.com with SMTP id gn14so14225946plb.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 09:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=appneta.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=N/ffkHrNvD7KRmfCXqPQHjhKNpKU2Xw1oefTLrXVHK4=;
        b=YidMr749NM/TnYHaJ9Kn68OQohg6gz7Bc/VTVsUSvIpSFFdRcwf9cH5eJpHGcl1si1
         pg15B9YFy3KOjso+yimE76G9ccGqz+WrQTEu+22DjK4bXKMPptJNdo69oeysja8ZJwRf
         qNx0apq1C3P3lo3zeVUz811aToFFvScSV1DvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=N/ffkHrNvD7KRmfCXqPQHjhKNpKU2Xw1oefTLrXVHK4=;
        b=c9lu9fAJIcmOWS3QvN2YXOoZR5GkO4+eX3qSZhN6bDHhithCARjC8Z6n6EerS7xT1v
         u0vcqR8TgbT/xDwxxkztoCV/hUSz0fxGolX6dfWoA3ZwK9Yefg6epkI+4i5NCNWs/DfL
         BFIKzwftjj41Bp2JKGtC3WI61WSw2sjv0BH9aRbXUY3LVi81w+SoIcraSaM5cpg5Obg7
         KyGtlZoVjTCoWAWGef7JEXrtaoZ0LrD08iF4aAMWvi64jVLbw0sKqNmyXNqGge96CIJa
         CRBAzbf/nJfQ5Fo8BlBNQE4d9aR3H3qNOCwc2FmO6YsSS6hK1i71CxVhDEI/4NNi9q2x
         Mhjw==
X-Gm-Message-State: AA+aEWYVMpax7ycYoMsBgPIRUKlurjwSZw+j1BF4HJ08QDz4XHwgJcKm
        6sLcw4/rpxkH76cCY/ZHxgWt
X-Google-Smtp-Source: AFSGD/X/SK/uV3I+oYyoANLle2kDzzAanNfi2ngu+2jCholY7iDzI7uVLFm7U3fQFnp61mx5BuU5Ew==
X-Received: by 2002:a17:902:e01:: with SMTP id 1-v6mr27873092plw.251.1543254870318;
        Mon, 26 Nov 2018 09:54:30 -0800 (PST)
Received: from ?IPv6:2001:4958:15a0:24:6935:96c7:a649:f2b6? ([2001:4958:15a0:24:6935:96c7:a649:f2b6])
        by smtp.gmail.com with ESMTPSA id m20sm971058pgv.93.2018.11.26.09.54.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 09:54:29 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [PATCH net] ixgbe: recognize 1000BaseLX SFP modules as 1Gbps
From:   Josh Elsasser <jelsasser@appneta.com>
In-Reply-To: <87efb92z5w.fsf@miraculix.mork.no>
Date:   Mon, 26 Nov 2018 09:54:28 -0800
Cc:     intel-wired-lan@lists.osuosl.org,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <40FD0CE5-973C-4A7F-91BD-66C1A1699223@appneta.com>
References: <20181124205801.67828-1-jelsasser@appneta.com>
 <87efb92z5w.fsf@miraculix.mork.no>
To:     =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bj=C3=B8rn Mork <bjorn@mork.no> wrote:

> Not that it matters much I guess, but I think LX SFPs were unsupported
> at that time. The LX support appears to have been added under the =
radar
> while refactoring ixgbe_setup_sfp_modules_X550em in commit =
e23f33367882
> ("ixgbe: Fix 1G and 10G link stability for X550EM_x SFP+")

Looks like you=E2=80=99re right. Want me to respin with an additional =
=E2=80=9CFixes=E2=80=9D tag?

- Josh=
