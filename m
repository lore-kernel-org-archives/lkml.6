Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4115C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6579220855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:52:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6579220855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbeIJOp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 10:45:27 -0400
Received: from mga05.intel.com ([192.55.52.43]:28206 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728063AbeIJOp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 10:45:27 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2018 02:52:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,355,1531810800"; 
   d="scan'208";a="87441673"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga004.fm.intel.com with SMTP; 10 Sep 2018 02:52:10 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 10 Sep 2018 12:52:10 +0300
Date:   Mon, 10 Sep 2018 12:52:09 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] thunderbolt: Obtain PCI slot number from DROM
Message-ID: <20180910095209.GK14465@lahna.fi.intel.com>
References: <cover.1536517047.git.lukas@wunner.de>
 <756f7148bc106d80d2e43273edd6dc8c48c1b87b.1536517047.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <756f7148bc106d80d2e43273edd6dc8c48c1b87b.1536517047.git.lukas@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 09, 2018 at 11:42:01PM +0200, Lukas Wunner wrote:
> +struct tb_drom_entry_pci {
> +	/* BYTES 0-1 */
> +	struct tb_drom_entry_header header;
> +	/* BYTE 2 */
> +	u8 unknown:5;
> +	u8 slot:3;
> +	/* BYTES 3-10 are only present on PCIe upstream ports */
> +} __packed;

No need for __packed unless you absolutely are certain the compiler does
not do the right thing. When I submitted the network driver, David
Miller explained this to me and I ended up dropping those.

Also use of bitfields is something we should avoid when touching
hardware/firmware records because compiler here can do all sorts of
tricks.

I know the driver is currently using quite many of them but I think it
is good for the new code not to include them anymore.
