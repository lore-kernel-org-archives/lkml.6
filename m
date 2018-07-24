Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5B8C28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 21:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85FB220685
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 21:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DJyheRvV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85FB220685
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388753AbeGXW5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 18:57:05 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:32838 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388491AbeGXW5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 18:57:04 -0400
Received: by mail-yw0-f194.google.com with SMTP id c135-v6so2127158ywa.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 14:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OvTV887pi6zaPuLasFfm1L9vmPFsgL+sWquokboB8v8=;
        b=DJyheRvVbrHScoCYgn0nLyxW5aXyToAvFeka5j7aWUFD5lbbGmMkqaZ+sI+vO0gXqM
         ci9ADVYOMKdafyxS6vugM2EcRw5Phf16zN5isoa6kdlMFFYCoFqo9nNIkUdRpDxdwNGk
         NeyvLe8UvFPixopUjudWGg+AMMVbnI8P1P7OU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OvTV887pi6zaPuLasFfm1L9vmPFsgL+sWquokboB8v8=;
        b=lezE65JWRblmP+wF7eHTtL1BkveTQ/29m7x1hxX+Lm+LWQur8gq8tBVlyrQR6glmox
         rrNEBWx84cq/kPMzReCaqkwk9L/IB9138CDbwfEDh777JttHmirx0JYVqsYRcn7Fb3SY
         WodTvilnBy/gthZzD5GvfHRtuaE3xpX2mH+2xAUAdvwOonX+aeyHK3wXU3ItdvXV4agf
         Ol9diBoeq/Nmdi1+wkyEcGvpKW/9A98H6n+dMf1cm/lR0Jco8u6nFitDFbU5eLoxfP8P
         MQoB6fekMn05B2Xuz17SOHGotvB+XRF/RZkalFw8OP+/8GQBOwq+SSR0AD3n6CdTdzYl
         khUg==
X-Gm-Message-State: AOUpUlEg6QjHK7J+3XFbG7Pi6ePRt7u5xlsw22czIbVD+eF6o+qvcAKt
        kWevXSUL16hphnLkX/Y9yXHsgtiRgGY/glFOOWbqHQ==
X-Google-Smtp-Source: AAOMgpc8hQk26nqO0wthNwNlGQZvTqlbOrgtCe3b8zzTbgcI/eEYKsjq65LTkT53Un3dlsu9iPBI4Fvs10Ab8Hcq9oU=
X-Received: by 2002:a81:7cc5:: with SMTP id x188-v6mr9994043ywc.358.1532468915528;
 Tue, 24 Jul 2018 14:48:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e716:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 14:48:34
 -0700 (PDT)
In-Reply-To: <CAACQVJrS9_fCNG3g51q7kZnTt5wy1X-SrvXTsFq=zqZEUvVS5Q@mail.gmail.com>
References: <20180724052454.21524-1-yuehaibing@huawei.com> <CACKFLini64_5N7aVtPAVH3CBYCSsdHAJv35jimR18PJXeV6j5g@mail.gmail.com>
 <CAACQVJrS9_fCNG3g51q7kZnTt5wy1X-SrvXTsFq=zqZEUvVS5Q@mail.gmail.com>
From:   Michael Chan <michael.chan@broadcom.com>
Date:   Tue, 24 Jul 2018 14:48:34 -0700
Message-ID: <CACKFLinjTEnma79YtNG3UVqfc+gzRxXoMttY0tMfSTSPRx8ZyQ@mail.gmail.com>
Subject: Re: [PATCH net-next] bnxt_en: Fix logic of forward the VF MAC address
 to PF in bnxt_vf_validate_set_mac
To:     Vasundhara Volam <vasundhara-v.volam@broadcom.com>
Cc:     YueHaibing <yuehaibing@huawei.com>,
        David Miller <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 9:01 AM, Vasundhara Volam
<vasundhara-v.volam@broadcom.com> wrote:
> On Tue, Jul 24, 2018 at 1:01 PM, Michael Chan <michael.chan@broadcom.com> wrote:
>>
>> On Mon, Jul 23, 2018 at 10:24 PM, YueHaibing <yuehaibing@huawei.com> wrote:
>> > Based on the comments,req->l2addr must match the VF MAC address
>> > if firmware spec >= 1.2.2, mac_ok can be true.
>> >
>> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> > ---
>> >  drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c | 7 ++-----
>> >  1 file changed, 2 insertions(+), 5 deletions(-)
>> >
>> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
>> > index a649108..7925964 100644
>> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
>> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
>> > @@ -954,12 +954,9 @@ static int bnxt_vf_validate_set_mac(struct bnxt *bp, struct bnxt_vf_info *vf)
>> >                 if (ether_addr_equal((const u8 *)req->l2_addr, vf->mac_addr))
>> >                         mac_ok = true;
>> >         } else if (is_valid_ether_addr(vf->vf_mac_addr)) {
>> > -               if (ether_addr_equal((const u8 *)req->l2_addr, vf->vf_mac_addr))
>> > +               if (ether_addr_equal((const u8 *)req->l2_addr, vf->vf_mac_addr) &&
>> > +                   bp->hwrm_spec_code >= 0x10202)
>> >                         mac_ok = true;
>>
>> I'm not sure if this is correct.  If firmware spec < 0x10202, the VF
>> MAC address is not forwarded to the PF and so it doesn't have to match
>> and mac_ok should still be true.  I think we are missing that
>> condition with this patch.
>>
>> I need to let my colleague Vasundhara comment on this.  She is more
>> familiar with this logic.
> Yes Michael, you are right. Also, the plain else condition is to cover
> a special case to allow VF to modify
> it's own MAC when PF has not assigned a valid MAC address and HWRM
> spec code > 0x10202.

We should combine the "else if" and "else" below into a plain else and
add some comments to explain the conditions.

>>
>> > -       } else if (bp->hwrm_spec_code < 0x10202) {
>> > -               mac_ok = true;
>> > -       } else {
>> > -               mac_ok = true;
>> >         }
>> >         if (mac_ok)
>> >                 return bnxt_hwrm_exec_fwd_resp(bp, vf, msg_size);
>> > --
>> > 2.7.0
>> >
>> >
