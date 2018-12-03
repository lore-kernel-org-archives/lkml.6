Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFADC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5331520850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:35:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5331520850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbeLCMgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 07:36:20 -0500
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:41657 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbeLCMgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 07:36:19 -0500
X-IronPort-AV: E=Sophos;i="5.56,310,1539648000"; 
   d="scan'208";a="82686130"
Date:   Mon, 3 Dec 2018 13:35:19 +0100
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
CC:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Dwayne Litzenberger <dlitz@dlitz.net>,
        <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [Xen-devel] [PATCH 1/2] xen-pciback: Fix error return in
 bar_write() and rom_write()
Message-ID: <20181203123519.l34a4yx26qle3whb@mac>
References: <cover.55c0e31b75e2fbdf4206cc39c2fd7581793ae7ae.1543772656.git-series.marmarek@invisiblethingslab.com>
 <f5ea0f3c2e29a96b59e409e4ae4c62de11a05fc8.1543772656.git-series.marmarek@invisiblethingslab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f5ea0f3c2e29a96b59e409e4ae4c62de11a05fc8.1543772656.git-series.marmarek@invisiblethingslab.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 02, 2018 at 06:47:32PM +0100, Marek Marczykowski-Górecki wrote:
> From: Dwayne Litzenberger <dlitz@dlitz.net>

I think this requires some description. At least a note that the
function is not altered, just errors from pci reads/writes are no
longer ignored.

> Signed-off-by: Dwayne Litzenberger <dlitz@dlitz.net>
> ---
>  drivers/xen/xen-pciback/conf_space_header.c | 24 ++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/xen/xen-pciback/conf_space_header.c b/drivers/xen/xen-pciback/conf_space_header.c
> index 10ae24b..697d0a8 100644
> --- a/drivers/xen/xen-pciback/conf_space_header.c
> +++ b/drivers/xen/xen-pciback/conf_space_header.c
> @@ -135,6 +135,7 @@ static int command_write(struct pci_dev *dev, int offset, u16 value, void *data)
>  
>  static int rom_write(struct pci_dev *dev, int offset, u32 value, void *data)
>  {
> +	int err = 0;
>  	struct pci_bar_info *bar = data;
>  
>  	if (unlikely(!bar)) {
> @@ -150,17 +151,22 @@ static int rom_write(struct pci_dev *dev, int offset, u32 value, void *data)
>  		bar->which = 1;
>  	else {
>  		u32 tmpval;
> -		pci_read_config_dword(dev, offset, &tmpval);
> +		err = pci_read_config_dword(dev, offset, &tmpval);
> +		if (err)
> +			goto out;

I don't think you need the out label, you could just return err.
Adding the label doesn't help in any way IMO, just makes the function
one line longer for no reason.

Same for the out label added to bar_write.

Thanks, Roger.
