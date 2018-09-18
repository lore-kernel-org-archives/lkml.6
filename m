Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D9FC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E146D214D5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QetEjJRz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E146D214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729962AbeIRUDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 16:03:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:50112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728681AbeIRUDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 16:03:49 -0400
Received: from [10.80.45.152] (unknown [71.69.156.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5570C2146D;
        Tue, 18 Sep 2018 14:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537281057;
        bh=3z322m+pIgqj4BdzuLWJRh5NuCabufTNWbeRlfzLbt8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QetEjJRzjU9zMe1PCWr6Q7WfMIF8wq3VoG5FPUfCvuBFY644kH7iTzT4d61OE4SO1
         pa91qRUK7XSw4dlKj7r/oV/sY3rFdUPao9Tginedeo4QlrkH5T4f1keQXlFkvYNYwY
         iRZBGa/DlA0DCkM6gxCWeVZomeQMPcT5rCYVjE2o=
Subject: Re: [PATCH] PCI/AER: Clear uncorrectable error status for device
To:     Oza Pawandeep <poza@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        Wei Zhang <wzhang@fb.com>, linux-kernel@vger.kernel.org
Cc:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
References: <1537258829-15763-1-git-send-email-poza@codeaurora.org>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <ab1ee64e-d257-4521-1517-4c2c648d0d9c@kernel.org>
Date:   Tue, 18 Sep 2018 10:30:52 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1537258829-15763-1-git-send-email-poza@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/2018 4:20 AM, Oza Pawandeep wrote:
> +++ b/drivers/pci/pcie/err.c
> @@ -265,6 +265,8 @@ static pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
>   		 * The error is non fatal so the bus is ok; just invoke
>   		 * the callback for the function that logged the error.
>   		 */
> +		if (cb == report_resume)
> +			pci_cleanup_aer_uncorrect_error_status(dev);
>   		cb(dev, &result_data);
>   	}

In order to follow the existing behavior (drivers are calling
pci_cleanup_aer_uncorrect_error_status() right before return),
you should probably move the pci_cleanup_aer_uncorrect_error_status
after

cb(dev, &result_data);

line.
