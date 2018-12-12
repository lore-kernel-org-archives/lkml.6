Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CB6C65BAE
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 03:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CFB72086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 03:25:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CFB72086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbeLLDZB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 22:25:01 -0500
Received: from mga01.intel.com ([192.55.52.88]:7311 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbeLLDZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 22:25:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2018 19:25:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,343,1539673200"; 
   d="scan'208";a="98054101"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by orsmga007.jf.intel.com with ESMTP; 11 Dec 2018 19:25:01 -0800
Received: from orsmsx113.amr.corp.intel.com (10.22.240.9) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 11 Dec 2018 19:25:00 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.175]) by
 ORSMSX113.amr.corp.intel.com ([169.254.9.208]) with mapi id 14.03.0415.000;
 Tue, 11 Dec 2018 19:25:00 -0800
From:   "Brown, Aaron F" <aaron.f.brown@intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH] igb: Fix an issue that PME is not
 enabled during runtime suspend
Thread-Topic: [Intel-wired-lan] [PATCH] igb: Fix an issue that PME is not
 enabled during runtime suspend
Thread-Index: AQHUiszDi4/3vECryEGfUzr+GXoHV6V6frmw
Date:   Wed, 12 Dec 2018 03:24:59 +0000
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B965E5E94@ORSMSX101.amr.corp.intel.com>
References: <20181203055438.363-1-kai.heng.feng@canonical.com>
In-Reply-To: <20181203055438.363-1-kai.heng.feng@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces@osuosl.org] On
> Behalf Of Kai-Heng Feng
> Sent: Sunday, December 2, 2018 9:55 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: netdev@vger.kernel.org; Kai-Heng Feng
> <kai.heng.feng@canonical.com>; intel-wired-lan@lists.osuosl.org;
> davem@davemloft.net; linux-kernel@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH] igb: Fix an issue that PME is not enabled
> during runtime suspend
> 
> I210 ethernet card doesn't wakeup when a cable gets plugged. It's
> because its PME is not set.
> 
> Since commit 42eca2302146 ("PCI: Don't touch card regs after runtime
> suspend D3"), if the PCI state is saved, pci_pm_runtime_suspend() stops
> calling pci_finish_runtime_suspend(), which enables the PCI PME.
> 
> To fix the issue, let's not to save PCI states when it's runtime
> suspend, to let the PCI subsytem enables PME.
> 
> Fixes: 42eca2302146 ("PCI: Don't touch card regs after runtime suspend D3")
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
