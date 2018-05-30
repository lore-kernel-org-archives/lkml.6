Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753656AbeE3PkX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 11:40:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32770 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753252AbeE3PkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 11:40:20 -0400
Subject: Re: [PATCH v7 2/7] drivers/i2c: Add FSI-attached I2C master algorithm
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-i2c <linux-i2c@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>, Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Edward A. James" <eajames@us.ibm.com>
References: <1527632665-25707-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1527632665-25707-3-git-send-email-eajames@linux.vnet.ibm.com>
 <CAHp75VexBiRQ1SPYK6=N-vmCAC9DhtpNKanYXrFshSM9WZb+UA@mail.gmail.com>
From: Eddie James <eajames@linux.vnet.ibm.com>
Date: Wed, 30 May 2018 10:40:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VexBiRQ1SPYK6=N-vmCAC9DhtpNKanYXrFshSM9WZb+UA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18053015-0016-0000-0000-000008D614DA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009098; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000264; SDB=6.01039879; UDB=6.00532260; IPR=6.00819012;
 MB=3.00021378; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-30 15:40:17
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18053015-0017-0000-0000-00003F00A229
Message-Id: <b87ee7a3-9901-b7ec-f89c-8a26f82cbb2f@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-30_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=482 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1805300172
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/29/2018 06:42 PM, Andy Shevchenko wrote:
> On Wed, May 30, 2018 at 1:24 AM, Eddie James <eajames@linux.vnet.ibm.com> wrote:
>> From: "Edward A. James" <eajames@us.ibm.com>
>>
>> Add register definitions for FSI-attached I2C master and functions to
>> access those registers over FSI. Add an FSI driver so that our I2C bus
>> is probed up during an FSI scan.
> This looks like reinventing a wheel in some ways.
>
> See my comments below.
>
>> +/*
>> + * Copyright 2017 IBM Corporation
>> + *
>> + * Eddie James <eajames@us.ibm.com>
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * as published by the Free Software Foundation; either version
>> + * 2 of the License, or (at your option) any later version.
>> + */
> We are using SPDX identifiers. Can you?

Sure.

>
>> +/* Find left shift from first set bit in m */
>> +#define MASK_TO_LSH(m)         (__builtin_ffsll(m) - 1ULL)
> Oh. What about GENMASK()?
>
>> +/* Extract field m from v */
>> +#define GETFIELD(m, v)         (((v) & (m)) >> MASK_TO_LSH(m))
>> +
>> +/* Set field m of v to val */
>> +#define SETFIELD(m, v, val)    \
>> +       (((v) & ~(m)) | ((((typeof(v))(val)) << MASK_TO_LSH(m)) & (m)))
> Oh, what about https://elixir.bootlin.com/linux/latest/source/include/linux/bitfield.h
> ?

Good idea, thanks.

