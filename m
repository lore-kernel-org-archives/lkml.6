Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE227C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 10:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C55620837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 10:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkFQLMKJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C55620837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbeHaOUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 10:20:03 -0400
Received: from mail-lj1-f178.google.com ([209.85.208.178]:38973 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727512AbeHaOUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 10:20:02 -0400
Received: by mail-lj1-f178.google.com with SMTP id l15-v6so9647307lji.6;
        Fri, 31 Aug 2018 03:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=49zPJ9YA4q1wdqqQiARdluIP/mmUI9jn9M1Kciae/hI=;
        b=ZkFQLMKJh2hbos2OONhk6EqhcrgLSQLeUFqh+Hp1j2NFj1syiLFPxBYsKnygwP8rht
         noroEs45Niun/DYZg5jBNVstVb9phxS3eAVa9G7wH4qKpHQ5KpYR07HXgL7fvQuceOsk
         9MPX/vKcDDEdbOLPjBQ1h6hNEq5NDqF33lSuLs0q6XRUfWi69qXxSU2YzD/Ece6mPwGu
         vcNRfUICYvIFU2Ccyxm8BtnKcLDFwQKnR45vRhE3CRGZevH/4jqufJT7cHR61wgjIHs9
         L3KOkuqXViJdZpZBp0m7QwEMZPQcQh8P1IaZwZENrUy9b8Wj5uaurscOTyxu68mzoRrr
         4bhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=49zPJ9YA4q1wdqqQiARdluIP/mmUI9jn9M1Kciae/hI=;
        b=PD3iM4ZGsJ+mWzdOiculC/yByZ5sqW6Mtu1KgI9N0aU8TQpVDZd3q4XXkQx8qS0pOK
         K9kiyDo19St7JYLoqRD+rvlq8xS2WHcDQ9Q/77wuMW3aVVxCleo5JceEuG1Yv2ZsUGkF
         P3alYS11TkiQy3jEHHE7jeJHloZ9WVrN+5cnR0tbITngQHrlRhLO69fyZzEPCTEwVURR
         okR+bVfXvx5hEIdrO6cy8SLP9u9WCES5nPAbfBdE+P8I76+g9gXshQvjnuMSwy4gbqZU
         WuD650+RO3timDuDnmq/0WfmNf0HYnYT64VmPmr60qevGELq7Cvq669XF5sNvV0PbqkE
         T0bg==
X-Gm-Message-State: APzg51C/nlVIp5f8D5ayyoR4ZzHD2P91EFCrE9TQTVj+t/8RSdffnSNk
        /YRdZXSCjCIk/apdJE8EoKE=
X-Google-Smtp-Source: ANB0Vda2z4Ln9Wn6qaYpFEwT3vc8bFQluwxPfhQ0OaF1LBASCOs2C3JJ/OnSaOPVERNoa1zQk9y9vA==
X-Received: by 2002:a2e:8103:: with SMTP id d3-v6mr1444468ljg.3.1535710394584;
        Fri, 31 Aug 2018 03:13:14 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id m11-v6sm659850lfk.70.2018.08.31.03.13.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 03:13:13 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1fvgQV-0006kE-67; Fri, 31 Aug 2018 12:13:15 +0200
Date:   Fri, 31 Aug 2018 12:13:15 +0200
From:   Johan Hovold <johan@kernel.org>
To:     "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        peter_hong@fintek.com.tw, hpeter+linux_kernel@gmail.com
Subject: Re: [PATCH V2 3/4] serial: f81232: implement break control
Message-ID: <20180831101315.GM28861@localhost>
References: <1535593634-22004-1-git-send-email-hpeter+linux_kernel@gmail.com>
 <1535593634-22004-4-git-send-email-hpeter+linux_kernel@gmail.com>
 <3f4bc3ff-1e72-54ee-1047-c69a0ff45771@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f4bc3ff-1e72-54ee-1047-c69a0ff45771@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 09:55:46AM +0800, Ji-Ze Hong (Peter Hong) wrote:
> Hi Johan,
> 
> This article is duplication with
> [PATCH V2 3/4] USB: serial: f81232: implement break control
> [PATCH V2 3/4] serial: f81232: implement break control
> 	(Title not start with USB token)
> 
> Should I discard this PATCH_V2 series and re-send PATCH_V3 ?
> or could you discard the patch - serial: f81232: implement break control
> only ?

Yes, no problem, so no need to resend. But thanks for highlighting this.

I'll try to look at these next week.

Johan
