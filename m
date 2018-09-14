Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B64CFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E4E20853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:17:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39E4E20853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbeINNaX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 09:30:23 -0400
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:28829 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728095AbeINNaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 09:30:22 -0400
X-IronPort-AV: E=Sophos;i="5.53,372,1531785600"; 
   d="scan'208";a="79047226"
From:   Paul Durrant <Paul.Durrant@citrix.com>
To:     'Dongli Zhang' <dongli.zhang@oracle.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "jgross@suse.com" <jgross@suse.com>, Wei Liu <wei.liu2@citrix.com>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        Roger Pau Monne <roger.pau@citrix.com>,
        "srinivas.eeda@oracle.com" <srinivas.eeda@oracle.com>
Subject: RE: Introduce xenwatch multithreading (mtwatch)
Thread-Topic: Introduce xenwatch multithreading (mtwatch)
Thread-Index: AQHUS/1LGTQJb+yi6UGo2svnt8VKvqTvbVDw
Date:   Fri, 14 Sep 2018 08:16:59 +0000
Message-ID: <d22e093ccb8c441ba81c68ebcbb6bbef@AMSPEX02CL03.citrite.net>
References: <1536910456-13337-1-git-send-email-dongli.zhang@oracle.com>
In-Reply-To: <1536910456-13337-1-git-send-email-dongli.zhang@oracle.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Dongli Zhang [mailto:dongli.zhang@oracle.com]
> Sent: 14 September 2018 08:34
> To: xen-devel@lists.xenproject.org; linux-kernel@vger.kernel.org
> Cc: boris.ostrovsky@oracle.com; jgross@suse.com; Paul Durrant
> <Paul.Durrant@citrix.com>; Wei Liu <wei.liu2@citrix.com>;
> konrad.wilk@oracle.com; Roger Pau Monne <roger.pau@citrix.com>;
> srinivas.eeda@oracle.com
> Subject: Introduce xenwatch multithreading (mtwatch)
> 
> Hi,
> 
> This patch set introduces xenwatch multithreading (mtwatch) based on the
> below xen summit 2018 design session notes:

Ah, here is the cover letter... just not labelled 0/6.

> 
> https://lists.xenproject.org/archives/html/xen-devel/2018-07/msg00017.html
> 
> 
> xenwatch_thread is a single kernel thread processing the callback function
> for subscribed xenwatch events successively. The xenwatch is stalled in
> 'D'
> state if any of callback function is stalled and uninterruptible.
> 
> The domU 

I think you should use 'frontend'. It is perfectly possible that a frontend could run in dom0m if, say, the system were using a driver domain.

> create/destroy is failed if xenwatch is stalled in 'D' state as
> the paravirtual driver init/uninit cannot complete. Usually, the only
> option is to reboot dom0 server unless there is solution/workaround to

Similarly 'backend' instead of 'dom0', pointing out that this is bad because it is normal for a single backend domain to serve multiple frontend domains, and the PV protocol is not (yet) re-startable if a backend goes away.

  Paul

> move forward and complete the stalled xenwatch event callback function.
> Below is the output of 'xl create' when xenwatch is stalled (the issue is
> reproduced on purpose by hooking netif_receive_skb() to intercept an
> sk_buff sent out from vifX.Y on dom0 with patch at
> https://github.com/finallyjustice/patchset/blob/master/xenwatch-stall-by-
> vif.patch):
> 
> # xl create pv.cfg
> Parsing config from pv.cfg
> libxl: error: libxl_device.c:1080:device_backend_callback: Domain 2:unable
> to add device with path /local/domain/0/backend/vbd/2/51712
> libxl: error: libxl_create.c:1278:domcreate_launch_dm: Domain 2:unable to
> add disk devices
> libxl: error: libxl_device.c:1080:device_backend_callback: Domain 2:unable
> to remove device with path /local/domain/0/backend/vbd/2/51712
> libxl: error: libxl_domain.c:1073:devices_destroy_cb: Domain
> 2:libxl__devices_destroy failed
> libxl: error: libxl_domain.c:1000:libxl__destroy_domid: Domain 2:Non-
> existant domain
> libxl: error: libxl_domain.c:959:domain_destroy_callback: Domain 2:Unable
> to destroy guest
> libxl: error: libxl_domain.c:886:domain_destroy_cb: Domain 2:Destruction
> of domain failed
> 
> 
> The idea of this patch set is to create a per-domU xenwatch thread for
> each
> domid. The per-domid thread is created when the 1st pv backend device (for
> this domid and with xenwatch multithreading enabled) is created, while
> this
> thread is destroyed when the last pv backend device (for this domid and
> with xenwatch multithreading enabled) is removed. Per-domid xs_watch_event
> is never put on the default event list, but is put on the per-domid event
> list directly.
> 
> 
> For more details, please refer to the xen summit 2018 design session notes
> and presentation slides:
> 
> https://lists.xenproject.org/archives/html/xen-devel/2018-07/msg00017.html
> http://www.donglizhang.org/xenwatch_multithreading.pdf
> 
> ----------------------------------------------------------------
> 
> Dongli Zhang (6):
>     xenbus: prepare data structures and parameter for xenwatch
> multithreading
>     xenbus: implement the xenwatch multithreading framework
>     xenbus: dispatch per-domU watch event to per-domU xenwatch thread
>     xenbus: process otherend_watch event at 'state' entry in xenwatch
> multithreading
>     xenbus: process be_watch events in xenwatch multithreading
>     drivers: enable xenwatch multithreading for xen-netback and xen-
> blkback driver
> 
>  Documentation/admin-guide/kernel-parameters.txt |   3 +
>  drivers/block/xen-blkback/xenbus.c              |   3 +-
>  drivers/net/xen-netback/xenbus.c                |   1 +
>  drivers/xen/xenbus/xenbus_probe.c               |  24 +-
>  drivers/xen/xenbus/xenbus_probe_backend.c       |  32 +++
>  drivers/xen/xenbus/xenbus_xs.c                  | 357
> +++++++++++++++++++++++-
>  include/xen/xenbus.h                            |  70 +++++
>  7 files changed, 484 insertions(+), 6 deletions(-)
> 
> Thank you very much!
> 
> Dongli Zhang

