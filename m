Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3948CC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 01:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2EF020872
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 01:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEDYGv0R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfALBkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 20:40:10 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37627 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfALBkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 20:40:09 -0500
Received: by mail-pg1-f196.google.com with SMTP id c25so7046582pgb.4;
        Fri, 11 Jan 2019 17:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kbgb3g0e2s642y67hYVumi4vwfrZzdiD92EP8bXmmcg=;
        b=TEDYGv0RH8qHLdyzMi/C8MPHnIj/m1AhzbPy+QAyzHmAJoNHMlLAytpslepP4i9JVT
         3ky0xae6Jz5VDjvKJOZ7AcR7KW+rgifu0xbn9gl6XNC8juEhnZaxFPLIOY9FGcl2ZUv2
         rxs9qOZvgWeXaz3zTAl+8Esm/U7Zxg4EDTsTb+iLDM11b/0u1fH/cblAtRyKSeGq2LC3
         s6ffj/0lS4Sl2j0ENcFM7mi5OdM6pls/L/5aM5tXmwT9o0HqUU9n/lHQOhpmEweRxz9g
         9xVaa6orRZ1OhTkqbCwsMnkAzu7e1IMXqWBBFfLN54HMBYzEJorgy6Iyv9zwcD3uz+VN
         dJlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kbgb3g0e2s642y67hYVumi4vwfrZzdiD92EP8bXmmcg=;
        b=pDMeUx3tRHp3N50D709ODNcbxpJ5Uf5OlDGByo6dFrhvbiNi77FTzS4dRZtE3dDeld
         TKlGGYG2RGL8cYKaCxta8dDbXO1uOW89GxWkmqP8cK7WDBbHIr8nn+e6o+0FDnPGb/V2
         y8CLXq7/wN43ODo4OeDTUXwnW1/gnqJBBxQiQO3nvZ/NcI2bgnPkVMLNvgb9/4op1a6c
         Zv03IHO+sK86xNrpGGJz32hPwI1WI0O9hn8Fx/1dOuo2ad41UH70ePARnHe7CTfhY1WM
         6R+2Ho/jiPFKnLTsdcQzFKe7uy96RnqqElzjDMjdnETvoZ9ERPzTuHyMJ769FP0u7bKD
         mkCg==
X-Gm-Message-State: AJcUukfysXkFK7Kby7PqcH5Gl6UerHvZbVoXhR9AJJjNMAcejTiNu4Is
        anJhYAYqowxX+UjKwAixdJU=
X-Google-Smtp-Source: ALg8bN62YBJQZIMLEFqN/5HRW195+nXECP+3uR30m3nTkaALmWN9KIcj65sTx94+ImhKyob5sXhonw==
X-Received: by 2002:a62:2044:: with SMTP id g65mr16633399pfg.127.1547257207337;
        Fri, 11 Jan 2019 17:40:07 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id 6sm166322580pfv.30.2019.01.11.17.40.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 17:40:06 -0800 (PST)
Date:   Fri, 11 Jan 2019 17:40:04 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Kim Phillips <kim@kimphillips.com>
Cc:     linux-kernel@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] Input: synaptics - add PNP IDs for Dell XPS models to
 forcepad
Message-ID: <20190112014004.GA122403@dtor-ws>
References: <20190111205430.15371-1-kim@kimphillips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111205430.15371-1-kim@kimphillips.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kim,

On Fri, Jan 11, 2019 at 02:54:30PM -0600, Kim Phillips wrote:
> This patch is the result of seeing this message:
> 
> psmouse serio1: synaptics: Your touchpad (PNP: DLL087c PNP0f13) says it can support a different bus. If i2c-hid and hid-rmi are not used, you might want to try setting psmouse.synaptics_intertouch to 1 and report this to linux-input@vger.kernel.org.
> 
> If I set psmouse.synaptics_intertouch=1, or add the PNP ID to
> smbus_pnp_ids, the touchpad continues to work, and the above message
> goes away, but we now get:
> 
> psmouse serio1: synaptics: Trying to set up SMBus access
> psmouse serio1: synaptics: SMbus companion is not ready yet
> 
> With this patch applied, i.e., the PNP IDs are added to the forcepad
> array, the touchpad continues to work and all of the above messages
> disappear.

Are you sure the touchpad in XPSes is a forcepad (i.e. it does not have
physical button underneath it)? As far as I know there were only couple
of HP laptops with forcepads and when switching to RMI mode forcepads
need F21 handler that we do not currently have in the kernel.

