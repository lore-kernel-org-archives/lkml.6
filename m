Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752849AbeDLIBB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 04:01:01 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52780 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752810AbeDLIA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 04:00:59 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Thu, 12 Apr 2018 13:30:56 +0530
From: Abhishek Sahu <absahu@codeaurora.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>,
        Archit Taneja <architt@codeaurora.org>,
        Richard Weinberger <richard@nod.at>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        Andy Gross <andy.gross@linaro.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 9/9] mtd: nand: qcom: erased page bitflips detection
In-Reply-To: <20180410123003.34f4cfaa@xps13>
References: <1522845745-6624-1-git-send-email-absahu@codeaurora.org>
 <1522845745-6624-10-git-send-email-absahu@codeaurora.org>
 <20180410123003.34f4cfaa@xps13>
Message-ID: <a28caf668b5dd7a9993d8eabbbdf5fd8@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-10 16:00, Miquel Raynal wrote:
> Hi Abhishek,
> 
> On Wed,  4 Apr 2018 18:12:25 +0530, Abhishek Sahu
> <absahu@codeaurora.org> wrote:
> 
>> Some of the newer nand parts can have bit flips in an erased
>> page due to the process technology used. In this case, qpic
> 
> AFAIK, this has always been possible, it was just rare.
> 

  Yes Miquel. It was rare earlier.
  Now, we are observing this more for newer parts coming.

>> nand controller is not able to identify that page as an erased
>> page. Currently the driver calls nand_check_erased_ecc_chunk for
>> identifying the erased pages but this won’t work always since the
>> checking is being with ECC engine returned data. In case of
>> bitflips, the ECC engine tries to correct the data and then it
>> generates the uncorrectable error. Now, this data is not equal to
>> original raw data. For erased CW identification, the raw data
>> should be read again from NAND device and this
>> nand_check_erased_ecc_chunk function should be called for raw
>> data only.
> 
> Absolutely.
> 
>> 
>> Now following logic is being added to identify the erased
>> codeword bitflips.
>> 
>> 1. In most of the case, not all the codewords will have bitflips
>>    and only single CW will have bitflips. So, there is no need to
>>    read the complete raw page data. The NAND raw read can be
>>    scheduled for any CW in page. The NAND controller works on CW
>>    basis and it will update the status register after each CW read.
>>    Maintain the bitmask for the CW which generated the uncorrectable
>>    error.
>> 2. Schedule the raw flash read from NAND flash device to
>>    NAND controller buffer for all these CWs between first and last
>>    uncorrectable errors CWs. Copy the content from NAND controller
>>    buffer to actual data buffer only for the uncorrectable errors
>>    CWs so that other CW data content won’t be affected, and
>>    unnecessary data copy can be avoided.
> 
> In case of uncorrectable error, the penalty is huge anyway.
> 

  Yes. We can't avoid that.
  But we are reducing that by doing raw read for few subpages in
  which we got uncorrectale error.

>> 3. Both DATA and OOB need to be checked for number of 0. The
>>    top-level API can be called with only data buf or oob buf so use
>>    chip->databuf if data buf is null and chip->oob_poi if
>>    oob buf is null for copying the raw bytes temporarily.
> 
> You can do that. But when you do, you should tell the core you used
> that buffer and that it cannot rely on what is inside. Please
> invalidate the page cache with:
> 
> chip->pagebuf = -1;
> 

  Thanks Miquel. I will check and update the patch.

>> 4. For each CW, check the number of 0 in cw_data and usable
>>    oob bytes, The bbm and spare bytes bit flip won’t affect the ECC
>>    so don’t check the number of bitflips in this area.
> 
> OOB is an area in which you are supposed to find the BBM, the ECC bytes
> and the spare bytes. Spare bytes == usable OOB bytes. And the BBM
> should be protected too. I don't get this sentence but I don't see its
> application neither in the code?
> 

  QCOM NAND layout does not support the BBM ECC protection.

  IN OOB,

  For all the possible layouts (4 bit RS/4 bit BCH/8 bit BCH)
  it has 16 usable OOB bytes which is protected with ECC.

  All the bytes in OOB other than BBM, ECC bytes and usable
  OOB bytes are ununsed.

  You can refer qcom_nand_host_setup for layout detail.

  Thanks,
  Abhishek
