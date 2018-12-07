Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5A4C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 20:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 196D520868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 20:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="RJPWNELc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 196D520868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbeLGUrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 15:47:00 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34620 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeLGUq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 15:46:56 -0500
Received: by mail-qt1-f196.google.com with SMTP id r14so6043126qtp.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 12:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uma9VNTYvjKEW1G+e3/Wrq2Y1p+aJsmXG7ojr6NsC90=;
        b=RJPWNELcg2cnYNQ4J5rgDdXZQ5bNrNowloS9v1B+arQT0ZbpSOumZewWvN0gjHPy4f
         X0Ocmja6ze1fmZnflK7QG6rJ6dBd3NRcxZWhgKKIzTVaH/tSvBNMfrUitdy+OaAQras4
         li0jZN/X8kAptC1QiFxFExBAuS/XjtTmjzPWBryeeItBTs3AFb04gDQ3/BFlZHhLura0
         Xz8H8coQzIJXuWkCWyb96ZOH7ekLzfB+xXfizpWdTQ8uBgQ9MxXvK+wp/WFfBaZdl/3+
         8UiF6gE4Txe3YZhaZGVJOXADEmT+8WLTBnwmieTC4tHwzDbw2nhQuvvzV682yJ96MwXe
         VpNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uma9VNTYvjKEW1G+e3/Wrq2Y1p+aJsmXG7ojr6NsC90=;
        b=cbWhXx627IedFVbShJshhFj3xhmWMiowUXBKDcL9O9DPVzRBmXxYCJ9uPq30qo7M8L
         5T4+xoi1Gck4Ue8H/h/yRz7CBe3pOO38VXOewsBKo5gnPdm/8LHfqNcBr0oa8vk1I1ua
         SBHKGHGSxvTHRk24vch+/fV0v+0NYp96B0EYusisrjVuCQZm3Iu7vQCZDD0XDxRyKhem
         lT4G7Si/VmwJqe455svisAOppukbjid9MLF7uUbuQgxA9iLC3r9PuPfPJ0M9827HsbtL
         Kn/I0+mbREyp2U3wEYZJ8ayTiykLNwM6v/qxWyGogIGBCXdZPIwQdwUIe5fUjVc/C8uk
         Q+aA==
X-Gm-Message-State: AA+aEWajO2zAccUb1IZ1c95+cdcMcY40ef3hr+GEB5SCBK2f9R9OkNKT
        dYU4uJFKFGyXmBDYXDUPdNECcfcVu6Xvchor
X-Google-Smtp-Source: AFSGD/XV+hWqHTO6aW9mXS7gKxsnoA33qWC1fhUS+/s2IUPNNci3e9jrCHhcGw7Get4wtja4PZKAuA==
X-Received: by 2002:a0c:f0c2:: with SMTP id d2mr3432519qvl.123.1544215615194;
        Fri, 07 Dec 2018 12:46:55 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id t40sm2900018qth.46.2018.12.07.12.46.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 12:46:54 -0800 (PST)
Message-ID: <1544215614.18411.1.camel@lca.pw>
Subject: Re: [PATCH] checkstack.pl: fix for aarch64
From:   Qian Cai <cai@lca.pw>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Date:   Fri, 07 Dec 2018 15:46:54 -0500
In-Reply-To: <20181207122434.efb1941a3ded73267496c784@linux-foundation.org>
References: <20181207195843.38528-1-cai@lca.pw>
         <20181207122434.efb1941a3ded73267496c784@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-12-07 at 12:24 -0800, Andrew Morton wrote:
> On Fri,  7 Dec 2018 14:58:43 -0500 Qian Cai <cai@lca.pw> wrote:
> 
> > There is actually a space after "sp," like this,
> > 
> > ffff2000080813c8:       a9bb7bfd        stp     x29, x30, [sp, #-80]!
> > 
> 
> Confused.  Why does this matter?  Why is the patched version superior?

<Resend in plain text.>

Right now, checkstack.pl won’t be able to  print anything on aarch64, because it
won’t be able to match the stating objdump line of a function due to this
missing space. Hence, it saw every stack is zero-size.

After applied this patch, checkpatch.pl is able to match the start of a
function’s objdump, and then be able to calculate each function’s stack
correctly.
