Return-Path: <pjones@redhat.com>
X-Google-Smtp-Source: AIpwx4/IF6cFZRLaid8giAjRBEebFYmjq1ZPkKE8TqhIu8ExjiWmJOgPFB9UULTNwiozxt6t2i4I
ARC-Seal: i=1; a=rsa-sha256; t=1522785216; cv=none;
        d=google.com; s=arc-20160816;
        b=frwmCgLP2Svl58Tycxd/AT4c2o5M1SwDz/4v74L6KO8VfflGVb9WT6W5STcMt7llCI
         aSOpATpBEE+2eMSfpBBUemhr0P+ciHqG5vuSl2K4q3RbNlVFrKzXYOmwD/C3a8nus1C4
         EEfjTVhVtfwiraKpDPylvPPsunmUrz4AGIk6N4g2sPHBuEDh34KggPIAtGyPai3Zxi0x
         h5jdgINTMDwqkSiBb0xGJ1iH0u4SlfqqyORdBtRtONxxw/fOcDIF3b4AcNZl/Nvg5rIM
         sEK4YFfJ70jXzoppyQLc3AgB0mgn0v0qk9FSiFlxy9gbqFVa36qxtbIcwUg2A0MlFOjy
         YjNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=TnE6LmlqoREm9nppaIJ2pnPK2WM6TCUppuQ7QZ2veJk=;
        b=QcQBrt/ldlFr6NHoio0Pcie6RTpNoJNvt5dHk+T3s+bxJxOf2qEv1ovg2OvHN+MF2U
         r75nmNan3eIPjp3q8eUX+U1BT3y2qdogPFuPkDSdayifd+Tdn47WYDfWm3yxY5FbuxXv
         PW5k8uDBB/fajDSuETrN4Uuy8FkL7zyZMYwFGABho8buyZ6foLvVDfrt6rYsT29i2GRF
         lNOXmYdv6g5eG9IYnZOOD5tbtL0lyWhMxKvPTH+U5+jBjSxrpBziz8n0gM2JfPUBfuF9
         1wXm1ot0HswU075CdJPIkLmRfi6wvmnT4svhcOSqVeKNI+O8a+rGfbFMuco2AV623yzk
         xg9g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of pjones@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=pjones@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of pjones@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=pjones@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Date: Tue, 3 Apr 2018 12:53:34 -0700
From: Peter Jones <pjones@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org, Dave Olsthoorn <dave@bewaar.me>,
	x86@kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH 2/2] efi: Add embedded peripheral firmware support
Message-ID: <20180403195332.tezh6alee26aic2s@redhat.com>
References: <20180331121944.8618-1-hdegoede@redhat.com>
 <20180331121944.8618-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180331121944.8618-2-hdegoede@redhat.com>
User-Agent: NeoMutt/20171215
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596455691844480056?=
X-GMAIL-MSGID: =?utf-8?q?1596756031294781442?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 31, 2018 at 02:19:44PM +0200, Hans de Goede wrote:
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index fddc5f706fd2..1a5ea950f58f 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -455,6 +455,7 @@ int __init efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *out_md)
>  		u64 end;
>  
>  		if (!(md->attribute & EFI_MEMORY_RUNTIME) &&
> +		    md->type != EFI_BOOT_SERVICES_CODE &&
>  		    md->type != EFI_BOOT_SERVICES_DATA &&
>  		    md->type != EFI_RUNTIME_SERVICES_DATA) {
>  			continue;

Might be worth adding a comment here to ensure nobody comes along later
and adds something like EFI_BOOT_LOADER_DATA or other stuff that's
allocated later here.  I don't want to accidentally patch our way into
having the ability to stumble across a firmware blob somebody dumped
into the middle of a grub config file, especially since you only need to
collide crc32 (within the same length) to pre-alias a match.

...
> +static int __init efi_check_md_for_embedded_firmware(
> +	efi_memory_desc_t *md, const struct embedded_fw_desc *desc)
> +{
...
> +	if (found_fw_count >= MAX_EMBEDDED_FIRMWARES) {
> +		pr_err("Error already have %d embedded firmwares\n",
> +		       MAX_EMBEDDED_FIRMWARES);
> +		return -ENOSPC;
> +	}

Doesn't seem like this needs to be pr_err(); after all we have already
found a valid match, so the firmware vendor has done something
moderately stupid, but we have a firmware that will probably work.  Of
course it still needs to return != 0, but pr_warn() or even pr_info()
seems more reasonable.

Aside from those nits, looks good to me.

Reviewed-by: Peter Jones <pjones@redhat.com>

-- 
  Peter
