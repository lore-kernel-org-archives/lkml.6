Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB24C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 06:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB2222084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 06:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="jsvLWQlw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB2222084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbeJANci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 09:32:38 -0400
Received: from smtprelay2.synopsys.com ([198.182.60.111]:54234 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbeJANci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 09:32:38 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 1F5AB10C0F1C;
        Sun, 30 Sep 2018 23:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1538376984; bh=H1TSMLmWnKNRsjQbEkkvpAM5eLlJ39jb8NHFkGLCuQ4=;
        h=From:To:CC:Subject:Date:References:From;
        b=jsvLWQlw/+PkAFUEUpkFlGJPU96zjdhnkSL6TBNigMTCXlbzAJ1sSMDj6MtiQF142
         AIPdi8FdvvxEpN93kdUvcoYxCyHzwAKm3+hQXe+1I6O3plgGOG81Tr1FmiY2z9vGis
         ji39vGpuCnvUJl0NH13/XE6bAQP85tfduERYIQ7MM/aGgylRqBNja3uFPUYKcWDQ1y
         EwvnNynFNdoMnCcxHvBFKehsivUOPgWFYiYKj93sedi+c/C3hRf3W5DX6YNJ9q7qmo
         ZB8d76POnkZN0L8kkT8M87lLGn47AFdK5d3HGdusOdE1DS+msP01SA5OoMg2ANzF1I
         aOCyai9kS4x/Q==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id D73635AD7;
        Sun, 30 Sep 2018 23:56:23 -0700 (PDT)
Received: from AM04WEHTCB.internal.synopsys.com (10.116.16.192) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Sun, 30 Sep 2018 23:56:23 -0700
Received: from AM04WEMBXB.internal.synopsys.com ([fe80::1006:bcdd:1b7:579b])
 by am04wehtcb.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Mon,
 1 Oct 2018 10:56:20 +0400
From:   Artur Petrosyan <arthur.petrosyan@synopsys.com>
To:     John Stultz <john.stultz@linaro.org>,
        Artur Petrosyan <arthur.petrosyan@synopsys.com>
CC:     Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        lkml <linux-kernel@vger.kernel.org>,
        John Youn <John.Youn@synopsys.com>,
        "Felipe Balbi" <felipe.balbi@linux.intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH] usb: dwc2: Fix HiKey regression caused by power_down
 feature
Thread-Topic: [PATCH] usb: dwc2: Fix HiKey regression caused by power_down
 feature
Thread-Index: AQHT7ws4O+8B/axYs0CeMD+6l4m0jQ==
Date:   Mon, 1 Oct 2018 06:56:20 +0000
Message-ID: <3AD91E696667BF4BA728303C178E8A63532B89A4@am04wembxb.internal.synopsys.com>
References: <1526690943-8211-1-git-send-email-john.stultz@linaro.org>
 <410670D7E743164D87FA6160E7907A5601313531E1@am04wembxa.internal.synopsys.com>
 <CALAqxLVZXs97sryfPaGY5Gq50-FZROgaBADNXXadcyiNhP3EPQ@mail.gmail.com>
 <410670D7E743164D87FA6160E7907A560131356C4E@am04wembxa.internal.synopsys.com>
 <CALAqxLU3sWrgPjFqZ2vK0m8wVThtE1hDsbNq9zRC7ritzyNHmQ@mail.gmail.com>
 <3AD91E696667BF4BA728303C178E8A63532AAF6D@am04wembxb.internal.synopsys.com>
 <CALAqxLXKOG8fxtrDaRLDGhJUfD1-4qc5QU60+ZmB3+9LsW69Lg@mail.gmail.com>
 <3AD91E696667BF4BA728303C178E8A63532AB36A@am04wembxb.internal.synopsys.com>
 <CALAqxLXy0YXNLwFQEUZxSsjFKC9boVcGkt+50XwmVfwKCcqsEw@mail.gmail.com>
 <3AD91E696667BF4BA728303C178E8A63532AB5E5@am04wembxb.internal.synopsys.com>
 <CALAqxLW=jT+oUASGKxcFghfHZEU7LtFJBiBBkmMM1oarKjSBKw@mail.gmail.com>
 <3AD91E696667BF4BA728303C178E8A63532AB864@am04wembxb.internal.synopsys.com>
 <CALAqxLWOBFO_CjfBFNwbC+qNjtK=TgYrPusb4r5-dThBD5bVnw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.116.70.210]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,=0A=
