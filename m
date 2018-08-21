Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35D0C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69914214FF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:50:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69914214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbeHUKJk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 06:09:40 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:45377 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbeHUKJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 06:09:40 -0400
Received: by mail-oi0-f65.google.com with SMTP id q11-v6so30255401oic.12;
        Mon, 20 Aug 2018 23:50:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FyJXHbfqPxCFM1mWbt9Cx0SMHF9SiOaecuSoNpI4jio=;
        b=sfOfI26HRrPPVFpZvlTKUlu33jtPsloIsoLsiCR9F3FA/D8ZOZxCLxMQOx0QVZHwA/
         RGwBsvdd89CA9cl3PogodW0W4xrvzFoHf8v6q2/eKJu2I9bZq7lqcrCjsQSQtLIJRZdb
         8ID7h8aFAKjMQeiw+GdvZWkaTvz1sAtKcN4W/xLRcufXDvHug1a5mAkVnwBY3AbfVtOv
         jSaTF0a6aH2vwyQqQ5UqBBSg/CZNPz4s1yH/hgggAWb77NWpjPE77+JlZljvGHk2LL0e
         EUjYdGt86nuZp9tCdhmm6rYI7iep/a2b0kLilPOsy2IYfyBMbNf8J7wERR+SBl8KNuzu
         8ieA==
X-Gm-Message-State: AOUpUlF2dSJ9JPyvb4HRZ72U7pXe2IljA9MVDLiPYU5AEz4HMF3atXVC
        3dxc3sMYl65d1wEKgqHEfI+vmEsgRD2c41b0Wr4=
X-Google-Smtp-Source: AA+uWPwszY2aFOf+qhUw2XEC9l9suqgnh4Op0fECsif+YDZNWhXc7fg85Kt6mdjv/R2t5XRUQ/8xzN7XILzMzGvf9SQ=
X-Received: by 2002:aca:b885:: with SMTP id i127-v6mr17564306oif.180.1534834247208;
 Mon, 20 Aug 2018 23:50:47 -0700 (PDT)
MIME-Version: 1.0
References: <20180820182906.48f7743f@kitsune.suse.cz>
In-Reply-To: <20180820182906.48f7743f@kitsune.suse.cz>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 21 Aug 2018 08:50:36 +0200
Message-ID: <CAJZ5v0hMZ_bmCy7vQBfzu6RNVkCX0V9qRtqYVNmFOefc1TnGCA@mail.gmail.com>
Subject: Re: Regression: 18996f2db918 ("ACPICA: Events: Stop unconditionally
 clearing ACPI IRQs during suspend/resume" breaks resume from suspend
To:     msuchanek@suse.de
Cc:     "Schmauss, Erik" <erik.schmauss@intel.com>,
        Lv <lv.zheng@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        devel@acpica.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 6:29 PM Michal Suchánek <msuchanek@suse.de> wrote:
>
> Hello,
>
> after commit 18996f2db918 ("ACPICA: Events: Stop unconditionally
> clearing ACPI IRQs during suspend/resume") I am no longer able to
> resume from suspend.
>
> Reported in bugzilla https://bugzilla.kernel.org/show_bug.cgi?id=200841
>
> Reverting this on top of 4.18 fixes the issue. acpidump output is
> attaches in the bugzilla.
>
> Is there anything else that can be done to diagnose the issue?

Can you please test the patch at
https://patchwork.kernel.org/patch/10563631/ to start with?

It's already queued up for inclusion.

Thanks,
Rafael
