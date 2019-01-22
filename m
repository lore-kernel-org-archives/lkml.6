Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF343C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2F1B217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548185361;
	bh=9G0OoWQpT/t/mKqkKkzvkzW3jZ1ZG6EXZvtup/7w6u0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CKMPdu2aEmExPirCqyE/jjNSA5DyxaMv+CRQdfz00xApam7tq4YKRmDGU8xbaqrYx
	 MKoyz2XPl6M2ez/isQiaRKKNIsZ04xkbrlv0H4mLcKAtVSMiBUxK70XF1pcrtGDzXm
	 kTOBakmBkjdMPXxn6pIRwmbQ1m9S6frU2mA+3TLc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfAVT3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 14:29:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:54120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbfAVT3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 14:29:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4ABC92085A;
        Tue, 22 Jan 2019 19:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548185358;
        bh=9G0OoWQpT/t/mKqkKkzvkzW3jZ1ZG6EXZvtup/7w6u0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RqSusjkGIzIPK3uzmGKnqZInJ/27ALesdnmH10rWoiA7haQtdmvgJ+IVxnz+6+AuD
         Vc3X8CRRVCp4ZIE8S8GvSWSlkgeVvU0q0oM8wvbtLzo2v/K44xxjQRmhQ+29muFlTw
         Dl2w7o8uZrKpvDI7gx9z0a4c0XmaTr3pwVzt+jeg=
Date:   Tue, 22 Jan 2019 20:29:16 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Paul Burton <paul.burton@mips.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        John Crispin <john@phrozen.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH 1/5] mips: cavium: no need to check return value of
 debugfs_create functions
Message-ID: <20190122192916.GB5676@kroah.com>
References: <20190122145742.11292-1-gregkh@linuxfoundation.org>
 <20190122145742.11292-2-gregkh@linuxfoundation.org>
 <20190122184855.GB2792@darkstar.musicnaut.iki.fi>
 <20190122192255.tjkmwgx25wvcp6y6@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122192255.tjkmwgx25wvcp6y6@pburton-laptop>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 07:22:57PM +0000, Paul Burton wrote:
> Hello,
> 
> On Tue, Jan 22, 2019 at 08:48:56PM +0200, Aaro Koskinen wrote:
> > On Tue, Jan 22, 2019 at 03:57:38PM +0100, Greg Kroah-Hartman wrote:
> > > -static int init_debufs(void)
> > > +static void init_debugfs(void)
> > >  {
> > > -	struct dentry *show_dentry;
> > >  	dir = debugfs_create_dir("oct_ilm", 0);
> > > -	if (!dir) {
> > > -		pr_err("oct_ilm: failed to create debugfs entry oct_ilm\n");
> > > -		return -1;
> > > -	}
> > > -
> > > -	show_dentry = debugfs_create_file("statistics", 0222, dir, NULL,
> > > -					  &oct_ilm_ops);
> > > -	if (!show_dentry) {
> > > -		pr_err("oct_ilm: failed to create debugfs entry oct_ilm/statistics\n");
> > > -		return -1;
> > > -	}
> > > -
> > > -	show_dentry = debugfs_create_file("reset", 0222, dir, NULL,
> > > -					  &reset_statistics_ops);
> > > -	if (!show_dentry) {
> > > -		pr_err("oct_ilm: failed to create debugfs entry oct_ilm/reset\n");
> > > -		return -1;
> > > -	}
> > > -
> > > +	debugfs_create_file("statistics", 0222, dir, NULL, &oct_ilm_ops);
> > > +	debugfs_create_file("reset", 0222, dir, NULL, &reset_statistics_ops);
> > >  	return 0;
> > 
> > The return needs to be deleted now that the function is void.
> 
> Well spotted - I'm happy to fix this up whilst applying the patch.

The fact that 0-day didn't catch this makes me worried, is this
platform/driver not being built there?

Thanks for catching this, sorry for the mistake.

greg k-h
