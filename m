Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF86C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4861921850
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="szj5Pezo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbfBZUKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 15:10:42 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38558 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbfBZUKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 15:10:42 -0500
Received: by mail-qt1-f196.google.com with SMTP id s1so16495029qte.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 12:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PVAJQc7zm0/UuJ2/28R2Kg+xhez7CklWKF4FR40pHt4=;
        b=szj5PezodOf6fy3TTJDCb6FuY6gx5NlIo+SgoBO/yoy5OIf2REWokCmVLNRLNJfxTM
         1YEvAwiY0UrzkPyP4CJyioVjKN/ZSwAVg3cZuyD655dSus84GhS4wib5eYKNvoI1LOVf
         U1cVfPgANCdKx7TlRkWvLhHC1fzhIBb3l4o8TnB8ys1FFGF96iZPXNYOvzBDcNO3boOd
         GB1I8yhCfwx9cI9K+wugOHBVzlVsEb2B2FfaPTDulHoDK6uI+ExJ3ynEtzqo3AnTAtGn
         H4s+cZu4VkBVNsBB400YQmvV3uBH1COFj6aBNxOB/Z+zPnRcsjWJkc/nk+PLDE6ceNPB
         qJpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PVAJQc7zm0/UuJ2/28R2Kg+xhez7CklWKF4FR40pHt4=;
        b=IEBPX4g5lXk87gAJT3geiEPirot7WFgCwWKTOetJEM3/Na99BvcZPUAKkydSNMhl3c
         6tJw0j+qQVuhi5mAlP3EJfcAZ1ysR9U4UASk8gHi0xlZuV0fyeypfNdR5HsKxTqM3cll
         4t8VZqXR3wBlFdzPzPFZ7Yw2IVkznuH8uRs+Z0azVo54r+ypfXjDpM1PzAwp8WatJGyP
         Yxxg+2eeqb+nXTBppbheqDBpPNy9M0b92OERv1ccpXFUs9XO+fF0lmTGDm716YkugeRo
         pZ/CfzeYUZDwR40hDf05aGZt9uUM8MPbR976ZEd2z8W7zNuOkcF4DIhT7rzr3IkQud2Y
         iTEA==
X-Gm-Message-State: AHQUAuZXRglKSqGAtbAL2gim/DL9UxaRfN3v+KxkkA5KMYCmdmLOZiix
        JMOK/84Rz/BE/icFj/Zcby15IUKxHjg=
X-Google-Smtp-Source: AHgI3IbwIASi1Yl1POT27rifla4p+mkrU+55VCWmojDk/BpmEDuBF3muTAszov9c9OLMp6LXHLjHzA==
X-Received: by 2002:ac8:1b6b:: with SMTP id p40mr18870589qtk.155.1551211841157;
        Tue, 26 Feb 2019 12:10:41 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id m128sm7927982qkf.53.2019.02.26.12.10.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 12:10:40 -0800 (PST)
Message-ID: <1551211839.6911.54.camel@lca.pw>
Subject: Re: [PATCH] mm/hotplug: fix an imbalance with DEBUG_PAGEALLOC
From:   Qian Cai <cai@lca.pw>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 26 Feb 2019 15:10:39 -0500
In-Reply-To: <20190226194024.GI10588@dhcp22.suse.cz>
References: <20190225191710.48131-1-cai@lca.pw>
         <20190226123521.GZ10588@dhcp22.suse.cz>
         <4d4d3140-6d83-6d22-efdb-370351023aea@lca.pw>
         <20190226142352.GC10588@dhcp22.suse.cz> <1551203585.6911.47.camel@lca.pw>
         <20190226181648.GG10588@dhcp22.suse.cz>
         <20190226182007.GH10588@dhcp22.suse.cz> <1551208782.6911.51.camel@lca.pw>
         <20190226194024.GI10588@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-02-26 at 20:40 +0100, Michal Hocko wrote:
> It seems you have missed the point of my question. It simply doesn't
> make much sense to have offline memory mapped. That memory is not
> accessible in general. So mapping it at the offline time is dubious at
> best. 

Well, kernel_map_pages() is like other debug features which could look
"unusual".

> Also you do not get through the offlining phase on a newly
> hotplugged (and not yet onlined) memory. So the patch doesn't look
> correct to me and it all smells like the bug you are seeing is a wrong
> reporting.
> 

That (physical memory hotadd) is a special case like during the boot. The patch
is strictly to deal with offline/online memory, i.e., logical/soft memory
hotplug.
