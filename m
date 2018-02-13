Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965957AbeBMWAA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 17:00:00 -0500
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:5859 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965865AbeBMV76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 16:59:58 -0500
Date: Tue, 13 Feb 2018 14:59:56 -0700
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, rwright@hpe.com,
        maurice.a.saldivar@hpe.com
Subject: Re: [PATCH v2 03/11] watchdog/hpwdt: Update nmi_panic message.
Message-ID: <20180213215956.GC22295@anatevka.americas.hpqcorp.net>
Reply-To: Jerry.Hoemann@hpe.com
References: <20180212052111.12010-1-jerry.hoemann@hpe.com>
 <20180212052111.12010-4-jerry.hoemann@hpe.com>
 <20180213174135.GA22401@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213174135.GA22401@roeck-us.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 09:41:35AM -0800, Guenter Roeck wrote:
> On Sun, Feb 11, 2018 at 10:21:03PM -0700, Jerry Hoemann wrote:
> > +	unsigned int mynmi = hpwdt_my_nmi();
> > +	static char panic_msg[] =
> > +		"00: An NMI occurred. Depending on your system the reason "
> > +		"for the NMI is logged in any one of the following resources:\n"
> > +		"1. Integrated Management Log (IML)\n"
> > +		"2. OA Syslog\n"
> > +		"3. OA Forward Progress Log\n"
> > +		"4. iLO Event Log";
> > +
> > +	if ((ulReason == NMI_UNKNOWN) && !mynmi)
> >  		return NMI_DONE;
> >  
> >  	if (allow_kdump)
> >  		hpwdt_stop();
> >  
> > -	nmi_panic(regs, "An NMI occurred. Depending on your system the reason "
> > -		"for the NMI is logged in any one of the following "
> > -		"resources:\n"
> > -		"1. Integrated Management Log (IML)\n"
> > -		"2. OA Syslog\n"
> > -		"3. OA Forward Progress Log\n"
> > -		"4. iLO Event Log");
> > +	panic_msg[0] = hexdigit((mynmi>>4)&0xf);
> > +	panic_msg[1] = hexdigit(mynmi&0xf);
> 
> No need to reinvent the wheel.
> 
> 	panic_msg[0] = hex_asc_hi(mynmi);
> 	panic_msg[1] = hex_asc_lo(mynmi);
> 
> or even better
> 	hex_byte_pack(panic_msg, mynmi);
> 
> There are matching _upper functions if you prefer A..F instead of a..f.
> 
> Guenter

Will do. thanks

-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------
