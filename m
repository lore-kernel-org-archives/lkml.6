Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B01C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 14:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 708432082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 14:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xNv40b/d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 708432082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbeIDSqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 14:46:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:57148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727072AbeIDSqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 14:46:36 -0400
Received: from mail-qt0-f181.google.com (mail-qt0-f181.google.com [209.85.216.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20BD72082B
        for <linux-kernel@vger.kernel.org>; Tue,  4 Sep 2018 14:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536070878;
        bh=egXClixNkXKPw1GXz6mDwrl4B18HWS/0Br1i1ngbMk4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xNv40b/doENfTNrKe9+UNZiAPTDBUXdEjROgn1lu1SRgW8lpQXHnhbWdMh2QCJ3N3
         sxXLO4LQqH0kpE+uhtVCJXDCqU3UxIqLO6CXX0X+qjJnt+Je3ZOq1WhX87RdfsGLXP
         N6VS+hn2pyDVyRrrPCF5gaAwI7OiPNy9Jr2Eoy8c=
Received: by mail-qt0-f181.google.com with SMTP id g53-v6so4099076qtg.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 07:21:18 -0700 (PDT)
X-Gm-Message-State: APzg51AJLjmuoaMzYk0+FQuH5sxw9yopb8iIu/kBDTZMlZZaCKqJKw5x
        A9gRZSKRQahtAVHCm8E3aQ3OY81ix4qR2U9zIQ==
X-Google-Smtp-Source: ANB0VdYGJgzieXVpkIekAqfYN1TzIjjaZQdAONX3o2oSrW44cQT6zdzHschp16jYo70fViYyEU0A8LS5PSIUCkaiGpI=
X-Received: by 2002:ac8:7a98:: with SMTP id x24-v6mr30445622qtr.298.1536070877311;
 Tue, 04 Sep 2018 07:21:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180828015252.28511-1-robh@kernel.org> <20180828015252.28511-39-robh@kernel.org>
 <9dcceda0-1d92-0a7a-feb1-887414021ac9@ti.com>
In-Reply-To: <9dcceda0-1d92-0a7a-feb1-887414021ac9@ti.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 4 Sep 2018 09:21:05 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLrMwd-=Y6rm5RRJ25HNLTxOkFbLMcB4w0UgHteVdidGA@mail.gmail.com>
Message-ID: <CAL_JsqLrMwd-=Y6rm5RRJ25HNLTxOkFbLMcB4w0UgHteVdidGA@mail.gmail.com>
Subject: Re: [PATCH] phy: Convert to using %pOFn instead of device_node.name
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 3, 2018 at 9:24 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Hi Rob,
>
> On Tuesday 28 August 2018 07:22 AM, Rob Herring wrote:
> > In preparation to remove the node name pointer from struct device_node,
> > convert printf users to use the %pOFn format specifier.
>
> I assume it should be okay to get this merged in the next merge window?

Yes, of course.

Rob
