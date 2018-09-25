Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22B2C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71CB92087A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:15:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71CB92087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbeIYPWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:22:15 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:35420 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727617AbeIYPWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:22:14 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w8P99416011181;
        Tue, 25 Sep 2018 11:14:32 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2mncme7v9w-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 25 Sep 2018 11:14:32 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 357CA5D;
        Tue, 25 Sep 2018 09:14:32 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 04849290E;
        Tue, 25 Sep 2018 09:14:32 +0000 (GMT)
Received: from [10.201.23.29] (10.75.127.45) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 25 Sep
 2018 11:14:31 +0200
Subject: Re: [PATCH 2/3] mtd: rawnand: stm32_fmc2: add STM32 FMC2 NAND flash
 controller driver
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <marek.vasut@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <1537199260-7280-1-git-send-email-christophe.kerello@st.com>
 <1537199260-7280-3-git-send-email-christophe.kerello@st.com>
 <20180924192356.5f2e56fd@bbrezillon>
From:   Christophe Kerello <christophe.kerello@st.com>
Message-ID: <3b37bac8-2616-eb7e-b559-2d73b96bfe28@st.com>
Date:   Tue, 25 Sep 2018 11:14:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180924192356.5f2e56fd@bbrezillon>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-25_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 09/24/2018 07:23 PM, Boris Brezillon wrote:
> Hi Christophe,
> 
> On Mon, 17 Sep 2018 17:47:39 +0200
> <christophe.kerello@st.com> wrote:
> 
>> +struct stm32_fmc2 {
>> +	struct nand_chip chip;
>> +	struct device *dev;
>> +	void __iomem *io_base;
>> +	void __iomem *data_base[FMC2_MAX_CE];
>> +	void __iomem *cmd_base[FMC2_MAX_CE];
>> +	void __iomem *addr_base[FMC2_MAX_CE];
>> +	phys_addr_t io_phys_addr;
>> +	phys_addr_t data_phys_addr[FMC2_MAX_CE];
>> +	struct clk *clk;
>> +
>> +	struct dma_chan *dma_tx_ch;
>> +	struct dma_chan *dma_rx_ch;
>> +	struct dma_chan *dma_ecc_ch;
>> +	struct sg_table dma_data_sg;
>> +	struct sg_table dma_ecc_sg;
>> +	u8 *ecc_buf;
>> +	int dma_ecc_len;
>> +
>> +	struct completion complete;
>> +	struct completion dma_data_complete;
>> +	struct completion dma_ecc_complete;
>> +
>> +	struct stm32_fmc2_timings timings;
>> +	u8 cs_assigned;
>> +	int cs_sel;
>> +	int ncs;
>> +	int cs_used[FMC2_MAX_CE];
>> +};
> 
> Can we have a clear separation between the NAND controller and NAND
> chip structures. I know you only support a single chip per-controller
> right now, but I prefer to have things clearly separated from the
> beginning.

Yes, I can create 2 structures: one for the controller (stm32_fmc2) and 
one for the NAND chip (stm32_fmc2_nand_chip).

Regards,
Christophe Kerello.

> 
> Regards,
> 
> Boris
> 
