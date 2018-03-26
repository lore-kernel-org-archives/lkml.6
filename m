Return-Path: <Ajay.Kathat@microchip.com>
X-Google-Smtp-Source: AG47ELuuIzhH+gQVwFiEv83w3WNeYPdhe+4Pq7NmaAKsXOuG6jFVzrHoXCy/4SQAByk2/VnhP5xi
ARC-Seal: i=1; a=rsa-sha256; t=1522078571; cv=none;
        d=google.com; s=arc-20160816;
        b=i3MZgXLGksWH9UgVlnfafsd5KKhynHvR4p6rNyli58Il0Llj4yJPJsbn1NlykJJpT+
         fKPhgZPwdD5cVlUvZEWSDn5eFugQ0BojVP/jdkYuoBTzXqvUyPW6v8+NIHVIq1Gflah/
         8sKXhr8XehusRtaqtXMe18DrgHu9kpHmHWBhwpITZX1h0eIPirApuQrywRc4I9mXbk4F
         96sn2ym7RIVH8lwfeRK6xRXkto5mN2AxkpzuhnuWzSUE841HJKhZ3qe6TLnuQ6HojZE4
         xx5doneDu1WG4IHfSmtpYOnUonOnV0RUJPvqXXVH7L+9xsGAL9VD2ZrhkY92XHLvB3Pb
         TdcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=dvHC7IEjaNzLmrdRYJV4sQeFFlV2SJx1gNWHOi/p6qM=;
        b=dOmh2x0ythkRX8PWbi/VTUE4CpqpEyU/+QgVUhzJcymwDgwoUnT8eymNJqCRtOlniv
         +a8xyMG+UbygA6hYrlfSQVbVwD7luQi4lbLOHxrkoPsOa77Phu1DDGPbSWBUHRcqKq2A
         Te0NWVE3fwhP8Td1PoceyHcMbDr1yv6Q2s7e4vp7kMBTpjcIG1dFLqJ3zC8/EjHFFgIB
         AHK1ls0ENc5bLZf/SCkLHhdUm51B3guySU1dk73m22ectgKjXAI+7tChA/NK4SJxAy+h
         YfKmsXjtXzIFVa38d5HfhO1nWMene+T8oB+8Tn7b+rijmOSa/L0AiIwo1pE3rjSumJlC
         ksog==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ajay.kathat@microchip.com designates 68.232.147.91 as permitted sender) smtp.mailfrom=Ajay.Kathat@microchip.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ajay.kathat@microchip.com designates 68.232.147.91 as permitted sender) smtp.mailfrom=Ajay.Kathat@microchip.com
X-IronPort-AV: E=Sophos;i="5.48,365,1517900400";
   d="scan'208";a="13280737"
Date: Mon, 26 Mar 2018 21:05:48 +0530
From: Ajay Singh <ajay.kathat@microchip.com>
To: Colin King <colin.king@canonical.com>
CC: Joe Perches <joe@perches.com>, Aditya Shankar
	<aditya.shankar@microchip.com>, Ganesh Krishna
	<ganesh.krishna@microchip.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, <linux-wireless@vger.kernel.org>,
	<devel@driverdev.osuosl.org>, <kernel-janitors@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: wilc1000: check for kmalloc allocation
 failures
Message-ID: <20180326210548.791f070a@ajaysk-VirtualBox>
In-Reply-To: <1521662598.7999.33.camel@perches.com>
References: <20180321191941.4126-1-colin.king@canonical.com>
	<1521662598.7999.33.camel@perches.com>
Organization: Microchip Techonology
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595576138463353935?=
X-GMAIL-MSGID: =?utf-8?q?1596015059778184688?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Thanks for submitting the patch.

On Wed, 21 Mar 2018 13:03:18 -0700
Joe Perches <joe@perches.com> wrote:

> On Wed, 2018-03-21 at 19:19 +0000, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > There are three kmalloc allocations that are not null checked which
> > potentially could lead to null pointer dereference issues. Fix this
> > by adding null pointer return checks.
> 
> looks like all of these should be kmemdup or kstrdup
> 
> >  
> > @@ -951,6 +955,10 @@ static s32 handle_connect(struct wilc_vif *vif,
> >  	if (conn_attr->ssid) {
> >  		hif_drv->usr_conn_req.ssid = kmalloc(conn_attr->ssid_len + 1,
> >  						     GFP_KERNEL);
> > +		if (!hif_drv->usr_conn_req.ssid) {
> > +			result = -ENOMEM;
> > +			goto error;
> > +		}
> >  		memcpy(hif_drv->usr_conn_req.ssid,
> >  		       conn_attr->ssid,
> >  		       conn_attr->ssid_len);

With this changes the Coverity reported warning is handled correctly.

For further improvement to the patch, as Joe Perches suggested, its better
to make use of kmemdup instead of kmalloc & memcpy. As kstrdup requires the
source string to be NULL terminated('\0') and conn_attr->ssid might not  
contains the '\0' terminated string. So kmemdup with length of 
'conn_attr->ssid_len' can be used instead.

Please include the changes by using kmemdup() for all kmalloc/memcpy in
this patch.



Regards,
Ajay
