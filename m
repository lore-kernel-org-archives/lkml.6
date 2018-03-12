Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AG47ELs4mPyw2pWdf1e3HKK+8AP8BuBSw65O79M/Je7Iefzq9uu7TGBhGiFcQajLPxgy2Y1IWJPa
ARC-Seal: i=1; a=rsa-sha256; t=1520882829; cv=none;
        d=google.com; s=arc-20160816;
        b=zR9CBxKU9XHTjvluRn5+ACoq01OlAHFr6BQKJSwSOJeDxs5Issiz8dA2yd4RHURT/W
         2OyZVXqkpqGVb4ERCLdVrvkSXUNt7ofLiYKlQPdAOOaxg+TiAz0UYM9hkXd9RQKwABca
         9wZZ7q/200T+qTs4mXrZbDdS9NFPlChP4h4HJ06w5Eko6aBupzwALcq6cFGMArJzfZ16
         m7uipVvs/iMlJnvD9pHFDQxE4vs+ruFL6drhnlKmB5W1zPxry9Hsfhje/wJ6rv87Ek5M
         JTBvb/0jnZtbqbGY8vZC+p+2Ba3ku2DRPJuaHzMXQO+VHApBMZrxS+Cvd5/tFwVIIS3R
         DoUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=1kJVFWaaLquGoRpSAScB0OXuVt5+tnVI18TiK4wiEF8=;
        b=XSUuUHjHBiWjwtSrrP9SLEIcTSTxhYZGtpMaH49JcKkEuTFzr2g9+UX5w15YQprKYi
         X0G59iW+xy497BdfPPU1P+clwmsVMlOs+wtYPPo8NoaJr+F+uTdrtSrA8xCyLHT0hHPl
         IGdiVNu5a7JYL/W+vKfXAY8uch7Kc4YKNYYmqW5n0uF3vAE4VjxnvUxC4u1w3CMggVLl
         zdwBJO+KvoLeuU6L0BYPojRq49T/JwT1+YVLtDLqo92Nn2S9xiYB4y0r+lUhq6c2mfKG
         sn+u97mCTmaumCBOrnzA9C13/11oBa4J4wje97cOkoPkC4jgQoSqqCAAg2m0elP61Zv3
         uW6A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Date: Mon, 12 Mar 2018 19:27:04 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Andres Rodriguez <andresx7@gmail.com>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-wireless <linux-wireless@vger.kernel.org>,
	Kalle Valo <kvalo@codeaurora.org>,
	Ilia Mirkin <imirkin@alum.mit.edu>
Subject: Re: [PATCH] firmware: add a function to load optional firmware v2
Message-ID: <20180312192704.GX4449@wotan.suse.de>
References: <20180309221243.15489-2-andresx7@gmail.com>
 <20180309230925.3573-1-andresx7@gmail.com>
 <CAB=NE6VY62KqmhzD=zT8od=PhgPi3rGKKKxKz_zad-ZrYW-97A@mail.gmail.com>
 <CAB=NE6XpY4LuDwnakCa6gZ_HjjhZDnu=gDeHwmpNRaSkqQOB2g@mail.gmail.com>
 <bbdc304f-edd5-38df-ea88-012fefc54b90@gmail.com>
 <5AA5B777.5020106@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5AA5B777.5020106@broadcom.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594503439621024078?=
X-GMAIL-MSGID: =?utf-8?q?1594761233106861669?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 12, 2018 at 12:10:47AM +0100, Arend van Spriel wrote:
> On 3/11/2018 5:05 PM, Andres Rodriguez wrote:
> > > Your patch series then should also have the driver callers who you
> > > want to modify to use this new API. Collect from the 802.11 folks the
> > > other drivers which I think they wanted changed as well.
> > 
> > Arend, Kalle, would love to hear your feedback.
> 
> I am not sure if it was ath10k, but Kalle will surely know. The other driver
> firing a whole batch of firmware requests is iwlwifi. These basically try to
> get latest firmware version and if not there try an older one.

Ah I recall now. At least for iwlwifi its that it requests firmware with a
range of api files, and we don't need information about files in the middle
not found, given all we need to know if is if at lest one file was found
or not.

I have future code to also enable use of a range request which would replace
the recursive nature of iwlwifi's firmware API request, so it simplifies it
considerably.

Once we get this flag to be silent in, this can be used later. Ie, the new
API I'd add would replace the complex api revision thing for an internal set.

> The brcmfmac driver I maintain is slightly different. It downloads two
> distinct pieces of firmware of which one is optional for certain
> configurations. Currently, my driver does two asynchronous requests for it,
> but I consider changing it and only make the first request asynchronous and
> the second request synchronous. You can look at the current code in
> drivers/net/wireless/broadcom/brcmfmac/firmware.c. However, I did quite some
> restructuring last week. Anyway, I probably will end up using the "optional"
> api where appropriate.

Thanks for the details.

  Luis
