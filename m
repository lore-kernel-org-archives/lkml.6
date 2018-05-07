Return-Path: <helgaas@kernel.org>
X-Google-Smtp-Source: AB8JxZpd7VdKQ9/ij+gXYRNMAtYUL8ltiVNXr3YHyj2G2UELWRlV3Q8S5pOG8n0fEoR70OwC9YW+
ARC-Seal: i=1; a=rsa-sha256; t=1525731240; cv=none;
        d=google.com; s=arc-20160816;
        b=EiTK0Fgdu7v1TXJf8pjCk2EWI4zdSA/ipb15HvvdPacY+zwUP3b3MH5vPUxX8Y2TfN
         gtyIxg8mFqKN8KvQy8uc+0kQ3jj8ayonoEbM7+wbW9oH6wCDbuHXJ8OfHJVE7qRzs+99
         9lM3NS+6hcS40v6pBw+ThDeOxL7U2xHfI6sCi/OzoawLvfITuXFBRI21sRuQCLu8U5Vp
         ANyNDgwznAbc7ZsLcs/X3m9snO+BIlmyw4IMuI2zNIZP08Xgt6KBgJ0qYYMXd55sk5Rz
         woMDTGCC/5aWtEnJOdEPRHtxWYHsSXfz+M7EtVOFDAr6RTsFo7LLt54EUHlgOe/Rmf45
         dhzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=ZqlLwvSFc/hSmyl9kTQCkx2rBKdcc9x60J08SiWk78c=;
        b=06qkAg7rD/bho5XF5+Im3aSSqmAPr0nilIqc0TbKh2Ss4A8AhYs7f/VnHegAqShccB
         poK/27o+sRWu0jyqqyebbV/Fot+y22ZIS1sXHLA8V/fMUBhVrjcYcLYCirRMFIz0UkU+
         cz01DtphPGGHwdIKM7nV8ua2rHWKVza7AC0xd4ovOS5dqsw8ljcnMsmqW4lRIn/eNSmu
         M8TdCr1L6g3oT2k3d1AltRM7f9sVymYiZZ3CterYlZycLFXKsAue2Fvm170Vispead6a
         F8Bhj5NG7A7kZPdRSftoXy2Z9cfCMf3fWkyFVz55R8dj5fOWPDB9IbWSCES40Uwk8mJR
         VJag==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=kuSjOT56;
       spf=pass (google.com: domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=kuSjOT56;
       spf=pass (google.com: domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Mon, 7 May 2018 17:13:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc: bhelgaas@google.com, alex_gagniuc@dellteam.com, austin_bolen@dell.com,
	shyam_iyer@dell.com, Frederick Lawler <fred@fredlawl.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] PCI/AER: Use a common function to print AER error bits
Message-ID: <20180507221342.GC161390@bhelgaas-glaptop.roam.corp.google.com>
References: <20180417170943.1767-1-mr.nuke.me@gmail.com>
 <20180430195218.27654-1-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180430195218.27654-1-mr.nuke.me@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598014086120567687?=
X-GMAIL-MSGID: =?utf-8?q?1599845160722633223?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 30, 2018 at 02:52:15PM -0500, Alexandru Gagniuc wrote:
> On errors reported from CPER, cper_print_bits() was used to log the
> AER bits. This resulted in hard-to-understand messages, without a
> prefix. Instead use __aer_print_error() for both native AER and CPER
> to provide a more consistent log format.
> 
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>

Applied to pci/aer for v4.18, thanks!

> ---
> 
> Changes since v1:
>   - Parse aer regs for first error pointer instead of disabling it
> On the Dell machine where I tested this, the first error pointer is
> reported correctly by firmware.
> 
>  drivers/pci/pcie/aer/aerdrv_errprint.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer/aerdrv_errprint.c b/drivers/pci/pcie/aer/aerdrv_errprint.c
> index cfc89dd57831..b5612cc51b63 100644
> --- a/drivers/pci/pcie/aer/aerdrv_errprint.c
> +++ b/drivers/pci/pcie/aer/aerdrv_errprint.c
> @@ -216,28 +216,30 @@ EXPORT_SYMBOL_GPL(cper_severity_to_aer);
>  void cper_print_aer(struct pci_dev *dev, int aer_severity,
>  		    struct aer_capability_regs *aer)
>  {
> -	int layer, agent, status_strs_size, tlp_header_valid = 0;
> +	int layer, agent, tlp_header_valid = 0;
>  	u32 status, mask;
> -	const char **status_strs;
> +	struct aer_err_info info;
>  
>  	if (aer_severity == AER_CORRECTABLE) {
>  		status = aer->cor_status;
>  		mask = aer->cor_mask;
> -		status_strs = aer_correctable_error_string;
> -		status_strs_size = ARRAY_SIZE(aer_correctable_error_string);
>  	} else {
>  		status = aer->uncor_status;
>  		mask = aer->uncor_mask;
> -		status_strs = aer_uncorrectable_error_string;
> -		status_strs_size = ARRAY_SIZE(aer_uncorrectable_error_string);
>  		tlp_header_valid = status & AER_LOG_TLP_MASKS;
>  	}
>  
>  	layer = AER_GET_LAYER_ERROR(aer_severity, status);
>  	agent = AER_GET_AGENT(aer_severity, status);
>  
> +	memset(&info, 0, sizeof(info));
> +	info.severity = aer_severity;
> +	info.status = status;
> +	info.mask = mask;
> +	info.first_error = PCI_ERR_CAP_FEP(aer->cap_control);
> +
>  	pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
> -	cper_print_bits("", status, status_strs, status_strs_size);
> +	__aer_print_error(dev, &info);
>  	pci_err(dev, "aer_layer=%s, aer_agent=%s\n",
>  		aer_error_layer[layer], aer_agent_string[agent]);
>  
> -- 
> 2.14.3
> 
