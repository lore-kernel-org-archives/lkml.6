Return-Path: <Ajay.Kathat@microchip.com>
X-Google-Smtp-Source: AB8JxZrCmMYc5uitth3HkafBIm0i38+ELCCMtMG9ScFdGzuRO8cDy3jRSNUAJjnxlhdyB+iUn5cm
ARC-Seal: i=1; a=rsa-sha256; t=1525098569; cv=none;
        d=google.com; s=arc-20160816;
        b=SFfORCQOizOwafl1VETLO2snRi0epd3g4q+SFaiFJxWXvXmoiclQ9AonY1SDQOdism
         S39h5wu90YDN+r0DYeGv4EmttuwOjGz20wUCiAsf9R6ssQ+5CYjkseBT0j2UBFMVTUw0
         6OuzqXKCLBQ97m9ykDU0HnMoCA3eQN/C4HB/0SvOI+E6gEPjnwpwpZm7TmtE19SHbDx+
         7Gn5p/5wlyBCp0hzv5NFYqVq3kDrcn3Z8YHDs4KY1a4Yp9xeRBMGBxO4PDGwsoEOStyH
         Vcy3C+/fnOkTUzoUNB6QQvQGxQ84GKrFouYrY1bd2pfQoZ0G/5QWm7koqO8x6hXF9leM
         mKMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=kPhMzkW91+ldwJv1vrnJygqXEZyrfw33/l1pKKF2xac=;
        b=hRHC1sjxkUXHXfTjs+H9JrJIYqQA7CRXIXH5oDCOFhWdpSU3Ny77bi1XmeM7BeHl2f
         3tsM6/N9Q5qCTTkXnDS0IOfFXD/ab0uAYGsCarYqeH6T8Oi22psb0nY6m1kEOpfFLaHu
         1fXbKsbxmvz740feApW8dFtY80cm3B/n7TjcMv1Rc/1mwFmGa9zGAkFII+65/OF/FZEW
         rzc6pBJvnj9EFwIHlfUecHxE4eXKSD9q3sp0t3utS1TekICjoVWi9jwbW4F9L0yqrYxh
         ACE9cZ/oVAZgdOYp6IfZ3w5XYzu1bnaqpnV0AbbFtH3ExMsG5ZpOQhIuhoyGnDXrsQgm
         RSUw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ajay.kathat@microchip.com designates 68.232.147.91 as permitted sender) smtp.mailfrom=Ajay.Kathat@microchip.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ajay.kathat@microchip.com designates 68.232.147.91 as permitted sender) smtp.mailfrom=Ajay.Kathat@microchip.com
X-IronPort-AV: E=Sophos;i="5.49,346,1520924400";
   d="scan'208";a="14353717"
Date: Mon, 30 Apr 2018 19:59:16 +0530
From: Ajay Singh <ajay.kathat@microchip.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
CC: Ganesh Krishna <ganesh.krishna@microchip.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, <linux-wireless@vger.kernel.org>,
	<devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
	<kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] staging: wilc1000: fix infinite loop and out-of-bounds
 access
Message-ID: <20180430195916.596a93eb@ajaysk-VirtualBox>
In-Reply-To: <20180430125040.GA19050@embeddedor.com>
References: <20180430125040.GA19050@embeddedor.com>
Organization: Microchip Technology
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599175544219202800?=
X-GMAIL-MSGID: =?utf-8?q?1599181757690379921?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Reviewed-by: Ajay Singh <ajay.kathat@microchip.com>

On Mon, 30 Apr 2018 07:50:40 -0500
"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> If i < slot_id is initially true then it will remain true. Also,
> as i is being decremented it will end up accessing memory out of
> bounds.
> 
> Fix this by incrementing *i* instead of decrementing it.

Nice catch!
Thanks for submitting the changes.

> 
> Addresses-Coverity-ID: 1468454 ("Infinite loop")
> Fixes: faa657641081 ("staging: wilc1000: refactor scan() to free
> kmalloc memory on failure cases")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
> 
> BTW... at first sight it seems to me that variables slot_id
> and i should be of type unsigned instead of signed.

Yes, 'slot_id' & 'i' can be changed to unsigned int.

> 
>  drivers/staging/wilc1000/wilc_wfi_cfgoperations.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
> b/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c index
> 3ca0c97..67104e8 100644 ---
> a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c +++
> b/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c @@ -608,7
> +608,7 @@ wilc_wfi_cfg_alloc_fill_ssid(struct cfg80211_scan_request
> *request, out_free:
>  
> -	for (i = 0; i < slot_id ; i--)
> +	for (i = 0; i < slot_id; i++)
>  		kfree(ntwk->net_info[i].ssid);
>  
>  	kfree(ntwk->net_info);



Regards,
Ajay
