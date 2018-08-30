Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 078EFC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7CDE20835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Wa94dHJj";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Wa94dHJj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7CDE20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbeH3XtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 19:49:08 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50100 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbeH3XtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 19:49:08 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9B6CA60452; Thu, 30 Aug 2018 19:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535658321;
        bh=Wf4WdTJf/AbQ5wx2UAHEmxf7/DU6zsY6AJUxWManmZw=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=Wa94dHJjfp1+qpIzWqVlCOCTGxJg2QC1P02n8JCVRjUTIs72ebJC1Xzx0DWCIETwm
         ijiH/kqQuqcFxF1cYsV9FJjONSZZxHmriuObV+hlX4XGKpfce6tSkls5xCHC/5mhiZ
         IqoQ0DDhlYt62F/y302tr52DS/24ixKxuGf8j0yo=
Received: from WUFANW10 (c-71-205-14-210.hsd1.co.comcast.net [71.205.14.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wufan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 88C866037C;
        Thu, 30 Aug 2018 19:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535658321;
        bh=Wf4WdTJf/AbQ5wx2UAHEmxf7/DU6zsY6AJUxWManmZw=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=Wa94dHJjfp1+qpIzWqVlCOCTGxJg2QC1P02n8JCVRjUTIs72ebJC1Xzx0DWCIETwm
         ijiH/kqQuqcFxF1cYsV9FJjONSZZxHmriuObV+hlX4XGKpfce6tSkls5xCHC/5mhiZ
         IqoQ0DDhlYt62F/y302tr52DS/24ixKxuGf8j0yo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 88C866037C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=wufan@codeaurora.org
From:   "wufan" <wufan@codeaurora.org>
To:     "'Tyler Baicar'" <baicar.tyler@gmail.com>
Cc:     <mchehab@kernel.org>, "'Borislav Petkov'" <bp@alien8.de>,
        "'James Morse'" <james.morse@arm.com>,
        <linux-edac@vger.kernel.org>,
        "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
        "'arm-mail-list'" <linux-arm-kernel@lists.infradead.org>,
        <john.garry@huawei.com>, <toshi.kani@hpe.com>
References: <1535654266-40053-1-git-send-email-wufan@codeaurora.org> <CABo9ajCui0y9HMBzgKWeNtrbu4de+mLh=d9Qdkyo4zhU9az6hw@mail.gmail.com>
In-Reply-To: <CABo9ajCui0y9HMBzgKWeNtrbu4de+mLh=d9Qdkyo4zhU9az6hw@mail.gmail.com>
Subject: RE: [PATCH v2] EDAC, ghes: use CPER module handles to locate DIMMs
Date:   Thu, 30 Aug 2018 13:45:19 -0600
Message-ID: <001901d44099$fc8d7550$f5a85ff0$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIwN43o3rGm5KlibLHCDVEy4C+DsgF7LWjApBTrNgA=
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tyler, 

> > +static int get_dimm_smbios_index(u16 handle) {
> > +       struct mem_ctl_info *mci;
> > +       int i;
> > +
> > +       mci = ghes_pvt->mci;
> > +
> 
> Minor nit: you could define and set mci in the same line to save some space
> here.
> 
> Otherwise this patch looks good to me.

Good catch Tyler! I'll fix it.

Thanks,
Fan

> Reviewed-by: Tyler Baicar <baicar.tyler@gmail.com>

