Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751836AbeCWOdl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 10:33:41 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33941 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751796AbeCWOdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 10:33:39 -0400
X-Google-Smtp-Source: AG47ELta+AQTqNCB3sOVi/hDWQ/C9/DTS5F7wVPZcbvTNOgn6Quetu9zNCtNnKl/m2cSXBs/w2i/zw==
Date: Fri, 23 Mar 2018 15:33:36 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Dennis Wassenberg <dennis.wassenberg@secunet.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Masaki Ota <masaki.ota@jp.alps.com>, Takashi Iwai <tiwai@suse.de>,
        Kees Cook <keescook@chromium.org>, Nir Perry <nirperry@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: ALPS - add support for 73 03 28 devices (Thinkpad
 L570)
Message-ID: <20180323143336.v26rvflt3oq5xppn@pali>
References: <7d5077ef-c185-c6b1-d602-df8d9f7dade3@secunet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7d5077ef-c185-c6b1-d602-df8d9f7dade3@secunet.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 23 March 2018 15:23:55 Dennis Wassenberg wrote:
> The Lenovo Thinkpad L570 uses V8 protocol.
> Add 0x73 0x03 0x28 devices to use V8 protovol which makes
> trackstick and mouse buttons work with Lenovo Thinkpad L570.
> 
> Signed-off-by: Dennis Wassenberg <dennis.wassenberg@secunet.com>
> ---
>  drivers/input/mouse/alps.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> index dbe57da..5523d4e 100644
> --- a/drivers/input/mouse/alps.c
> +++ b/drivers/input/mouse/alps.c
> @@ -136,6 +136,8 @@
>  	{ { 0x73, 0x02, 0x0a }, { ALPS_PROTO_V2, 0xf8, 0xf8, 0 } },
>  	{ { 0x73, 0x02, 0x14 }, { ALPS_PROTO_V2, 0xf8, 0xf8, ALPS_FW_BK_2 } },			/* Ahtec Laptop */
>  	{ { 0x73, 0x02, 0x50 }, { ALPS_PROTO_V2, 0xcf, 0xcf, ALPS_FOUR_BUTTONS } },		/* Dell Vostro 1400 */
> +	{ { 0x73, 0x03, 0x28 }, { ALPS_PROTO_V8, 0x18, 0x18,
> +		ALPS_DUALPOINT | ALPS_DUALPOINT_WITH_PRESSURE | ALPS_BUTTONPAD } },		/* Lenovo L570 */
>  };
>  
>  static const struct alps_protocol_info alps_v3_protocol_data = {

Hi! alps_model_data table is used for fixed identification of v1 and v2
protocols. Why you need to add there v8 protocol which autodetection is
already done in alps_identify() function? There is already code:

		} else if (e7[0] == 0x73 && e7[1] == 0x03 &&
			   (e7[2] == 0x14 || e7[2] == 0x28)) {
			protocol = &alps_v8_protocol_data;

Which matches above your E7 detection 0x73, 0x03, 0x28.

Also you patch matches basically all v8 device and therefore has
potential to break proper v8 autodetection for other v8 devices...

-- 
Pali Rohár
pali.rohar@gmail.com