=0A=
On 9/28/2018 22:30, John Stultz wrote:=0A=
> On Tue, Sep 25, 2018 at 11:02 PM, Artur Petrosyan =0A=
> <arthur.petrosyan@synopsys.com <mailto:arthur.petrosyan@synopsys.com>> =
=0A=
> wrote:=0A=
>  > On 9/25/2018 21:59, John Stultz wrote:=0A=
>  >> On Tue, Sep 25, 2018 at 3:04 AM, Artur Petrosyan=0A=
>  >> <arthur.petrosyan@synopsys.com =0A=
> <mailto:arthur.petrosyan@synopsys.com>> wrote:=0A=
>  >>> Just a clarification by this commit "[PATCH] usb: dwc2: Fix HiKey=0A=
>  >>> regression caused by power_down feature"=0A=
>  >>> =0A=
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__marc.info_-3Fl-3Dl=
inux-2Dusb-26m-3D152669095513248-26w-3D2&d=3DDwIBaQ&c=3DDPL6_X_6JkXFx7AXWqB=
0tg&r=3D9hPBFKCJ_nBjJhGVrrlYOeOQjP_HlVzYqrC_D7niMJI&m=3D0lMkv7adFVwkzyaUzD6=
-pUG0iwg4fd6b1-aHQgbqvSI&s=3Dm8SZvo3J_Za08sMbo-S9EkhoA06YnzEN-SRm-uTPnbg&e=
=3D=0A=
>  >>>=0A=
>  >>> the power_down is disabled setting "p->power_down =3D false;" in=0A=
>  >>> "dwc2_set_his_params" function.=0A=
>  >>>=0A=
>  >>> Could you please clarify that the testes done for those 3 patches we=
re=0A=
>  >>> done enabling "p->power_down =3D true;" in "dwc2_set_his_params" =0A=
> function.=0A=
>  >>=0A=
>  >> So if I remove the "power_down =3D true" initialization, USB does not=
=0A=
>  >> seem to function.=0A=
>  >>=0A=
>  >> If I boot w/ the gadget port removed, the USB host ports do work, but=
=0A=
>  >> plugging in the gadget cable results in a bunch of:=0A=
>  >> =A0 =A0 dwc2 f72c0000.usb: Waiting for Host Mode, Mode=3DPeripheral=
=0A=
>  >> messages.=0A=
>  >>=0A=
>  >> If I boot w/ the gadget port plugged in, USB gadget mode doesn't seem=
=0A=
>  >> to function at all, and when I remove the gadget cable nothing=0A=
>  >> happens, it doesn't switch to host mode.=0A=
>  >>=0A=
>  >=0A=
>  > Could you please send the dmesg logs for those situations?=0A=
> =0A=
> Attached with some annotations in the log.=0A=
> =0A=
>  > Also, please specify the version of the kernel that the testes has bee=
n=0A=
>  > done on.=0A=
> =0A=
> This was done utilizing my dev/hikey-mainline-WIP branch here:=0A=
> https://git.linaro.org/people/john.stultz/android-dev.git/log/?h=3Ddev/hi=
key-mainline-WIP =0A=
> <https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git.linaro.org_pe=
ople_john.stultz_android-2Ddev.git_log_-3Fh-3Ddev_hikey-2Dmainline-2DWIP&d=
=3DDwMFaQ&c=3DDPL6_X_6JkXFx7AXWqB0tg&r=3D9hPBFKCJ_nBjJhGVrrlYOeOQjP_HlVzYqr=
C_D7niMJI&m=3DNziBHu0F0eefQE7CehTMAHF9RnbfSzfHeSOy5MUMv_o&s=3DMzQmTF47Ved3Q=
e2vhL66-hyxWyLUwcC5kK7BhZjxRvI&e=3D>=0A=
> =0A=
> which is 4.19.0-rc5 based + your 3 patches + removing the "p->power_down =
=0A=
> =3D true" line.=0A=
> =0A=
> Though the changes in my tree are mainly for getting Android up and =0A=
> running and not related to USB.=0A=
> =0A=
> thanks=0A=
> -john=0A=
=0A=
Looking through the dmesg log you have provided, It seems that the debug =
=0A=
is disabled.=0A=
Could you please provide log with debug enabled configuration. So that =0A=
we can see more about the described problem.=0A=
=0A=
Also, the register dump could be really helpful for us. Please provide =0A=
it too.=0A=
=0A=
Regards,=0A=
Artur=0A=
