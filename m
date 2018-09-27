Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38002C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 21:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E504B21571
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 21:46:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E504B21571
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbeI1EGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 00:06:24 -0400
Received: from mga03.intel.com ([134.134.136.65]:16332 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbeI1EGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 00:06:24 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Sep 2018 14:46:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,312,1534834800"; 
   d="scan'208";a="74413151"
Received: from agluck-desk.sc.intel.com (HELO agluck-desk) ([10.3.52.160])
  by fmsmga008.fm.intel.com with ESMTP; 27 Sep 2018 14:44:01 -0700
Date:   Thu, 27 Sep 2018 14:44:01 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Russ Anderson <rja@hpe.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Justin Ernst <justin.ernst@hpe.com>, russ.anderson@hpe.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aristeu Rozanski Filho <arozansk@redhat.com>
Subject: Re: [PATCH] Raise maximum number of memory controllers
Message-ID: <20180927214400.GA2249@agluck-desk>
References: <20180925175023.GA16725@agluck-desk>
 <20180925180458.GG23986@zn.tnic>
 <20180926093510.GA5584@zn.tnic>
 <20180926152752.GG5584@zn.tnic>
 <20180926130340.6b22918b@coco.lan>
 <20180926161749.GI5584@zn.tnic>
 <20180926181035.GA1132@agluck-desk>
 <20180926182317.patqjso7nzw2oxiz@hpe.com>
 <20180926230257.GA5666@agluck-desk>
 <20180927045244.GA30912@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927045244.GA30912@zn.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 06:52:44AM +0200, Borislav Petkov wrote:
> On Wed, Sep 26, 2018 at 04:02:57PM -0700, Luck, Tony wrote:
> > But ... we are at -rc5. Not sure that we'll figure out, write, test & debug
> > the proper solution in the next 3-4 weeks. So perhaps we should apply
> > 
> > -#define EDAC_MAX_MCS   16
> > +#define EDAC_MAX_MCS   64
> > 
> > as a temporary band-aid to get HPE's 32-socket machine running while
> > we work on the proper fix?
> 
> Yeah, after sleeping on it I see it the same way - band-aid it now and
> clean it up properly later.

The problem with your patch that gets rid of EDAC_MAX_MCS is making
device links under /sys/bus/edac.  Which is hinted at in some of the
code your patch deleted:

-       /*
-        * The memory controller needs its own bus, in order to avoid
-        * namespace conflicts at /sys/bus/edac.
-        */
-       name = kasprintf(GFP_KERNEL, "mc%d", mci->mc_idx);
-       if (!name)
-               return -ENOMEM;
-
-       mci->bus->name = name;
-
-       edac_dbg(0, "creating bus %s\n", mci->bus->name);
-
-       err = bus_register(mci->bus);

Just to see if there was anything else wrong I added a patch to
make the names unique:


diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
index 2ca2012f2857..6ec6d8a2adb8 100644
--- a/drivers/edac/edac_mc_sysfs.c
+++ b/drivers/edac/edac_mc_sysfs.c
@@ -410,7 +410,7 @@ static int edac_create_csrow_object(struct mem_ctl_info *mci,
 	device_initialize(&csrow->dev);
 	csrow->dev.parent = &mci->dev;
 	csrow->mci = mci;
-	dev_set_name(&csrow->dev, "csrow%d", index);
+	dev_set_name(&csrow->dev, "mci%d_csrow%d", mci->mc_idx, index);
 	dev_set_drvdata(&csrow->dev, csrow);
 
 	edac_dbg(0, "creating (virtual) csrow node %s\n",
@@ -641,9 +641,9 @@ static int edac_create_dimm_object(struct mem_ctl_info *mci,
 
 	dimm->dev.parent = &mci->dev;
 	if (mci->csbased)
-		dev_set_name(&dimm->dev, "rank%d", index);
+		dev_set_name(&dimm->dev, "mci%d_rank%d", mci->mc_idx, index);
 	else
-		dev_set_name(&dimm->dev, "dimm%d", index);
+		dev_set_name(&dimm->dev, "mci%d_dimm%d", mci->mc_idx, index);
 	dev_set_drvdata(&dimm->dev, dimm);
 	pm_runtime_forbid(&mci->dev);
 

which seemed to work.  But then I began wondering what are ABI expectations
from applications that read the EDAC /sys files?

Is this this current source repository?  https://github.com/grondo/edac-utils

This code doesn't seem to know about the "dimm*" directories below the
"mc*" level. It just looks for the csrow* entries.

-Tony
