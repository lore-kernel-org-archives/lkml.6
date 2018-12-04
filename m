Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5826C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 04:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 749592082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 04:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="eZeEYYwC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 749592082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbeLDEdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 23:33:24 -0500
Received: from imap.thunk.org ([74.207.234.97]:38872 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbeLDEdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 23:33:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=U0hf+QFwQWhecs7cFf6uPgdOiQD/L6O4HpP1VpkadQA=; b=eZeEYYwCTOD1j6Z/V9mbwQne+c
        wFkhAvSaBwTRumURj7KvlNMfCdr22W7eh9ez7+Tja1PD4+ONRxOlj1e6geZe96vwDssb2ro7l0SRp
        Bjk39zr7akb8/Is4j0wsxRifaZ4A085tOSk/OyIjVPhp/tTNHXd1zKlRk9xwWKQSo20A=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gU2Oc-0007tq-91; Tue, 04 Dec 2018 04:33:18 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id A009C7A47B7; Mon,  3 Dec 2018 23:33:16 -0500 (EST)
Date:   Mon, 3 Dec 2018 23:33:16 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     Pan Bian <bianpan2016@163.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: fix possible use after free in ext4_quota_enable
Message-ID: <20181204043316.GC4981@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>, Pan Bian <bianpan2016@163.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1543202466-68277-1-git-send-email-bianpan2016@163.com>
 <20181127091453.GA16301@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127091453.GA16301@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 10:14:53AM +0100, Jan Kara wrote:
> On Mon 26-11-18 11:21:06, Pan Bian wrote:
> > The function frees qf_inode via iput but then pass qf_inode to
> > lockdep_set_quota_inode on the failure path. This may result in a
> > use-after-free bug. The patch frees df_inode only when it is never used.
> > 
> > Signed-off-by: Pan Bian <bianpan2016@163.com>
> > Fixes: daf647d2dd5("ext4: add lockdep annotations for i_data_sem")
> 
> Thanks for the fix! The patch looks good. You can add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks, applied.

						- Ted
