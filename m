Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C48C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AF7C20663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:18:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AF7C20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729682AbeKZVxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:53:40 -0500
Received: from mga11.intel.com ([192.55.52.93]:21749 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729648AbeKZVxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:53:39 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2018 02:59:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,281,1539673200"; 
   d="scan'208";a="99108902"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by FMSMGA003.fm.intel.com with SMTP; 26 Nov 2018 02:59:52 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 26 Nov 2018 12:59:51 +0200
Date:   Mon, 26 Nov 2018 12:59:51 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] thunderbolt: Prevent root port runtime suspend
 during NVM upgrade
Message-ID: <20181126105951.GE2296@lahna.fi.intel.com>
References: <20181126094746.65030-1-mika.westerberg@linux.intel.com>
 <20181126094746.65030-2-mika.westerberg@linux.intel.com>
 <20181126104639.GA29089@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126104639.GA29089@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 11:46:39AM +0100, Greg Kroah-Hartman wrote:
> On Mon, Nov 26, 2018 at 12:47:46PM +0300, Mika Westerberg wrote:
> > During NVM upgrade process the host router is hot-removed for a short
> > while. During this time it is possible that the root port is moved into
> > D3cold which would be fine if the root port could trigger PME on itself.
> > However, many systems actually do not implement it so what happens is
> > that the root port goes into D3cold and never wakes up unless userspace
> > does PCI config space access, such as running 'lscpi'.
> > 
> > For this reason we explicitly prevent the root port from runtime
> > suspending during NVM upgrade.
> > 
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> >  drivers/thunderbolt/switch.c | 40 ++++++++++++++++++++++++++++++++++--
> >  1 file changed, 38 insertions(+), 2 deletions(-)
> 
> Is this a regression?  If so, should it go to stable kernels?

It is not a regression.

> If not, and this never worked, should this just wait until 4.21-rc1?

Only reason I would like to have it included in v4.20 is that v4.20
started supporting PCI runtime PM for these systems so NVM upgrade would
then not work until v4.21.

But I'm fine either way and can send it to you later for v4.21 inclusion :)
