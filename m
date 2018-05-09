Return-Path: <poza@codeaurora.org>
X-Google-Smtp-Source: AB8JxZraxdQGCQ4JKVl3ooVqhuefCMRukvxtFAuAJAItdeh+37oq0naGxCG2/YI6T8xWR2OI3zuJ
ARC-Seal: i=1; a=rsa-sha256; t=1525871694; cv=none;
        d=google.com; s=arc-20160816;
        b=v+GlCadV5vZtRb8ShdFsspPdJTAiyjT1zV1a4Oqg6mo8cEb75LBhx3/Se4MsnzasxC
         X+U2a5KKljQE7wMb4VBlakfTufeemrpE06oG2runmmv39sm/DGFocuO0y1tPtcZGYfdY
         91GDzgYbgLAjhVEncuJ8gdtozOKn3IXxkQRBJI/lP6NTtVeh3J2EFup+vlsP+phJo3dk
         Q8zm8TfWHc6E0l3CZIOeD6r7mgOV71ri5O0XEzaFPt5tfaz4jzGSSOS4QzJSk56L5j0Y
         9ze5C6cFbiK+JbcKC2drK35Vm7xZk2HFbxwpD1Hu1HHn6aVJmyB3uE6XYP0207yHWmlG
         hw6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:message-id:references:in-reply-to:subject:cc:to:from
         :date:content-transfer-encoding:mime-version:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=6p7FnPSRktqZXZIpMhbP0vpzMiLmBy9Run0+BH1TQUU=;
        b=VgBEiHhFO/+F5w2Mo+OZve54E1+6Fxb3rn7wQSyhABLs1MhaBxafkkHvWmHNdCSFid
         silVeBNW5hZucpuxhyU1CBgVwP8gFIMx4oF6h569nT/rFwjWxOWKz4OhCCcqJ6mHQpzq
         oGac2SLw8wo2mfJ9Bi4DZL4mXZXhUXw8h0bT+D3Pecgwsv0DdlC3zp6XNpGbYSFwz5US
         13VjyCyl3lBrjIU+mpzAMAsMwDhvYE1BIO2kf3PXGTxAUQqAKVeTewi/sV6mXAPI2Wrm
         xgFoVQcHPnQouhwNdNqLXdzLCctoBZgwPQ2g+QaqbJNCw/rcQTTil5HSyfn6oXriFhT0
         iSEw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Q4LDS9Ul;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Q4LDS9Ul;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Q4LDS9Ul;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Q4LDS9Ul;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 09 May 2018 18:44:53 +0530
From: poza@codeaurora.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Philippe Ombredanne
 <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart
 <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>, Keith
 Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>, Sinan Kaya
 <okaya@codeaurora.org>, Timur Tabi <timur@codeaurora.org>,
 linux-pci-owner@vger.kernel.org
Subject: Re: [PATCH v15 3/9] PCI/AER: Handle ERR_FATAL with removal and
 re-enumeration of devices
In-Reply-To: <20180509130730.GA236548@bhelgaas-glaptop.roam.corp.google.com>
References: <1525323838-1735-1-git-send-email-poza@codeaurora.org>
 <1525323838-1735-4-git-send-email-poza@codeaurora.org>
 <20180508235330.GN161390@bhelgaas-glaptop.roam.corp.google.com>
 <20180509130730.GA236548@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <b1f9aaf43300ef7a829001e964bf4e72@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599417977501212020?=
