Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92608C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 08:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4934D20658
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 08:04:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4934D20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbeJVQWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 12:22:19 -0400
Received: from mga18.intel.com ([134.134.136.126]:46107 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727523AbeJVQWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 12:22:19 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2018 01:04:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,411,1534834800"; 
   d="scan'208";a="267697003"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga005.jf.intel.com with SMTP; 22 Oct 2018 01:04:50 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 22 Oct 2018 11:04:49 +0300
Date:   Mon, 22 Oct 2018 11:04:49 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] thunderbolt: Fix a missing-check bug
Message-ID: <20181022080449.GK2302@lahna.fi.intel.com>
References: <1540058151-17116-1-git-send-email-wang6495@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540058151-17116-1-git-send-email-wang6495@umn.edu>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Oct 20, 2018 at 12:55:51PM -0500, Wenwen Wang wrote:
> In tb_ctl_rx_callback(), the checksum of the received control packet is
> calculated on 'pkg->buffer' through tb_crc() and saved to 'crc32', Then,
> 'crc32' is compared with the received checksum to confirm the integrity of
> the received packet. If the checksum does not match, the packet will be
> dropped. In the following execution, 'pkg->buffer' will be copied through
> req->copy() and processed if there is an active request and the packet is
> what is expected.
> 
> The problem here is that the above checking process is performed directly
> on the buffer 'pkg->buffer', which is actually a DMA region. Given that the
> DMA region can also be accessed directly by a device at any time, it is
> possible that a malicious device controlled by an attacker can race to
> modify the content in 'pkg->buffer' after the checksum checking but before
> req->copy(). By doing so, the attacker can inject malicious data, which can
> cause undefined behavior of the kernel and introduce potential security
> risk.
> 
> This patch allocates a new buffer 'buf' to hold the data in 'pkg->buffer'.
> By performing the checking and copying on 'buf', rather than 'pkg->buffer',
> the above issue can be avoided.

Here same comment applies than to the previous one - this is something
that requires the attacker to have physical access to the system and
requires him to either replace the firmware or the hardware itself with
a malicious one and in that case protection like this here does not
actually help because they can just overwrite it directly.

BTW, just in case you send multiple patches to other subsystems as well
it is good to have $subject contain summary of the fix in a way that one
can distinguish between them. For example you sent 4 patches with all
having:

  thunderbolt: Fix a missing-check bug

in the $subject. So for example I originally thought that you sent the
same patch several times :)
