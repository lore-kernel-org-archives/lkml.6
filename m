Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64B4C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B17F72086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547453444;
	bh=xPnyuXgi/m3IZTuEEswjUmveMd8U/Efyx+JRNla0eBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jPnLBzAPeB7fKs7dzJhykK8ae0NM9vj8w6HPwQ+L8dIBiwcmXm/KWM1TGTKzYfi5v
	 sw1rd2haJNShYXu6SLP/kp+M2pb2MNWRQntagkxYXRmZd9vjshv5V+LyOecwMoIvtJ
	 98iz3U/nSyHPrfF2bKkUDSSqW+twsFt8156O50MA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfANIKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 03:10:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:51088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbfANIKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 03:10:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEBA320659;
        Mon, 14 Jan 2019 08:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547453441;
        bh=xPnyuXgi/m3IZTuEEswjUmveMd8U/Efyx+JRNla0eBk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OOAfOoXrCH7zoSD6Nw8BOunrOjsHLsbhfv7wVpCJHfXSe3cKZjNiwLG8ceLu279wg
         9pRvMaH6aSREY3ZJgFhEvcTR4S/3F4ImWlncwu1lD+APtHArIxWv+ouyjtIhKKljUQ
         agP26u5CXWiF5AnA5+K870uOQ2aMozuTlgdDqPLs=
Date:   Mon, 14 Jan 2019 09:10:38 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Breno Leitao <leitao@debian.org>,
        Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Subject: Re: [PATCH 4.20 41/65] Revert "powerpc/tm: Unset MSR[TS] if not
 recheckpointing"
Message-ID: <20190114081038.GA25405@kroah.com>
References: <20190111131055.331350141@linuxfoundation.org>
 <20190111131102.136630542@linuxfoundation.org>
 <1547328527@msgid.manchmal.in-ulm.de>
 <20190113071140.GD5540@kroah.com>
 <87pnt0ds6e.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pnt0ds6e.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 11:00:25AM +1100, Michael Ellerman wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> > On Sat, Jan 12, 2019 at 10:35:59PM +0100, Christoph Biedl wrote:
> >> Greg Kroah-Hartman wrote...
> >> 
> >> > 4.20-stable review patch.  If anyone has any objections, please let me know.
> >> >
> >> > ------------------
> >> >
> >> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >> >
> >> > This reverts commit d412deb85a4aada382352a8202beb7af8921cd53 which is
> >> > commit 6f5b9f018f4c7686fd944d920209d1382d320e4e upstream.
> >> >
> >> > It breaks the powerpc build, so drop it from the tree until a fix goes
> >> > upstream.
> >> 
> >> Is this necessary on 4.20? The build failures I reported were on 4.19
> >> only. The 4.20.2-rc1 kernel for my Powermac G5 builds with and without
> >> that patch, both boot fine, no visible differences. Again however, Breno
> >> is authoritative here.
> >
> > If there's no difference on 4.20, then maybe it's not needed there?  :)
> >
> > And yes, I would like confirmation from Breno as well.
> 
> You shouldn't need the revert on 4.20.
> 
> In 4.20 we changed how MSR_TM_ACTIVE() is defined, which means commit
> 6f5b9f018f4c ("powerpc/tm: Unset MSR[TS] if not recheckpointing") should
> build fine on 4.20.
> 
> For 4.19 and earlier MSR_TM_ACTIVE() is different and that's what's
> causing the build error.
> 
> I have a fix queued in my fixes tree and will push it to Linus in the
> next few days.

Ok, added back to 4.20.y

thanks,

greg k-h
