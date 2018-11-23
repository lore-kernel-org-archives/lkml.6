Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5B8C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 20:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7E7520664
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 20:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JME/lVKw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7E7520664
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441464AbeKXHIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 02:08:19 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39043 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441463AbeKXHIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 02:08:18 -0500
Received: by mail-pl1-f194.google.com with SMTP id 101so4763837pld.6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 12:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=HV2zezqZg+svxntefN2B27anq/kdxBzJ2ADMtaTt8VQ=;
        b=JME/lVKwEFljSpleTcadUg02cU0i10zyzOua4v8dbdWF5grkJzcEXVHUj49lguvUk6
         FUtbdi8sL5mZ196l4DOAAJOOtNR3z5aBby1RpXd9+K9+z62LxIQZlYJsbmOQY51yWzVr
         8eb5Zo2heuZguLKceFvIIB5wvr7d7lrzceT6GelfHfbKtPJ/VvJG03904IkXMS4n85Yx
         8XTynakA1xdrQmm5YQUy61J6Y2Dt2CSTUDwmlWva4kQ9IB8a/iVl9OlumQIA91r5Sa4a
         0sbKyLgTcRKRwzoFm8yycmtApvVmtmc39d3yKGWH38nDxYV4++tOMU6a/B2M/vizTvE4
         a7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=HV2zezqZg+svxntefN2B27anq/kdxBzJ2ADMtaTt8VQ=;
        b=t/WFBMGgXU2ShLtYlsjglOZ2ZVu3JQtweScZ+CX4paL6NpDPA+2lETcjtM9S8bCzP/
         Ii9nCpX7F7GdFS8XB9DxrMorRcL+z7JS6hU7GMpT1J/6hSQAywLMDg2a4bdZfs0QPbaK
         fejNZi1vWS/3Vadp7zOLy0kBsAhsUQ3SvxpRMHV4N3/tOmWMvi9lgMiKanv5pXQ1f1NO
         RanZ/+vSUVJ6Uz5Bpe8Te4BDb6fZRc+pAxxs8UpNOH++tp4rVjSox/U2On26CN/ZhOzy
         BKfGHwBrkTOaM0EihMJH/kOQnuHYCkhhjvwTY4LbNZ2Ai3J4ZPVs2tjJ9AQMtRpNqtMk
         hZsQ==
X-Gm-Message-State: AA+aEWau/7pT4zqTpG3geDu87XIm9KHVM7eq5jcazCT04lS44wwBOhyN
        e7dlgrzDVLZG8RiKkdxRu/dgkQ==
X-Google-Smtp-Source: AFSGD/Xo5vkt3T78EFOewK9ZPpFXD3hr4or/x+vRLnwcWXBKCKespDFJRfiungwvG+I4NE9bIi5sCw==
X-Received: by 2002:a17:902:bb05:: with SMTP id l5mr802158pls.230.1543004552028;
        Fri, 23 Nov 2018 12:22:32 -0800 (PST)
Received: from [100.112.89.103] ([104.133.8.103])
        by smtp.gmail.com with ESMTPSA id l184sm6637805pfc.112.2018.11.23.12.22.30
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Nov 2018 12:22:30 -0800 (PST)
Date:   Fri, 23 Nov 2018 12:22:29 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Michal Hocko <mhocko@kernel.org>
cc:     Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <OSalvador@suse.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [RFC PATCH 3/3] mm, fault_around: do not take a reference to a
 locked page
In-Reply-To: <20181122090547.GD18011@dhcp22.suse.cz>
Message-ID: <alpine.LSU.2.11.1811231211200.1964@eggly.anvils>
References: <20181120134323.13007-1-mhocko@kernel.org> <20181120134323.13007-4-mhocko@kernel.org> <alpine.LSU.2.11.1811201721470.2061@eggly.anvils> <20181121071132.GD12932@dhcp22.suse.cz> <alpine.LSU.2.11.1811211757070.5557@eggly.anvils>
 <20181122090547.GD18011@dhcp22.suse.cz>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Nov 2018, Michal Hocko wrote:
> 
> If you want some update to the comment in this function or to the
> changelog, I am open of course. Right now I have
> +                * Check for a locked page first, as a speculative
> +                * reference may adversely influence page migration.
> as suggested by William.

I ought to care, since I challenged the significance of this aspect
in the first place, but find I don't care enough - I much prefer the
patch to the comments on and in it, but have not devised any wording
that I'd prefer to see instead - sorry.

Hugh
