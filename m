Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932371AbeBLVfb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 16:35:31 -0500
Received: from smtprelay0053.hostedemail.com ([216.40.44.53]:50821 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932204AbeBLVfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 16:35:30 -0500
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:355:379:541:599:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2693:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3871:4321:5007:9040:10004:10400:10848:10967:11232:11658:11914:12043:12438:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21324:21611:21627:21740:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: base66_2fbe07e1f9f60
X-Filterd-Recvd-Size: 1862
Message-ID: <1518471326.22190.8.camel@perches.com>
Subject: Re: [PATCH 2/2] i2c: piix4: Use usleep_range()
From: Joe Perches <joe@perches.com>
To: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.de>
Cc: Wolfram Sang <wsa@the-dreams.de>,
        =?ISO-8859-1?Q?Zolt=E1n_B=F6sz=F6rm=E9nyi?= <zboszor@pr.hu>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 12 Feb 2018 13:35:26 -0800
In-Reply-To: <20180212205959.GA27573@roeck-us.net>
References: <1514652658-6228-1-git-send-email-linux@roeck-us.net>
         <1514652658-6228-2-git-send-email-linux@roeck-us.net>
         <20180212115336.4b828ab8@endymion> <20180212205959.GA27573@roeck-us.net>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-02-12 at 12:59 -0800, Guenter Roeck wrote:
> On Mon, Feb 12, 2018 at 11:53:36AM +0100, Jean Delvare wrote:
> > On Sat, 30 Dec 2017 08:50:58 -0800, Guenter Roeck wrote:
> > > The piix4 i2c driver is extremely slow. Replacing msleep()
> > > with usleep_range() increases its speed substantially.
[]
> > > diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
[]
> > > @@ -467,13 +467,13 @@ static int piix4_transaction(struct i2c_adapter *piix4_adapter)
> > >  
> > >  	/* We will always wait for a fraction of a second! (See PIIX4 docs errata) */
> > >  	if (srvrworks_csb5_delay) /* Extra delay for SERVERWORKS_CSB5 */
> > > -		msleep(2);
> > > +		usleep_range(2000, 2000);

usleep_range without a range isn't particularly useful.
Perhaps a 100 uSec range would allow better scheduling.

		usleep_range(2000, 2100);
