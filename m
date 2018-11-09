Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D05C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 13:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B457D20840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 13:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFK4OvQv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B457D20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbeKIWnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 17:43:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:37680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727667AbeKIWnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 17:43:31 -0500
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 151CC204FD;
        Fri,  9 Nov 2018 13:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541768579;
        bh=PHjlIQ+UNZrhezpqcOjFDDnYjOcXoYSL/oQRVd1ATnE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZFK4OvQvIPCBwv62JXdPHaR0BVvJzPXEFPrz6r0drHO70geZUqFxs+sy5/n1XopFw
         4szbz1mCPYGKrjLlzLXjh7K55lgs/R37p6lp62QOalrhU5UC9SihVACqzWcYM+G+1M
         J6tmihcKFu6ud7zwsWnnCs7lniSyoHhG4L71Hr+o=
Received: by mail-qk1-f181.google.com with SMTP id 189so1331136qkj.8;
        Fri, 09 Nov 2018 05:02:59 -0800 (PST)
X-Gm-Message-State: AGRZ1gKo9ynJFSy8sFSWJMdJ/G+jz5eCHvfSNyoOjvhV+6J94mv8qmhM
        +MGyAT2Nsoi6X3Rm1Z4glDiYJ8cWr8t6V2N2uA==
X-Google-Smtp-Source: AJdET5dn6Jw6/d72FPgwjkEIZbBqk5s1saKeASbQwGAUvyVbkFxtBMjPExrsO3NAHAFgSYfqU9wOd1l33mFdnbRxiJA=
X-Received: by 2002:a37:9201:: with SMTP id u1-v6mr7681721qkd.29.1541768578255;
 Fri, 09 Nov 2018 05:02:58 -0800 (PST)
MIME-Version: 1.0
References: <20181107223151.14991-1-robh@kernel.org> <20181107223151.14991-4-robh@kernel.org>
 <20181108.191320.1503108955211963619.davem@davemloft.net>
In-Reply-To: <20181108.191320.1503108955211963619.davem@davemloft.net>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 9 Nov 2018 07:02:46 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+VAkCmEpHKK-D8SjJ2pVuTbXuVVbLzpjKyOQY-jvmG8g@mail.gmail.com>
Message-ID: <CAL_Jsq+VAkCmEpHKK-D8SjJ2pVuTbXuVVbLzpjKyOQY-jvmG8g@mail.gmail.com>
Subject: Re: [PATCH 3/8] sparc: prom: use property "name" directly to
 construct node names
To:     David Miller <davem@davemloft.net>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 8, 2018 at 9:13 PM David Miller <davem@davemloft.net> wrote:
>
> From: Rob Herring <robh@kernel.org>
> Date: Wed,  7 Nov 2018 16:31:46 -0600
>
> > In preparation to remove direct accesses to the device_node.name
> > pointer, retrieve the node name from the "name" property instead.
> >
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: sparclinux@vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
>
> On some 32-bit sparcs, the OF runs in non-cached memory.
>
> Sucking in the OF device tree take a signficant amount of the
> boot time on such systems.
>
> And these changes are going to make it even slower.
>
> Please just put a wrapper around dp->name or whatever and use that,
> instead of making more get property OF calls which can be very
> expensive.

It's not making calls into OF. It is retrieving the property from the
kernel's copy of the DT (allocated by memblock). So the only
difference is we have to walk the struct property list to find "name".
That's perhaps offset by the fact that we'll be doing one less
property retrieval from OF when this is all done. Right now, we
retrieve "name" from OF twice per node.

Rob
