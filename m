Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752738AbeCMOAx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 10:00:53 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53510 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752531AbeCMOAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 10:00:51 -0400
Date: Tue, 13 Mar 2018 16:59:57 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc: devel@driverdev.osuosl.org, Graff Yang <graff.yang@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>, daniel.baluta@nxp.com,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 3/3] staging:iio:ad2s1210: Add write_raw to handle
 frequency
Message-ID: <20180313135957.jfgxmq7gtcfgwdhe@mwanda>
References: <cover.1520878492.git.rodrigosiqueiramelo@gmail.com>
 <ae60ca5cf37d1678cb6b498450f75f93f3d498d2.1520878492.git.rodrigosiqueiramelo@gmail.com>
 <20180313090249.cdurikolfwc5qyol@mwanda>
 <20180313130629.c6zmvoy5o7a5ax2c@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313130629.c6zmvoy5o7a5ax2c@smtp.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8830 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=978
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803130167
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 10:06:29AM -0300, Rodrigo Siqueira wrote:
> On 03/13, Dan Carpenter wrote:
>
> > Ah...  I see why you did the ERROR_MESSAGE define, to get around the 80
> > character limit.  Don't do that.  Just go over 80 characters if you need
> > to.
> > 
> > 
> > > +					"fclkin");
> > > +				ret = -EINVAL;
> > > +				goto error_ret;
> > 
> > Direct returns are better.  Less chance of bugs statistically.
> 
> I totally get your point here, and I will fix it. However, just for
> curiosity, why goto in this situation has more chance to generate bugs
> statically?
> 

This is a do-nothing goto.  I normally consider do-nothing gotos and
do-everything gotos basically cousins but in this case it's probably
unfair since it already has other labels.

Do-everything gotos are the most error prone way of doing error
handling.  I've reviewed a lot of static checker warnings and it really
is true.  I can't give you like a percent figure but do-everything error
handling is a lot buggier than normal kernel style.

This style of error handling is supposed to prevent returning without
unlocking bugs.  I once looked through the git log and counted missing
unlock bugs and my conclusion was that it basically doesn't work for
preventing bugs.  The kind of people who just add random returns will do
it regardless of the error handling style.  There was even one driver
that indented locked code like this:

	lock(); {
		blah blah blah;
	} unlock();

When the driver was first submitted, it already had a missing unlock
bug.  I don't think style helps slow people down who are in a hurry.

The other thing about do-nothing gotos is that you introduce the
possibility of "forgot to set the error code" bugs which wasn't there
before.

regards,
dan carpenter








So actually "error_ret" seems like a pretty reasonable name for a
do-nothing goto.  I no

I've looked at a lot of error handling and this kind of error handling
is more error prone.  The single exit path thing is supposed to prevent
bugs like not dropping the lock on exit and I've looked through the logs
and counted bugs to see if it works and I don't think it does.  The
people who forget to unlock will forget to unlock regardless of the
error handling style.





> I will send a v2 with your recommendantions.
> Thanks for the review and feedbacks :)
>  
> > regards,
> > dan carpenter
> > 
> _______________________________________________
> devel mailing list
> devel@linuxdriverproject.org
> http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
