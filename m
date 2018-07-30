Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B67C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABD2920870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:54:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABD2920870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731637AbeG3Uab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 16:30:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47748 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730400AbeG3Uab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 16:30:31 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1C3D6E9017;
        Mon, 30 Jul 2018 18:54:11 +0000 (UTC)
Received: from treble (ovpn-120-73.rdu2.redhat.com [10.10.120.73])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C85A20389E0;
        Mon, 30 Jul 2018 18:54:10 +0000 (UTC)
Date:   Mon, 30 Jul 2018 13:54:08 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Jeremy Cline <jcline@redhat.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] ext4: mballoc: Fix spectre gadget in
 ext4_mb_regular_allocator
Message-ID: <20180730185408.hl6omiitkqpac5d3@treble>
References: <20180730180747.25200-1-jcline@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180730180747.25200-1-jcline@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 30 Jul 2018 18:54:11 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 30 Jul 2018 18:54:11 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jpoimboe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 06:07:47PM +0000, Jeremy Cline wrote:
> 'ac->ac_g_ex.fe_len' is a user-controlled value which is used in the
> derivation of 'ac->ac_2order'. 'ac->ac_2order', in turn, is used to
> index arrays which makes it a potential spectre gadget. Fix this by
> sanitizing the value assigned to 'ac->ac2_order'.  This covers the
> following accesses found with the help of smatch:
> 
> * fs/ext4/mballoc.c:1896 ext4_mb_simple_scan_group() warn: potential
>   spectre issue 'grp->bb_counters' [w] (local cap)
> 
> * fs/ext4/mballoc.c:445 mb_find_buddy() warn: potential spectre issue
>   'EXT4_SB(e4b->bd_sb)->s_mb_offsets' [r] (local cap)
> 
> * fs/ext4/mballoc.c:446 mb_find_buddy() warn: potential spectre issue
>   'EXT4_SB(e4b->bd_sb)->s_mb_maxs' [r] (local cap)
> 
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: stable@vger.kernel.org
> Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Jeremy Cline <jcline@redhat.com>

Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh
