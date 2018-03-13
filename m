Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AG47ELsGu1aS3LIuJnO0CrWD6AMizjSuDsxbAj2p3XwIzaSFKAXEtX11YrWpUDbripCASWucMnZ6
ARC-Seal: i=1; a=rsa-sha256; t=1520959228; cv=none;
        d=google.com; s=arc-20160816;
        b=WY9vxDEFK2PZAFgFHAUKaFDJqWPNOh6UR8jsuY+9dc7X5MBSQi9eUG/WVMd27ZRxcF
         M1Q68IUJKmWXUFXNZz34Nn50EB18xPMNjEqNE+skbUsFz4TfZpE4fnQ4KIjfawuPHk5+
         knitGP+dfa5krzJ/vJPthLIHZugCuj2TFHvR0mdITBhAsIPmMa9q4ga8kd6dPx0HaWrP
         OjVe9zjx2L/7QMez2PdHX/q8vt1+M3WnvBPXOsuaStBFUJwSPrsXizEi/TSndjuODwNn
         b2pdwigf3z/EM4e8XPJFkD64dPx2jvv5JlPKQm1mZPZTgQgzBjuEK0DEwyT3//9PcCzm
         KyjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=p5VPrGZ0wAoGQR375atruq8NpAESWkEc9WKli2EUG5w=;
        b=I2VZVG0UDPxpqp3AqUNE/Pd/l8pe+IEt2ohpX5QXJzXrXYyDpPeT6bLKaNqawe8oGr
         taVT+UYXI7sqUDbXXVnTvzjoLE+5ujy06hJXOwP8KkQKEnIl+HnCdvQMDduHdpuWyK2x
         SzhBzhnii5kUrEtzLoZUU/KxqTaD1IGDOv3V1wZokvZxa2VAa2XgatzHhwWQX+/GkE7K
         b/m+s7/5BTtLNXkh8sQ6mIX6JjvnKmm1iHNKV4kyhQ9Puq6ZKvjZ4neIlT789JimZvzO
         ELhSYbXB2C3fWcG4UN2SgTKwjZfKn+7dCdg1ywrL4tmQM03qeDEoYPY3oPyMRbu/uLD7
         iUyQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Date: Tue, 13 Mar 2018 16:40:26 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Kalle Valo <kvalo@codeaurora.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
	Andres Rodriguez <andresx7@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-wireless <linux-wireless@vger.kernel.org>,
	Arend Van Spriel <arend.vanspriel@broadcom.com>
Subject: Re: [PATCH] firmware: add a function to load optional firmware v2
Message-ID: <20180313164026.GG4449@wotan.suse.de>
References: <20180309221243.15489-2-andresx7@gmail.com>
 <20180309230925.3573-1-andresx7@gmail.com>
 <CAB=NE6VY62KqmhzD=zT8od=PhgPi3rGKKKxKz_zad-ZrYW-97A@mail.gmail.com>
 <87a7vcazf1.fsf@kamboji.qca.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a7vcazf1.fsf@kamboji.qca.qualcomm.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594503439621024078?=
X-GMAIL-MSGID: =?utf-8?q?1594841343776143816?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 13, 2018 at 03:16:34PM +0200, Kalle Valo wrote:
> "Luis R. Rodriguez" <mcgrof@kernel.org> writes:
> 
> >> +/**
> >> + * request_firmware_optional: - request for an optional fw module
> >> + * @firmware_p: pointer to firmware image
> >> + * @name: name of firmware file
> >> + * @device: device for which firmware is being loaded
> >> + *
> >> + * This function is similar in behaviour to request_firmware(), except
> >> + * it doesn't produce warning messages when the file is not found.
> >> + **/
> >> +int
> >> +request_firmware_optional(const struct firmware **firmware_p, const char *name,
> >> +                         struct device *device)
> >> +{
> >> +       int ret;
> >> +
> >> +       /* Need to pin this module until return */
> >> +       __module_get(THIS_MODULE);
> >> +               ret = _request_firmware(firmware_p, name, device, NULL, 0,
> >> +                               FW_OPT_UEVENT | FW_OPT_NO_WARN );
> >> +       module_put(THIS_MODULE);
> >> +       return ret;
> >> +}
> >> +EXPORT_SYMBOL(request_firmware_optional);
> >
> > New exported symbols for the firmware API should be EXPORT_SYMBOL_GPL().
> 
> To me the word optional feels weird to me. For example, in ath10k I
> suspect we would be only calling request_firmware_optional() with all
> firmware and not request_firmware() at all.
> 
> How about request_firmware_nowarn()? That would even match the
> documentation above.

_nowarn() works with me. Do you at least want the return value to give
an error value if no file was found? This way the driver can decide
when to issue an error if it wants to.

  Luis
