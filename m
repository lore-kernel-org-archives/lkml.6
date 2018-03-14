Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752052AbeCNVbs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 17:31:48 -0400
Received: from h2.hallyn.com ([78.46.35.8]:45028 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751781AbeCNVbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 17:31:36 -0400
Date: Wed, 14 Mar 2018 16:31:34 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Subject: Re: [PATCH 2/4] ima: Simplify ima_eventsig_init()
Message-ID: <20180314213134.GA14289@mail.hallyn.com>
References: <20180314202020.3794-1-bauerman@linux.vnet.ibm.com>
 <20180314202020.3794-3-bauerman@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314202020.3794-3-bauerman@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Thiago Jung Bauermann (bauerman@linux.vnet.ibm.com):
> The "goto out" statement doesn't have any purpose since there's no cleanup
> to be done when returning early, so remove it. This also makes the rc
> variable unnecessary so remove it as well.
> 
> Also, the xattr_len and fmt variables are redundant so remove them as well.
> 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>

Acked-by: Serge Hallyn <serge@hallyn.com>

> ---
>  security/integrity/ima/ima_template_lib.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
> index 28af43f63572..5afaa53decc5 100644
> --- a/security/integrity/ima/ima_template_lib.c
> +++ b/security/integrity/ima/ima_template_lib.c
> @@ -378,16 +378,11 @@ int ima_eventname_ng_init(struct ima_event_data *event_data,
>  int ima_eventsig_init(struct ima_event_data *event_data,
>  		      struct ima_field_data *field_data)
>  {
> -	enum data_formats fmt = DATA_FMT_HEX;
>  	struct evm_ima_xattr_data *xattr_value = event_data->xattr_value;
> -	int xattr_len = event_data->xattr_len;
> -	int rc = 0;
>  
>  	if ((!xattr_value) || (xattr_value->type != EVM_IMA_XATTR_DIGSIG))
> -		goto out;
> +		return 0;
>  
> -	rc = ima_write_template_field_data(xattr_value, xattr_len, fmt,
> -					   field_data);
> -out:
> -	return rc;
> +	return ima_write_template_field_data(xattr_value, event_data->xattr_len,
> +					     DATA_FMT_HEX, field_data);
>  }
