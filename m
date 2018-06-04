Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751247AbeFDThM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 15:37:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42248 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751010AbeFDThK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 15:37:10 -0400
Subject: Re: [PATCH v9 5/7] i2c: fsi: Add transfer implementation
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-i2c <linux-i2c@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>, Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
References: <1528138850-18259-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1528138850-18259-6-git-send-email-eajames@linux.vnet.ibm.com>
 <CAHp75VdcKg7fzPtfgb2mZ+07nGtA4HXMO2T=P1m+wovnph93Pg@mail.gmail.com>
From: Eddie James <eajames@linux.vnet.ibm.com>
Date: Mon, 4 Jun 2018 14:37:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VdcKg7fzPtfgb2mZ+07nGtA4HXMO2T=P1m+wovnph93Pg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18060419-0068-0000-0000-0000030319A7
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009129; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01042314; UDB=6.00533715; IPR=6.00821444;
 MB=3.00021461; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-04 19:37:07
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060419-0069-0000-0000-000044917957
Message-Id: <ae055969-6f30-69e6-4e13-32c26c0f5e80@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-04_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806040225
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/04/2018 02:14 PM, Andy Shevchenko wrote:
> On Mon, Jun 4, 2018 at 10:00 PM, Eddie James <eajames@linux.vnet.ibm.com> wrote:
>> Execute I2C transfers from the FSI-attached I2C master. Use polling
>> instead of interrupts as we have no hardware IRQ over FSI.
>>
>> Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
>> ---
>>   drivers/i2c/busses/i2c-fsi.c | 195 ++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 193 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-fsi.c b/drivers/i2c/busses/i2c-fsi.c
>> index 101b9c5..4e5964e 100644
>> --- a/drivers/i2c/busses/i2c-fsi.c
>> +++ b/drivers/i2c/busses/i2c-fsi.c
>> @@ -150,6 +150,7 @@ struct fsi_i2c_port {
>>          struct i2c_adapter      adapter;
>>          struct fsi_i2c_master   *master;
>>          u16                     port;
>> +       u16                     xfrd;
>>   };
>>
>>   static int fsi_i2c_read_reg(struct fsi_device *fsi, unsigned int reg,
>> @@ -225,6 +226,99 @@ static int fsi_i2c_set_port(struct fsi_i2c_port *port)
>>          return fsi_i2c_write_reg(fsi, I2C_FSI_RESET_ERR, &dummy);
>>   }
>>
>> +static int fsi_i2c_start(struct fsi_i2c_port *port, struct i2c_msg *msg,
>> +                        bool stop)
>> +{
>> +       struct fsi_i2c_master *i2c = port->master;
>> +       u32 cmd = I2C_CMD_WITH_START | I2C_CMD_WITH_ADDR;
>> +
>> +       port->xfrd = 0;
>> +
>> +       if (msg->flags & I2C_M_RD)
>> +               cmd |= I2C_CMD_READ;
>> +
>> +       if (stop || msg->flags & I2C_M_STOP)
>> +               cmd |= I2C_CMD_WITH_STOP;
>> +
>> +       cmd |= FIELD_PREP(I2C_CMD_ADDR, msg->addr >> 1);
> Did you consider to unify READ + ADDR as ADDR_8BIT?

Yes, however the result from the i2c_8bit_addr_from_msg function is not 
equivalent. This hardware expects the 8-bit address to be concatenated 
with the read/not write bit. Also the function returns a u8, which won't 
work for addresses with bit 7 set, since it left-shifts by one.

>
>> +       cmd |= FIELD_PREP(I2C_CMD_LEN, msg->len);
>> +
>> +       return fsi_i2c_write_reg(i2c->fsi, I2C_FSI_CMD, &cmd);
>> +}
>> +
>> +static int fsi_i2c_get_op_bytes(int op_bytes)
>> +{
>> +       /* fsi is limited to max 4 byte aligned ops */
>> +       if (op_bytes > 4)
>> +               return 4;
>> +       else if (op_bytes == 3)
> Since you dropped one of 'else', another also is not needed.

True.

>
>> +               return 2;
>> +       return op_bytes;
>> +}
>> +
>> +static int fsi_i2c_write_fifo(struct fsi_i2c_port *port, struct i2c_msg *msg,
>> +                             u8 fifo_count)
>> +{
>> +       int write;
>> +       int rc;
>> +       struct fsi_i2c_master *i2c = port->master;
>> +       int bytes_to_write = i2c->fifo_size - fifo_count;
>> +       int bytes_remaining = msg->len - port->xfrd;
>> +
>> +       bytes_to_write = min(bytes_to_write, bytes_remaining);
>> +
>> +       while (bytes_to_write) {
>> +               write = fsi_i2c_get_op_bytes(bytes_to_write);
>> +
>> +               rc = fsi_device_write(i2c->fsi, I2C_FSI_FIFO,
>> +                                     &msg->buf[port->xfrd], write);
>> +               if (rc)
>> +                       return rc;
>> +
>> +               port->xfrd += write;
>> +               bytes_to_write -= write;
>> +       }
> Just to be sure, if by some reason write == 0 in the loop for a while,
> would it become infinite loop?

It's not possible that write == 0. Same for read below.

Thanks,
Eddie

>
>> +
>> +       return 0;
>> +}
>> +
>> +static int fsi_i2c_read_fifo(struct fsi_i2c_port *port, struct i2c_msg *msg,
>> +                            u8 fifo_count)
>> +{
>> +       int read;
>> +       int rc;
>> +       struct fsi_i2c_master *i2c = port->master;
>> +       int bytes_to_read;
>> +       int xfr_remaining = msg->len - port->xfrd;
>> +       u32 dummy;
>> +
>> +       bytes_to_read = min_t(int, fifo_count, xfr_remaining);
>> +
>> +       while (bytes_to_read) {
>> +               read = fsi_i2c_get_op_bytes(bytes_to_read);
>> +
>> +               if (xfr_remaining) {
>> +                       rc = fsi_device_read(i2c->fsi, I2C_FSI_FIFO,
>> +                                            &msg->buf[port->xfrd], read);
>> +                       if (rc)
>> +                               return rc;
>> +
>> +                       port->xfrd += read;
>> +                       xfr_remaining -= read;
>> +               } else {
>> +                       /* no more buffer but data in fifo, need to clear it */
>> +                       rc = fsi_device_read(i2c->fsi, I2C_FSI_FIFO, &dummy,
>> +                                            read);
>> +                       if (rc)
>> +                               return rc;
>> +               }
>> +
>> +               bytes_to_read -= read;
>> +       }
> Ditto for read == 0.
>
>> +
>> +       return 0;
>> +}
>> +
>>   static int fsi_i2c_reset_bus(struct fsi_i2c_master *i2c)
>>   {
>>          int i, rc;
>> @@ -388,17 +482,114 @@ static int fsi_i2c_abort(struct fsi_i2c_port *port, u32 status)
>>          return -ETIMEDOUT;
>>   }
>>
>> +static int fsi_i2c_handle_status(struct fsi_i2c_port *port,
>> +                                struct i2c_msg *msg, u32 status)
>> +{
>> +       int rc;
>> +       u8 fifo_count;
>> +
>> +       if (status & I2C_STAT_ERR) {
>> +               rc = fsi_i2c_abort(port, status);
>> +               if (rc)
>> +                       return rc;
>> +
>> +               if (status & I2C_STAT_INV_CMD)
>> +                       return -EINVAL;
>> +
>> +               if (status & (I2C_STAT_PARITY | I2C_STAT_BE_OVERRUN |
>> +                   I2C_STAT_BE_ACCESS))
>> +                       return -EPROTO;
>> +
>> +               if (status & I2C_STAT_NACK)
>> +                       return -ENXIO;
>> +
>> +               if (status & I2C_STAT_LOST_ARB)
>> +                       return -EAGAIN;
>> +
>> +               if (status & I2C_STAT_STOP_ERR)
>> +                       return -EBADMSG;
>> +
>> +               return -EIO;
>> +       }
>> +
>> +       if (status & I2C_STAT_DAT_REQ) {
>> +               fifo_count = FIELD_GET(I2C_STAT_FIFO_COUNT, status);
>> +
>> +               if (msg->flags & I2C_M_RD)
>> +                       return fsi_i2c_read_fifo(port, msg, fifo_count);
>> +
>> +               return fsi_i2c_write_fifo(port, msg, fifo_count);
>> +       }
>> +
>> +       if (status & I2C_STAT_CMD_COMP) {
>> +               if (port->xfrd < msg->len)
>> +                       return -ENODATA;
>> +
>> +               return msg->len;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int fsi_i2c_wait(struct fsi_i2c_port *port, struct i2c_msg *msg,
>> +                       unsigned long timeout)
>> +{
>> +       u32 status = 0;
>> +       int rc;
>> +       unsigned long start = jiffies;
>> +
>> +       do {
>> +               rc = fsi_i2c_read_reg(port->master->fsi, I2C_FSI_STAT,
>> +                                     &status);
>> +               if (rc)
>> +                       return rc;
>> +
>> +               if (status & I2C_STAT_ANY_RESP) {
>> +                       rc = fsi_i2c_handle_status(port, msg, status);
>> +                       if (rc < 0)
>> +                               return rc;
>> +
>> +                       /* cmd complete and all data xfrd */
>> +                       if (rc == msg->len)
>> +                               return 0;
>> +
>> +                       /* need to xfr more data, but maybe don't need wait */
>> +                       continue;
>> +               }
>> +
>> +               usleep_range(I2C_CMD_SLEEP_MIN_US, I2C_CMD_SLEEP_MAX_US);
>> +       } while (time_after(start + timeout, jiffies));
>> +
>> +       return -ETIMEDOUT;
>> +}
>> +
>>   static int fsi_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
>>                          int num)
>>   {
>> -       int rc;
>> +       int i, rc;
>> +       unsigned long start_time;
>>          struct fsi_i2c_port *port = adap->algo_data;
>> +       struct i2c_msg *msg;
>>
>>          rc = fsi_i2c_set_port(port);
>>          if (rc)
>>                  return rc;
>>
>> -       return -EOPNOTSUPP;
>> +       for (i = 0; i < num; i++) {
>> +               msg = msgs + i;
>> +               start_time = jiffies;
>> +
>> +               rc = fsi_i2c_start(port, msg, i == num - 1);
>> +               if (rc)
>> +                       return rc;
>> +
>> +               rc = fsi_i2c_wait(port, msg,
>> +                                 adap->timeout - (jiffies - start_time));
>> +               if (rc)
>> +                       return rc;
>> +       }
>> +
>> +       return 0;
>>   }
>>
>>   static u32 fsi_i2c_functionality(struct i2c_adapter *adap)
>> --
>> 1.8.3.1
>>
>
>
