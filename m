Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970440AbeCSSs5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 14:48:57 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:41570 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S970180AbeCSSsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 14:48:52 -0400
X-Google-Smtp-Source: AG47ELsUN/0wc4FU/5zS5rl1opT6usiz+Ic2RnLixymoAnbFxlY7UEkULMFkQYw7GAcxQ/Xp/5p3BQ==
Date: Mon, 19 Mar 2018 11:48:50 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Rosin <peda@axentia.se>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Adrian Fiergolski <adrian.fiergolski@cern.ch>
Subject: Re: [RFC PATCH 1/2] i2c: Add i2c_verify_device_id() to verify device
 id
Message-ID: <20180319184850.GB23774@roeck-us.net>
References: <1521475859-16765-1-git-send-email-linux@roeck-us.net>
 <99548eb6-1958-b2a1-1f2c-ba995f8965ee@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99548eb6-1958-b2a1-1f2c-ba995f8965ee@axentia.se>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 05:47:05PM +0100, Peter Rosin wrote:
> On 2018-03-19 17:10, Guenter Roeck wrote:
> > Commit dde67eb1beeb ("i2c: add i2c_get_device_id() to get the standard
> > I2C device id") added a function to return the standard I2C device ID.
> > Use that function to verify the device ID of a given device.
> 
> Yeah, you're moving complexity from the driver to the core, reducing
> the indentation level and generally make things look neater. In fact,
> I thought about adding something like this, but didn't since I only had
> the one user.
> 
> The only negative is the added line count, but I suppose more drivers
> will call this function down the line so it should be a net win in the
> long run. There was the PCA9641 chip earlier today e.g., but maybe we
> should wait for more device id users?
> 
Unfortunately it looks like only NXPs GPIO expanders and i2c muxes support
it, or at least I didn't find any other chips. I figured though that it
would be worth it even if only two drivers (or even one) end up using it.

> I wonder when other manufacturers will get on board?
> 
Hah, good question. As mentioned above, I didn't find any.

> I also wonder if NXP will ever release a chip with part-id 0 and
> die-revision 0? If not, an all zero struct i2c_device_identity
> could be used instead of manufacturer_id 0xffff and that would
> simplify the pca954x driver code a bit more. But I guess we can
> never know the answer to that question. And even if we did, the
> answer might change later. But it would be nice...
> 

That would be nice. You could ask at i2c.support@nxp.com, but I guess
it would always be somewhat risky since the standard doesn't restrict
its use, and some product manager at NXP might decide in the future
that a device ID of 0x00 would be "cool".

Guenter

> > Cc: Peter Rosin <peda@axentia.se>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> > RFC:
> > - Compile tested only
> 
> Can't test either since I have no chips, but the code looks good.
> 
> Adrian have HW, but maybe he's getting tried of testing?
> 
> Hmmm, for testing purposes it would be nice if a linux slave device
> implemented this. But I don't have HW that supports that either so it
> wouldn't help *me* anyway...
> 
> Anyway, ack from me for both patches. But maybe I'm the one
> picking them up? Wolfram?
> 
> Cheers,
> Peter
> 
> > - Should there also be I2C_DEVICE_PART_ID_ANY to enable maching
> >   against all parts from a given manufacturer ?
> > 
> >  drivers/i2c/i2c-core-base.c | 34 ++++++++++++++++++++++++++++++++++
> >  include/linux/i2c.h         |  3 +++
> >  2 files changed, 37 insertions(+)
> > 
> > diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> > index 16a3b73375a6..4e4372b064f6 100644
> > --- a/drivers/i2c/i2c-core-base.c
> > +++ b/drivers/i2c/i2c-core-base.c
> > @@ -2009,6 +2009,40 @@ int i2c_get_device_id(const struct i2c_client *client,
> >  }
> >  EXPORT_SYMBOL_GPL(i2c_get_device_id);
> >  
> > +/**
> > + * i2c_verify_device_id - verify device ID
> > + * @client: The device to query
> > + * @id: Expected device ID
> > + *
> > + * Returns negative errno on error, zero on success.
> > + */
> > +int i2c_verify_device_id(const struct i2c_client *client,
> > +			 const struct i2c_device_identity *id)
> > +{
> > +	struct i2c_device_identity real_id;
> > +	int ret;
> > +
> > +	if (id->manufacturer_id == I2C_DEVICE_ID_NONE)
> > +		return 0;
> > +
> > +	ret = i2c_get_device_id(client, &real_id);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	if (id->manufacturer_id != real_id.manufacturer_id ||
> > +	    id->part_id != real_id.part_id ||
> > +	    (id->die_revision != I2C_DEVICE_DIE_REVISION_ANY &&
> > +	     id->die_revision != real_id.die_revision)) {
> > +		dev_err(&client->dev, "unexpected device id %03x-%03x-%x\n",
> > +			real_id.manufacturer_id, real_id.part_id,
> > +			real_id.die_revision);
> > +		return -ENODEV;
> > +	}
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(i2c_verify_device_id);
> > +
> >  /* ----------------------------------------------------
> >   * the i2c address scanning function
> >   * Will not work for 10-bit addresses!
> > diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> > index 44ad14e016b5..45bae9717ecb 100644
> > --- a/include/linux/i2c.h
> > +++ b/include/linux/i2c.h
> > @@ -189,6 +189,8 @@ i2c_smbus_read_i2c_block_data_or_emulated(const struct i2c_client *client,
> >  					  u8 command, u8 length, u8 *values);
> >  int i2c_get_device_id(const struct i2c_client *client,
> >  		      struct i2c_device_identity *id);
> > +int i2c_verify_device_id(const struct i2c_client *client,
> > +			 const struct i2c_device_identity *id);
> >  #endif /* I2C */
> >  
> >  /**
> > @@ -216,6 +218,7 @@ struct i2c_device_identity {
> >  #define I2C_DEVICE_ID_NONE                         0xffff
> >  	u16 part_id;
> >  	u8 die_revision;
> > +#define I2C_DEVICE_DIE_REVISION_ANY		     0xff
> >  };
> >  
> >  enum i2c_alert_protocol {
> > 
> 
