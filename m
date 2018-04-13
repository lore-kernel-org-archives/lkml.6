Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753493AbeDMG7j (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 02:59:39 -0400
Received: from hub02.inventec.com ([218.32.67.167]:6997 "EHLO
        mail.inventec.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750849AbeDMG7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 02:59:38 -0400
X-Google-Smtp-Source: AIpwx4+uCQzTK/o6MPbirhUNRmpyA+ezmSMYnyb6WbovasWNLSLZwxKtFRLiVgLBM5OJmLBNe2haXJMiLq7Snq7x2Ww=
MIME-Version: 1.0
In-Reply-To: <5053d0d0-e4c5-733e-051d-b5900d05ea2b@axentia.se>
References: <20180320061909.5775-1-chen.kenyy@inventec.com>
 <20180320093200.19179-1-peda@axentia.se> <5053d0d0-e4c5-733e-051d-b5900d05ea2b@axentia.se>
From: =?UTF-8?B?Q2hlbktlbllZIOmZs+awuOeHnyBUQU8=?=
        <chen.kenyy@inventec.com>
Date: Fri, 13 Apr 2018 14:59:09 +0800
Message-ID: <CADo_Z40fZaT8iRSALDv7-YaK0YD-WFph5RwmrngFbC4FzFAp9Q@mail.gmail.com>
Subject: Re: [PATCH linux dev-4.16 v2] i2c: muxes: pca9641: new driver
To: Peter Rosin <peda@axentia.se>
CC: <linux-kernel@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>,
        Wolfram Sang <wsa@the-dreams.de>, Joel Stanley <joel@jms.id.au>,
        <linux-i2c@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-DNSRBL: 
X-MAIL: IEC1-MSE-FE1.inventec.com w3D6xGS0056257
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Sorry for late. Here has some event at my company which needs to pause
this work.

If the status changed, I will update my patch.

Thanks.
Ken

2018-04-11 17:37 GMT+08:00 Peter Rosin <peda@axentia.se>:
> Hi Ken,
>
> It's been a couple of weeks and I wondered if you are making any
> progress? Simple lack of time perhaps, or are you stuck and need
> help?
>
> Cheers,
> Peter
>
> On 2018-03-20 10:31, Peter Rosin wrote:
>> On 2018-03-20 07:19, Ken Chen wrote:
>>> Signed-off-by: Ken Chen <chen.kenyy@inventec.com>
>>
>> Ok, now that you are not adding a new driver, but instead
>> modify an existing driver, the subject I requested in no
>> longer relevant. Now I would like to see:
>>
>> i2c: mux: pca9541: add support for PCA9641 chips
>>
>> Or something like that.
>>
>>> ---
>>> v1->v2
>>> - Merged PCA9641 code into i2c-mux-pca9541.c
>>> - Modified title
>>> - Add PCA9641 detect function
>>> ---
>>>  drivers/i2c/muxes/i2c-mux-pca9541.c | 184 ++++++++++++++++++++++++++++++++++--
>>>  1 file changed, 174 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/i2c/muxes/i2c-mux-pca9541.c b/drivers/i2c/muxes/i2c-mux-pca9541.c
>>> index 6a39ada..493f947 100644
>>> --- a/drivers/i2c/muxes/i2c-mux-pca9541.c
>>> +++ b/drivers/i2c/muxes/i2c-mux-pca9541.c
>>> @@ -1,5 +1,5 @@
>>>  /*
>>> - * I2C multiplexer driver for PCA9541 bus master selector
>>> + * I2C multiplexer driver for PCA9541/PCA9641 bus master selector
>>>   *
>>>   * Copyright (c) 2010 Ericsson AB.
>>>   *
>>> @@ -26,8 +26,8 @@
>>>  #include <linux/slab.h>
>>>
>>>  /*
>>> - * The PCA9541 is a bus master selector. It supports two I2C masters connected
>>> - * to a single slave bus.
>>> + * The PCA9541/PCA9641 is a bus master selector. It supports two I2C masters
>>
>> PCA9541 and PCA9641 are bus master selectors. They support two I2C masters
>>
>> And make sure to lose the trailing space.
>>
>>> + * connected to a single slave bus.
>>>   *
>>>   * Before each bus transaction, a master has to acquire bus ownership. After the
>>>   * transaction is complete, bus ownership has to be released. This fits well
>>> @@ -58,11 +58,43 @@
>>>  #define PCA9541_ISTAT_MYTEST        (1 << 6)
>>>  #define PCA9541_ISTAT_NMYTEST       (1 << 7)
>>>
>>> +#define PCA9641_ID          0x00
>>> +#define PCA9641_ID_MAGIC    0x38
>>> +
>>> +#define PCA9641_CONTROL             0x01
>>> +#define PCA9641_STATUS              0x02
>>> +#define PCA9641_TIME                0x03
>>> +
>>> +#define PCA9641_CTL_LOCK_REQ                BIT(0)
>>> +#define PCA9641_CTL_LOCK_GRANT              BIT(1)
>>> +#define PCA9641_CTL_BUS_CONNECT             BIT(2)
>>> +#define PCA9641_CTL_BUS_INIT                BIT(3)
>>> +#define PCA9641_CTL_SMBUS_SWRST             BIT(4)
>>> +#define PCA9641_CTL_IDLE_TIMER_DIS  BIT(5)
>>> +#define PCA9641_CTL_SMBUS_DIS               BIT(6)
>>> +#define PCA9641_CTL_PRIORITY                BIT(7)
>>> +
>>> +#define PCA9641_STS_OTHER_LOCK              BIT(0)
>>> +#define PCA9641_STS_BUS_INIT_FAIL   BIT(1)
>>> +#define PCA9641_STS_BUS_HUNG                BIT(2)
>>> +#define PCA9641_STS_MBOX_EMPTY              BIT(3)
>>> +#define PCA9641_STS_MBOX_FULL               BIT(4)
>>> +#define PCA9641_STS_TEST_INT                BIT(5)
>>> +#define PCA9641_STS_SCL_IO          BIT(6)
>>> +#define PCA9641_STS_SDA_IO          BIT(7)
>>> +
>>> +#define PCA9641_RES_TIME    0x03
>>> +
>>>  #define BUSON               (PCA9541_CTL_BUSON | PCA9541_CTL_NBUSON)
>>>  #define MYBUS               (PCA9541_CTL_MYBUS | PCA9541_CTL_NMYBUS)
>>>  #define mybus(x)    (!((x) & MYBUS) || ((x) & MYBUS) == MYBUS)
>>>  #define busoff(x)   (!((x) & BUSON) || ((x) & BUSON) == BUSON)
>>>
>>> +#define BUSOFF(x, y)        (!((x) & PCA9641_CTL_LOCK_GRANT) && \
>>> +                    !((y) & PCA9641_STS_OTHER_LOCK))
>>> +#define other_lock(x)       ((x) & PCA9641_STS_OTHER_LOCK)
>>> +#define lock_grant(x)       ((x) & PCA9641_CTL_LOCK_GRANT)
>> These macro names are now completely hideous. They were bad before,
>> but this is just too much for me. So, instead of adding BUSOFF etc,
>> I would like to see all the macros with a chip prefix. But I think
>> they will get overly long, so I think you should just write trivial
>> pca9541_mybus, pca9541_busoff, pca9641_busoff etc functions. The
>> compiler should inline them just fine.
>>
>> The rename of the existing macros and their conversion to functions
>> should be in the first preparatory patch that I mention below. The
>> new functions should be in the second patch.
>>
>>> +
>>>  /* arbitration timeouts, in jiffies */
>>>  #define ARB_TIMEOUT (HZ / 8)        /* 125 ms until forcing bus ownership */
>>>  #define ARB2_TIMEOUT        (HZ / 4)        /* 250 ms until acquisition failure */
>>> @@ -79,6 +111,7 @@ struct pca9541 {
>>>
>>>  static const struct i2c_device_id pca9541_id[] = {
>>>      {"pca9541", 0},
>>> +    {"pca9641", 1},
>>
>> You are actually not using this 0/1 difference. Have a look at
>> e.g. how the i2c-mux-pca954x driver uses this as an index into
>> a chip description array. I would like to see something similar
>> here...
>>
>>>      {}
>>>  };
>>>
>>> @@ -87,6 +120,7 @@ MODULE_DEVICE_TABLE(i2c, pca9541_id);
>>>  #ifdef CONFIG_OF
>>>  static const struct of_device_id pca9541_of_match[] = {
>>>      { .compatible = "nxp,pca9541" },
>>> +    { .compatible = "nxp,pca9641" },
>>
>> ...including pointers to the above chip descriptions here, just
>> like the pca954x driver.
>>
>>>      {}
>>>  };
>>>  MODULE_DEVICE_TABLE(of, pca9541_of_match);
>>> @@ -328,6 +362,125 @@ static int pca9541_release_chan(struct i2c_mux_core *muxc, u32 chan)
>>>  }
>>>
>>>  /*
>>> + * Arbitration management functions
>>> + */
>>> +static void pca9641_release_bus(struct i2c_client *client)
>>> +{
>>> +    pca9541_reg_write(client, PCA9641_CONTROL, 0);
>>> +}
>>> +
>>> +/*
>>> + * Channel arbitration
>>> + *
>>> + * Return values:
>>> + *  <0: error
>>> + *  0 : bus not acquired
>>> + *  1 : bus acquired
>>> + */
>>> +static int pca9641_arbitrate(struct i2c_client *client)
>>> +{
>>> +    struct i2c_mux_core *muxc = i2c_get_clientdata(client);
>>> +    struct pca9541 *data = i2c_mux_priv(muxc);
>>> +    int reg_ctl, reg_sts;
>>> +
>>> +    reg_ctl = pca9541_reg_read(client, PCA9641_CONTROL);
>>> +    if (reg_ctl < 0)
>>> +            return reg_ctl;
>>> +    reg_sts = pca9541_reg_read(client, PCA9641_STATUS);
>>> +
>>> +    if (BUSOFF(reg_ctl, reg_sts)) {
>>> +            /*
>>> +             * Bus is off. Request ownership or turn it on unless
>>> +             * other master requested ownership.
>>> +             */
>>> +            reg_ctl |= PCA9641_CTL_LOCK_REQ;
>>> +            pca9541_reg_write(client, PCA9641_CONTROL, reg_ctl);
>>> +            reg_ctl = pca9541_reg_read(client, PCA9641_CONTROL);
>>> +
>>> +            if (lock_grant(reg_ctl)) {
>>> +                    /*
>>> +                     * Other master did not request ownership,
>>> +                     * or arbitration timeout expired. Take the bus.
>>> +                     */
>>> +                    reg_ctl |= PCA9641_CTL_BUS_CONNECT
>>> +                                    | PCA9641_CTL_LOCK_REQ;
>>> +                    pca9541_reg_write(client, PCA9641_CONTROL, reg_ctl);
>>> +                    data->select_timeout = SELECT_DELAY_SHORT;
>>> +
>>> +                    return 1;
>>> +            } else {
>>> +                    /*
>>> +                     * Other master requested ownership.
>>> +                     * Set extra long timeout to give it time to acquire it.
>>> +                     */
>>> +                    data->select_timeout = SELECT_DELAY_LONG * 2;
>>> +            }
>>> +    } else if (lock_grant(reg_ctl)) {
>>> +            /*
>>> +             * Bus is on, and we own it. We are done with acquisition.
>>> +             */
>>> +            reg_ctl |= PCA9641_CTL_BUS_CONNECT | PCA9641_CTL_LOCK_REQ;
>>> +            pca9541_reg_write(client, PCA9641_CONTROL, reg_ctl);
>>> +
>>> +            return 1;
>>> +    } else if (other_lock(reg_sts)) {
>>> +            /*
>>> +             * Other master owns the bus.
>>> +             * If arbitration timeout has expired, force ownership.
>>> +             * Otherwise request it.
>>> +             */
>>> +            data->select_timeout = SELECT_DELAY_LONG;
>>> +            reg_ctl |= PCA9641_CTL_LOCK_REQ;
>>> +            pca9541_reg_write(client, PCA9641_CONTROL, reg_ctl);
>>> +    }
>>> +    return 0;
>>> +}
>>> +
>>> +static int pca9641_select_chan(struct i2c_mux_core *muxc, u32 chan)
>>> +{
>>> +    struct pca9541 *data = i2c_mux_priv(muxc);
>>> +    struct i2c_client *client = data->client;
>>> +    int ret;
>>> +    unsigned long timeout = jiffies + ARB2_TIMEOUT;
>>> +            /* give up after this time */
>>> +
>>> +    data->arb_timeout = jiffies + ARB_TIMEOUT;
>>> +            /* force bus ownership after this time */
>>> +
>>> +    do {
>>> +            ret = pca9641_arbitrate(client);
>>> +            if (ret)
>>> +                    return ret < 0 ? ret : 0;
>>> +
>>> +            if (data->select_timeout == SELECT_DELAY_SHORT)
>>> +                    udelay(data->select_timeout);
>>> +            else
>>> +                    msleep(data->select_timeout / 1000);
>>> +    } while (time_is_after_eq_jiffies(timeout));
>>> +
>>> +    return -ETIMEDOUT;
>>> +}
>>> +
>>> +static int pca9641_release_chan(struct i2c_mux_core *muxc, u32 chan)
>>> +{
>>> +    struct pca9541 *data = i2c_mux_priv(muxc);
>>> +    struct i2c_client *client = data->client;
>>> +
>>> +    pca9641_release_bus(client);
>>> +    return 0;
>>> +}
>>
>> The pca9641_select_chan and pca9641_release_chan functions are exact
>> copies of the pca9541 counterparts, with the exception of which
>> functions they ultimately call. So, instead of using different
>> function pointers in the i2c_mux_alloc calls below, add a couple of
>> function pointers to the above mentioned chip description struct.
>>
>> Then change pca9541_release_chan to something like this:
>>
>> static int pca9541_release_chan(struct i2c_mux_core *muxc, u32 chan)
>> {
>>       struct pca9541 *data = i2c_mux_priv(muxc);
>>       struct i2c_client *client = data->client;
>>
>>       data->chip->release_bus(client);
>>       return 0;
>> }
>>
>> Similarly for the *_select_chan "wrapper".
>>
>> Now, these changes will somewhat affect the pca9541 side of the
>> driver, so I would like to see more than one patch. There should be
>> patches that prepares the driver that should be kind of easy to
>> verify that they are equivalent but that makes adding a new chip
>> easier, and then one patch at then end that adds the new chip. Hmm,
>> it will probably be easier if I write those patches instead of
>> reviewing them. I will followup with them. But note that I can
>> only compile test them, so I would like to see tags for them.
>>
>>> +
>>> +static int pca9641_detect_id(struct i2c_client *client)
>>> +{
>>> +    int reg;
>>> +
>>> +    reg = pca9541_reg_read(client, PCA9641_ID);
>>> +    if (reg == PCA9641_ID_MAGIC)
>>> +            return 1;
>>> +    else
>>> +            return 0;
>>> +}
>>
>> This was not what I had in mind. If you do dig out the id, I think
>> you should only use it to verify that the input to the probe function
>> is correct and error out otherwise. But maybe I'm conservative?
>> Anyway, with the above patches you will not need this.
>>
>>> +/*
>>>   * I2C init/probing/exit functions
>>>   */
>>>  static int pca9541_probe(struct i2c_client *client,
>>> @@ -339,34 +492,45 @@ static int pca9541_probe(struct i2c_client *client,
>>>      struct pca9541 *data;
>>>      int force;
>>>      int ret;
>>> +    int detect_id;
>>>
>>>      if (!i2c_check_functionality(adap, I2C_FUNC_SMBUS_BYTE_DATA))
>>>              return -ENODEV;
>>>
>>> +    detect_id = pca9641_detect_id(client);
>>>      /*
>>>       * I2C accesses are unprotected here.
>>>       * We have to lock the adapter before releasing the bus.
>>>       */
>>> -    i2c_lock_adapter(adap);
>>> -    pca9541_release_bus(client);
>>> -    i2c_unlock_adapter(adap);
>>> -
>>> +    if (detect_id == 0) {
>>> +            i2c_lock_adapter(adap);
>>> +            pca9541_release_bus(client);
>>> +            i2c_unlock_adapter(adap);
>>> +    } else {
>>> +            i2c_lock_adapter(adap);
>>> +            pca9641_release_bus(client);
>>> +            i2c_unlock_adapter(adap);
>>> +    }
>>>      /* Create mux adapter */
>>>
>>>      force = 0;
>>>      if (pdata)
>>>              force = pdata->modes[0].adap_id;
>>> -    muxc = i2c_mux_alloc(adap, &client->dev, 1, sizeof(*data),
>>> +    if (detect_id == 0) {
>>> +            muxc = i2c_mux_alloc(adap, &client->dev, 1, sizeof(*data),
>>>                           I2C_MUX_ARBITRATOR,
>>>                           pca9541_select_chan, pca9541_release_chan);
>>> +    } else {
>>> +            muxc = i2c_mux_alloc(adap, &client->dev, 1, sizeof(*data),
>>> +                         I2C_MUX_ARBITRATOR,
>>> +                         pca9641_select_chan, pca9641_release_chan);
>>> +    }
>>>      if (!muxc)
>>>              return -ENOMEM;
>>>
>>>      data = i2c_mux_priv(muxc);
>>>      data->client = client;
>>> -
>>>      i2c_set_clientdata(client, muxc);
>>> -
>>
>> Please don't do spurious whitespace changes like this as part of a
>> functional change.
>>
>>>      ret = i2c_mux_add_adapter(muxc, force, 0, 0);
>>>      if (ret)
>>>              return ret;
>>>
>>
>> You should change the Kconfig file to mention the new chip and you are
>> still missing a devicetree binding.
>>
>> Cheers,
>> Peter
>>
>
