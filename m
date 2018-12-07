Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE8CC64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E66C520672
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HG4NdIU+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E66C520672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbeLGSha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 13:37:30 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41144 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbeLGSh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 13:37:29 -0500
Received: by mail-pg1-f193.google.com with SMTP id 70so2077600pgh.8;
        Fri, 07 Dec 2018 10:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TipxjuVTetJLdNenIgGqyzJK986c8b3z8SSjGt//NU8=;
        b=HG4NdIU+2AOGBg0HjvQlPBxcpJBbCAt33bd/X78GmzeDgOJaatawjkhdTkjxp7J+Pp
         eGalkiRrVrgWj7HKeqpqjb5v+D//LfcSfVSWvpiGoYWgm3z8adLml8JimmIy3uV40usz
         dY3ohSJcY/AHV8G+9kLXZCaRvZfPQ1PC96t8aWNuIOiOPHXlKs2BhCBtfjXlY5DcWhG3
         6zF1eDjvhvWnG6LzzN7zfusMofXRoloJqBFHMmozX3Xlo/Pr+o2LcIAoShoNmSUdiLwJ
         RYpFXuyoElrgqUUu/oZMzm90eTNbLcClYfaCZPsfdO4nWgLwXoZE9VbadrbG2eg5A4Gj
         5nmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TipxjuVTetJLdNenIgGqyzJK986c8b3z8SSjGt//NU8=;
        b=MkwuND7a7gJ0X2/BjX5SUbuj2WgrMW3GsxLxzCNjKnWwZMgIghpp7+Y4bSnautm/VH
         sLKdlFggp4MMz2FmFzkkADDJm2l4dvWCotl6j9ddf3ijWYiWWUJDxxchvmUA4ZViU1su
         k8waDeMDigQbGM+VnFBp2neKcXgOuQs9kdA+KqmH5cnAsUdg1jjPbW3pdwSFy+aX1R1E
         nuWUDYcYwDFp4cv6fnUxdmcFfyl+eL8970CezGaQA28dCwnfcJrpV2dWCd3P/5dZujeH
         7b7RGuHeoANOoQWRLw0bBDQY7AzJdrO/b22JKl1EA4xoIi3rarvxt2/9GINvJw+g5ufk
         +CSA==
X-Gm-Message-State: AA+aEWYZIIHd3ILyxvrqamG/bJCf9i3LooNvNYd096dzYyq/KIs+xF6m
        DOAVcd1EoUxqFASg3osJN9M=
X-Google-Smtp-Source: AFSGD/X/+hF1Ph5ldWdIS2FJ0RBYwx10Rkpq6GO5IAuArDgqgWTLzsIRSJkaX1hQfnWVNS5oVkWm2Q==
X-Received: by 2002:a63:c64f:: with SMTP id x15mr2845480pgg.16.1544207847681;
        Fri, 07 Dec 2018 10:37:27 -0800 (PST)
Received: from Shreeya-Patel ([103.212.140.150])
        by smtp.googlemail.com with ESMTPSA id g15sm17915806pfj.131.2018.12.07.10.37.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 10:37:26 -0800 (PST)
Message-ID: <90e3066edb0616cd20ee019e3f2a392fd3a3f285.camel@gmail.com>
Subject: Re: [PATCH] Revert "Staging: iio: adt7316: Add an extra check for
 'ret' equals to 0"
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jeremy Fertic <jeremyfertic@gmail.com>
Cc:     devel@driverdev.osuosl.org, lars@metafoo.de,
        Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        pmeerw@pmeerw.net, knaack.h@gmx.de, jic23@kernel.org
Date:   Sat, 08 Dec 2018 00:07:21 +0530
In-Reply-To: <20181206124047.GH3095@unbuntlaptop>
References: <20181205014900.4827-1-jeremyfertic@gmail.com>
         <fccdb26936a9cfcd5134c760cd918929ad3dfa19.camel@gmail.com>
         <20181205215953.GA2365@r2700x.localdomain>
         <20181206124047.GH3095@unbuntlaptop>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-12-06 at 15:40 +0300, Dan Carpenter wrote:
> On Wed, Dec 05, 2018 at 02:59:53PM -0700, Jeremy Fertic wrote:
> > On Thu, Dec 06, 2018 at 01:25:55AM +0530, Shreeya Patel wrote:
> > > On Tue, 2018-12-04 at 18:49 -0700, Jeremy Fertic wrote:
> > > > This reverts commit 00426e99789357dbff7e719a092ce36a3ce49d94.
> > > > 
> > > > i2c_smbus_read_byte() returns 0 when a byte with the value 0 is
> > > > read
> > > > from
> > > > the device. This is a valid read so revert the check for 0.
> > > > 
> > > > Signed-off-by: Jeremy Fertic <jeremyfertic@gmail.com>
> > > > ---
> > > 
> > > Hi Jeremy,
> > > 
> > > As per my understanding, 0 value indicates no error but no data
> > > read.
> > > Then how can this be a valid case?
> > > 
> > > Can you please make me understand that how can we consider this
> > > as a
> > > valid case even when no data has been read?
> 
> It's not reading no data.  It's reading one byte of data and
> returning
> it.
> 
> > > 
> > > 
> > > Thanks
> > 
> > I'm not sure I understand why the value 0 would indicate no data
> > read.
> > Doesn't that just mean a byte was read with the value 0.
> 
> Yes.  It does mean that.  Please don't ask rhetorical
> questions...  :(
> This list is full of people who can't resist answering every
> question.
> 
> > For instance, if the input to the adc is 0V. Can you point me to
> > where
> > you're seeing that this would indicate no data read?
> 
> drivers/i2c/i2c-core-smbus.c
>     88  /**
>     89   * i2c_smbus_read_byte - SMBus "receive byte" protocol
>     90   * @client: Handle to slave device
>     91   *
>     92   * This executes the SMBus "receive byte" protocol, returning
> negative errno
>     93   * else the byte received from the device.
>     94   */
>     95  s32 i2c_smbus_read_byte(const struct i2c_client *client)
>     96  {
>     97          union i2c_smbus_data data;
>     98          int status;
>     99  
>    100          status = i2c_smbus_xfer(client->adapter, client-
> >addr, client->flags,
>    101                                  I2C_SMBUS_READ, 0,
>    102                                  I2C_SMBUS_BYTE, &data);
>    103          return (status < 0) ? status : data.byte;
>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>    104  }
>    105  EXPORT_SYMBOL(i2c_smbus_read_byte);

Even I had sent the same code to Jonathan and we had a discussion on
this. 
I asked him that this code clearly shows that there is an error
condition only when status < 0 then why do we need a check for status =
0.

Then he explained me that 0 isn't an error. The issue is the silliness
of the i2c interface.

Pretty much every other bus returns an error (negative) if less data is
received than expected.  Most i2c
bus master's do as well but in theory it can return 0 to indicate no
error but no data read (which doesn't make any sense)

0 doesn't ever happen in reality but it should be handled for
correctness though.

So we should wait for what Jonathan has to say on this :)

Thanks

> You are right.  Commit 00426e997893 ("Staging: iio: adt7316: Add an
> extra check for 'ret' equals to 0") needs to be reverted...
> 
> regards,
> dan carpenter
> 
> 
