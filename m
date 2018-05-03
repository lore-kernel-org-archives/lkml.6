Return-Path: <andriy.shevchenko@linux.intel.com>
X-Google-Smtp-Source: AB8JxZp10DgI72eW4D7RsmZaHXNqKD6GjoxZaDlrOfg1MuW00+hOYU3qn1bCGTanpqrswFsOli0m
ARC-Seal: i=1; a=rsa-sha256; t=1525342849; cv=none;
        d=google.com; s=arc-20160816;
        b=fy3AYok5YRgIhXuE0MgYK5SiKFatGB76aNwtCoXTEf4i25m3u0cqccwQeDewE6PCqd
         I/qg3Yp4RNWWTNbz0OX+s8gNdWng8Dh18nHAF7Sevy5jjYZYJtI8ltcEd94lUY7nmyfG
         +73AjVGq/KMr1nNCmQ/1WtwblHi/ihBADwMhnvJB52WJb15WUUU3kPmvv3WhtoDAUrlV
         uH0NrHAu+N0LpBeqy84G62riHoSh3gRs+eK/BwDoOyBjMKXoC3yJemq+pjGFIPMEdyqi
         grio5MR73c6YijxPkdbhOE+v4icyvkGesOx6ZXIp9KK0soEato2sCOiFWIQfwk7fJSL1
         nyFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:date:cc:to:from:subject:message-id
         :arc-authentication-results;
        bh=9IlzHr4URac3CmcFeJuNQK8NOHaKE6Z/CPPx4bs06Ko=;
        b=HDc4h2Aji+hpc7aLztP3Hvu+3dbcxDHaE0gLfUFgre/bLPZw+aF925vxtShMUwgWnn
         jY1dTJ3BmwGjsSgtZD+A13fix0C3s7oP9WAJRwBToosudBh2KP8wHXqXjWYNRF5yZgBj
         aHsXvswrJnu16aPPghlEr70S52QeiaYmSvXcqXOtlRtCF97vyaazMtWyEIlXUOOk2taI
         tSs1A56HjsrgAY1nGK2jqORjA21pv0lwzuKCbpxa15dEqkzElcmPr7k0YVJHUrB9jG0J
         Qku001gsJ5jXM2hwAWZX8Yy/EJBYU/lN/6zwsXSbnAMY7m6d6xmhadt3mKgDjNWVRjGh
         ibSA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,358,1520924400";
   d="scan'208";a="55642398"
Message-ID: <1525342843.21176.635.camel@linux.intel.com>
Subject: Re: [PATCH v2 3/3] NFC: fdp: Fix possible buffer overflow in
 WCS4000 NFC driver
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Amit Pundir <amit.pundir@linaro.org>, lkml
 <linux-kernel@vger.kernel.org>,  linux-wireless@vger.kernel.org
Cc: Suren Baghdasaryan <surenb@google.com>, Samuel Ortiz
 <sameo@linux.intel.com>,  Christophe Ricard <christophe.ricard@gmail.com>,
 Greg KH <gregkh@linuxfoundation.org>, John Stultz <john.stultz@linaro.org>,
 Dmitry Shmidt <dimitrysh@google.com>, Todd Kjos <tkjos@google.com>, Android
 Kernel Team <kernel-team@android.com>
Date: Thu, 03 May 2018 13:20:43 +0300
In-Reply-To: <1525283288-7027-4-git-send-email-amit.pundir@linaro.org>
References: <1525283288-7027-1-git-send-email-amit.pundir@linaro.org>
	 <1525283288-7027-4-git-send-email-amit.pundir@linaro.org>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1+b1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599375469996220614?=
X-GMAIL-MSGID: =?utf-8?q?1599437903655653866?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 2018-05-02 at 23:18 +0530, Amit Pundir wrote:
> From: Suren Baghdasaryan <surenb@google.com>
> 
> Possible buffer overflow when reading next_read_size bytes into
> tmp buffer after next_read_size was extracted from a previous packet.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> ---
> v2:
> Remove redundant __func__ from dev_dgb().
> 
>  drivers/nfc/fdp/i2c.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/nfc/fdp/i2c.c b/drivers/nfc/fdp/i2c.c
> index c4da50e..b80d1ad 100644
> --- a/drivers/nfc/fdp/i2c.c
> +++ b/drivers/nfc/fdp/i2c.c
> @@ -176,6 +176,15 @@ static int fdp_nci_i2c_read(struct fdp_i2c_phy
> *phy, struct sk_buff **skb)
>  		/* Packet that contains a length */
>  		if (tmp[0] == 0 && tmp[1] == 0) {
>  			phy->next_read_size = (tmp[2] << 8) + tmp[3]
> + 3;
> +			/*
> +			 * Ensure next_read_size does not exceed
> sizeof(tmp)
> +			 * for reading that many bytes during next
> iteration
> +			 */
> +			if (phy->next_read_size >
> FDP_NCI_I2C_MAX_PAYLOAD) {
> +				dev_dbg(&client->dev, "corrupted
> packet\n");

> +				phy->next_read_size = 5;

Shouldn't be this magic replaced by

	phy->next_read_size = FDP_NCI_I2C_MIN_PAYLOAD;

? 

> +				goto flush;
> +			}
>  		} else {
>  			phy->next_read_size =
> FDP_NCI_I2C_MIN_PAYLOAD;
>  

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
