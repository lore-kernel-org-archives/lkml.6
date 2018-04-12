Return-Path: <Valentin.Vidic@carnet.hr>
X-Google-Smtp-Source: AIpwx4+NhtcVQVaIiKTUypv6zSjaQLGwkgd8Tnuk1iGyRBVzfLN4Ta7E51hpB8akArissIDdQHJF
ARC-Seal: i=1; a=rsa-sha256; t=1523558774; cv=none;
        d=google.com; s=arc-20160816;
        b=WIEwdyHlsxujf0QgI/B21+MxcROTHyOOr65Twgdzp0/X3hL31l3LzkYvsRRbnTkhy8
         UApIx1e2iLHdhvqV8R+q5PpMRnKFHpAR/117t1HSGpuMEW0HRvjGl4F2sRTWnoQBO/AM
         /CbOcaD1L0id5KnO/J2TibqF3skmX41aKObb9XmhwERF20Hiyd9boHhKQ3r6/i/qrS2K
         w3+IMeuoKjLj0GOzKVpWBzmopdahX/KATKZdWRfmgd4zw7TrwWhjLgBle23iTQ59oeqH
         lgm1JKJo9JTpzkBnJndsC2XNcvFFLkTw7bvK0MOmqqLQtSh8E5ycakmieAQUCYZojABN
         g5/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:user-agent:in-reply-to:content-disposition:mime-version
         :references:message-id:cc:to:from:date:arc-authentication-results;
        bh=YUsakGu9JILhGXvrZ94kDQcquVN0pmVCQVO3W65iyDg=;
        b=PT0g697fmYrTq3fB9TYG2U5F0AsTl23QmcC6FD64uFmVpC39boh/Tuy2LdCLCxCN+j
         AvKYygYf23Q+/aRtgt0pOeVQORyeW26ww9uhqTLtsBgUTx6pXRG0Y1kqnQ0jJ2PaCWxB
         zedEVQ5zwrNFvYNzWKXmSRKdKK9rVHNUADOtR7b1FqvluMSPrY2eZVPQ2miZb8vdm7ly
         LNM8n7EjdTRF6VgexSkFQR46SpBh7Hu/is0AAmsIpjaTdNX6okeTdR5vBhsABo7PGhep
         mLaMuaMBG3f/G0aUbAiWJLp1iNQIiqloBHEA/22pF6RBRd8kxtY4cIXOurMw6/htXul4
         mdHw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of valentin.vidic@carnet.hr designates 2001:b68:ff:2::6 as permitted sender) smtp.mailfrom=Valentin.Vidic@carnet.hr
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of valentin.vidic@carnet.hr designates 2001:b68:ff:2::6 as permitted sender) smtp.mailfrom=Valentin.Vidic@carnet.hr
Date: Thu, 12 Apr 2018 20:46:08 +0200
From: Valentin Vidic <Valentin.Vidic@CARNet.hr>
To: Marcus Wolf <marcus.wolf@smarthome-wolf.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Simon =?iso-8859-1?Q?Sandstr=F6m?= <simon@nikanor.nu>,
	Marcus Wolf <linux@Wolf-Entwicklungen.de>,
	Luca =?iso-8859-1?Q?S=F6the?= <luca@acul.me>,
	Marcin Ciupak <marcin.s.ciupak@gmail.com>,
	Michael Panzlaff <michael.panzlaff@fau.de>,
	Derek Robson <robsonde@gmail.com>, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Message-ID: <20180412184608.GV3257@gavran.carpriv.carnet.hr>
References: <20180323094725.4904-1-Valentin.Vidic@CARNet.hr>
 <d263c605-f652-fe24-2034-c699f2d27693@smarthome-wolf.de>
 <20180323114254.GL31333@gavran.carpriv.carnet.hr>
 <9442615c-5606-328a-f8cc-ad389af55ee3@smarthome-wolf.de>
 <20180323180027.GM31333@gavran.carpriv.carnet.hr>
 <20180323221821.GP31333@gavran.carpriv.carnet.hr>
 <8544b858-673f-0f59-0d8b-0474036068ce@smarthome-wolf.de>
 <20180325130944.GU31333@gavran.carpriv.carnet.hr>
 <68bb0145-b144-b442-7ff3-c6080e44f377@smarthome-wolf.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68bb0145-b144-b442-7ff3-c6080e44f377@smarthome-wolf.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-SA-Exim-Connect-IP: 161.53.12.131
Subject: Re: [PATCH] staging: pi433: add descriptions for mutex locks
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595721331728718925?=
X-GMAIL-MSGID: =?utf-8?q?1597567165379744212?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 08, 2018 at 05:22:46PM +0200, Marcus Wolf wrote:
> Regarding your patch, I did not understand, why you did not remove
> the mutex_lock in pi433_write. Wasn't it the goal to remove it?

Is it possible for more than one userspace program to open the pi433
device and send messages?  In that case more than one pi433_write
could be running and it needs to hold a mutex_lock before calling
kfifo_in.

> Below find a proposal of pi433_write function, I wrote on base
> of my outdated (!), private repo. It is not compiled and not tested.
> Since there is no more handling in case of an error (as well in the
> propsal as in your patch), I removed the error handling completely.
> I only do a test to detect proplems while writing to the tx_fifo,
> but (like in your patch) do nothing for solving, just printing a line.
> If this unexpected situation will occur (most probably never),
> the tx_fifo will be (and stay) out of sync until driver gets unloaded.
> We have to decide, whether we can stay with that. Like written above,
> I thinkt the benefits are great, the chance of such kind of error
> very low.
> What do you think?

Yes, if there is only one writer and it checks the available size,
kfifo_in should not fail.  The only problem might be copy_from_user
but perhaps that is also quite unlikely.  A workaround for that could
be to copy the data into a temporary kernel buffer first and than
start kfifo writes using only kernel memory.

> It could be discussed, whether it is better to return EMSGSIZE or
> EAGAIN on the first check. On the one hand, there is a problem with
> the message size, on the other hand (if message isn't generally too
> big) after a while, there should be some more space available in
> fifo, so EAGAIN may be better choice.

EAGAIN does seem better unless the message is too big to ever fit
in the kfifo.

> 	if (retval != required ) {
> 		dev_dbg(device->dev, "write to fifo failed, reason unknown, non recoverable.");
> 		return -EAGAIN;
> 	}

Maybe this should be dev_warn or even dev_crit if the driver is not
usable anymore when this happens?  The error message should than also
be adjusted to EBADF or something similar.

-- 
Valentin
