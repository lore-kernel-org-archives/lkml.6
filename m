Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EAFC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5045206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pBEpKGya"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730691AbeLUJHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 04:07:38 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33051 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729563AbeLUJHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 04:07:37 -0500
Received: by mail-pf1-f195.google.com with SMTP id c123so2320409pfb.0;
        Fri, 21 Dec 2018 01:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NB5trgo9uCGGn6yAxl6VATsZwvzz/OOpZhr/f7H8Mhg=;
        b=pBEpKGyaE6Rfo7n29PaF6ttiGAzp9Qp4Nte8GXK6vw7uZSOofQTfae+2LjnHRscoCN
         qaYtTvTnog9OEi0u/vcKM6hVs4aPZjVTqZn3T3c7XsmJAkuaQqd+IKpBDGuSdRylTQCl
         mKvfDO6bpkpj8ieUxNr2hXMW0Ks21G0Tfm0QBoWuWCFNzRBy0gR4EDmI1XD9fMnFtw5A
         Cfd4/sdeqwNqtfcZ5xOfkMOa5S24shv1qqCtPGOtASXQZrXw3wyvFPrP4OH9yM+F+TCo
         6j9ny7q1x5qKKu/ip9ioDBmtw4pLrP0boqUB0o+RzoUEyOXWMOaZeDTnI86HRYr7pX2h
         EfyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NB5trgo9uCGGn6yAxl6VATsZwvzz/OOpZhr/f7H8Mhg=;
        b=gHDvGcTG45eqzr2NmuQOKIdyEx1l9q85tYNDw7VA4qNmAo08XRV21ch2W/7sK/Lsdw
         ilg+PulJB+MnLhbI3kUhLFHi4hyqN0v7DnNH+/N7MXf+2GOBeyzFe7cmhca0ospFBetF
         Z6k3iB/DrpvILNXBG3oIoCv4XU+TUCB3FGuMUjb4YuKl0Ti78B56OLylso5fb8mFyS7z
         oTq+jM7pNYfFFa+NT9FVc1+IC7mx5CCWej1T1JuBkxsRAFI9gAGOBOpe1Q0/2F82w5x2
         T2oRtcni0wy8OjQf8aM+oPzABelKjLTgYo/X8szFDarWzZ/cDCfbAhE3o/6I1opAar92
         W2zQ==
X-Gm-Message-State: AJcUukdT9YC11lEYKU/I/LbRJo2S2wheDWokAYIIN6i5RP5CzTtmiWMq
        GwL2Ic+G/3rmwEFkvcx3el4=
X-Google-Smtp-Source: ALg8bN5YYg0WmPE6W5ay20si0GlC4H8j0VyEVXyDLlVZ0XlZspkj8ho+TejhwhiGhAHQC13nMmCmSQ==
X-Received: by 2002:a63:9b11:: with SMTP id r17mr1617303pgd.416.1545383255606;
        Fri, 21 Dec 2018 01:07:35 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id h79sm47713757pfj.186.2018.12.21.01.07.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 01:07:34 -0800 (PST)
Date:   Fri, 21 Dec 2018 01:07:33 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Hardik Singh Rathore <hardiksingh.k@gmail.com>
Cc:     michael.hennerich@analog.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, joe@perches.com
Subject: Re: [PATCH v3] Input: touchscreen: Fix coding style issue
Message-ID: <20181221090733.GL211587@dtor-ws>
References: <20181211111740.25643-1-hardiksingh.k@gmail.com>
 <20181211130332.27781-1-hardiksingh.k@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211130332.27781-1-hardiksingh.k@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 06:33:32PM +0530, Hardik Singh Rathore wrote:
> This patch fixes the coding style problem reported
> by checkpatch.pl as below:
> 
> ERROR: foo* bar should be "foo *bar"
> 
> Signed-off-by: Hardik Singh Rathore <hardiksingh.k@gmail.com>

Applied, thank you.

