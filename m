Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A21DC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E98622077C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOBwvpet"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E98622077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbeJLT1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 15:27:11 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40817 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbeJLT1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 15:27:11 -0400
Received: by mail-wm1-f65.google.com with SMTP id z204-v6so12698006wmc.5;
        Fri, 12 Oct 2018 04:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=urOnk3xgFScUzGb94oxh5qbnOa3yFehZolR1WbPy2rs=;
        b=KOBwvpetR3IecA3jjPDDX8n3nyQ9lnIS7wBrxiEJKsyakGnHee8BZLA0KwvRoOFj2P
         f5jAYMOx75eTH2o3xRoTATUA8grgGd79LUCyNjK8sHPN1+DpQdQkZZt9fB6u+UfA+Zwg
         DSZpC0gs5SjB9PQF1Dn6sYv8ylPInOH3MZJCDVaqeaDMUE5axObwtQ6j8KaCRhNjfRon
         89rxRysDatmITzDJr7XpqEnTOw8PD4VP4HilObB6NsgmYyz4LfEI3Wjg73TH/GjGBM11
         kQGPRP/DlJqaXR4eqTusxfMe+5Vx7kr1IG5lq0JysUtyX0kJVZn76iAfpPai4HprPYGx
         3/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=urOnk3xgFScUzGb94oxh5qbnOa3yFehZolR1WbPy2rs=;
        b=sBaJxTsGza798lH22KTllhCukgA3Ydl1RkBJHBVmIazUtLUuRj8kBZTiMTnBlrwuBg
         kKAe1w7eX62/S72wsLUqR8f54nHPdOO4WDgT97toGfSzMm0u2EIRPB3YdzmnyKT2/NqA
         8RwbU+KJK8LkfaXi9q86X0rnVD3zb9Wx8Q3AKBRindzeAVJI1h3bCvSMIOPwvLbok8T8
         hinFqVtXlA8j+Abwsq+kQ4uRJUyloXwMAgKstTllZzqJuAeFLuBaNf7Lr/mZtWGMs0L4
         fIoKvJGaX9S6JZWecrrQXU+qldN5tlqechMRuEL5tfrpg6rJqFgcbSRYWdrLsU02E3s7
         DUWg==
X-Gm-Message-State: ABuFfohOXhCvxarqyJE1GJDbif6JTSorrCp/CF+henWS5LIHWE1SJmqN
        Floxy/9cGhdowSHsfbHTLE4=
X-Google-Smtp-Source: ACcGV60LDIqHOj7UY2/PmGiIjboUAVCKJdHfkFB0GgsSrpFOmTWMwh7xUXfEJ5cJhEmXFwxi3wOXjg==
X-Received: by 2002:a1c:1e8e:: with SMTP id e136-v6mr5047379wme.100.1539345302749;
        Fri, 12 Oct 2018 04:55:02 -0700 (PDT)
Received: from localhost (p2E5BEEEA.dip0.t-ipconnect.de. [46.91.238.234])
        by smtp.gmail.com with ESMTPSA id h82-v6sm1055820wmf.14.2018.10.12.04.55.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 04:55:01 -0700 (PDT)
Date:   Fri, 12 Oct 2018 13:55:00 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     gottfried.haider@gmail.com, stefan.wahren@i2se.com,
        hsweeten@visionengravers.com, loic.pallardy@st.com,
        broonie@kernel.org, gohai@sukzessiv.net, michal.vokac@ysoft.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 0/2] pwm: sysfs: fix exporting PWM channel
