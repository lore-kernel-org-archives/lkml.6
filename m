Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A03C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 19:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0482121872
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 19:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="kOSEEN/m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbfBZTTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 14:19:46 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45084 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbfBZTTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 14:19:45 -0500
Received: by mail-qt1-f195.google.com with SMTP id d18so16209314qtg.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 11:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GK4SfxpHL1TW7COE/Vay6DFmtSQUb3SQpYp/sxEryuI=;
        b=kOSEEN/mQlVE842b2oxlZn98OH6UUr8fe9rGWUi2TQmmVz/w+xcm4mJWpjzwIVxSSG
         Z5ZMti6XgNY00hCkh14bfQCXqATzNYLmpoYrwh8gb4kbaRb2dcwl3kQiM+ssCIh1z5//
         b7jIiv2nwipNu6Txhp9IsEmnlYzNp5pAcz3rdl5hin83RLQdm55iFXKEej6OmSC6b0IV
         ZwT49L1caPXLToKrePIImY55Lx0DJQwWUOj3ylYLeKVGHvzxJuOFIXN2Utpuekd7I1aD
         Hz+C+6ALeqy7Rq8kjI3FQ4XjrtJmbIONtjDThoiUMe6xnvnVDYGSkNZLOUG7RA0tsMJA
         jZfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GK4SfxpHL1TW7COE/Vay6DFmtSQUb3SQpYp/sxEryuI=;
        b=uV4EI+VCRr4bhT3mMHJsgzyA/rAWS4vbluP3QlLcE4FinUakZ7s73RYuqtpJZXtkvV
         fsDxpGAccdXhULNYjeSXLw430JGMNQoRSL+iphd4CJEaTAQEPrr1db/4uZj9JyizGtDx
         /C3Z92xgFjPTCxTUGrxPqGb5sUbWIB/Mxg6hO4sizSyC0zw+EuFz3r59LFbxJq2VDxNP
         CvCB5d5vwPVJPENHlhk3Jfmf14lQoxO+vug+0iL9QfyjlnozV5sWatmbPhQIKYppquPr
         h9z96WfP8Vaue0ZF0Am0oW+vhVFlL/HRyZiX538bj1nQ7/6jqRVL0F1ZzAkQs/N4PR1H
         zwxg==
X-Gm-Message-State: AHQUAuau4lw3qZSVmD6GwjLJjCqs+Ne84Fe0aFuPzh9vhLkK1XERBuSO
        4J2ESVllU7JMmh8GcFDqtIfiv19HTUk=
X-Google-Smtp-Source: AHgI3IYkmMFLwdW/jIteTI8bQIBaUYBhG9HD5Lwb5XOogW2UFF2P/XIQ56UhBknstq64zReANdUOYQ==
X-Received: by 2002:ac8:22b6:: with SMTP id f51mr19277552qta.182.1551208784518;
        Tue, 26 Feb 2019 11:19:44 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id t38sm11324314qtc.12.2019.02.26.11.19.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 11:19:43 -0800 (PST)
Message-ID: <1551208782.6911.51.camel@lca.pw>
Subject: Re: [PATCH] mm/hotplug: fix an imbalance with DEBUG_PAGEALLOC
From:   Qian Cai <cai@lca.pw>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 26 Feb 2019 14:19:42 -0500
In-Reply-To: <20190226182007.GH10588@dhcp22.suse.cz>
References: <20190225191710.48131-1-cai@lca.pw>
         <20190226123521.GZ10588@dhcp22.suse.cz>
         <4d4d3140-6d83-6d22-efdb-370351023aea@lca.pw>
         <20190226142352.GC10588@dhcp22.suse.cz> <1551203585.6911.47.camel@lca.pw>
         <20190226181648.GG10588@dhcp22.suse.cz>
         <20190226182007.GH10588@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-02-26 at 19:20 +0100, Michal Hocko wrote:
> Btw. what happens if the offlined pfn range is removed completely? Is
> the range still mapped? What kind of consequences does this have?

Well, the pages are still marked as reserved as well, so it is up to the
physically memory hotplug handler to free kernel direct mapping pagetable,
virtual memory mapping pages, and virtual memory mapping pagetable as by design,
although I have no way to test it.

> Also when does this tweak happens on a completely new hotplugged memory
> range?

I suppose it will call online_pages() which in-turn call
kernel_unmap_linear_page() which may or may not have the same issue, but I have
no way to test that path.
