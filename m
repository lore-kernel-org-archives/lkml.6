Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752315AbeCORox (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 13:44:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48378 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751372AbeCORow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 13:44:52 -0400
Date: Thu, 15 Mar 2018 10:44:48 -0700
From: Chris Leech <cleech@redhat.com>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: lduncan@suse.com, jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        linux-kernel@vger.kernel.org, open-iscsi@googlegroups.com,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: scsi_transport_iscsi: use put_device() instead of
 kfree()
Message-ID: <20180315174448.GB32176@straylight.hirudinean.org>
Mail-Followup-To: Chris Leech <cleech@redhat.com>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>, lduncan@suse.com,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        linux-kernel@vger.kernel.org, open-iscsi@googlegroups.com,
        linux-scsi@vger.kernel.org
References: <a77739e256b044c2e125e106165efc751ce4a0f6.1520422535.git.arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a77739e256b044c2e125e106165efc751ce4a0f6.1520422535.git.arvind.yadav.cs@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07, 2018 at 05:07:33PM +0530, Arvind Yadav wrote:
> Never directly free @dev after calling device_register(), even
> if it returned an error! Always use put_device() to give up the
> reference initialized.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/scsi/scsi_transport_iscsi.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
> 

> @@ -783,7 +781,7 @@ struct iscsi_iface *
>  
>  free_iface:
>  	put_device(iface->dev.parent);
> -	kfree(iface);
> +	put_device(&iface->dev);
>  	return NULL;
>  }
>  EXPORT_SYMBOL_GPL(iscsi_create_iface);

Am I reading the device code correctly that the parent reference is only
released in the unregister path (device_unregister calls device_del) and
so the manual put_device on the parent here is still correct?

Just want to make sure that's still needed with the call to put_device.

Other than that question, I this all looks good.
Thanks.

Signed-off-by: Chris Leech <cleech@redhat.com>
