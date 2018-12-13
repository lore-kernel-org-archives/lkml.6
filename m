Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE28FC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 21:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61C6120811
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 21:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tSA+Rc+B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61C6120811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbeLMVxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 16:53:15 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45822 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbeLMVxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 16:53:14 -0500
Received: by mail-pf1-f195.google.com with SMTP id g62so1733230pfd.12;
        Thu, 13 Dec 2018 13:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l+XaacF6pcfIwa5UH45hGJNh3br2qCONULeyN+S4+9I=;
        b=tSA+Rc+BjXUOmTioNtqVDLe7wMFcOBT1LT/SSeQ9zuy3aVGeyGFgloXCaeakQeTwxo
         RreSQpVvxx/Ve8Bew9G7BMTFgC7eZ3q4mTmwKFOQ+R0lKqVPU6S6VA8u47x9+9LmfUlN
         mHC9HERpakHBz2nQNa7ZJzgqPymcCeZxeq18Xeo/s7FeVXM5jiaFmpOGNPYtyDhcVYDc
         MfIhvM4USt57ZOIkyqqsmoa5YcUpxV4YGp0/ut7o4ALtH+OO3Cc/WfjxJRTC5et2hPIm
         eqIirFtNuoaDpYLu1MMoajDVisfu08H06fp42/zoaTmqL1A3qMpnSHW+Wjj3X4NlO478
         7dKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l+XaacF6pcfIwa5UH45hGJNh3br2qCONULeyN+S4+9I=;
        b=HBK8rjmW3HgcJZSmHG+98vc66Nl0ysBFmY+4w6j7jSw1UDmExje/mEE5FQlUdAc33W
         9XM/LwPHZCtYt8RQLQ9c6EWJfv+fSb4UdGbpSwF3buALA8G+EV85FHEV+wH2aYqrRjXT
         i9RMANbN8A1FK0Ka6MVX92eyKXz9epEYFHvoMH+z3Fu3IX1D/tI4114DBHeQskOAVTGA
         68wignuehZktWItiDX7ldx8Z14Z20F/w5DNDFovJ5o2n5YgjgWbAWWQzWpSb2hWkpoG+
         RJn9h2OkmbHqe7njYpF5dn69ACjLADGmhtWtW7rIt3oBFeVsWx2mWP20TeweXwqNMuar
         J4hA==
X-Gm-Message-State: AA+aEWYAigVJRZRdoJ9ya8vWs4+x0RuXYFju/cSFt+1WiXTWGr44u+Ft
        5z5hE1kzzGdUa0OTNkTpXtc=
X-Google-Smtp-Source: AFSGD/XUulhFv2yikKgjJwIuPEtpggjVEWgedWf2vXqK6GW2Dl25tkt4V5W9tnwJxkWcAqxUxaCymw==
X-Received: by 2002:a63:3c58:: with SMTP id i24mr451883pgn.284.1544737993959;
        Thu, 13 Dec 2018 13:53:13 -0800 (PST)
Received: from xldev-tmpl.dev.purestorage.com ([192.30.188.252])
        by smtp.gmail.com with ESMTPSA id m85sm4263751pfj.171.2018.12.13.13.53.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 13 Dec 2018 13:53:13 -0800 (PST)
Date:   Thu, 13 Dec 2018 14:53:11 -0700
From:   Anatoliy Glagolev <glagolig@gmail.com>
To:     aglagolev@purestorage.com, adailey@purestorage.com,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com, hch@lst.de,
        qla2xxx-upstream@qlogic.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: qla2xxx: deadlock by configfs_depend_item
Message-ID: <20181213215310.GA29430@xldev-tmpl.dev.purestorage.com>
References: <1544140125-3060-1-git-send-email-glagolig@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544140125-3060-1-git-send-email-glagolig@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any thoughts on this change?

Thanks.