>
>> +#define I2C_CMD_WITH_START     0x80000000
>> +#define I2C_CMD_WITH_ADDR      0x40000000
>> +#define I2C_CMD_RD_CONT                0x20000000
>> +#define I2C_CMD_WITH_STOP      0x10000000
>> +#define I2C_CMD_FORCELAUNCH    0x08000000
> BIT() ?
>
>> +#define I2C_CMD_ADDR           0x00fe0000
>> +#define I2C_CMD_READ           0x00010000
> GENMASK()? Though precisely here it might be good to leave explicit values.
>
>> +#define I2C_CMD_LEN            0x0000ffff
>> +#define I2C_MODE_CLKDIV                0xffff0000
>> +#define I2C_MODE_PORT          0x0000fc00
>> +#define I2C_MODE_ENHANCED      0x00000008
>> +#define I2C_MODE_DIAG          0x00000004
>> +#define I2C_MODE_PACE_ALLOW    0x00000002
>> +#define I2C_MODE_WRAP          0x00000001
> What are they? Masks? Bit fields? Just plain numbers?
>
>> +#define I2C_WATERMARK_HI       0x0000f000
>> +#define I2C_WATERMARK_LO       0x000000f0
> GENMASK() ?
>
>> +#define I2C_INT_INV_CMD                0x00008000
>> +#define I2C_INT_PARITY         0x00004000
>> +#define I2C_INT_BE_OVERRUN     0x00002000
>> +#define I2C_INT_BE_ACCESS      0x00001000
>> +#define I2C_INT_LOST_ARB       0x00000800
>> +#define I2C_INT_NACK           0x00000400
>> +#define I2C_INT_DAT_REQ                0x00000200
>> +#define I2C_INT_CMD_COMP       0x00000100
>> +#define I2C_INT_STOP_ERR       0x00000080
>> +#define I2C_INT_BUSY           0x00000040
>> +#define I2C_INT_IDLE           0x00000020
> BIT()
>
>> +#define I2C_INT_ENABLE         0x0000ff80
>> +#define I2C_INT_ERR            0x0000fcc0
>> +#define I2C_STAT_INV_CMD       0x80000000
>> +#define I2C_STAT_PARITY                0x40000000
>> +#define I2C_STAT_BE_OVERRUN    0x20000000
>> +#define I2C_STAT_BE_ACCESS     0x10000000
>> +#define I2C_STAT_LOST_ARB      0x08000000
>> +#define I2C_STAT_NACK          0x04000000
>> +#define I2C_STAT_DAT_REQ       0x02000000
>> +#define I2C_STAT_CMD_COMP      0x01000000
>> +#define I2C_STAT_STOP_ERR      0x00800000
>> +#define I2C_STAT_MAX_PORT      0x000f0000
>> +#define I2C_STAT_ANY_INT       0x00008000
>> +#define I2C_STAT_SCL_IN                0x00000800
>> +#define I2C_STAT_SDA_IN                0x00000400
>> +#define I2C_STAT_PORT_BUSY     0x00000200
>> +#define I2C_STAT_SELF_BUSY     0x00000100
> BIT()
>
>> +#define I2C_STAT_FIFO_COUNT    0x000000ff
> GENMASK()
>
>> +
>> +#define I2C_STAT_ERR           0xfc800000
>> +#define I2C_STAT_ANY_RESP      0xff800000
>> +#define I2C_ESTAT_FIFO_SZ      0xff000000
> GENMASK()
>
>> +#define I2C_ESTAT_SCL_IN_SY    0x00008000
>> +#define I2C_ESTAT_SDA_IN_SY    0x00004000
>> +#define I2C_ESTAT_S_SCL                0x00002000
>> +#define I2C_ESTAT_S_SDA                0x00001000
>> +#define I2C_ESTAT_M_SCL                0x00000800
>> +#define I2C_ESTAT_M_SDA                0x00000400
>> +#define I2C_ESTAT_HI_WATER     0x00000200
>> +#define I2C_ESTAT_LO_WATER     0x00000100
>> +#define I2C_ESTAT_PORT_BUSY    0x00000080
>> +#define I2C_ESTAT_SELF_BUSY    0x00000040
> BIT()
>
>> +#define I2C_ESTAT_VERSION      0x0000001f
> GENMASK()
>
>> +       __be32 data_be;
> No need to have a suffix. If anything can go wrong we have a tool,
> it's called sparse. It will catch out inappropriate use of __bitwise
> types.

I already have a variable called data...

>
>> +       __be32 data_be = cpu_to_be32(*data);
> cpu_to_be32p()  IIUC?

Sure.

>
>> +static int fsi_i2c_dev_init(struct fsi_i2c_master *i2c)
>> +{
>> +       int rc;
>> +       u32 mode = I2C_MODE_ENHANCED, extended_status, watermark = 0;
>> +       u32 interrupt = 0;
> Redundant assignment.

No, I need to set the interrupt register to 0, so I must set this.

>
>> +
>> +       /* since we use polling, disable interrupts */
>> +       rc = fsi_i2c_write_reg(i2c->fsi, I2C_FSI_INT_MASK, &interrupt);
>> +       if (rc)
>> +               return rc;
>> +       return rc;
> Would be non-zero?

No, fsi_i2c_write_reg returns non-zero on error, zero on success. That 
is what I want.

Thanks,
Eddie

>
>> +}
