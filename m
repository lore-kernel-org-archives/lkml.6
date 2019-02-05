Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47277C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21D0F2175B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="GWbNtUxA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730274AbfBESep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 13:34:45 -0500
Received: from mail-ed1-f51.google.com ([209.85.208.51]:41604 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbfBESep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 13:34:45 -0500
Received: by mail-ed1-f51.google.com with SMTP id a20so3735542edc.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 10:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=uYltDArnLF2Gf/kLaTia884ASMuJ34t0Q/Ew89zcOoM=;
        b=GWbNtUxArFvX6QeLvxYROdblOO4Hk26oRssHlM03AF3+fKhHes+hnzbUFIzPJrtosD
         tKhbUj1dmlkErWcz8+sp+svZB39zm0apHPGMojctOFrmKrAZvHuaGNN0x9xBlcVYVQ7T
         8i7HW5ALm4F/oqDc5SmCjrDTVvUMb2Dlx5tYPqQIZL7PvTX20R0fmjA0OSJrhdhSRifk
         Rxw9/y5JJh8bqAmtA5pzzMXM9qJH/3cfyyngYxV7rzF7uld1fq04KQyNM5IDS9kMIp2D
         dY72SfWWAPRXeSyd2uyol8Wa4QYnDw4rcZqqzv9w6xmVEW+wefWSf64j9cgi0RMLBxyc
         d+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=uYltDArnLF2Gf/kLaTia884ASMuJ34t0Q/Ew89zcOoM=;
        b=SFGi1nSQ/YcmvOkYPQyfqGqlYcrwWD1YjOyEnbyXPnvhvIbyB4roL4lnFYgEj0hSHd
         FpmtkMkz9lZnl4O6yxoAChFSCr0vIx4b2pIBuElCJ5lZxr7VZ9hWU4W9fbU45zef9k65
         EP5J2T5ebh9xWd6PXYtZqyWUrqvxd4o7IJeLNa6F/SrrIuJ7lutoS0FTij/ppBv+xyxj
         YrlZCmsJgBkatOArL6EnMsioOZqluGqHDqMPtLiDv8EhaW5gzfMpyHGaqBFdIwxwktD5
         fkoifUun6UOVU4KwbfxeI1AP+du46U+YYW1htBIuIFMZtdgKKbWjdMPapDnLOZE5K2Ca
         rQoQ==
X-Gm-Message-State: AHQUAuaaixEuoAflH4hgQ5CaBfOj+6OJVlNI4Jo8QITez33MatocR1Do
        kN6JxSzpjRUt8y6rpbL4KT8cm9oglHYHDVgL31+WaVhb
X-Google-Smtp-Source: AHgI3IbvbWVGnqYG/0VLkB9Gy/4Z5K4AGHel63dbfZxbHUGxiOtNUGxXS8pl5C6Wb4j9pqNWuP4xvFsoKqasRHWu368=
X-Received: by 2002:a50:a4ce:: with SMTP id x14mr4981572edb.229.1549391683544;
 Tue, 05 Feb 2019 10:34:43 -0800 (PST)
MIME-Version: 1.0
From:   Denys Vlasenko <vda.linux@googlemail.com>
Date:   Tue, 5 Feb 2019 19:34:31 +0100
Message-ID: <CAK1hOcN8_0MNEFfoHg0sAuu09SPhXHvXfXkeHONtoFXOArjumg@mail.gmail.com>
Subject: preempt.h: some SOFTIRQ_OFFSET should be SOFTIRQ_MASK?
To:     Frederic Weisbecker <fweisbec@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SOFTIRQ is a counter.
Why here:

#define in_serving_softirq()    (softirq_count() & SOFTIRQ_OFFSET)
#define in_task()               (!(preempt_count() & \
                                   (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET)))

we check only lowest bit?