X-GMAIL-MSGID: =?utf-8?q?1599992438213381573?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-05-09 18:37, Bjorn Helgaas wrote:
> On Tue, May 08, 2018 at 06:53:30PM -0500, Bjorn Helgaas wrote:
>> On Thu, May 03, 2018 at 01:03:52AM -0400, Oza Pawandeep wrote:
>> > This patch alters the behavior of handling of ERR_FATAL, where removal
>> > of devices is initiated, followed by reset link, followed by
>> > re-enumeration.
>> >
>> > So the errors are handled in a different way as follows:
>> > ERR_NONFATAL => call driver recovery entry points
>> > ERR_FATAL    => remove and re-enumerate
>> >
>> > please refer to Documentation/PCI/pci-error-recovery.txt for more details.
>> >
>> > Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
>> >
>> > diff --git a/drivers/pci/pcie/aer/aerdrv.c b/drivers/pci/pcie/aer/aerdrv.c
>> > index 779b387..206f590 100644
>> > --- a/drivers/pci/pcie/aer/aerdrv.c
>> > +++ b/drivers/pci/pcie/aer/aerdrv.c
>> > @@ -330,6 +330,13 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
>> >  	reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
>> >  	pci_write_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, reg32);
>> >
>> > +	/*
>> > +	 * This function is called only on ERR_FATAL now, and since
>> > +	 * the pci_report_resume is called only in ERR_NONFATAL case,
>> > +	 * the clearing part has to be taken care here.
>> > +	 */
>> > +	aer_error_resume(dev);
>> 
>> I don't understand this part.  Previously the ERR_FATAL path looked 
>> like
>> this:
>> 
>>   do_recovery
>>     reset_link
>>       driver->reset_link
>>         aer_root_reset
>>           pci_reset_bridge_secondary_bus                # <-- reset
>>     broadcast_error_message(..., report_resume)
>>       pci_walk_bus(..., report_resume, ...)
>>         report_resume
>>       if (cb == report_resume)
>>         pci_cleanup_aer_uncorrect_error_status
>>           pci_write_config_dword(PCI_ERR_UNCOR_STATUS)  # <-- clear 
>> status
>> 
>> After this patch, it will look like this:
>> 
>>   do_recovery
>>     do_fatal_recovery
>>       pci_cleanup_aer_uncorrect_error_status
>>         pci_write_config_dword(PCI_ERR_UNCOR_STATUS)    # <-- clear 
>> status
>>       reset_link
>>         driver->reset_link
>>           aer_root_reset
>>             pci_reset_bridge_secondary_bus              # <-- reset
>>             aer_error_resume
>>               pcie_capability_write_word(PCI_EXP_DEVSTA)        # <-- 
>> clear more
>>               pci_write_config_dword(PCI_ERR_UNCOR_STATUS)      # <-- 
>> clear status
>> 
>> So if I'm understanding correctly, the new path clears the status too
>> early, then clears it again (plus clearing DEVSTA, which we didn't do
>> before) later.
>> 
>> I would think we would want to leave aer_root_reset() alone, and just 
>> move
>> the pci_cleanup_aer_uncorrect_error_status() in do_fatal_recovery() 
>> down so
>> it happens after we call reset_link().  That way the reset/clear 
>> sequence
>> would be the same as it was before.
> 
> I've been fiddling with this a bit myself and will post the results to 
> see
> what you think.


ok so you are suggesting to move pci_cleanup_aer_uncorrect_error_status 
down which I can do.

And not to call aer_error_resume, because you think its clearing the 
status again.

following code: calls aer_error_resume.
pci_broadcast_error_message()
  /*
                  * If the error is reported by an end point, we think 
this
                  * error is related to the upstream link of the end 
point.
                  */
                 if (state == pci_channel_io_normal)
                         /*
                          * the error is non fatal so the bus is ok, just 
invoke
                          * the callback for the function that logged the 
error.
                          */
                         cb(dev, &result_data);
                 else
                         pci_walk_bus(dev->bus, cb, &result_data);


besides aer_error_resume does following things in addition to clearing 
PCI_ERR_UNCOR_STATUS

/* Clean up Root device status */
	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &reg16);
	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, reg16);

if (dev->error_state == pci_channel_io_normal)
		status &= ~mask; /* Clear corresponding nonfatal bits */
	else
		status &= mask; /* Clear corresponding fatal bits */
	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, status);


so we have to have conditional call
such as
if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE)
            error_resume


so the code might look like this..

do_recovery
    do_fatal_recovery
        reset_link
          driver->reset_link
            aer_root_reset
                pci_reset_bridge_secondary_bus              # <-- reset
            if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE)
            {
                aer_error_resume
                    pcie_capability_write_word(PCI_EXP_DEVSTA)        # 
<-- clear more
                    pci_write_config_dword(PCI_ERR_UNCOR_STATUS)      # 
<--
            }
            pci_cleanup_aer_uncorrect_error_status(dev);


does it make sense ?

Regards,
Oza.
