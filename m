Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7340AC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 04:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C43D520864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 04:09:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C43D520864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=popple.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752856AbeFREJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 00:09:25 -0400
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:34280 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750910AbeFREJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 00:09:24 -0400
Received: from static-82-10.transact.net.au (HELO new-mexico.localnet) ([122.99.82.10])
  by ipmail07.adl2.internode.on.net with ESMTP; 18 Jun 2018 13:39:23 +0930
From:   Alistair Popple <alistair@popple.id.au>
To:     openbmc@lists.ozlabs.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 5/5] fsi/scom: Major overhaul
Date:   Mon, 18 Jun 2018 14:09:20 +1000
Message-ID: <1908243.hVhg7auBNd@new-mexico>
User-Agent: KMail/5.2.3 (Linux/4.13.0-0.bpo.1-amd64; KDE/5.28.0; x86_64; ; )
In-Reply-To: <aff7b975390119239bfcb5bdef869bdfd28e712a.camel@kernel.crashing.org>
References: <20180612051911.20690-1-benh@kernel.crashing.org> <f2421fad1ea210b32a6813454832c0ed66770bf5.camel@kernel.crashing.org> <aff7b975390119239bfcb5bdef869bdfd28e712a.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 17 June 2018 11:22:11 AM AEST Benjamin Herrenschmidt wrote:
> On Sun, 2018-06-17 at 11:17 +1000, Benjamin Herrenschmidt wrote:
> > 
> > We have everything that cronus needs and more than pdbg needs afaik :-)

Yep, has what we need and more (such as put scom under mask and indirect scom).
Only other useful thing would be repeated getsom/putscom operations (eg. read
the same scom address n times) as they would help with ADU access which can do
autoincrement or scanscom (although we should just use the scan engine directly
for that so not a big issue).

> +	for (retries = 0; retries < SCOM_MAX_RETRIES; retries++) {
> +		rc = raw_get_scom(scom, value, addr, &status);
> +		if (rc) {
> +			/* Try resetting the bridge if FSI fails */
> +			if (rc != -ENODEV && retries == 0) {
> +				fsi_device_write(scom->fsi_dev, SCOM_FSI2PIB_RESET_REG,
> +						 &dummy, sizeof(uint32_t));
> +				rc = -EBUSY;
> +			} else
> +				return rc;
> +		} else
> +			rc = handle_fsi2pib_status(scom, status);
> +		if (rc && rc != -EBUSY)
> +			break;
> +		if (rc == 0) {
> +			rc = handle_pib_status(scom,
> +					       (status & SCOM_STATUS_PIB_RESP_MASK)
> +					       >> SCOM_STATUS_PIB_RESP_SHIFT);
> +			if (rc && rc != -EBUSY)
> +				break;
> +		}
> +		if (rc == 0)
> +			break;
> +		msleep(1);
> +	}

The rc handling above took me a little while to grok but I didn't come up with a
cleaner alternative and I think it's correct.

- Alistair

> > 
> > That said, cronus does a bunch of other stupid things that I'm still
> > trying to figure out how to fix.
> > 
> > We might need to create a /dev/cfam rather than going through that
> > magic sysfs "raw" file, and I wouldn't mind using a single IDA so that
> > all the devices below a given FSI slace (cfam itself, sbefifo, occ,
> > ...) have the same "number".
> 
> Also while we're at reworking how all this is exposed to our broken
> userspace, I wouldn't mind putting all these dev entries under a
> directory, if I can figure out how to do that (I haven't really looked
> yet).
> 
> /dev/fsi/{cfamN,sbefifoN,occN, ...} and possibly similar by-id and by-
> path that other subsystems use, so we have something more deterministic
> than the "random number" crap we do now.
> 
> We can always keep hacks to do symlinks in our kernel tree until we
> have converted all our userspace users.
> 
> We currently control the only userspace users of this, so now is a good
> time to cleanup how we expose things. This won't always be the case.
> 
> Cheers,
> Ben.
> 
> 


