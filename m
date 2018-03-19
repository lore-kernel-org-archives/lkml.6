Return-Path: <vinod.koul@intel.com>
X-Google-Smtp-Source: AG47ELtoC+Sk542gUQ3Vq3aid8uGz6ty8lJv5UXdlvdLMwztEG2z0Qjiwsk4wDh0Jlr5BBrXqbCf
ARC-Seal: i=1; a=rsa-sha256; t=1521428676; cv=none;
        d=google.com; s=arc-20160816;
        b=zolq0O5zAMPyHl1osc87Kn7Z41Wc11sJ/WwkkebO1LX5Md+zSKZ2Z/8/17j4VoJ4GA
         +P9vw+oIA/9uv9asqw3z2iFzTO29ra0vSMtye3wAhETngDbJSpHR9c5FlhsFiypCoYsa
         Ks3bTkEjBqtnsMs1O5o03NFbcjg517plu0PrTiABRZlhWtVJiDGXm4dS7Uymk0ZkhIeX
         vRjiP2l+B/RzqBHr+Ku+8v5LjFdIi36hrucL61B/WAuBdFIV42iI7i9EEgwXWitaa9yv
         IY0tuno+GtaAjkX3Tk5r/XelJB04Th/0QcT9EDjEOukltwYhcTJ8CfplJT9V7OvWm7zN
         URpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=Q7o0cc0w/GZLfnfgmAYp5UUwyjh9SXuauUbh9vrcW+g=;
        b=GXNAZpWd3wY+SvJ4x0IG3W/m6vEumaN5UKNyB33tyJKgJwuHUwwKJx8t60f8XDoqOE
         LBVfyUqfXCwO+jPcZnJ2zhyvuFHhd//esDLz3DA/tkLnTanfJqY85GayaPys/zBat1as
         ed0l3lHFG1gCcZUvgSdNhTOZrEMxO0iJTdQGuTcLEM/wtjE2Rn6xYCirbnDJu8uzKv8B
         gpOHNTB9fDTw7rM9dB+zHP3ACZZAuiMydN84rvEZIpISVFPiI8KH6ig8ISsT7dE+0akh
         j1MmtBvpCcCH7em7R9ezXbDp5jJhjau4XLhxNqCbx+dvqdI0Ra3KEDZVBWehcn4lTcNT
         Cbjw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of vinod.koul@intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=vinod.koul@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of vinod.koul@intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=vinod.koul@intel.com
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,328,1517904000";
   d="scan'208";a="29116003"
Date: Mon, 19 Mar 2018 08:38:41 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Peter Ujfalusi <peter.ujfalusi@ti.com>,
	Eric Anholt <eric@anholt.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.14 064/109] dmaengine: bcm2835-dma: Use
 vchan_terminate_vdesc() instead of desc_free
Message-ID: <20180319030840.GJ15443@localhost>
References: <20180316152329.844663293@linuxfoundation.org>
 <20180316152333.462064800@linuxfoundation.org>
 <20180316184640.rxw6kwvqghsmdgcc@xps>
 <20180317143253.GI15443@localhost>
 <20180318102417.GA30164@kroah.com>
 <20180318104451.GA19721@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180318104451.GA19721@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595109144645401566?=
X-GMAIL-MSGID: =?utf-8?q?1595333595912976156?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Mar 18, 2018 at 11:44:51AM +0100, Greg Kroah-Hartman wrote:
> On Sun, Mar 18, 2018 at 11:24:17AM +0100, Greg Kroah-Hartman wrote:
> > > > This patch is causing a build error on arm and arm64 per i.e.
> > > > https://kernelci.org/build/id/5aac017e59b5141cb1b3a4d5/
> > > > 
> > > > Builds are also failing for arm/arm64 on 4.15 and this patch seems to be a
> > > > problem there as well, but I have not verified it yet.
> > > 
> > > I think we are missing commit 1c7f072d94e8. Pls cherrypick that as well
> > > 
> > > commit 1c7f072d94e8b697fd9b70cdb268622a18faf522
> > > Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > > Date:   Tue Nov 14 16:32:04 2017 +0200
> > > 
> > >     dmaengine: virt-dma: Support for race free transfer termination
> > > 
> > > This adds vchan_terminate_vdesc API..
> > 
> > Thanks, that helped.  I've now added this and send out a -rc2 for this
> > kernel.
> 
> Oops, no, that broke the build for all arches :(
> 
> Let me just go drop this patch, and the two dmaengine patches that
> relied on this one.  If you think these should be applied to the stable
> trees, can you send me a series of working patches?

Okay let me grab your tree and cherry-pick all that is required and send
you. Stay tuned...

Thanks
-- 
~Vinod
