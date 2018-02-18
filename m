Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751411AbeBRNPH (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 08:15:07 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:45601 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751339AbeBRNPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 08:15:04 -0500
X-Google-Smtp-Source: AH8x2260kFt+hRIjTCPyziK+DGTHEZbWW8vIoCgBXbC7MmETrRS+pnSiCGsuBdcZ4mW0duXInh0zkA==
Date: Sun, 18 Feb 2018 05:15:00 -0800
From: Tejun Heo <tj@kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] libata-scsi: Delete an unnecessary variable in
 ata_scsi_slave_config()
Message-ID: <20180218131500.GY695913@devbig577.frc2.facebook.com>
References: <52d9a12e-e420-b880-ac02-c8156d977264@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52d9a12e-e420-b880-ac02-c8156d977264@users.sourceforge.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 06:26:30PM +0100, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 16 Feb 2018 18:19:13 +0100
> 
> * Return a result code without storing it in an intermediate variable.
> 
> * Reduce the needed source code.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/ata/libata-scsi.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 66be961c93a4..93456cff051b 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -1345,14 +1345,9 @@ int ata_scsi_slave_config(struct scsi_device *sdev)
>  {
>  	struct ata_port *ap = ata_shost_to_port(sdev->host);
>  	struct ata_device *dev = __ata_scsi_find_dev(ap, sdev);
> -	int rc = 0;
>  
>  	ata_scsi_sdev_config(sdev);
> -
> -	if (dev)
> -		rc = ata_scsi_dev_config(sdev, dev);
> -
> -	return rc;
> +	return dev ? ata_scsi_dev_config(sdev, dev) : 0;

Let's do the following instead.

	if (dev)
		return ata_scsi..;
	else
		return 0;

Thanks.

-- 
tejun