> ---
> v3:
> - v2 was depends on v1 so it didn't solve the issue.
> 
>  drivers/input/touchscreen/ad7879.c   | 2 +-
>  drivers/input/touchscreen/ektf2127.c | 2 +-
>  drivers/input/touchscreen/gunze.c    | 4 ++--
>  drivers/input/touchscreen/inexio.c   | 4 ++--
>  drivers/input/touchscreen/mtouch.c   | 4 ++--
>  5 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/ad7879.c b/drivers/input/touchscreen/ad7879.c
> index 6bad23ee47a1..b68902c17f2e 100644
> --- a/drivers/input/touchscreen/ad7879.c
> +++ b/drivers/input/touchscreen/ad7879.c
> @@ -290,7 +290,7 @@ static int ad7879_open(struct input_dev *input)
>  	return 0;
>  }
>  
> -static void ad7879_close(struct input_dev* input)
> +static void ad7879_close(struct input_dev *input)
>  {
>  	struct ad7879 *ts = input_get_drvdata(input);
>  
> diff --git a/drivers/input/touchscreen/ektf2127.c b/drivers/input/touchscreen/ektf2127.c
> index 0ed34ff787ce..28fa1b36f7a5 100644
> --- a/drivers/input/touchscreen/ektf2127.c
> +++ b/drivers/input/touchscreen/ektf2127.c
> @@ -51,7 +51,7 @@ struct ektf2127_ts {
>  	struct touchscreen_properties prop;
>  };
>  
> -static void ektf2127_parse_coordinates(const u8* buf, unsigned int touch_count,
> +static void ektf2127_parse_coordinates(const u8 *buf, unsigned int touch_count,
>  				       struct input_mt_pos *touches)
>  {
>  	int index = 0;
> diff --git a/drivers/input/touchscreen/gunze.c b/drivers/input/touchscreen/gunze.c
> index 054c2537b392..56cf1a1ea3ea 100644
> --- a/drivers/input/touchscreen/gunze.c
> +++ b/drivers/input/touchscreen/gunze.c
> @@ -53,7 +53,7 @@ struct gunze {
>  	char phys[32];
>  };
>  
> -static void gunze_process_packet(struct gunze* gunze)
> +static void gunze_process_packet(struct gunze *gunze)
>  {
>  	struct input_dev *dev = gunze->dev;
>  
> @@ -72,7 +72,7 @@ static void gunze_process_packet(struct gunze* gunze)
>  static irqreturn_t gunze_interrupt(struct serio *serio,
>  		unsigned char data, unsigned int flags)
>  {
> -	struct gunze* gunze = serio_get_drvdata(serio);
> +	struct gunze *gunze = serio_get_drvdata(serio);
>  
>  	if (data == '\r') {
>  		gunze_process_packet(gunze);
> diff --git a/drivers/input/touchscreen/inexio.c b/drivers/input/touchscreen/inexio.c
> index b9bc56233ccc..13bd0bf580a7 100644
> --- a/drivers/input/touchscreen/inexio.c
> +++ b/drivers/input/touchscreen/inexio.c
> @@ -79,7 +79,7 @@ static void inexio_process_data(struct inexio *pinexio)
>  static irqreturn_t inexio_interrupt(struct serio *serio,
>  		unsigned char data, unsigned int flags)
>  {
> -	struct inexio* pinexio = serio_get_drvdata(serio);
> +	struct inexio *pinexio = serio_get_drvdata(serio);
>  
>  	pinexio->data[pinexio->idx] = data;
>  
> @@ -97,7 +97,7 @@ static irqreturn_t inexio_interrupt(struct serio *serio,
>  
>  static void inexio_disconnect(struct serio *serio)
>  {
> -	struct inexio* pinexio = serio_get_drvdata(serio);
> +	struct inexio *pinexio = serio_get_drvdata(serio);
>  
>  	input_get_device(pinexio->dev);
>  	input_unregister_device(pinexio->dev);
> diff --git a/drivers/input/touchscreen/mtouch.c b/drivers/input/touchscreen/mtouch.c
> index a3707fad4d1c..8278a9058640 100644
> --- a/drivers/input/touchscreen/mtouch.c
> +++ b/drivers/input/touchscreen/mtouch.c
> @@ -90,7 +90,7 @@ static void mtouch_process_response(struct mtouch *mtouch)
>  static irqreturn_t mtouch_interrupt(struct serio *serio,
>  		unsigned char data, unsigned int flags)
>  {
> -	struct mtouch* mtouch = serio_get_drvdata(serio);
> +	struct mtouch *mtouch = serio_get_drvdata(serio);
>  
>  	mtouch->data[mtouch->idx] = data;
>  
> @@ -110,7 +110,7 @@ static irqreturn_t mtouch_interrupt(struct serio *serio,
>  
>  static void mtouch_disconnect(struct serio *serio)
>  {
> -	struct mtouch* mtouch = serio_get_drvdata(serio);
> +	struct mtouch *mtouch = serio_get_drvdata(serio);
>  
>  	input_get_device(mtouch->dev);
>  	input_unregister_device(mtouch->dev);
> -- 
> 2.17.1
> 

-- 
Dmitry
