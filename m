Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751361AbeFCUDI (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 16:03:08 -0400
Received: from smtprelay0157.hostedemail.com ([216.40.44.157]:60205 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750952AbeFCUDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 16:03:07 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::,RULES_HIT:41:355:379:541:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:2898:2899:3138:3139:3140:3141:3142:3352:3622:3865:3867:3870:3871:3872:3873:4321:4605:5007:8957:10004:10400:10848:11026:11232:11658:11914:12043:12438:12679:12740:12760:12895:13069:13095:13311:13357:13439:14659:14721:21080:21212:21433:21627:30012:30054:30070:30080:30083:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.14.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:35,LUA_SUMMARY:none
X-HE-Tag: room66_1aeb472a87716
X-Filterd-Recvd-Size: 2226
Message-ID: <1800e18130f7f768128feea2755f2c6ea0af7241.camel@perches.com>
Subject: Re: [PATCH 3/3] message: fusion: Fix line over 80 characters
From: Joe Perches <joe@perches.com>
To: Varsha Rao <rvarsha016@gmail.com>
Cc: Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nicholas Mc Guire <der.herr@hofr.at>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date: Sun, 03 Jun 2018 13:03:03 -0700
In-Reply-To: <ae9327e821e82a9c9e6a41c1fa12ec02496189f2.1528031458.git.rvarsha016@gmail.com>
References: <cover.1528031458.git.rvarsha016@gmail.com>
         <ae9327e821e82a9c9e6a41c1fa12ec02496189f2.1528031458.git.rvarsha016@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-06-03 at 18:52 +0530, Varsha Rao wrote:
> Line over 80 characters is split to fix the following checkpatch issue:
> 
> WARNING: line over 80 characters
[]
> diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
[]
> @@ -5690,7 +5690,8 @@ mpt_inactive_raid_volumes(MPT_ADAPTER *ioc, u8 channel, u8 id)
>  		    buffer->PhysDisk[i].PhysDiskNum, &phys_disk) != 0)
>  			continue;
>  
> -		if (!(component_info = kmalloc(sizeof(*component_info), GFP_KERNEL)))
> +		if (!(component_info = kmalloc(sizeof(*component_info),
> +		      GFP_KERNEL)))
>  			continue;

It's much more common to split this into multiple statements like

		component_info = kmalloc(sizeof(*component_info), GFP_KERNEL);
		if (!component_info)
			continue;

but the continue in a loop with a known alloc failure
seems silly as the next alloc is also extremely likely
to fail as well.

btw: Are you actually using this code?

If not, perhaps it's better to send cleanup only patches
for files in drivers/staging as practice instead.
