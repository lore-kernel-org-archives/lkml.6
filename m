Return-Path: <tcminyard@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520429660; cv=none;
        d=google.com; s=arc-20160816;
        b=RQGsjt1t2SNZgjkcUytgc8/Tn5tT6I6uqUmIWYk95DdxJbhivj2KF/n5Rq41y8XZCV
         5g8oZvDJxDB6WoGNqVdJMDQlzZ7lLCYSsrk4ejOPwLv5VJaT6BFOhKu/hpDPGFYcaUZO
         T9DUzJQHNLaN5Np0SQpQ16LEcvfWYtZ+5Vr23juP4ZmQxCByR2Nvy4AAv5EKmxqebk5b
         +5qpc3G6j+MXBfJQjEMqYKLX1nrA91IQ44wSZi4Om+rcbXoo2SFaSaTH7NupDp1pEiSQ
         4fP80nwYlhqP067Hb4a0wB54Jk9zM6R2yHR4YLfmzbiFFx2Fk7kbAYvxypJfYZafAchs
         ZQwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:reply-to
         :sender:dkim-signature:arc-authentication-results;
        bh=FysqmPdmAkG29KDtgnH5fTj3FNWwCJHdZRadBxIx48I=;
        b=kzLX32GV3Vc6qPAL1I9WR2LZkMC1YYnlHM9nbVs5JYaAbFhXVj3LFaOmGRdpEj5+To
         KQ/oOHkDXhBKTN3fTle1s0/rbV2NCDOnWWSrN5iss5yKoGx5T8xVFJ2nUjiwwa7USAG4
         M0lkqtxGnXmHDAswNoSITaWWets3K8A+CU/7JP43j7N9OCvuUJ07l3aKRXjB4btP0lKQ
         BVtX0LXNQfPB/wQu5yPyYuUbwvqrs05jHEVL/jf5X36feKRfx7pzPq1UdFralO9+UYaw
         4YsMOb8FVSV2fjykeMwgSJQGNo3DG69th+5zCGEv4n0I41Z7nnU+rYonCeLHAZMxZbUZ
         YYmA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=T9oT6844;
       spf=pass (google.com: domain of tcminyard@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tcminyard@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=T9oT6844;
       spf=pass (google.com: domain of tcminyard@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tcminyard@gmail.com
X-Google-Smtp-Source: AG47ELtUB4CpWwxchzqX+2T42MyB0A/I2X/AjgARc85Iv797K3YR1QODOVTw78h6LkIiztnRSssYsw==
Sender: Corey Minyard <tcminyard@gmail.com>
Reply-To: minyard@acm.org
Subject: Re: [PATCH] ipmi:ssif: Fix double probe from tryacpi and trydmi
To: Jiandi An <anjiandi@codeaurora.org>, arnd@arndb.de,
 gregkh@linuxfoundation.org
Cc: openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <1520401742-29371-1-git-send-email-anjiandi@codeaurora.org>
From: Corey Minyard <minyard@acm.org>
Message-ID: <fa7367db-4199-3dd6-0e51-e991a5fd97fb@acm.org>
Date: Wed, 7 Mar 2018 07:34:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520401742-29371-1-git-send-email-anjiandi@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594256783530173798?=
X-GMAIL-MSGID: =?utf-8?q?1594286052044085364?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/06/2018 11:49 PM, Jiandi An wrote:
> IPMI SSIF driver's parameter tryacpi and trydmi both
> are set to true.  The addition of IPMI DMI driver to
> create platform device for each IPMI device causes
> SSIF probe to be done twice on the same SMB I2C address
> for BMC.  Fix is to not call trydmi if tryacpi is able
> to find I2C address for BMC from SPMI ACPI table and
> probe successfully.

Why are you trying to do this?  Is something bad happening?

SPMI is not the preferred mechanism for detecting a device,
the preferred mechanism should be the acpi match table or
OF, followed by DMI, followed by SPMI.  In fact, it might be
best to just remove SPMI.

-corey

> Signed-off-by: Jiandi An <anjiandi@codeaurora.org>
> ---
>   drivers/char/ipmi/ipmi_ssif.c | 35 ++++++++++++++++++++++++-----------
>   1 file changed, 24 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
> index 9d3b0fa..5c57363 100644
> --- a/drivers/char/ipmi/ipmi_ssif.c
> +++ b/drivers/char/ipmi/ipmi_ssif.c
> @@ -1981,29 +1981,41 @@ static int try_init_spmi(struct SPMITable *spmi)
>   	return new_ssif_client(myaddr, NULL, 0, 0, SI_SPMI, NULL);
>   }
>   
> -static void spmi_find_bmc(void)
> +static int spmi_find_bmc(void)
>   {
>   	acpi_status      status;
>   	struct SPMITable *spmi;
>   	int              i;
> +	int              rc = 0;
>   
>   	if (acpi_disabled)
> -		return;
> +		return -EPERM;
>   
>   	if (acpi_failure)
> -		return;
> +		return -ENODEV;
>   
>   	for (i = 0; ; i++) {
>   		status = acpi_get_table(ACPI_SIG_SPMI, i+1,
>   					(struct acpi_table_header **)&spmi);
> -		if (status != AE_OK)
> -			return;
> +		if (status != AE_OK) {
> +			if (i == 0)
> +				return -ENODEV;
> +			else
> +				return 0;
> +		}
>   
> -		try_init_spmi(spmi);
> +		rc = try_init_spmi(spmi);
> +		if (rc)
> +			return rc;
>   	}
> +
> +	return 0;
>   }
>   #else
> -static void spmi_find_bmc(void) { }
> +static int spmi_find_bmc(void)
> +{
> +	return -ENODEV;
> +}
>   #endif
>   
>   #ifdef CONFIG_DMI
> @@ -2104,12 +2116,13 @@ static int init_ipmi_ssif(void)
>   			       addr[i]);
>   	}
>   
> -	if (ssif_tryacpi)
> +	if (ssif_tryacpi) {
>   		ssif_i2c_driver.driver.acpi_match_table	=
>   			ACPI_PTR(ssif_acpi_match);
> -
> -	if (ssif_tryacpi)
> -		spmi_find_bmc();
> +		rv = spmi_find_bmc();
> +		if (!rv)
> +			ssif_trydmi = false;
> +	}
>   
>   	if (ssif_trydmi) {
>   		rv = platform_driver_register(&ipmi_driver);
