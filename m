Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B92AC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46803222B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Iu0VoZYx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392701AbfBMQ2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 11:28:47 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:39264 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728150AbfBMQ2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 11:28:46 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1DGIaSZ103986;
        Wed, 13 Feb 2019 16:28:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=wx7Y2TIha6dVGdshZaOcrv7Qrw7Uy9yBsRD4sYdzn5c=;
 b=Iu0VoZYx8milwuwMJPaZOk2fhda7NXlgfjEWv/1iDZvTYU/2GkRrZOtVTBjpJ7qBbXdN
 c9uXnkTTaBah3dGzhEeqRgY/XHxr01x1LQFl/muYNv0d65MZlRrCiSCin6FlVLmLnpJb
 3czi6j2/v6DCz4YOqdF/NDK2na0bcHfFx7jlSAoQyipbYYhUeKmRbIy5Z/3zej8Y+qo8
 szvKNu6BatfIKkyYyRWBq9IyJaAzO2zuqR57muWkUZ8csSfTqtAHjlFTzB/dWqWstRcy
 TBjnGf4Ke0LSxZpSO8mKl1X8LXjlzY7dFMt9ts6NVqqlvMQD6pSVcaRLvee0iRyzOwTE pQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2qhrekk26u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Feb 2019 16:28:25 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1DGSPOY029844
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Feb 2019 16:28:25 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1DGSPdr013578;
        Wed, 13 Feb 2019 16:28:25 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Feb 2019 08:28:24 -0800
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 1E99D6A0133; Wed, 13 Feb 2019 11:28:21 -0500 (EST)
Date:   Wed, 13 Feb 2019 11:28:21 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Eric Auger <eric.auger@redhat.com>
Cc:     eric.auger.pro@gmail.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, alex.williamson@redhat.com
Subject: Re: [PATCH] vfio_pci: Enable memory accesses before calling
 pci_map_rom
Message-ID: <20190213162821.GC22883@char.us.oracle.com>
References: <20190213101406.3934-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213101406.3934-1-eric.auger@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9165 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=791 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902130117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 11:14:06AM +0100, Eric Auger wrote:
> pci_map_rom/pci_get_rom_size() performs memory access in the ROM.
> In case the Memory Space accesses were disabled, readw() is likely to
> crash the host with a synchronous external abort (aarch64).

Ouch. Is there an CVE for this?

Also I think this can cause x86 machines to blow up.

See https://xenbits.xen.org/xsa/advisory-120.html
> 
> In case memory accesses were disabled, re-enable them before the call
> and disable them back again just after.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  drivers/vfio/pci/vfio_pci.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index ff60bd1ea587..96b8bbd909d7 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -706,8 +706,10 @@ static long vfio_pci_ioctl(void *device_data,
>  			break;
>  		case VFIO_PCI_ROM_REGION_INDEX:
>  		{
> +			bool mem_access_disabled;
>  			void __iomem *io;
>  			size_t size;
> +			u16 cmd;
>  
>  			info.offset = VFIO_PCI_INDEX_TO_OFFSET(info.index);
>  			info.flags = 0;
> @@ -723,6 +725,13 @@ static long vfio_pci_ioctl(void *device_data,
>  					break;
>  			}
>  
> +			pci_read_config_word(pdev, PCI_COMMAND, &cmd);
> +			mem_access_disabled = !(cmd & PCI_COMMAND_MEMORY);
> +			if (mem_access_disabled) {
> +				cmd |= PCI_COMMAND_MEMORY;
> +				pci_write_config_word(pdev, PCI_COMMAND, cmd);
> +			}
> +
>  			/* Is it really there? */
>  			io = pci_map_rom(pdev, &size);
>  			if (!io || !size) {
> @@ -731,6 +740,11 @@ static long vfio_pci_ioctl(void *device_data,
>  			}
>  			pci_unmap_rom(pdev, io);
>  
> +			if (mem_access_disabled) {
> +				cmd &= ~PCI_COMMAND_MEMORY;
> +				pci_write_config_word(pdev, PCI_COMMAND, cmd);
> +			}
> +
>  			info.flags = VFIO_REGION_INFO_FLAG_READ;
>  			break;
>  		}
> -- 
> 2.20.1
> 
