Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2097C282E6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B95422084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbfAUHwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:52:14 -0500
Received: from bout01.mta.xmission.com ([166.70.11.15]:53374 "EHLO
        bout01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728543AbfAUHwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:52:13 -0500
Received: from mx04.mta.xmission.com ([166.70.13.214])
        by bout01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1glKVp-0007zL-Qe; Sun, 20 Jan 2019 14:20:14 -0700
Received: from plesk14-shared.xmission.com ([166.70.198.161] helo=plesk14.xmission.com)
        by mx04.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1glKVo-0003Ub-2T; Sun, 20 Jan 2019 14:20:13 -0700
Received: from hacktheplanet (c-68-50-23-202.hsd1.in.comcast.net [68.50.23.202])
        by plesk14.xmission.com (Postfix) with ESMTPSA id 6F37A21433D;
        Sun, 20 Jan 2019 21:20:11 +0000 (UTC)
Date:   Sun, 20 Jan 2019 16:20:00 -0500
From:   Scott Bauer <sbauer@plzdonthack.me>
To:     David Kozub <zub@linux.fjfi.cvut.cz>
Cc:     linux-kernel@vger.kernel.org, axboe@kernel.dk, hch@infradead.org,
        jonathan.derrick@intel.com
Message-ID: <20190120212000.GA4387@hacktheplanet>
References: <1547760716-7304-12-git-send-email-zub@linux.fjfi.cvut.cz>
 <20190119171550.GB12171@hacktheplanet>
 <alpine.LRH.2.21.1901201045280.4278@linux.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.1901201045280.4278@linux.fjfi.cvut.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-XM-SPF: eid=1glKVo-0003Ub-2T;;;mid=<20190120212000.GA4387@hacktheplanet>;;;hst=mx04.mta.xmission.com;;;ip=166.70.198.161;;;frm=sbauer@plzdonthack.me;;;spf=none
X-SA-Exim-Connect-IP: 166.70.198.161
X-SA-Exim-Mail-From: sbauer@plzdonthack.me
Subject: Re: [PATCH v2 11/16] block: sed-opal: ioctl for writing to shadow mbr
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on mx04.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 20, 2019 at 11:27:30AM +0100, David Kozub wrote:
> On Sat, 19 Jan 2019, Scott Bauer wrote:
> 
> > On Thu, Jan 17, 2019 at 09:31:51PM +0000, David Kozub wrote:
> > 
> > > +static int write_shadow_mbr(struct opal_dev *dev, void *data)
> > > +{
> > > +	struct opal_shadow_mbr *shadow = data;
> > > +	const u8 __user *src;
> > > +	u8 *dst;
> > > +	size_t off = 0;
> > > +	u64 len;
> > > +	int err = 0;
> > > +
> > > +	/* do the actual transmission(s) */
> > > +	src = (u8 *) shadow->data;
> > > +	while (off < shadow->size) {
> > > +		err = cmd_start(dev, opaluid[OPAL_MBR], opalmethod[OPAL_SET]);
> > > +		add_token_u8(&err, dev, OPAL_STARTNAME);
> > > +		add_token_u8(&err, dev, OPAL_WHERE);
> > > +		add_token_u64(&err, dev, shadow->offset + off);
> > > +		add_token_u8(&err, dev, OPAL_ENDNAME);
> > > +
> > > +		add_token_u8(&err, dev, OPAL_STARTNAME);
> > > +		add_token_u8(&err, dev, OPAL_VALUES);
> > > +
> > > +		/*
> > > +		 * The bytestring header is either 1 or 2 bytes, so assume 2.
> > > +		 * There also needs to be enough space to accommodate the
> > > +		 * trailing OPAL_ENDNAME (1 byte) and tokens added by
> > > +		 * cmd_finalize.
> > > +		 */
> > > +		len = min(remaining_size(dev) - (2+1+CMD_FINALIZE_BYTES_NEEDED),
> > > +			  (size_t)(shadow->size - off));
> > 
> > What if remaining_size(dev) <  2 + 1 + CMD_FINALIZE_BYTES_NEEDED? If that's possible we
> > get min(UINT_MAX(ish) , some size larger than our remaining buffer) and that's not good.
> 
> This is only possible for uselessly small values of IO_BUFFER_LENGTH, which
> is a compile-time value. Originally I thought it's OK as nobody would set
> the value so low. But on a second thought, after reading your comment, I
> think that even if IO_BUFFER_LENGTH was set to such a value, the code should
> fail gracefully.

Naw, just leave it the way it is. I didnt follow cmd_start down deep enough to realize we reset
the position on cmd_start, so there is no way for my scenario to happen. We'll never change IO_BUFFER_LENGTH
to something small. If someone wants to write a bug in their custom kernel, it's not our problem.
