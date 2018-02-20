Return-Path: <fthain@telegraphics.com.au>
X-Google-Smtp-Source: AH8x224cmy9d170Dh7UQJvlhJBO3u0to1M9mVo/UAuVcTy2hPFpTUbAOZYjNs+ZEDgLYWy/cj0+h
ARC-Seal: i=1; a=rsa-sha256; t=1519166687; cv=none;
        d=google.com; s=arc-20160816;
        b=N1uj3nbhl+46SLFcLz2y/LCpd0xMAMUJOkk0LRa1OAObrMXJ1ZA/SQ1CkBByUMo7i8
         G0O/Ie5sUeXivvJGEwcOQoJrfcyDVw5e1BB6GXDTOQEg4zCJwLaI4iix0vbGm+InSmVi
         XRH10S2lJjS90gR5T9LBe6xXbqB6Wwndb2kuNc2hCK6jlO3CkxZp/RyJd+bdFbfz1lvk
         T7GET/mdthY7PqtVmTyGTclyDnlt1H6fGsEmiL07XiNTgSOx3YM+qtqim5EdNq4HWhxh
         zTozFw+yxXEBXHY/n/ZAXOxc1sY/tyMVeBDWWJ4up56m+Fei+mRdbOoO2WaA9uOaV/4C
         JpVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:arc-authentication-results;
        bh=J6Wv/B9k4oXOJzuSOAVJ2+ZcA428yjT8W04x3MuWHec=;
        b=b6ga0dg6GNImps/uWA7Onh8Xdui5Qgbc7nFz82J1r13SSCK9xt68t98orsvueiPW80
         +4j8yunXOrCPhRREZb2MQynJpTHDFe15Y14NxZs/8t9BOJTJ+ZdKPPLeNeZbCHN5pwEn
         GND/ECqa69bJ6tU2/gLnz38Ae3q6hK/zOM3+AulWlOPafZ8fv8kze052bP16m/lUvMpx
         7ioJoRZjI3AP4AHov5WNVGtB9Ujcgc7KFJfeXL1YV2p3ggmkOpjL3fCJKxLbzfvtpgLR
         GRx6UkBOH2wgFRKQgaCuZdOsu+wGBaKnDa3nH8yECrLDOzc987GVssU1qkzDNFqkQbcl
         /fqA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of fthain@telegraphics.com.au designates 98.124.60.144 as permitted sender) smtp.mailfrom=fthain@telegraphics.com.au
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of fthain@telegraphics.com.au designates 98.124.60.144 as permitted sender) smtp.mailfrom=fthain@telegraphics.com.au
Date: Wed, 21 Feb 2018 09:44:45 +1100 (AEDT)
From: Finn Thain <fthain@telegraphics.com.au>
To: Arnd Bergmann <arnd@arndb.de>
cc: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
    linux-kernel@vger.kernel.org, Michael Schmitz <schmitzmic@gmail.com>,
    "James E.J. Bottomley" <JBottomley@odin.com>,
    "Martin K. Petersen" <martin.petersen@oracle.com>,
    linux-scsi@vger.kernel.org
Subject: Re: [4.4-stable 08/22] ncr5380: shut up gcc indentation warning
In-Reply-To: <20180220115527.1806578-9-arnd@arndb.de>
Message-ID: <alpine.LNX.2.21.1802210932350.8@nippy.intranet>
References: <20180220115527.1806578-1-arnd@arndb.de> <20180220115527.1806578-9-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592921053566092317?=
X-GMAIL-MSGID: =?utf-8?q?1592961728531422345?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 20 Feb 2018, Arnd Bergmann wrote:

> gcc-6 and higher warn about the way some loops are written in
> the ncr5380 driver:
> 
> drivers/scsi/g_NCR5380.c: In function 'generic_NCR5380_pread':
> drivers/scsi/g_NCR5380.c:541:3: error: this 'while' clause does not guard... [-Werror=misleading-indentation]
>    while (NCR5380_read(C400_CONTROL_STATUS_REG) & CSR_HOST_BUF_NOT_RDY);
>    ^~~~~
> drivers/scsi/g_NCR5380.c:544:3: note: ...this statement, but the latter is misleadingly indented as if it is guarded by the 'while'
> 
> This was addressed in mainline kernels as part of a rework on commit
> 12150797d064 ("ncr5380: Use runtime register mapping").

Acked-by: Finn Thain <fthain@telegraphics.com.au>

> We don't want the entire patch backported to stable kernels, but we can 
> backport one hunk to get rid of the warning.

Or "backport something equivalent to one hunk".

> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/scsi/g_NCR5380.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/g_NCR5380.c b/drivers/scsi/g_NCR5380.c
> index f8d2478b11cc..87e081f8a386 100644
> --- a/drivers/scsi/g_NCR5380.c
> +++ b/drivers/scsi/g_NCR5380.c
> @@ -538,7 +538,10 @@ static inline int NCR5380_pread(struct Scsi_Host *instance, unsigned char *dst,
>  			printk(KERN_ERR "53C400r: Got 53C80_IRQ start=%d, blocks=%d\n", start, blocks);
>  			return -1;
>  		}
> -		while (NCR5380_read(C400_CONTROL_STATUS_REG) & CSR_HOST_BUF_NOT_RDY);
> +		while (NCR5380_read(C400_CONTROL_STATUS_REG) & CSR_HOST_BUF_NOT_RDY)
> +		{
> +			// FIXME - no timeout
> +		}
>  
>  #ifndef SCSI_G_NCR5380_MEM
>  		{
> 
