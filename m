Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F11C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A6DB20866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:45:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A6DB20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbeIJOi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 10:38:26 -0400
Received: from mga06.intel.com ([134.134.136.31]:46449 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727593AbeIJOi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 10:38:26 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2018 02:45:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,355,1531810800"; 
   d="scan'208";a="71974902"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga008.jf.intel.com with SMTP; 10 Sep 2018 02:44:55 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 10 Sep 2018 12:44:54 +0300
Date:   Mon, 10 Sep 2018 12:44:54 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] thunderbolt: Correlate PCI devices with Thunderbolt
 ports
Message-ID: <20180910094454.GJ14465@lahna.fi.intel.com>
References: <cover.1536517047.git.lukas@wunner.de>
 <f53ea40a7487e145aa1a62c347cef1814072e140.1536517047.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f53ea40a7487e145aa1a62c347cef1814072e140.1536517047.git.lukas@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukas,

On Sun, Sep 09, 2018 at 11:42:01PM +0200, Lukas Wunner wrote:
> Ideas what we can do with correlation:
> 
> * Represent the relationship between PCI devices and Thunderbolt ports
>   with symlinks in sysfs.

I wonder is that really useful? I don't think we should be adding sysfs
entries without any real reason why it would be needed and who would be
using them.

> * Thunderbolt controllers up to revision 1 of Cactus Ridge 4C have to
>   use INTx because MSI signaling is broken.  This results in hotplug
>   ports sharing interrupts with other devices and, when daisy-chaining
>   multiple affected Thunderbolt controllers, can lead to extremely
>   unbalanced interrupt usage.  To avoid this we could prefer downstream
>   ports for tunnel establishment which do not share interrupts (based
>   on the nr_actions field of the correlated PCI device's irq_desc).
> 
> * Alternatively, we could use non-working MSI signaling on affected
>   controllers and synthesize an interrupt whenever a tunnel is
>   established or goes down on unplug.

Problem I see with this patch as it stands is that you add 200+ lines of
code into the driver that is not being used by anything as far as I
understand it.