Message-ID: <20181012115500.GD31561@ulmo>
References: <1538400237-28766-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Q0rSlbzrZN6k9QnT"
Content-Disposition: inline
In-Reply-To: <1538400237-28766-1-git-send-email-fabrice.gasnier@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Q0rSlbzrZN6k9QnT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 01, 2018 at 03:23:55PM +0200, Fabrice Gasnier wrote:
> Since commit 7e5d1fd75c3d ("pwm: Set class for exported channels in sysfs=
")
> - it's not possible to export more than one PWM channel
> - ABI has changed, as a side effect. It may cause bad behavior as pwmchip
>   attributes are wrongly added to pwm channels and report wrong values.
> See [1] and [2].
>=20
> One purpose of the original patch is to send uevents to udev, when export=
ing a
> PWM channel through the sysfs. This series:
> - Reverts the original patch.
> - Proposes a new way to send notifications to be used by udev rules.
>=20
> - With this series:
> $ echo 0 > /sys/class/pwm/pwmchip0/export
> $ ls /sys/class/pwm
> pwmchip0 pwmchip4
>=20
> $ ls /sys/class/pwm/pwmchip0/pwm0/
> capture     enable      polarity    uevent
> duty_cycle  period      power
>=20
> - Without this series:
> $ echo 0 > /sys/class/pwm/pwmchip0/export
> $ ls /sys/class/pwm
> pwm0 pwmchip0 pwmchip4
>=20
> $ ls /sys/class/pwm/pwmchip0/pwm0/
> capture     duty_cycle  export      period      power       uevent
> device      enable      npwm        polarity    subsystem   unexport
>=20
> - Backtrace when exporting a 2nd channel (0) on a separate pwmchip device:
> $ echo 0 > /sys/class/pwm/pwmchip4/export
> [   95.286558] sysfs: cannot create duplicate filename '/class/pwm/pwm0'
> [   95.293630] CPU: 0 PID: 54 Comm: sh Not tainted 4.19.0-rc6-00013-g00b4=
9b0 #151
> [   95.301344] Hardware name: STM32 (Device Tree Support)
> [   95.306833] [<0000c155>] (unwind_backtrace) from [<0000b273>] (show_st=
ack+0xb/0xc)
> [   95.315136] [<0000b273>] (show_stack) from [<00092455>] (sysfs_warn_du=
p+0x31/0x48)
> [   95.323247] [<00092455>] (sysfs_warn_dup) from [<00092635>] (sysfs_do_=
create_link_sd+0x75/0x88)
> [   95.332539] [<00092635>] (sysfs_do_create_link_sd) from [<00125823>] (=
device_add+0x133/0x3b0)
> [   95.341694] [<00125823>] (device_add) from [<001059ed>] (export_store+=
0xb5/0x12c)
> [   95.349761] [<001059ed>] (export_store) from [<00091911>] (kernfs_fop_=
write+0x87/0xda)
> [   95.358150] [<00091911>] (kernfs_fop_write) from [<0005beb1>] (__vfs_w=
rite+0x1d/0xe0)
> [   95.366295] [<0005beb1>] (__vfs_write) from [<0005bfe7>] (vfs_write+0x=
4f/0x7c)
> [   95.374053] [<0005bfe7>] (vfs_write) from [<0005c0bf>] (ksys_write+0x3=
3/0x70)
> [   95.381708] [<0005c0bf>] (ksys_write) from [<00009001>] (ret_fast_sysc=
all+0x1/0x58)
> [   95.389682] Exception stack(0x01bcffa8 to 0x01bcfff0)
> [   95.394946] ffa0:                   00000000 00c4883c 00000001 00c4e59=
0 00000002 00000004
> [   95.403639] ffc0: 00000000 00c4883c 00c4cbe8 00000004 00000002 0000002=
0 00000000 00c4d008
> [   95.412223] ffe0: 00c29151 00c4cbe8 00c17833 00c13c0c
> -sh: write error: File exists
>=20
> [1] https://lkml.org/lkml/2018/9/25/713
> [2] https://lkml.org/lkml/2018/9/25/447
>=20
> ---
> Changes in v2:
> - update revert commit message
> - new patch 2/2 to propose uevent notification (change) on pwmchip
>=20
> Fabrice Gasnier (2):
>   Revert "pwm: Set class for exported channels in sysfs"
>   pwm: send a uevent on the pwmchip device upon channel sysfs (un)export
>=20
>  drivers/pwm/sysfs.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)

Both patches applied, thanks. What do you think would be the importance
of getting this into stable kernels? We can't get one of the patches in
without the other, so they'd both have to be backported. The second one
is still fairly small, so would qualify for stable, I think.

However, given that it's taken a long time for somebody to notice this,
I'm not sure if this is something that people care about too much in the
stable kernels.

Thierry

--Q0rSlbzrZN6k9QnT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvAi5QACgkQ3SOs138+
s6EKTA/+JaRokyKNvfPT6Td1ZQDzT30HpYUrTNmIoa2d4/y0lRDqTpKr6fTurt4z
LKVpyhoKZUjCYmCZZupGW9mJEdPwh95dYIgUchfkl03iLrDWL9K8DX6pzWSUt/Sj
YcxfuhEQEG0tkoUeHPiJ7V83673PcI9m7DBibFfjEondhxjqy/JVqU8uzduNLSQ6
HwYmuvM3VyqSzsIggyWC0ibnshdpx3afXQi/I4AO5ZM9mGvSX+Y73Hal39dTHTXy
rjWru/TXkIU5BRmSr7880lB2e1E+vq8NlWganuwXb3USCWMWew9P7OqrJ3wL4vP9
KsQIdllkI88chkZ9njUMppmldTEygMOFN0I5YcgLJoPU2jZRO0CfkAh60Y5gDvDC
vLvCWRBlcpm+s2KDPfmvIXYMGWbM/cHvRm4ic6wtr4ahQ9LFxlrrjn3lKKrgJX16
AfwzOAAcdNcsINE9QeSgGOZ7SQqxZvsx4Mwp8qUkGxdhXJTlyo2IKH9nployMIhi
PfgdrI/mB/rALsnZEDY2O5mzT8ftclkU21cuaLnaUglKNRc8DOVMHu+K8wKmvQvc
3sz4Q+GpbQB5KYOIeD+gBpPlKMy3oi4kD9g/+eVdt8oKi+lBSQEAI15yNUe0MQrV
7VK6pQ7yIHHBrlHcpmvN7WPbxcacwNXiwH7mGpO0rn2DiPAqpdo=
=VkA1
-----END PGP SIGNATURE-----

--Q0rSlbzrZN6k9QnT--
