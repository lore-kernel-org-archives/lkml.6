Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752431AbeCZWhh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 18:37:37 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41088 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752334AbeCZWhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 18:37:35 -0400
X-Google-Smtp-Source: AG47ELsdiy10GvCH3PDrStO9OOPD7rfHCUKMTZqfhixvZCxkfMBLuEKd9aMfYKKxnk3675u29XAaAQ==
Date: Mon, 26 Mar 2018 15:37:32 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Masaki Ota <masaki.ota@jp.alps.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: alps - Report pressure of v3 and v7 trackstick
Message-ID: <20180326223732.GB204225@dtor-ws>
References: <20180321200736.32406-1-pali.rohar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180321200736.32406-1-pali.rohar@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pali,

On Wed, Mar 21, 2018 at 09:07:36PM +0100, Pali Rohár wrote:
> ALPS v3 and v7 packet formats reports trackstick pressure. This information
> is already parsed in unused "z" variable.
> 
> ALPS SS4 S2 devices already reports trackstick pressure as ABS_PRESSURE
> attribute, therefore reports pressure in the same way also for v3 and v7.
> 
> This patch also updates parsing v3 pressure information, it is also stored
> in 7 bits.
> 
> Signed-off-by: Pali Rohár <pali.rohar@gmail.com>
> ---
>  drivers/input/mouse/alps.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> index 010c1bcdb06d..0a9e6a3a2f9f 100644
> --- a/drivers/input/mouse/alps.c
> +++ b/drivers/input/mouse/alps.c
> @@ -139,11 +139,11 @@ static const struct alps_model_info alps_model_data[] = {
>  };
>  
>  static const struct alps_protocol_info alps_v3_protocol_data = {
> -	ALPS_PROTO_V3, 0x8f, 0x8f, ALPS_DUALPOINT
> +	ALPS_PROTO_V3, 0x8f, 0x8f, ALPS_DUALPOINT | ALPS_DUALPOINT_WITH_PRESSURE

It seems that with these changes we no longer have trackpoints that do
not report pressure in ALPS. Should we get rid of
ALPS_DUALPOINT_WITH_PRESSURE and clean up the code a bit?

Thanks.

>  };
>  
>  static const struct alps_protocol_info alps_v3_rushmore_data = {
> -	ALPS_PROTO_V3_RUSHMORE, 0x8f, 0x8f, ALPS_DUALPOINT
> +	ALPS_PROTO_V3_RUSHMORE, 0x8f, 0x8f, ALPS_DUALPOINT | ALPS_DUALPOINT_WITH_PRESSURE
>  };
>  
>  static const struct alps_protocol_info alps_v4_protocol_data = {
> @@ -155,7 +155,7 @@ static const struct alps_protocol_info alps_v5_protocol_data = {
>  };
>  
>  static const struct alps_protocol_info alps_v7_protocol_data = {
> -	ALPS_PROTO_V7, 0x48, 0x48, ALPS_DUALPOINT
> +	ALPS_PROTO_V7, 0x48, 0x48, ALPS_DUALPOINT | ALPS_DUALPOINT_WITH_PRESSURE
>  };
>  
>  static const struct alps_protocol_info alps_v8_protocol_data = {
> @@ -583,7 +583,7 @@ static void alps_process_trackstick_packet_v3(struct psmouse *psmouse)
>  
>  	x = (s8)(((packet[0] & 0x20) << 2) | (packet[1] & 0x7f));
>  	y = (s8)(((packet[0] & 0x10) << 3) | (packet[2] & 0x7f));
> -	z = (packet[4] & 0x7c) >> 2;
> +	z = packet[4] & 0x7c;
>  
>  	/*
>  	 * The x and y values tend to be quite large, and when used
> @@ -595,6 +595,7 @@ static void alps_process_trackstick_packet_v3(struct psmouse *psmouse)
>  
>  	input_report_rel(dev, REL_X, x);
>  	input_report_rel(dev, REL_Y, -y);
> +	input_report_abs(dev, ABS_PRESSURE, z);
>  
>  	/*
>  	 * Most ALPS models report the trackstick buttons in the touchpad
> @@ -1118,6 +1119,7 @@ static void alps_process_trackstick_packet_v7(struct psmouse *psmouse)
>  
>  	input_report_rel(dev2, REL_X, (char)x);
>  	input_report_rel(dev2, REL_Y, -((char)y));
> +	input_report_abs(dev2, ABS_PRESSURE, z);
>  
>  	input_report_key(dev2, BTN_LEFT, left);
>  	input_report_key(dev2, BTN_RIGHT, right);
> -- 
> 2.11.0
> 

-- 
Dmitry
