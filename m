Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF822C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AF7720844
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:31:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AF7720844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730038AbeGaTNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 15:13:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37974 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727495AbeGaTNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 15:13:00 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 181974023461;
        Tue, 31 Jul 2018 17:31:40 +0000 (UTC)
Received: from treble (ovpn-120-73.rdu2.redhat.com [10.10.120.73])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 652311C596;
        Tue, 31 Jul 2018 17:31:38 +0000 (UTC)
Date:   Tue, 31 Jul 2018 12:31:36 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Jeremy Cline <jcline@redhat.com>, Theodore Ts'o <tytso@mit.edu>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/3] ext4: super: Fix spectre gadget in ext4_quota_on
Message-ID: <20180731173136.rnhzvvvt3wtt2xdg@treble>
References: <20180727162357.30801-1-jcline@redhat.com>
 <20180727162357.30801-2-jcline@redhat.com>
 <20180727174654.bnooz26puuo7456w@treble>
 <E3E7B6AF-3819-4998-9B12-DACB4EBC14F1@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <E3E7B6AF-3819-4998-9B12-DACB4EBC14F1@dilger.ca>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 31 Jul 2018 17:31:40 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 31 Jul 2018 17:31:40 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jpoimboe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 12:39:41AM -0600, Andreas Dilger wrote:
> > Also it looks like XQM_MAXQUOTAS, MAXQUOTAS, and EXT4_MAXQUOTAS all
> > have the same value (3).  Maybe they can be consolidated to just use
> > MAXQUOTAS everywhere?
> 
> No, the filesystem-specific MAXQUOTAS values were separated from
> the kernel MAXQUOTAS value for a good reason.  This allows some
> filesystems to support new quota types (e.g. project quotas) that
> not all other filesystems can handle.  This may potentially change
> again in the future, so they shouldn't be tightly coupled.

But isn't that what sb->s_quota_types is for?  To allow different
filesystems to support different quota types?

Also I don't see any bounds checks for EXT4_MAXQUOTAS.  It seems like
the ext4 code assumes that MAXQUOTAS and EXT4_MAXQUOTAS are the same.

-- 
Josh
