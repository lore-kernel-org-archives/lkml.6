Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753526AbeE3Pr0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 11:47:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39336 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753044AbeE3PrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 11:47:24 -0400
Subject: Re: [PATCH v7 3/7] drivers/i2c: Add port structure to FSI algorithm
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
 <1527632665-25707-4-git-send-email-eajames@linux.vnet.ibm.com>
 <CAHp75Vd38BrJcULxoqj1mTKCEvMh9ZVYEvzCMAg2t9onZrSR6w@mail.gmail.com>
From: Eddie James <eajames@linux.vnet.ibm.com>
Date: Wed, 30 May 2018 10:47:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vd38BrJcULxoqj1mTKCEvMh9ZVYEvzCMAg2t9onZrSR6w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18053015-0016-0000-0000-000008D619C5
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009098; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000264; SDB=6.01039881; UDB=6.00532261; IPR=6.00819014;
 MB=3.00021378; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-30 15:47:22
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18053015-0017-0000-0000-00003F00AA99
Message-Id: <ae3de08c-6849-bb3a-7c6c-96309876d48e@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-30_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=805 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1805300173
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/29/2018 06:19 PM, Andy Shevchenko wrote:
> On Wed, May 30, 2018 at 1:24 AM, Eddie James <eajames@linux.vnet.ibm.com> wrote:
>> From: "Edward A. James" <eajames@us.ibm.com>
>>
>> Add and initialize I2C adapters for each port on the FSI-attached I2C
>> master. Ports for each master are defined in the devicetree.
>> +#include <linux/of.h>
>
>> +static int fsi_i2c_set_port(struct fsi_i2c_port *port)
>> +{
>> +       int rc;
>> +       struct fsi_device *fsi = port->master->fsi;
>> +       u32 mode, dummy = 0;
>> +       u16 old_port;
>> +
>> +       rc = fsi_i2c_read_reg(fsi, I2C_FSI_MODE, &mode);
>> +       if (rc)
>> +               return rc;
>> +
>> +       old_port = GETFIELD(I2C_MODE_PORT, mode);
>> +
>> +       if (old_port != port->port) {
> Why not simple
>
> if (port->port == GETFIELD())
>    return 0;
>
> ?

Sure.

>
>> +               /* reset engine when port is changed */
>> +               rc = fsi_i2c_write_reg(fsi, I2C_FSI_RESET_ERR, &dummy);
>> +               if (rc)
>> +                       return rc;
>> +       }
>> +       return rc;
> It's hardly would be non-zero, right?

No, fsi_i2c_read_reg and fsi_i2c_write_reg both return 0 on success and 
non-zero on error. That is the desired behavior of this function also.

>
>> +}
>>   static int fsi_i2c_probe(struct device *dev)
>>   {
> Isn't below somehow repeats of_i2c_register_devices() ?
> Why not to use it?

Because I need to assign all these port structure fields. Also looks 
like of_i2c_register_devices creates new devices; I just want an adapter 
for each port.

>
>> +       /* Add adapter for each i2c port of the master. */
>> +       for_each_available_child_of_node(dev->of_node, np) {
>> +               rc = of_property_read_u32(np, "reg", &port_no);
>> +               if (rc || port_no > USHRT_MAX)
>> +                       continue;
>> +
>> +               port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
>> +               if (!port)
>> +                       break;
>> +
>> +               port->master = i2c;
>> +               port->port = port_no;
>> +
>> +               port->adapter.owner = THIS_MODULE;
>> +               port->adapter.dev.of_node = np;
>> +               port->adapter.dev.parent = dev;
>> +               port->adapter.algo = &fsi_i2c_algorithm;
>> +               port->adapter.algo_data = port;
>> +
>> +               snprintf(port->adapter.name, sizeof(port->adapter.name),
>> +                        "i2c_bus-%u", port_no);
>> +
>> +               rc = i2c_add_adapter(&port->adapter);
>> +               if (rc < 0) {
>> +                       dev_err(dev, "Failed to register adapter: %d\n", rc);
>> +                       devm_kfree(dev, port);
> This hurts my eyes. Why?!

What would you suggest instead?

>
>> +                       continue;
>> +               }
>> +
>> +               list_add(&port->list, &i2c->ports);
>> +       }
>> +
>>          dev_set_drvdata(dev, i2c);
>>
>>          return 0;
>>   }
>> +       if (!list_empty(&i2c->ports)) {
> My gosh, this is done already in list_for_each*()

No, list_for_each_entry does NOT check if the list is empty or if the 
first entry is NULL.

Thanks,
Eddie

>
>> +               list_for_each_entry(port, &i2c->ports, list) {
>> +                       i2c_del_adapter(&port->adapter);
>> +               }
>> +       }
>
>
