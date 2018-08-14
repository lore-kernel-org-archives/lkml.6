Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E99CC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE67C2173A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qT+MkzHy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE67C2173A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732430AbeHNRBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 13:01:43 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:53664 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728458AbeHNRBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 13:01:43 -0400
Received: by mail-it0-f54.google.com with SMTP id 72-v6so18319573itw.3;
        Tue, 14 Aug 2018 07:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=I38SMJ8D2/ZA/3AOgjDNDHPhHHHfxwg2Uo77DDqSlr4=;
        b=qT+MkzHyn0O9pJz6XuxLDFd/EWdWb2CtIeR/rJ6EvPEaOWJ5Y7EjxyPEONdxiXzyYW
         WBzUO41YEEg09akfuon5QAGJwqy6JYEU8L9JuDBOoBEmr8AvRLAgR/GLcuegLFJvyFAV
         RfKhFVqwUqtpIfintg4ai+v66ObndlOVFlJHYJRjXJPW0fmNhb15dVblCTXR+4GxCI6T
         3JG2TSimd4zS9znZ0FqVC4CXFootkr9X+dm9gX23ehjpPnpDYN2bjHt1VeqiWflI+jNX
         c3rtiOhwE7A7vjirkHg1Q06GWaAnpDJjr8UxBAzPEuiLpVw9lAVjXyjKwmHXctqweHGJ
         O39Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=I38SMJ8D2/ZA/3AOgjDNDHPhHHHfxwg2Uo77DDqSlr4=;
        b=W10wkrb1ZEIguNAPHCRf0CY5BaIFQ9X+OOi1aVeF9SNrMKxpme14NIPTQIwpioSYhe
         SykJcULBZAL+M/UHZH8v9SKd7qRx5GdrVr37JchzJ3iYtlEiFlxKsT4PjyhX03I4Se1I
         qC6QY7Oyox+fMKb5J6oXoC0h2W21LCvNMuPJzb2njc7QiTySliw1P6Vg/Z5aP+EfzmaA
         H9nUTEZQJ9LMtzPm03HKhjVGSs0+cp3oIwk60KzBJWArEIV3g2GfoNDS2p0KTP6f+5D+
         l8MrRDbMklxlOMgwrv/KRa21+TaK5QbC6PZltmLMXRCXlUQAcQcjWuaM9N7AMexYad1E
         trXw==
X-Gm-Message-State: AOUpUlFEhRoBHnLK9aPF335jpG2Um8THIk3zXblbIWgvusKLC/xJbo1w
        v2n4/Zz2CyWWwOz6BvPAbmFxE5HgnkSbQAOmLmI=
X-Google-Smtp-Source: AA+uWPx+no4U6IwGsX7hC4OwrdRQd6Jh1eoUJlFcJrRMbPKydwIKg6o1jQcYAf2WFs0t6hdsg9oPUqhclmuLZDHxW10=
X-Received: by 2002:a24:36c5:: with SMTP id l188-v6mr14107796itl.125.1534256061121;
 Tue, 14 Aug 2018 07:14:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:aa09:0:0:0:0:0 with HTTP; Tue, 14 Aug 2018 07:14:00
 -0700 (PDT)
In-Reply-To: <CALeDE9ORLoyiUcf8Bmwr2rPyo7-3d8Fo54WuPGWtv4ByE_JG=Q@mail.gmail.com>
References: <20180807212531.25161.63476@mailman01.phx2.fedoraproject.org> <CALeDE9ORLoyiUcf8Bmwr2rPyo7-3d8Fo54WuPGWtv4ByE_JG=Q@mail.gmail.com>
From:   Andrew Lutomirski <luto@kernel.org>
Date:   Tue, 14 Aug 2018 07:14:00 -0700
X-Google-Sender-Auth: niIYM9ZParOIs0szxcER3gK4_34
Message-ID: <CAObL_7GOOQ01NPf4y1MqRJh4S=CYV8NPmEGTbkrTcjrfUKc5LA@mail.gmail.com>
Subject: Re: Kernel lockdown patch & IPAddressAllow/IPAddressDeny systemd
 feature with Secure Boot
To:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>, ast@kernel.org,
        Laura Abbott <labbott@fedoraproject.org>,
        linux-kernel@vger.kernel.org, Linux API <linux-api@vger.kernel.org>
Cc:     Kernel Fedora <kernel@lists.fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Removed Fedora devel list because it's subscriber-only]

> On Aug 8, 2018, at 12:29 AM, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> Probably a good idea to cc: this to the kernel list :-)
>
> I suspect it's intentional but with the planned changes for iptables
> etc to be backed by bpf in the upstream kernel sometime in the future
> it's likely going to need to be reviewed.
>

I thought this got covered in review. I think this part of lockdown
needs to get reverted or fixed ASAP.

(I definitely brought up multiple issues with the bpf lockdown stuff.
It's clearly extremely broken right now in the "new kernel breaks
*current* Linux distro" sense.)

> Peter
>
>> On Tue, Aug 7, 2018 at 10:25 PM, Timoth=C3=A9e Ravier <tim@siosm.fr> wro=
te:
>> Booting Fedora with Secure Boot enabled will result in Lockdown being en=
abled at boot time. This will completly disable the BPF system call for all=
 users [1][2].
>>
>> Unfortunately, this breaks the IPAddressAllow & IPAddressDeny systemd fe=
ature [3][4][5].
>>
>> I don't have a solution for this, but as far as I understand, this will =
also prevent other BPF use-cases (for example: Cilium on Fedora CoreOS).
>>
>> [1] https://src.fedoraproject.org/rpms/kernel/blob/master/f/efi-lockdown=
.patch#_1525
>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/jforbes/linux.git/co=
mmit/?h=3Dlockdown&id=3D0eb0d0851747787f7182b3e9d0d38edb5925a678
>> [3] https://github.com/systemd/systemd/blob/master/src/core/bpf-firewall=
.c
>> [4] https://github.com/systemd/systemd/blob/master/NEWS#L1192
>> [5] https://www.freedesktop.org/software/systemd/man/systemd.resource-co=
ntrol.html#IPAddressAllow=3DADDRESS%5B/PREFIXLENGTH%5D%E2%80%A6
>> _______________________________________________
>> devel mailing list -- devel@lists.fedoraproject.org
>> To unsubscribe send an email to devel-leave@lists.fedoraproject.org
>> Fedora Code of Conduct: https://getfedora.org/code-of-conduct.html
>> List Guidelines: https://fedoraproject.org/wiki/Mailing_list_guidelines
>> List Archives: https://lists.fedoraproject.org/archives/list/devel@lists=
.fedoraproject.org/message/ZMEWJMQH6DDMV3AZ4IG7LOYMMIETCH42/
> _______________________________________________
> devel mailing list -- devel@lists.fedoraproject.org
> To unsubscribe send an email to devel-leave@lists.fedoraproject.org
> Fedora Code of Conduct: https://getfedora.org/code-of-conduct.html
> List Guidelines: https://fedoraproject.org/wiki/Mailing_list_guidelines
> List Archives: https://lists.fedoraproject.org/archives/list/devel@lists.=
fedoraproject.org/message/RUWDEDQHS5I47YBPEZVEKXNU2BAX2SLU/
