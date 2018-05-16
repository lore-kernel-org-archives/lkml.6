Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752565AbeEPHmj convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 03:42:39 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57806 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751449AbeEPHma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 03:42:30 -0400
Date: Wed, 16 May 2018 09:42:27 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Chris Moore <moore@free.fr>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>,
        "Wan, Jane (Nokia - US/Sunnyvale)" <jane.wan@nokia.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "prabhakar.kushwaha@nxp.com" <prabhakar.kushwaha@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "jagdish.gediya@nxp.com" <jagdish.gediya@nxp.com>,
        "shreeya.patel23498@gmail.com" <shreeya.patel23498@gmail.com>,
        "Bos, Ties (Nokia - US/Sunnyvale)" <ties.bos@nokia.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7] mtd: rawnand: use bit-wise majority to recover the
 contents of ONFI parameter
Message-ID: <20180516094227.14132e74@xps13>
In-Reply-To: <ca076561-5b7c-b220-d499-eb2bcad3d1b4@free.fr>
References: <VI1PR07MB1615A02B23D992E84A3B333F819D0@VI1PR07MB1615.eurprd07.prod.outlook.com>
        <ce0c8d75-b02a-cad0-7198-ffbd503427ce@free.fr>
        <20180515093429.34902670@bbrezillon>
        <ca076561-5b7c-b220-d499-eb2bcad3d1b4@free.fr>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

> >>> +static void nand_bit_wise_majority(const void **srcbufs,
> >>> +				   unsigned int nsrcbufs,
> >>> +				   void *dstbuf,
> >>> +				   unsigned int bufsize)
> >>> +{
> >>> +	int i, j, k;
> >>> +
> >>> +	for (i = 0; i < bufsize; i++) {
> >>> +		u8 cnt, val;
> >>> +
> >>> +		val = 0;
> >>> +		for (j = 0; j < 8; j++) {
> >>> +			cnt = 0;
> >>> +			for (k = 0; k < nsrcbufs; k++) {
> >>> +				const u8 *srcbuf = srcbufs[k];
> >>> +
> >>> +				if (srcbuf[i] & BIT(j))
> >>> +					cnt++;
> >>> +			}
> >>> +			if (cnt > nsrcbufs / 2)
> >>> +				val |= BIT(j);
> >>> +		}
> >>> +		((u8 *)dstbuf)[i] = val;
> >>> +	}
> >>> +}
> >>> +
> >>> +/*
> >>>     * Check if the NAND chip is ONFI compliant, returns 1 if it is, 0 otherwise.
> >>>     */
> >>>    static int nand_flash_detect_onfi(struct nand_chip *chip)
> >>> @@ -5102,7 +5131,7 @@ static int nand_flash_detect_onfi(struct nand_chip *chip)
> >>>    		return 0;  
> >>>    >>>    	/* ONFI chip: allocate a buffer to hold its parameter page */  
> >>> -	p = kzalloc(sizeof(*p), GFP_KERNEL);
> >>> +	p = kzalloc((sizeof(*p) * 3), GFP_KERNEL);
> >>>    	if (!p)
> >>>    		return -ENOMEM;  
> >>>    >>> @@ -5113,21 +5142,32 @@ static int nand_flash_detect_onfi(struct nand_chip *chip)  
> >>>    	}  
> >>>    >>>    	for (i = 0; i < 3; i++) {  
> >>> -		ret = nand_read_data_op(chip, p, sizeof(*p), true);
> >>> +		ret = nand_read_data_op(chip, &p[i], sizeof(*p), true);
> >>>    		if (ret) {
> >>>    			ret = 0;
> >>>    			goto free_onfi_param_page;
> >>>    		}  
> >>>    >>> -		if (onfi_crc16(ONFI_CRC_BASE, (uint8_t *)p, 254) ==  
> >>> +		if (onfi_crc16(ONFI_CRC_BASE, (u8 *)&p[i], 254) ==
> >>>    				le16_to_cpu(p->crc)) {
> >>> +			if (i)
> >>> +				memcpy(p, &p[i], sizeof(*p));
> >>>    			break;
> >>>    		}
> >>>    	}  
> >>>    >>>    	if (i == 3) {  
> >>> -		pr_err("Could not find valid ONFI parameter page; aborting\n");
> >>> -		goto free_onfi_param_page;
> >>> +		const void *srcbufs[3] = {p, p + 1, p + 2};
> >>> +
> >>> +		pr_warn("Could not find a valid ONFI parameter page, trying bit-wise majority to recover it\n");
> >>> +		nand_bit_wise_majority(srcbufs, ARRAY_SIZE(srcbufs), p,
> >>> +				       sizeof(*p));
> >>> +
> >>> +		if (onfi_crc16(ONFI_CRC_BASE, (u8 *)p, 254) !=
> >>> +				le16_to_cpu(p->crc)) {
> >>> +			pr_err("ONFI parameter recovery failed, aborting\n");
> >>> +			goto free_onfi_param_page;
> >>> +		}
> >>>    	}  
> >>>    >>>    	/* Check version */  
> >> This version is still hard coded for a three sample bitwise majority vote.
> >> So why not use the method which I suggested previously for v2 and which
> >> I repeat below?  
> > Because I want the nand_bit_wise_majority() function to work with
> > nsrcbufs > 3 (the ONFI spec says there's at least 3 copy of the param
> > page, but NAND vendor can decide to put more). Also, if the X copies of
> > the PARAM are corrupted (which is rather unlikely), that means we
> > already spent quite a lot of time reading the different copies and
> > calculating the CRC, so I think we don't care about perf optimizations
> > when doing bit-wise majority.
> >  
> >> The three sample bitwise majority can be implemented without bit level
> >> manipulation using the identity:
> >> majority3(a, b, c) = (a & b) | (a & c) | (b & c)
> >> This can be factorized slightly to (a & (b | c)) | (b & c)
> >> This enables the operation to be performed 8, 16, 32 or even 64 bits at
> >> a time depending on the hardware.
> >>
> >> This method is not only faster and but also more compact.
> >>  
> 
> I do understand that the ONFI specifications permit more than 3 copies.
> However elsewhere the proposed code shows no intention of handling other cases.
> The constant 3 is hard coded in the following lines extracted from the proposed code:
> ...
> +    p = kzalloc((sizeof(*p) * 3), GFP_KERNEL);
> ...
>       for (i = 0; i < 3; i++) {
> ...
>       if (i == 3) {
> ...
> +        const void *srcbufs[3] = {p, p + 1, p + 2};
> 
> Moreover the last of these is difficult to generalize.

Indeed, this is something to improve. I think Boris' request was to
prepare changes like this one, to avoid the situation where the code
does not scale (like this 'p, p + 1, p + 2').

Thanks,
Miquèl
