Return-Path: <helgaas@kernel.org>
X-Google-Smtp-Source: AB8JxZrS88xKuulTVqw4I6Imbfu0jVxH4y9BRha7BePEMabXB/u6w9SsBpCK513qRVVSPIUH0bCg
ARC-Seal: i=1; a=rsa-sha256; t=1524869018; cv=none;
        d=google.com; s=arc-20160816;
        b=aeCR+ohBSfjc7x9CEFWL3d9aiALSdLbHFHvMjfqj1sj0rQZatKncPdLOuy1t7gAej3
         xsDy7TvR5uT67fo2xkT2464djOZq/f877tGayrlmMBp4GmeGXhZfOA0D0pvuaXj1YTmt
         9fyOa2FCwJROz1cjS8HTUh/kL/TOBYUjUjPecaBCaseANe/JxWyHarPnnbvB9KS7TOOi
         tdd/e3oHedOwRThhwboOUHlF3RHlZNFQYl3z/hajsG5yJe+NOGiQPbEmZFDM22wYaFaj
         jtCwU6P771aFLysJy2waQB8mVqEsz+eaOmL+6vI+4SVuB//eRIkfuYpC4sgO7DzBr8+K
         zkUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=bcbt8bcvlR6eTIb45DNac/YOXstKYHftNKIDDGlG7Ow=;
        b=H0rRmsRVCv0FlK6VsJVekwb4RAR0Tt1HuJN/Un1iWJELIwfTTYI64/QgFwQU+Rtyis
         FavQ400dD+bf5oF0J62XJZ631ITAzR5DayeacHcMYKdjPnulJnarXKQEhDwfiLsUlxNJ
         IF/g+64DW4ZvLQPDYRoDw+xdEg0hVYKs3iiTGZKlmCLP+qNVVpACGwI77Voffk7OQL2/
         OpdvnuonGpL2FK0iyw/zXamWc49QwXovjUxPLHv7pwgaqXIjqapMsCjMWGmxO4fXtXLJ
         nJiWzqp9sBxoNYa8BFqQYdP/1QGHr1CE2EWzwk/9vR5Cqu5yzUnmLT96t758GLfSuKpJ
         2K5w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2632D218EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=helgaas@kernel.org
Date: Fri, 27 Apr 2018 17:43:37 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org, fred@fredlawl.com,
	linux-kernel@vger.kernel.org, alex_gagniuc@dellteam.com,
	austin_bolen@dell.com, keith.busch@intel.com
Subject: Re: [PATCH RESEND] PCI/AER: Use a common function to print AER error
 bits
Message-ID: <20180427224337.GC73256@bhelgaas-glaptop.roam.corp.google.com>
References: <20180417170943.1767-1-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180417170943.1767-1-mr.nuke.me@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598014086120567687?=
X-GMAIL-MSGID: =?utf-8?q?1598941056527428960?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 17, 2018 at 12:09:43PM -0500, Alexandru Gagniuc wrote:
> On errors reported from CPER, cper_print_bits() was used to log the
> AER bits. This resulted in hard-to-understand messages, without a
> prefix. Instead use __aer_print_error() for both native AER and CPER
> to provide a more consistent log format.
> 
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> ---
>  drivers/pci/pcie/aer/aerdrv_errprint.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer/aerdrv_errprint.c b/drivers/pci/pcie/aer/aerdrv_errprint.c
> index cfc89dd57831..cfae4d52f848 100644
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
> +	info.first_error = 0x1f;

I like this patch a lot, but where does this "first_error = 0x1f" come
from?

I assume this is supposed to be the "First Error Pointer" in the
Advanced Error Capabilities and Control register (PCIe r4.0, sec
7.8.4.7).  There is a "cap_control" field in struct
aer_capability_regs; should we be using that here?

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
