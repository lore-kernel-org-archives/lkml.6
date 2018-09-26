Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCF0C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 23:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 954A82154B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 23:03:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 954A82154B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbeI0FSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 01:18:31 -0400
Received: from mga06.intel.com ([134.134.136.31]:11979 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726107AbeI0FSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 01:18:31 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2018 16:03:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,308,1534834800"; 
   d="scan'208";a="83538618"
Received: from agluck-desk.sc.intel.com (HELO agluck-desk) ([10.3.52.160])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Sep 2018 16:02:57 -0700
Date:   Wed, 26 Sep 2018 16:02:57 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Russ Anderson <rja@hpe.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Justin Ernst <justin.ernst@hpe.com>, russ.anderson@hpe.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aristeu Rozanski Filho <arozansk@redhat.com>
Subject: Re: [PATCH] Raise maximum number of memory controllers
Message-ID: <20180926230257.GA5666@agluck-desk>
References: <20180925143449.284634-1-justin.ernst@hpe.com>
 <20180925152659.GE23986@zn.tnic>
 <20180925175023.GA16725@agluck-desk>
 <20180925180458.GG23986@zn.tnic>
 <20180926093510.GA5584@zn.tnic>
 <20180926152752.GG5584@zn.tnic>
 <20180926130340.6b22918b@coco.lan>
 <20180926161749.GI5584@zn.tnic>
 <20180926181035.GA1132@agluck-desk>
 <20180926182317.patqjso7nzw2oxiz@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926182317.patqjso7nzw2oxiz@hpe.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This issue has made me look a bit more at what EDAC puts in sysfs.
It seems like the current code inherits some useless baggage
from the device calls it makes.

E.g. all the "power" subdirectories:

$ find /sys/devices/system/edac -name power
/sys/devices/system/edac/power
/sys/devices/system/edac/mc/mc6/dimm3/power
/sys/devices/system/edac/mc/mc6/power
/sys/devices/system/edac/mc/mc6/csrow0/power
/sys/devices/system/edac/mc/mc6/dimm6/power
/sys/devices/system/edac/mc/mc6/dimm0/power
/sys/devices/system/edac/mc/mc6/dimm9/power
/sys/devices/system/edac/mc/mc4/dimm3/power
/sys/devices/system/edac/mc/mc4/power
... total of 50 of these ...

$ grep -r . /sys/devices/system/edac/mc/mc6/dimm0/power
/sys/devices/system/edac/mc/mc6/dimm0/power/runtime_active_time:0
/sys/devices/system/edac/mc/mc6/dimm0/power/runtime_status:unsupported
grep: /sys/devices/system/edac/mc/mc6/dimm0/power/autosuspend_delay_ms: Input/output error
/sys/devices/system/edac/mc/mc6/dimm0/power/runtime_suspended_time:0
/sys/devices/system/edac/mc/mc6/dimm0/power/control:auto

We don't have stats, nor control of power on a per memory controller
or per dimm basis. So all these files are just noise.


But ... we are at -rc5. Not sure that we'll figure out, write, test & debug
the proper solution in the next 3-4 weeks. So perhaps we should apply

-#define EDAC_MAX_MCS   16
+#define EDAC_MAX_MCS   64

as a temporary band-aid to get HPE's 32-socket machine running while
we work on the proper fix?

-Tony