> 
> Tested on a Dell XPS 15 9570.  The other IDs - for Dell XPS 13
> 9350/9360/9370 and XPS 15 9550/9560 - were obtained by searching
> for the model numbers and "says it can support a different bus".
> E.g, this is one such instance:
> 
> https://lkml.org/lkml/2018/2/15/52
> 
> Cc: Paul Menzel <pmenzel@molgen.mpg.de>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Cc: linux-input@vger.kernel.org
> Signed-off-by: Kim Phillips <kim@kimphillips.com>
> ---
> With or without this patch, I'm seeing a problem where when the XPS 15
> comes out of a resume, and without even touching the touchpad, I notice
> about 600 interrupts per second firing on the "IR-IO-APIC   51-fasteoi
> SYNA2393:00" line in /proc/interrupts.  If I start using the touchpad,
> then leave it alone, I check if there are still interrupts firing, and
> they have indeed stopped.  This adversely affects my battery life when
> using an external mouse.  Any ideas on how to debug the situation?
> Could it be related to the 'vdd not found' messages?:
> 
> $ dmesg | grep -C 1 -i syna
> probe of 1-12 returned 1 after 2343 usecs
> psmouse serio1: synaptics: queried max coordinates: x [..5664], y [..4646]
> psmouse serio1: synaptics: queried min coordinates: x [1278..], y [1206..]
> psmouse serio1: synaptics: Touchpad model: 1, fw: 8.2, id: 0x1e2b1, caps: 0xf00123/0x840300/0x12e800/0x0, board id: 3125, fw id: 2378871
> input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio1/input/input6
> probe of serio1 returned 1 after 939332 usecs
> --
> probe of idma64.1 returned 1 after 72 usecs
> i2c_hid i2c-SYNA2393:00: i2c-SYNA2393:00 supply vdd not found, using dummy regulator
> i2c_hid i2c-SYNA2393:00: Linked as a consumer to regulator.0
> i2c_hid i2c-SYNA2393:00: i2c-SYNA2393:00 supply vddl not found, using dummy regulator
> ath10k_pci 0000:3b:00.0: qca6174 hw3.2 target 0x05030000 chip_id 0x00340aff sub 1a56:1535
> --
> ath10k_pci 0000:3b:00.0: firmware ver WLAN.RM.4.4.1-00079-QCARMSWPZ-1 api 6 features wowlan,ignore-otp crc32 fd869beb
> probe of i2c-SYNA2393:00 returned 1 after 23978 usecs
> ath10k_pci 0000:3b:00.0: board_file api 2 bmi_id N/A crc32 20d869c3
> --
> probe of 0018:056A:488F.0001 returned 1 after 1366 usecs
> input: SYNA2393:00 06CB:7A13 Mouse as /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-10/i2c-SYNA2393:00/0018:06CB:7A13.0002/input/input23
> input: SYNA2393:00 06CB:7A13 Touchpad as /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-10/i2c-SYNA2393:00/0018:06CB:7A13.0002/input/input24
> hid-generic 0018:06CB:7A13.0002: input,hidraw1: I2C HID v1.00 Mouse [SYNA2393:00 06CB:7A13] on i2c-SYNA2393:00
> probe of 0018:06CB:7A13.0002 returned 1 after 320 usecs
> --
> probe of 0018:06CB:7A13.0002 returned 0 after 5 usecs
> input: SYNA2393:00 06CB:7A13 Touchpad as /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-10/i2c-SYNA2393:00/0018:06CB:7A13.0002/input/input27
> hid-multitouch 0018:06CB:7A13.0002: input,hidraw1: I2C HID v1.00 Mouse [SYNA2393:00 06CB:7A13] on i2c-SYNA2393:00
> probe of 0018:06CB:7A13.0002 returned 1 after 25104 usecs
> 
>  drivers/input/mouse/synaptics.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> index b6da0c1267e3..e3fb4b9346c0 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -185,6 +185,12 @@ static const char * const smbus_pnp_ids[] = {
>  };
>  
>  static const char * const forcepad_pnp_ids[] = {
> +	"DLL06e4", /* Dell XPS 15 9550 */
> +	"DLL0704", /* Dell XPS 13 9350 */
> +	"DLL075b", /* Dell XPS 13 9360 */
> +	"DLL07be", /* Dell XPS 15 9560 */
> +	"DLL07e6", /* Dell XPS 13 9370 */
> +	"DLL087c", /* Dell XPS 15 9570 */
>  	"SYN300D",
>  	"SYN3014",
>  	NULL
> -- 
> 2.20.1
> 

Thanks.

-- 
Dmitry
