Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AG47ELtFAoydwDUizHbawDa5yMgh0421mV+n0tyscsIyqV1h4S3SoZPux4iY0jljUHqJ1zVTk+Ra
ARC-Seal: i=1; a=rsa-sha256; t=1520959125; cv=none;
        d=google.com; s=arc-20160816;
        b=E080W9Ke/7qqLLbBjZkymDcNaGMsxv/1SFXRqVT412X0pD0xc64k5bsdVVtlHlHHSu
         f9l1KqvdoE4IoRcgAulDp/4swON/BvpTxCSWlMp154SKGorzf/3KkAT06MIZ8ISl7Bg1
         jFV7lPhby818TWLgJIpCmJx+Bc+9KLF+C5P6NJTtHNRxpnY8r4kVmjXAKsqZ03lyFeEn
         Oco7VaUClnwtiN1C461DXfnJsUyjNGEjc5/bqHm9UUFtn1XJPAOYnNZYdXAuAP3Xk/Qy
         +HYyuJM3nXsYvA98iW8xZW2BTUUnaTznwcW9SSD3Am566ROoj2KftIrh5rmIHsVXnp1l
         WUXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=Ic7yZyNAdEQ2Ge9XNVrb2WXoVG2vUZwPV5LxihI2IPg=;
        b=xJ3mR47z7dvM8shUJPW790YrQC1QJAVA1HZZhMyzs1GBmKW1BWskL7Gp5dCsaV6eTH
         DAnRYIY9CWP9MRxtz6tgfbrX1ODv2lrQpJKFE68cAaMZKGO+p2CIN6AaDmQYd9eCziJI
         fFAPuDCCLGFc4LTmbltxHIGp5YcA3VpyCFxfIIhH5pIKOBSeH1Ne2wWL5yeDvHZan2jR
         1zQK5hJHGZB7whXW6sZrn3BGkuSz/ozPg/2HTHlZAp9Y5M4KEMvOihKATyRy778OkRM1
         6o9j/ah6t6CGUUlZXuku876w+2t+dfb5CdkIUYlf4t8+LZW7DHq1toFN2GHsm4mmzbpB
         fjNA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Date: Tue, 13 Mar 2018 16:38:42 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Kalle Valo <kvalo@codeaurora.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Andres Rodriguez <andresx7@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-wireless <linux-wireless@vger.kernel.org>,
	Ilia Mirkin <imirkin@alum.mit.edu>
Subject: Re: [PATCH] firmware: add a function to load optional firmware v2
Message-ID: <20180313163842.GF4449@wotan.suse.de>
References: <20180309221243.15489-2-andresx7@gmail.com>
 <20180309230925.3573-1-andresx7@gmail.com>
 <CAB=NE6VY62KqmhzD=zT8od=PhgPi3rGKKKxKz_zad-ZrYW-97A@mail.gmail.com>
 <CAB=NE6XpY4LuDwnakCa6gZ_HjjhZDnu=gDeHwmpNRaSkqQOB2g@mail.gmail.com>
 <bbdc304f-edd5-38df-ea88-012fefc54b90@gmail.com>
 <5AA5B777.5020106@broadcom.com>
 <20180312192704.GX4449@wotan.suse.de>
 <87r2oo9jsk.fsf@kamboji.qca.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r2oo9jsk.fsf@kamboji.qca.qualcomm.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594503439621024078?=
X-GMAIL-MSGID: =?utf-8?q?1594841236416980682?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 13, 2018 at 03:39:23PM +0200, Kalle Valo wrote:
> "Luis R. Rodriguez" <mcgrof@kernel.org> writes:
> 
> > On Mon, Mar 12, 2018 at 12:10:47AM +0100, Arend van Spriel wrote:
> >> On 3/11/2018 5:05 PM, Andres Rodriguez wrote:
> >> > > Your patch series then should also have the driver callers who you
> >> > > want to modify to use this new API. Collect from the 802.11 folks the
> >> > > other drivers which I think they wanted changed as well.
> >> > 
> >> > Arend, Kalle, would love to hear your feedback.
> >> 
> >> I am not sure if it was ath10k, but Kalle will surely know. The other driver
> >> firing a whole batch of firmware requests is iwlwifi. These basically try to
> >> get latest firmware version and if not there try an older one.
> >
> > Ah I recall now. At least for iwlwifi its that it requests firmware with a
> > range of api files, and we don't need information about files in the middle
> > not found, given all we need to know if is if at lest one file was found
> > or not.
> >
> > I have future code to also enable use of a range request which would replace
> > the recursive nature of iwlwifi's firmware API request, so it simplifies it
> > considerably.
> >
> > Once we get this flag to be silent in, this can be used later. Ie, the new
> > API I'd add would replace the complex api revision thing for an internal set.
> 
> TBH I doubt we would use this kind of "range" request in ath10k, 

Well it doesn't have the form to use a range either so it wouldn't make sense.

> the
> current code works just fine only if we can get rid of the annoying
> warning from request_firmware(). Unless if it's significantly faster or
> something.

Thanks, I see ath10k uses the sync request_firmware() call, so indeed it
would be a trivial conversion.

Andres can you roll that in for your patch series?

  Luis
