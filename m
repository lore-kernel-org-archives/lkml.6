Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751881AbeCTBoW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 21:44:22 -0400
Received: from mga07.intel.com ([134.134.136.100]:42918 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751828AbeCTBoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 21:44:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,333,1517904000";
   d="scan'208";a="212835221"
Subject: Re: [PATCH i2c/slave-mqueue v1] i2c: slave-mqueue: add a slave
 backend to receive and queue messages
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, wsa@the-dreams.de,
        brendanhiggins@google.com, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: jarkko.nikula@linux.intel.com, jae.hyun.yoo@linux.intel.com
References: <1521258504-22968-1-git-send-email-haiyue.wang@linux.intel.com>
 <1521487945.23017.58.camel@linux.intel.com>
From: "Wang, Haiyue" <haiyue.wang@linux.intel.com>
Message-ID: <4e2b25da-3a19-ea8d-8152-2ef10637f476@linux.intel.com>
Date: Tue, 20 Mar 2018 09:44:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521487945.23017.58.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, Andy.


Hi Wolfram,

Let me introduce some development background, it is used for OpenBMC 
project,

which belongs to the Linux Foundation now 
(https://www.linuxfoundation.org/blog/openbmc-project-community-comes-together-at-the-linux-foundation-to-define-open-source-implementation-of-bmc-firmware-stack/).

1. *https://goo.gl/WgvPFi*

*** 
<https://goo.gl/WgvPFi>***https://lists.ozlabs.org/pipermail/openbmc/2018-January/010493.html* 
<https://goo.gl/WgvPFi>*

**

*IPMI is embedded within IPMB (similar to KCS, BT?)*

*

  *

    Who started, who responded to messages

  *

    We need a kernel interface for handling a multi-master slave

  *

    Dell has a non-standard i2c IPMB interface

      o

        Kernel maintains table of outstanding commands

  *

    Brendan suggests we need a kernel driver for doing both MCTP and IPMB

  *

    We can’t do them both in usersland as MCTP makes extensions to SMBUS
    in order to allow arbitration. Problematic extension is the “MCTP
    fairness arbitration”. Requires the i2c controllers on the bus
    (masters/slaves) to observe the line for a certain period of time in
    order to see who is using the line. There’s no userspace API for
    this, and it the timing requirements are tight

  *

    Slave mode is not yet exposed to the user

  *

    As we don’t have a userspace interface, it makes sense to add a new one

*

BR,
Haiyue

On 2018-03-20 03:32, Andy Shevchenko wrote:
> On Sat, 2018-03-17 at 11:48 +0800, Haiyue Wang wrote:
>> Some protocols over I2C are designed for bi-directional transferring
>> messages by using I2C Master Write protocol. Like the MCTP (Management
>> Component Transport Protocol) and IPMB (Intelligent Platform
>> Management
>> Bus), they both require that the userspace can receive messages from
>> I2C dirvers under slave mode.
>>
>> This new slave mqueue backend is used to receive and queue messages,
>> it
>> will exposes these messages to userspace by sysfs bin file.
>>
> Wolfram, I'm not sure this is the best approach, though I can't propose
> anything else right now.
>
> If you are satisfied with it, I give a formal
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
>> Signed-off-by: Haiyue Wang <haiyue.wang@linux.intel.com>
>> ---
>>   Documentation/i2c/slave-mqueue-backend.rst | 125 ++++++++++++++++++
>>   drivers/i2c/Kconfig                        |  13 ++
>>   drivers/i2c/Makefile                       |   1 +
>>   drivers/i2c/i2c-slave-mqueue.c             | 202
>> +++++++++++++++++++++++++++++
>>   4 files changed, 341 insertions(+)
>>   create mode 100644 Documentation/i2c/slave-mqueue-backend.rst
>>   create mode 100644 drivers/i2c/i2c-slave-mqueue.c
>>
>> diff --git a/Documentation/i2c/slave-mqueue-backend.rst
>> b/Documentation/i2c/slave-mqueue-backend.rst
>> new file mode 100644
>> index 0000000..69d6437
>> --- /dev/null
>> +++ b/Documentation/i2c/slave-mqueue-backend.rst
>> @@ -0,0 +1,125 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +=====================================
>> +Linux I2C slave message queue backend
>> +=====================================
>> +
>> +:Author: Haiyue Wang <haiyue.wang@linux.intel.com>
>> +
>> +Some protocols over I2C/SMBus are designed for bi-directional
>> transferring
>> +messages by using I2C Master Write protocol. This requires that both
>> sides
>> +of the communication have slave addresses.
>> +
>> +Like MCTP (Management Component Transport Protocol) and IPMB
>> (Intelligent
>> +Platform Management Bus), they both require that the userspace can
>> receive
>> +messages from i2c dirvers under slave mode.
>> +
>> +This I2C slave mqueue (message queue) backend is used to receive and
>> queue
>> +messages from the remote i2c intelligent device; and it will add the
>> target
>> +slave address (with R/W# bit is always 0) into the message at the
>> first byte,
>> +so that userspace can use this byte to dispatch the messages into
>> different
>> +handling modules. Also, like IPMB, the address byte is in its message
>> format,
>> +it needs it to do checksum.
>> +
>> +For messages are time related, so this backend will flush the oldest
>> message
>> +to queue the newest one.
>> +
>> +Link
>> +----
>> +`Intelligent Platform Management Bus
>> +Communications Protocol Specification
>> +<https://www.intel.com/content/dam/www/public/us/en/documents/product
>> -briefs/ipmp-spec-v1.0.pdf>`_
>> +
>> +`Management Component Transport Protocol (MCTP)
>> +SMBus/I2C Transport Binding Specification
>> +<https://www.dmtf.org/sites/default/files/standards/documents/DSP0237
>> _1.1.0.pdf>`_
>> +
>> +How to use
>> +----------
>> +For example, the I2C5 bus has slave address 0x10, bellowing command
>> will create
>> +the related message queue interface:
>> +
>> +    echo slave-mqueue 0x1010 > /sys/bus/i2c/devices/i2c-5/new_device
>> +
>> +Then you can dump the messages like this:
>> +
>> +    hexdump -C /sys/bus/i2c/devices/5-1010/slave-mqueue
>> +
>> +Code Example
>> +------------
>> +*Note: call 'lseek' before 'read', this is a requirement from kernfs'
>> design.*
>> +
>> +::
>> +
>> +  #include <sys/types.h>
>> +  #include <sys/stat.h>
>> +  #include <unistd.h>
>> +  #include <poll.h>
>> +  #include <time.h>
>> +  #include <fcntl.h>
>> +  #include <stdio.h>
>> +
>> +  int main(int argc, char *argv[])
>> +  {
>> +          int i, r;
>> +          struct pollfd pfd;
>> +          struct timespec ts;
>> +          unsigned char data[256];
>> +
>> +          pfd.fd = open(argv[1], O_RDONLY | O_NONBLOCK);
>> +          if (pfd.fd < 0)
>> +                  return -1;
>> +
>> +          pfd.events = POLLPRI;
>> +
>> +          while (1) {
>> +                  r = poll(&pfd, 1, 5000);
>> +
>> +                  if (r < 0)
>> +                          break;
>> +
>> +                  if (r == 0 || !(pfd.revents & POLLPRI))
>> +                          continue;
>> +
>> +                  lseek(pfd.fd, 0, SEEK_SET);
>> +                  r = read(pfd.fd, data, sizeof(data));
>> +                  if (r <= 0)
>> +                          continue;
>> +
>> +                  clock_gettime(CLOCK_MONOTONIC, &ts);
>> +                  printf("[%ld.%.9ld] :", ts.tv_sec, ts.tv_nsec);
>> +                  for (i = 0; i < r; i++)
>> +                          printf(" %02x", data[i]);
>> +                  printf("\n");
>> +          }
>> +
>> +          close(pfd.fd);
>> +
>> +          return 0;
>> +  }
>> +
>> +Result
>> +------
>> +*./a.out "/sys/bus/i2c/devices/5-1010/slave-mqueue"*
>> +
>> +::
>> +
>> +  [10183.232500449] : 20 18 c8 2c 78 01 5b
>> +  [10183.479358348] : 20 18 c8 2c 78 01 5b
>> +  [10183.726556812] : 20 18 c8 2c 78 01 5b
>> +  [10183.972605863] : 20 18 c8 2c 78 01 5b
>> +  [10184.220124772] : 20 18 c8 2c 78 01 5b
>> +  [10184.467764166] : 20 18 c8 2c 78 01 5b
>> +  [10193.233421784] : 20 18 c8 2c 7c 01 57
>> +  [10193.480273460] : 20 18 c8 2c 7c 01 57
>> +  [10193.726788733] : 20 18 c8 2c 7c 01 57
>> +  [10193.972781945] : 20 18 c8 2c 7c 01 57
>> +  [10194.220487360] : 20 18 c8 2c 7c 01 57
>> +  [10194.468089259] : 20 18 c8 2c 7c 01 57
>> +  [10203.233433099] : 20 18 c8 2c 80 01 53
>> +  [10203.481058715] : 20 18 c8 2c 80 01 53
>> +  [10203.727610472] : 20 18 c8 2c 80 01 53
>> +  [10203.974044856] : 20 18 c8 2c 80 01 53
>> +  [10204.220734634] : 20 18 c8 2c 80 01 53
>> +  [10204.468461664] : 20 18 c8 2c 80 01 53
>> +
>> diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
>> index efc3354..7053b5b 100644
>> --- a/drivers/i2c/Kconfig
>> +++ b/drivers/i2c/Kconfig
>> @@ -118,6 +118,19 @@ if I2C_SLAVE
>>   config I2C_SLAVE_EEPROM
>>   	tristate "I2C eeprom slave driver"
>>   
>> +config I2C_SLAVE_MQUEUE
>> +	tristate "I2C mqueue (message queue) slave driver"
>> +	help
>> +	  Some protocols over I2C are designed for bi-directional
>> transferring
>> +	  messages by using I2C Master Write protocol. This driver is
>> used to
>> +	  receive and queue messages from the remote I2C device.
>> +
>> +	  Userspace can get the messages by reading sysfs file that
>> this driver
>> +	  exposes.
>> +
>> +	  This support is also available as a module. If so, the
>> module will be
>> +	  called i2c-slave-mqueue.
>> +
>>   endif
>>   
>>   config I2C_DEBUG_CORE
>> diff --git a/drivers/i2c/Makefile b/drivers/i2c/Makefile
>> index 72c94c6..7ec287b 100644
>> --- a/drivers/i2c/Makefile
>> +++ b/drivers/i2c/Makefile
>> @@ -16,6 +16,7 @@ obj-$(CONFIG_I2C_MUX)		+= i2c-mux.o
>>   obj-y				+= algos/ busses/ muxes/
>>   obj-$(CONFIG_I2C_STUB)		+= i2c-stub.o
>>   obj-$(CONFIG_I2C_SLAVE_EEPROM)	+= i2c-slave-eeprom.o
>> +obj-$(CONFIG_I2C_SLAVE_MQUEUE)	+= i2c-slave-mqueue.o
>>   
>>   ccflags-$(CONFIG_I2C_DEBUG_CORE) := -DDEBUG
>>   CFLAGS_i2c-core-base.o := -Wno-deprecated-declarations
>> diff --git a/drivers/i2c/i2c-slave-mqueue.c b/drivers/i2c/i2c-slave-
>> mqueue.c
>> new file mode 100644
>> index 0000000..a486e85
>> --- /dev/null
>> +++ b/drivers/i2c/i2c-slave-mqueue.c
>> @@ -0,0 +1,202 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright (c) 2017 - 2018, Intel Corporation.
>> +
>> +#include <linux/i2c.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/slab.h>
>> +#include <linux/spinlock.h>
>> +#include <linux/sysfs.h>
>> +
>> +#define MQ_MSGBUF_SIZE		128
>> +#define MQ_QUEUE_SIZE		32
>> +#define MQ_QUEUE_NEXT(x)	(((x) + 1) & (MQ_QUEUE_SIZE - 1))
>> +
>> +struct mq_msg {
>> +	int	len;
>> +	u8	*buf;
>> +};
>> +
>> +struct mq_queue {
>> +	struct bin_attribute	bin;
>> +	struct kernfs_node	*kn;
>> +
>> +	spinlock_t		lock; /* spinlock for queue index
>> handling */
>> +	int			in;
>> +	int			out;
>> +
>> +	struct mq_msg		*curr;
>> +	int			truncated; /* drop current if
>> truncated */
>> +	struct mq_msg		queue[MQ_QUEUE_SIZE];
>> +};
>> +
>> +static int i2c_slave_mqueue_callback(struct i2c_client *client,
>> +				     enum i2c_slave_event event, u8
>> *val)
>> +{
>> +	struct mq_queue *mq = i2c_get_clientdata(client);
>> +	struct mq_msg *msg = mq->curr;
>> +	int ret = 0;
>> +
>> +	switch (event) {
>> +	case I2C_SLAVE_WRITE_REQUESTED:
>> +		mq->truncated = 0;
>> +
>> +		msg->len = 1;
>> +		msg->buf[0] = client->addr << 1;
>> +		break;
>> +
>> +	case I2C_SLAVE_WRITE_RECEIVED:
>> +		if (msg->len < MQ_MSGBUF_SIZE) {
>> +			msg->buf[msg->len++] = *val;
>> +		} else {
>> +			dev_err(&client->dev, "message is
>> truncated!\n");
>> +			mq->truncated = 1;
>> +			ret = -EINVAL;
>> +		}
>> +		break;
>> +
>> +	case I2C_SLAVE_STOP:
>> +		if (unlikely(mq->truncated))
>> +			break;
>> +
>> +		spin_lock(&mq->lock);
>> +		mq->in = MQ_QUEUE_NEXT(mq->in);
>> +		mq->curr = &mq->queue[mq->in];
>> +
>> +		/* Flush the oldest message */
>> +		if (mq->out == mq->in)
>> +			mq->out = MQ_QUEUE_NEXT(mq->out);
>> +		spin_unlock(&mq->lock);
>> +
>> +		kernfs_notify(mq->kn);
>> +		break;
>> +
>> +	default:
>> +		*val = 0xFF;
>> +		break;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static ssize_t i2c_slave_mqueue_bin_read(struct file *filp,
>> +					 struct kobject *kobj,
>> +					 struct bin_attribute *attr,
>> +					 char *buf, loff_t pos,
>> size_t count)
>> +{
>> +	struct mq_queue *mq;
>> +	struct mq_msg *msg;
>> +	unsigned long flags;
>> +	bool more = false;
>> +	ssize_t ret = 0;
>> +
>> +	mq = dev_get_drvdata(container_of(kobj, struct device,
>> kobj));
>> +
>> +	spin_lock_irqsave(&mq->lock, flags);
>> +	if (mq->out != mq->in) {
>> +		msg = &mq->queue[mq->out];
>> +
>> +		if (msg->len <= count) {
>> +			ret = msg->len;
>> +			memcpy(buf, msg->buf, ret);
>> +		} else {
>> +			ret = -EOVERFLOW; /* Drop this HUGE one. */
>> +		}
>> +
>> +		mq->out = MQ_QUEUE_NEXT(mq->out);
>> +		if (mq->out != mq->in)
>> +			more = true;
>> +	}
>> +	spin_unlock_irqrestore(&mq->lock, flags);
>> +
>> +	if (more)
>> +		kernfs_notify(mq->kn);
>> +
>> +	return ret;
>> +}
>> +
>> +static int i2c_slave_mqueue_probe(struct i2c_client *client,
>> +				  const struct i2c_device_id *id)
>> +{
>> +	struct device *dev = &client->dev;
>> +	struct mq_queue *mq;
>> +	int ret, i;
>> +	void *buf;
>> +
>> +	mq = devm_kzalloc(dev, sizeof(*mq), GFP_KERNEL);
>> +	if (!mq)
>> +		return -ENOMEM;
>> +
>> +	BUILD_BUG_ON(!is_power_of_2(MQ_QUEUE_SIZE));
>> +
>> +	buf = devm_kmalloc_array(dev, MQ_QUEUE_SIZE, MQ_MSGBUF_SIZE,
>> +				 GFP_KERNEL);
>> +	if (!buf)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < MQ_QUEUE_SIZE; i++)
>> +		mq->queue[i].buf = buf + i * MQ_MSGBUF_SIZE;
>> +
>> +	i2c_set_clientdata(client, mq);
>> +
>> +	spin_lock_init(&mq->lock);
>> +	mq->curr = &mq->queue[0];
>> +
>> +	sysfs_bin_attr_init(&mq->bin);
>> +	mq->bin.attr.name = "slave-mqueue";
>> +	mq->bin.attr.mode = 0400;
>> +	mq->bin.read = i2c_slave_mqueue_bin_read;
>> +	mq->bin.size = MQ_MSGBUF_SIZE * MQ_QUEUE_SIZE;
>> +
>> +	ret = sysfs_create_bin_file(&dev->kobj, &mq->bin);
>> +	if (ret)
>> +		return ret;
>> +
>> +	mq->kn = kernfs_find_and_get(dev->kobj.sd, mq-
>>> bin.attr.name);
>> +	if (!mq->kn) {
>> +		sysfs_remove_bin_file(&dev->kobj, &mq->bin);
>> +		return -EFAULT;
>> +	}
>> +
>> +	ret = i2c_slave_register(client, i2c_slave_mqueue_callback);
>> +	if (ret) {
>> +		kernfs_put(mq->kn);
>> +		sysfs_remove_bin_file(&dev->kobj, &mq->bin);
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +};
>> +
>> +static int i2c_slave_mqueue_remove(struct i2c_client *client)
>> +{
>> +	struct mq_queue *mq = i2c_get_clientdata(client);
>> +
>> +	i2c_slave_unregister(client);
>> +
>> +	kernfs_put(mq->kn);
>> +	sysfs_remove_bin_file(&client->dev.kobj, &mq->bin);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct i2c_device_id i2c_slave_mqueue_id[] = {
>> +	{ "slave-mqueue", 0 },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(i2c, i2c_slave_mqueue_id);
>> +
>> +static struct i2c_driver i2c_slave_mqueue_driver = {
>> +	.driver = {
>> +		.name	= "i2c-slave-mqueue",
>> +	},
>> +	.probe		= i2c_slave_mqueue_probe,
>> +	.remove		= i2c_slave_mqueue_remove,
>> +	.id_table	= i2c_slave_mqueue_id,
>> +};
>> +module_i2c_driver(i2c_slave_mqueue_driver);
>> +
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_AUTHOR("Haiyue Wang <haiyue.wang@linux.intel.com>");
>> +MODULE_DESCRIPTION("I2C slave mode for receiving and queuing
>> messages");
