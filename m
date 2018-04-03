Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754704AbeDCAm0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 20:42:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:47758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754550AbeDCAmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 20:42:24 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96A3F20CAA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
Subject: Re: [RFC PATCH v1] fw_lockdown: new micro LSM module to prevent
 loading unsigned firmware
To: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>
Cc: linux-security-module <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Luis R. Rodriguez" <mcgrof@suse.com>,
        "AKASHI, Takahiro" <takahiro.akashi@linaro.org>
References: <1510347775.3549.2.camel@linux.vnet.ibm.com>
From: Andy Lutomirski <luto@kernel.org>
Message-ID: <21dd4b88-f6e7-f6bb-e34d-ba8ef3755622@kernel.org>
Date: Mon, 2 Apr 2018 17:42:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1510347775.3549.2.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2017 01:02 PM, Mimi Zohar wrote:
> If the kernel is locked down and IMA-appraisal is not enabled, prevent
> loading of unsigned firmware.

> diff --git a/security/fw_lockdown/Kconfig b/security/fw_lockdown/Kconfig
> new file mode 100644
> index 000000000000..d6aef6ce8fee
> --- /dev/null
> +++ b/security/fw_lockdown/Kconfig
> @@ -0,0 +1,6 @@
> +config SECURITY_FW_LOCKDOWN
> +	bool "Prevent loading unsigned firmware"
> +	depends on LOCK_DOWN_KERNEL
> +	default y
> +	help
> +	  Prevent loading unsigned firmware in lockdown mode,

Please be honest about what this does.  This option makes your system 
useless if you don't use IMA-Appraisal and it offers a particular 
security benefit if you do you IMA-Appraisal.  How about making it 
depend on IMA-Appraisal?  Change the name to 
SECURITY_ONLY_LOAD_IMA_APPRAISED_FIRMWARE and adjust the text 
accordingly, please.

> +/**
> + * fw_lockdown_read_file - prevent loading of unsigned firmware
> + * @file: pointer to firmware
> + * @read_id: caller identifier
> + *
> + * Prevent loading of unsigned firmware in lockdown mode.

That comment gives a highly misleading impression of what this function 
does.

> + */
> +static int fw_lockdown_read_file(struct file *file, enum kernel_read_file_id id)
