Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id J7brDP6rGltoWAAAmS7hNA
	; Fri, 08 Jun 2018 16:17:38 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 5E6D46089E; Fri,  8 Jun 2018 16:17:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=2.0 tests=BAYES_00,FROM_EXCESS_BASE64,
	MAILING_LIST_MULTI autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id ECA7E601B4;
	Fri,  8 Jun 2018 16:17:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ECA7E601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752628AbeFHQRe (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 12:17:34 -0400
Received: from smtp.eu.citrix.com ([185.25.65.24]:51241 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751134AbeFHQRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 12:17:33 -0400
X-IronPort-AV: E=Sophos;i="5.49,490,1520899200";
   d="scan'208";a="74372451"
Date: Fri, 8 Jun 2018 18:17:19 +0200
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Stefano Stabellini <sstabellini@kernel.org>
CC: <linux-kernel@vger.kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v3] xen: share start flags between PV and PVH
Message-ID: <20180608161719.3zyns6dnr7w2nez4@mac>
References: <20180608084038.19344-1-roger.pau@citrix.com>
 <alpine.DEB.2.10.1806080909320.14699@sstabellini-ThinkPad-X260>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.10.1806080909320.14699@sstabellini-ThinkPad-X260>
User-Agent: NeoMutt/20180512
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 09:12:25AM -0700, Stefano Stabellini wrote:
> On Fri, 8 Jun 2018, Roger Pau Monne wrote:
> > Use a global variable to store the start flags for both PV and PVH.
> > This allows the xen_initial_domain macro to work properly on PVH.
> > 
> > Note that ARM is also switched to use the new variable.
> > 
> > Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> > Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> 
> As I already mentioned, the ARM part is OK. However, is the issue that
> xen_start_info is not available on PVH? We had the same problem on ARM
> and solved it by faking a xen_start_info page, see the top of
> arch/arm/xen/enlighten.c.
> 
> I would love to get rid of that, but to do that, we also need to remove
> the xen_start_info referece at drivers/tty/hvc/hvc_xen.c:255:
> 
>   if (!xen_start_info->console.domU.evtchn)
> 		return -ENODEV;

We could likely guard xen_pv_console_init (and other PV related
console functions) with CONFIG_PV. HVM/PVH use xen_hvm_console_init.

Roger.
