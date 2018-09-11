Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E538C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED0020866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:16:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CED0020866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbeIKRPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 13:15:13 -0400
Received: from mga17.intel.com ([192.55.52.151]:59277 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbeIKRPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 13:15:12 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2018 05:15:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,360,1531810800"; 
   d="scan'208";a="89459500"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga001.jf.intel.com with SMTP; 11 Sep 2018 05:15:49 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 11 Sep 2018 15:15:48 +0300
Date:   Tue, 11 Sep 2018 15:15:48 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Pasha Tatashin <Pavel.Tatashin@microsoft.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] Revert "x86/tsc: Consolidate init code"
Message-ID: <20180911121548.GW5565@intel.com>
References: <20180910121925.27682-1-ville.syrjala@linux.intel.com>
 <alpine.DEB.2.21.1809101443290.1292@nanos.tec.linutronix.de>
 <20180910140710.GR5565@intel.com>
 <alpine.DEB.2.21.1809101846160.1419@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.21.1809101846160.1419@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 06:53:54PM +0200, Thomas Gleixner wrote:
> On Mon, 10 Sep 2018, Ville Syrjälä wrote:
> 
> Good: 1718674.70 BogoMIPS (lpj=2863311530)
> Bad:   859455.59 BogoMIPS (lpj=1431852151)
> 
> while both kernels agree on the CPU frequency of 996MHz. This pretty much
> smells like the 32bit LPJ conversion bug which got fixed in rc3. Does the
> problem persist with rc3?

Indeed looks to be fixed by commit 17f6bac22493 ("x86/tsc:
Prevent result truncation on 32bit"). I both cherry-picked that
on top of rc2 to make sure it really is that commit, and also
tested plain rc3 to make sure it still works.

And comparing the bogomips between the three relevant commits makes
the bug pretty obvious in hindsight:
Calibrating delay loop (skipped), value calculated using timer frequency.. 1718674.70 BogoMIPS (lpj=2863311530)
Calibrating delay loop (skipped), value calculated using timer frequency.. 859455.59 BogoMIPS (lpj=1431852151)
Calibrating delay loop (skipped), value calculated using timer frequency.. 1994.50 BogoMIPS (lpj=3322410)

I suppose we just got very lucky with older kernels.

-- 
Ville Syrjälä
Intel
