Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95872C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 606EC2192B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BmG8A/hC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbfBOQmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 11:42:20 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:48588 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfBOQmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 11:42:19 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1FGYJ2S049004;
        Fri, 15 Feb 2019 16:41:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=iVjgmbc2XllPUTCKug9I6U8ieAopoBIASH5WaRM287U=;
 b=BmG8A/hC8ysleohaoVYLC+tRwuXkgMf3Vn4Spu/4J51VXimX58OdzzAjHtsfZCGNlXAD
 +bkZuIFQvaiD2MWCUFvUgn4v+WM/alobUxWurYNU9npExPbqw6YjqX8QSMfGiQeYEMH3
 YF0Z/nvDlYWB80KsDYMRdro6SRTW/H8xqZeSbu229C/pwXlheY4HowoQ0nyd9/RMmjlP
 +aMmRjhH5bezt+9BTWeuFFSsFmxKg4VLlpB3ANVvpzMqx0mXqK2T1E3qUM8+fZ0Et7fy
 +vPEagBKEDuKPnSKodIA1yXJo80yI5BoLK2QaFN4bFnPEVTwhovqjEOxaimY7uJNOqa9 8g== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2qhrekxve3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Feb 2019 16:41:46 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1FGfj5b026566
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Feb 2019 16:41:45 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1FGfimu018957;
        Fri, 15 Feb 2019 16:41:45 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 Feb 2019 08:41:44 -0800
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id C847A6A0123; Fri, 15 Feb 2019 11:41:43 -0500 (EST)
Date:   Fri, 15 Feb 2019 11:41:43 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Prarit Bhargava <prarit@redhat.com>, linux-kernel@vger.kernel.org
Cc:     xen-devel@lists.xenproject.org, jbeulich@suse.com,
        Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH] xen/pciback: Don't disable PCI_COMMAND on PCI device
 reset.
Message-ID: <20190215164143.GB889@char.us.oracle.com>
References: <20190213232131.18942-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213232131.18942-1-prarit@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9168 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902150114
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 06:21:31PM -0500, Prarit Bhargava wrote:
> From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> 

+LKML
> This was submitted in 2015 here
> 
> https://marc.info/?l=linux-kernel&m=142807132515973&w=2
> 
> and has been included in Fedora builds ever since.  No issues have been
> reported with the patch.
> 
> P.
> 
> ----8<----
> 
> There is no need for this at all. Worst it means that if
> the guest tries to write to BARs it could lead (on certain
> platforms) to PCI SERR errors.
> 
> Please note that with af6fc858a35b90e89ea7a7ee58e66628c55c776b
> "xen-pciback: limit guest control of command register"
> a guest is still allowed to enable those control bits (safely), but
> is not allowed to disable them and that therefore a well behaved
> frontend which enables things before using them will still
> function correctly.
> 
> This is done via an write to the configuration register 0x4 which
> triggers on the backend side:
> command_write
>   \- pci_enable_device
>      \- pci_enable_device_flags
>         \- do_pci_enable_device
>            \- pcibios_enable_device
>               \-pci_enable_resourcess
>                 [which enables the PCI_COMMAND_MEMORY|PCI_COMMAND_IO]
> 
> However guests (and drivers) which don't do this could cause
> problems, including the security issues which XSA-120 sought
> to address.
> 
> Reported-by: Jan Beulich <jbeulich@suse.com>
> Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Reviewed-by: Prarit Bhargava <prarit@redhat.com>
> Cc: Juergen Gross <jgross@suse.com>
> ---
>  drivers/xen/xen-pciback/pciback_ops.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/xen/xen-pciback/pciback_ops.c b/drivers/xen/xen-pciback/pciback_ops.c
> index ea4a08b83fa0..787966f44589 100644
> --- a/drivers/xen/xen-pciback/pciback_ops.c
> +++ b/drivers/xen/xen-pciback/pciback_ops.c
> @@ -127,8 +127,6 @@ void xen_pcibk_reset_device(struct pci_dev *dev)
>  		if (pci_is_enabled(dev))
>  			pci_disable_device(dev);
>  
> -		pci_write_config_word(dev, PCI_COMMAND, 0);
> -
>  		dev->is_busmaster = 0;
>  	} else {
>  		pci_read_config_word(dev, PCI_COMMAND, &cmd);
> -- 
> 2.18.1
> 
