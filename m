Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752225AbeC3STo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 14:19:44 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:37457 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751275AbeC3STm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 14:19:42 -0400
X-Google-Smtp-Source: AIpwx4++ulYOsu2SZcWtrDRSMt4W2I3utQUsBz8aTL6s86jqjGyh2HIWg5zZdPC8s+nVMeHaEfEZ7w==
Date: Fri, 30 Mar 2018 11:19:38 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hs@denx.de" <hs@denx.de>,
        "ZHU Yi (BT-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>
Subject: Re: [PATCH] Input: add bu21029 touch driver
Message-ID: <20180330181938.GD143703@dtor-ws>
References: <7ab56efbafd34c11968d8cef2369c6a5@de.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ab56efbafd34c11968d8cef2369c6a5@de.bosch.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2018 at 06:57:42AM +0000, Jonas Mark (BT-FIR/ENG1) wrote:
> > > +	/* calculate Rz (pressure resistance value) by equation:
> > > +	 * Rz = Rx * (x/Q) * ((z2/z1) - 1), where
> > > +	 * Rx is x-plate resistance,
> > > +	 * Q  is the touch screen resolution (8bit = 256, 12bit = 4096)
> > > +	 * x, z1, z2 are the measured positions.
> > > +	 */
> > > +	rz  = z2 - z1;
> > > +	rz *= x;
> > > +	rz *= bu21029->x_plate_ohms;
> > > +	rz /= z1;
> > > +	rz  = DIV_ROUND_CLOSEST(rz, SCALE_12BIT);
> > > +	if (rz <= bu21029->max_pressure) {
> > > +		input_report_abs(bu21029->in_dev, ABS_X, x);
> > > +		input_report_abs(bu21029->in_dev, ABS_Y, y);
> > > +		input_report_abs(bu21029->in_dev, ABS_PRESSURE, rz);
> > 
> > What is the values of pressure reported when finger is touching the
> > surface? IOW is 'rz' pressure or resistance?
> 
> Rz is pressure measured in Ohms. That is, it is a resistance which
> correlates with finger pressure.
> 
> I fear that I do not understand your question. Does ABS_PRESSURE have
> to be reported in a specific unit, e.g. milli Newton? We thought that
> it is a device specific scale and that it will be converted into a
> calibrated value (just like the coordinates) in user space.

What I was trying to say is that it is expected that ABS_PRESSURE values
grow the harder you press on the screen, and reduce back to 0 when
finger is about to be removed from the surface. Here, it seems, we have
the opposite case, where resistance decreases the harder you press and
increases up to some maximum value when you remove the finger.

IOW, I think you want to report:

		input_report_abs(bu21029->in_dev, ABS_PRESSURE,
				 bu21029->max_pressure - rz);

Thanks.

-- 
Dmitry
