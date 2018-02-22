Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751902AbeBVWye (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 17:54:34 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53077 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751805AbeBVWyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 17:54:31 -0500
X-Google-Smtp-Source: AG47ELu6JaZq6z/PURFQnxUDMnFdgyJdJeUiqojMBtk2xHzd9SdhrHE5SifzEPTYSnbB1JfNyll3bQ==
Date: Thu, 22 Feb 2018 23:54:26 +0100
From: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
To: Cameron Gutman <aicommander@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v2 1/3] HID: add driver for Valve Steam Controller
Message-ID: <20180222225426.GA3726@casa>
References: <20180220193306.28748-1-rodrigorivascosta@gmail.com>
 <20180220193306.28748-2-rodrigorivascosta@gmail.com>
 <eb75654d-cd83-83a4-edde-6492300e4948@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb75654d-cd83-83a4-edde-6492300e4948@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 09:32:08PM -0800, Cameron Gutman wrote:
> On 02/20/2018 11:33 AM, Rodrigo Rivas Costa wrote:
> > +static void steam_work_connect_cb(struct work_struct *work)
> > +{
> > +	struct steam_device *steam = container_of(work, struct steam_device,
> > +							work_connect);
> > +	unsigned long flags;
> > +	bool connected;
> > +	int ret;
> > +
> > +	spin_lock_irqsave(&steam->lock, flags);
> > +	connected = steam->connected;
> > +	spin_unlock_irqrestore(&steam->lock, flags);
> > +
> > +	if (connected) {
> > +		if (steam->input) {
> > +			dbg_hid("%s: already connected\n", __func__);
> > +			return;
> > +		}
> > +		ret = steam_register(steam);
> > +		if (ret) {
> > +			hid_err(steam->hdev,
> > +				"%s:steam_register failed with error %d\n",
> > +				__func__, ret);
> > +			return;
> > +		}
> > +	} else {
> > +		steam_unregister(steam);
> 
> I think you need synchronization here. You don't want to be in the middle of
> processing a HID event or power supply update and have your device freed out
> from underneath you.
> 
> xpad uses RCU to avoid this race.

Ah, I see, if we get an input message just after the "disconnect"
packet, (unlikely) it could file. I'll don't know RCU very will but I'll
try and do my best.

Please, stay tuned for v3.
Thanks.
Rodrigo
