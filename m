Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F272EC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 18:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9647208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 18:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oXkBZrU3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9647208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbeJQCBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 22:01:42 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33383 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbeJQCBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 22:01:42 -0400
Received: by mail-pf1-f195.google.com with SMTP id 78-v6so9470176pfq.0;
        Tue, 16 Oct 2018 11:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=3w6CyTv8A3LV2uwlWQcQZ/oGfCNBUgmBmFsDZ0MJOm4=;
        b=oXkBZrU3zv++Atg6T1jsM/MOUIjRvViZYieFEu/hmwUTxWGwN1ucdt9uYKRtkY8MrF
         +w21khC9jErGiwOPQlpgdw0rZniS24kYnoW9sUoPWPBnkWDs9V8AynTy1MFj0SJvt+Cd
         cLoRlSYZSKy+LltMQwsq8K8LTzu9eBa1cLyM0cEP7TbtACo/OfSEyb20SSMiNrXG5Dlq
         IJCvPUpo8S2CzCaAjuaGU/0htz3VfCwkwlJIB7C87tI1ZJ71OywiyiRi+zoGji7flT4l
         3YGdIVDcBC9H3kuyU7GYs0CJIPI5bmjzlMqLINP39CPfwAAEAIyrY8XxzFMMx/e65Au6
         8ycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=3w6CyTv8A3LV2uwlWQcQZ/oGfCNBUgmBmFsDZ0MJOm4=;
        b=NvHJER5ZAFKfQ86SndGmYZ3iQaO13iwZQrYegrP78HJkmeWfh/sEd1jeV9QUrHHpS+
         MPvj2+g6IVqiEcLVXMhtFk2Sdqn1pdob31zixIFmzBbV+EPACIEMPqKvYyfjWV4VJhCp
         nVNQRF9L8E+SE3fWEare9LIgPxhV5jaGD0ku/isXwDYA7o0YnGxocJh9Wpl9/H4ZlMrY
         edZsfubPM5d9sbyA9YgWQgu91Ib/vwjPUHvELfNCrQapP1pNHWY6T0UNgG62Txa3GGFI
         XIOa/a2GK6s/5soXLxGtohum4isB5SdEOM5+zvse1tA5ydCAILNjHbBuMDziwOz195Ct
         D7aQ==
X-Gm-Message-State: ABuFfoiXWZxVuAamZ1cbvHBO5pirOAQQu9MMDOrVm54FVDQIGYPWiTZG
        ZHZ5oJ6EqpwXbLnHWvrt9Vs=
X-Google-Smtp-Source: ACcGV612lBi0YbxjPB0b1ZdAZkLHMvHJPsJ7d/KYRs0zcPwOFHZSSdyTHgEbrYf5K50K8PvhwTXfFw==
X-Received: by 2002:a63:cc:: with SMTP id 195-v6mr20838138pga.44.1539713403160;
        Tue, 16 Oct 2018 11:10:03 -0700 (PDT)
Received: from ?IPv6:2607:fb90:284c:957e:e0c3:4055:73a1:30a2? ([2607:fb90:284c:957e:e0c3:4055:73a1:30a2])
        by smtp.gmail.com with ESMTPSA id v38-v6sm23762112pgn.57.2018.10.16.11.10.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 11:10:02 -0700 (PDT)
Date:   Tue, 16 Oct 2018 11:09:56 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <ead3e95a-1acb-362a-0ee2-d02dbc4f378c@embeddedor.com>
References: <20181016111313.GA28307@embeddedor.com> <20181016172107.GA230131@dtor-ws> <ead3e95a-1acb-362a-0ee2-d02dbc4f378c@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] Input: uinput - fix Spectre v1 vulnerability
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
CC:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Message-ID: <26EEA6BC-43B0-42F7-A237-572D32EB2309@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On October 16, 2018 10:52:58 AM PDT, "Gustavo A=2E R=2E Silva" <gustavo@emb=
eddedor=2Ecom> wrote:
>Hi Dmitry,
>
>On 10/16/18 7:21 PM, Dmitry Torokhov wrote:
>> Hi Gustavo,
>>=20
>> On Tue, Oct 16, 2018 at 01:13:13PM +0200, Gustavo A=2E R=2E Silva wrote=
:
>>> setup=2Ecode can be indirectly controlled by user-space, hence leading
>to
>>> a potential exploitation of the Spectre variant 1 vulnerability=2E
>>>
>>> This issue was detected with the help of Smatch:
>>>
>>> drivers/input/misc/uinput=2Ec:512 uinput_abs_setup() warn: potential
>>> spectre issue 'dev->absinfo' [w] (local cap)
>>>
>>> Fix this by sanitizing setup=2Ecode before using it to index
>dev->absinfo=2E
>>=20
>> So we are saying that attacker, by repeatedly calling ioctl(=2E=2E=2E,
>> UI_ABS_SETUP, =2E=2E=2E) will be able to poison branch predictor and
>discover
>> another program or kernel secrets? But uinput is a privileged
>interface
>> open to root only, as it allows injecting arbitrary keystrokes into
>the
>> kernel=2E And since only root can use uinput, meh?
>>=20
>
>Oh I see=2E=2E=2E in that case this is a false positive=2E
>
>Although, I wonder if all these operations are only accessible to root:
>
>static const struct file_operations uinput_fops =3D {
>        =2Eowner          =3D THIS_MODULE,
>        =2Eopen           =3D uinput_open,
>        =2Erelease        =3D uinput_release,
>        =2Eread           =3D uinput_read,
>        =2Ewrite          =3D uinput_write,
>        =2Epoll           =3D uinput_poll,
>        =2Eunlocked_ioctl =3D uinput_ioctl,
>#ifdef CONFIG_COMPAT
>        =2Ecompat_ioctl   =3D uinput_compat_ioctl,
>#endif
>        =2Ellseek         =3D no_llseek,
>};

/dev/uinput must be 0600, or accessible to equally privileged user, or you=
'll be opening your system to much mischief=2E


Thanks=2E

--=20
Dmitry
