Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADE9C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 03:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68B50206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 03:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBN0GgKf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731151AbfAPDZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 22:25:27 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37771 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731039AbfAPDZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 22:25:27 -0500
Received: by mail-ot1-f66.google.com with SMTP id s13so4929798otq.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 19:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=iug1m1r6FrUl2yxO8k9WIkcW6n+pohJCiwrmF0qZVtM=;
        b=CBN0GgKf4JJ/EH+RUx//FkuFtzn3LwaRlVAxjapwnAkyOK83pbbu7ZJ5kxdvSbduN6
         ZcH/SsyioMr3bT7f5a8Qb6rkGTB/oyJFt9Nw6BvUEVv7zhFpSDy2ox8+39mScKvueyiB
         p7NT2QsqUFjp2zwOK50V+Y/MEs+fBiTNs8qD7Aprm8llcr+GJ43nk0YrEutYzNM095Q3
         RN0nThXGU4F7prVhoSemQ344JCr5IW5WITNU+lklKdvz5esi3L8n/RSJAzR/OggnIcZa
         D0LplrMZY3KZDQtEdQqHxniGHaTt7ED71eHY1lCi0LgocCFH6SX4mEm6D7DolEpByDS9
         YBcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=iug1m1r6FrUl2yxO8k9WIkcW6n+pohJCiwrmF0qZVtM=;
        b=eo4vXVVhDxZ98Vs/01Ay1sZxb7FcsqdDcEIQgPkrSwyrvj3M8mg8q6Xzd0B9Opur8z
         +H5DJrZWmKy3qyvxLLqnbQ/8bbY741l3UIxdzPTdvZSrUc+jK+huoIwnLNWIVKUL4pc3
         WM7EEnWBGtIrfsIjohtsOCarS5bXrgkFXzembAyWbldWJEzoJjWeFhXWr1OCRhVfSBLu
         k1Ub1BWEoHMSWn477+1EZDI1GglW8FRCCsiQx2JnallcZW3qmWcJ7idja9FDKoPHc43O
         mPOPficTdtBQO+cHszAioP6zWfBZlGtZmiq3WIiyGRjFcNq16dVGC3147itlN5EF1dvi
         j+RQ==
X-Gm-Message-State: AJcUukfU3GT8q9ltIOhgdwu1JlAfGr7QC4mMt+pHdSVDpytVEaCkoNDy
        /qOImp1/DmM6Z4ORcmCKrn9u18CIcoIN+GCtEZaE07NIEgE=
X-Google-Smtp-Source: ALg8bN5CJxxm8u1MZUanAopcwuzZRE200s9ZMbfQ1rvBqmjloqYwBSlnFVJRTD9Py5SiX8GHyL1Rr/yEUDhvLuVpGV4=
X-Received: by 2002:aca:408b:: with SMTP id n133mr3282269oia.44.1547609126403;
 Tue, 15 Jan 2019 19:25:26 -0800 (PST)
MIME-Version: 1.0
From:   Kassey <kassey1216@gmail.com>
Date:   Wed, 16 Jan 2019 11:25:15 +0800
Message-ID: <CAKwPUowmzZ2BNi-RmJm3=ENrZ5sxPf1SeT+b9A9iHHSCUQQAUw@mail.gmail.com>
Subject: arm64: copy_from_user access the last page of ddr has problem on 4.14 kernel
To:     linux-kernel@vger.kernel.org, willy@infradead.org,
        will.deacon@arm.com
Cc:     kassey@126.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Will and team:

   we met a issue when copy_from_user to access the last page of DDR
on 4.14 kenrel, below is the detail steps,
   can you help to suggest if there is know fix or debug something ?

1. we mmap ( in userspace)  a region of  phy address that is not
continous  but include the last page of ddr

  for example our ddr end is 0x200000000
  the last page is fall in below addr:
  0x1fffff000  to  0x200000000

2. we using copy_from_user to copy these mmap address to kernel buffer

3. and we find everytime when trying to copy_from_user  the last page
in phy of ddr,
    the dst kernel buffer is looks overwrite by some same patten start
with "mmap" in this last page ,but the src in the last page of ddr is
still correct.

is there any know issue for copy_from_user to accces the last page of
phy ddr mmaped by userspace  ?



-- 
Best regards
Kassey
