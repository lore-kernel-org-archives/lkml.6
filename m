Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165D0C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B92822075E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oadeDw9/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B92822075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbeIDV1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 17:27:46 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46296 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbeIDV1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 17:27:46 -0400
Received: by mail-lj1-f193.google.com with SMTP id 203-v6so3742269ljj.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 10:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kVAjU5IMlwNqPHvnaLe47Alenb3CkPbmv98STyRxr0U=;
        b=oadeDw9/vLsK8aF2Wew2j6umCrqrHLttnRc0bM4QPlh8tG6EGXfZX2SXbvnTLNm0Uu
         f4X2TBGzTh9PjCfh+X5OZENUu3FQQtjQ3H6z1i7fCzMMQYrIbLCXj1wEZrk84dRzUz0Y
         PP1dsIZV1P5pVeQ2Q978gPcXpOttbfgTxKbD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kVAjU5IMlwNqPHvnaLe47Alenb3CkPbmv98STyRxr0U=;
        b=K0NoLF13LU6So0/DpD7S5Sy5dh+88U6OhjYy6lRxeUHwRoHFNFBLKMh26AHBZugQ4I
         5qFikncghedy3K6fwkfY2xfPOUBAB8DCJ4RXkStUV0FMBVWr3r3ZkYDWdzaQc3u/QXMO
         jWuVyxYMBLpkbJ+kBObyC0QkrW51Jx6kSgVSWTr8Stm5owsvYikl24fRW9C/uuPE8LIy
         /wkrXRpRX1NgcNvANH4BDDznJ03aqGYfEc87OW8EUruSHqtdYTV7vi6LAHs6B7RVFwhl
         ZFUXA4O/4LTZi0E+wl4puFA7Aug2nSAso4lsQWqf2n3obxlhfnFEJ2O+Qo8wWOtPApFR
         tlKQ==
X-Gm-Message-State: APzg51Bbmg6iHfBdthy0+OwcdY+ST6K2tKt1iORAlYjTx61iNqtUimrL
        0iY59ix9P3CaFHCsngdyrRE8f/6qPhc=
X-Google-Smtp-Source: ANB0VdbI4cyCwaoF8S9cj0s8Wkhz9hxwC3/e0r7pmBHN5866oLEzVhj903DWaAfMreNiTq7Ue7ha7g==
X-Received: by 2002:a2e:888d:: with SMTP id k13-v6mr21078554lji.38.1536080503841;
        Tue, 04 Sep 2018 10:01:43 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id g30-v6sm4266666lfi.84.2018.09.04.10.01.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 10:01:42 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id p6-v6so3787635ljc.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 10:01:42 -0700 (PDT)
X-Received: by 2002:a2e:954e:: with SMTP id t14-v6mr20823469ljh.68.1536080502249;
 Tue, 04 Sep 2018 10:01:42 -0700 (PDT)
MIME-Version: 1.0
References: <20180810235010.6004-1-evgreen@chromium.org>
In-Reply-To: <20180810235010.6004-1-evgreen@chromium.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 4 Sep 2018 10:01:05 -0700
X-Gmail-Original-Message-ID: <CAE=gft7zk-wkKEqFAF+O-HQRGRhD_pgiS0d_HraGFyK8Ac78bQ@mail.gmail.com>
Message-ID: <CAE=gft7zk-wkKEqFAF+O-HQRGRhD_pgiS0d_HraGFyK8Ac78bQ@mail.gmail.com>
Subject: Re: [PATCH] scsi: ufs: Enable bInitPowerMode of sleep
To:     Vinayak Holikatti <vinholikatti@gmail.com>,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, Stanislav.Nijnikov@wdc.com
Cc:     Gwendal Grignou <gwendal@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 4:50 PM Evan Green <evgreen@chromium.org> wrote:
>
> UFS devices can be provisioned to have an initial power mode of either
> active or sleep. If the initial power mode is sleep, then the host
> controller driver must send a START STOP UNIT to the device in order
> to wake it up. Unfortunately, the device will refuse to complete other
> common low level operations, such as reading descriptors and attributes.
> The Linux driver currently fails to enumerate devices that start in
> sleep mode, because it fails to read the device descriptor from the
> unconscious device.
>
> The way the UFS controller driver is structured, this presents a bit of
> a Catch-22. In order to perform low-level enumeration of the device, the
> driver needs to send a SCSI command. But SCSI needs low-level enumeration
> of the device to be complete before full enumeration can occur.
>
> This change adds a method for sending low-level SCSI commands, modeled
> after (and reusing much of) the mechanism for sending device management
> commands. With this primitive, ufshcd_probe_hba can execute REQUEST SENSE
> to clear the Unit Attention, and then a START STOP UNIT in order to bring
> the device out of sleep mode. Only after this is done can the rest of
> enumeration, such as reading the device descriptor and geometry descriptor,
> be done.
>
> Signed-off-by: Evan Green <evgreen@chromium.org>

A very gentle bump, did anyone get a chance to take a look at this?
Currently Linux can't enumerate UFS devices that start in Sleep mode.
