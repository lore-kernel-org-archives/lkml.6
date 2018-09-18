Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA38C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 19:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27FD0206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 19:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Mg9OBVOI";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IpFsJQNG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27FD0206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729685AbeISAiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 20:38:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59590 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728721AbeISAiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 20:38:52 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C8A09601CF; Tue, 18 Sep 2018 19:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537297493;
        bh=1evB/4PEtGE4+5auLOhcvbyvx31j9yAeFIBIu9djTxg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Mg9OBVOImvMq8b3BF3oUqPfIpfHAGBLeCq32wcKO3Dl7VR+HocbuaWMaBNLuWs19/
         h7biJgkF687OBvykFjnS0YOE6TsstdMgJHqey1HICuj9mz3hPopV6QaVvch/va3GDR
         UYyH4gNg2Ai7823sJ6DvEbqGvP7FDGjU51Z4IM5Y=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 92C6B605A5;
        Tue, 18 Sep 2018 19:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537297492;
        bh=1evB/4PEtGE4+5auLOhcvbyvx31j9yAeFIBIu9djTxg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IpFsJQNGoFzorITCkyHlH6DPDTGMgAiyjJjADyjPFY9BN+s2g4oV6H5nrkH13iinM
         O+IrSGjHI/exC/beTUaHmrAKuSIhrsgedNpWlO7/38BDoB5HICKHrwNX8RKCzBkcBa
         3IGOAFcCJM/PDy83Va5cvesBIl+560DERyV7Tzn8=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 19 Sep 2018 00:34:52 +0530
From:   poza@codeaurora.org
To:     Sinan Kaya <okaya@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        Wei Zhang <wzhang@fb.com>, linux-kernel@vger.kernel.org,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] PCI/AER: Clear uncorrectable error status for device
In-Reply-To: <ab1ee64e-d257-4521-1517-4c2c648d0d9c@kernel.org>
References: <1537258829-15763-1-git-send-email-poza@codeaurora.org>
 <ab1ee64e-d257-4521-1517-4c2c648d0d9c@kernel.org>
Message-ID: <49a44a7202802c20d52164403139284b@codeaurora.org>
X-Sender: poza@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-18 20:00, Sinan Kaya wrote:
> On 9/18/2018 4:20 AM, Oza Pawandeep wrote:
>> +++ b/drivers/pci/pcie/err.c
>> @@ -265,6 +265,8 @@ static pci_ers_result_t 
>> broadcast_error_message(struct pci_dev *dev,
>>   		 * The error is non fatal so the bus is ok; just invoke
>>   		 * the callback for the function that logged the error.
>>   		 */
>> +		if (cb == report_resume)
>> +			pci_cleanup_aer_uncorrect_error_status(dev);
>>   		cb(dev, &result_data);
>>   	}
> 
> In order to follow the existing behavior (drivers are calling
> pci_cleanup_aer_uncorrect_error_status() right before return),
> you should probably move the pci_cleanup_aer_uncorrect_error_status
> after
> 
> cb(dev, &result_data);
> 
> line.

some drivers are calling it in slot_reset, which is before resume,
while some are calling in beginning of resume (e.g. netxen_io_resume)

hence I have kept it before calling resume()   (e.g. before cb(dev, 
&result_data))

Regards,
Oza.
