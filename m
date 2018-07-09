Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE86C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36016208A5
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="ngFrF1fG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36016208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934037AbeGIR5y (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 13:57:54 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40450 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933676AbeGIR5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 13:57:52 -0400
Received: by mail-ed1-f67.google.com with SMTP id e19-v6so14587317edq.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 10:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=10smi3kQOMsHu1AfTUpL6Uww2PcVPptjnx4WIf/sqBA=;
        b=ngFrF1fG8rIOQNDccVmyIkhVkevaJHHpow64MFP3B5bJYfSODcJevoiQ7L9WS99kH3
         QUvhcIzBa0MOYSPyvyTPAcdhY8NpB3AusTmeifOnTJ51RQyAfawb7Xgz38OZtHYFKy2H
         M0SEOik0WYVOH4AX5Nvhn9DMw8HzyeZksM8mm9yYpiXxVjGyc53PrzBBogAO0sZJguEO
         RBDm0EslfuJ9lQxB2POL9ulmxA9xUlv1gVPLVsWOdbZqtHthI16xvJEi/3tmuPP+0BnF
         AmFLkow6JkSZ6Vb9SfV412dyiUZIGaXecOKSTMifr4h5tGyVFJDh6eJ8dZFPo2M5UrwM
         BLLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=10smi3kQOMsHu1AfTUpL6Uww2PcVPptjnx4WIf/sqBA=;
        b=fp+5g1++QsVFpxa0fjcSFUr9/xbP+KTPOwnMAOJNqpbeW6MlmWMZEOccW7vGN/v9fX
         7uqRp+ym6C8Ngfv4D75A5kCJMjvxmIUgwaDQ5fXQcGs63EKD+9M1yaseqc7LENKJl5KH
         ZlhMY/NsDrRLyt69zbH/LK2mGNOg47Vc2kCivTKMnyU4nQG3RMC6QKUB7WVs8M5Dgdjb
         E9GLGDdqAafl4k1IYnCMuZiJYwCI8Du+uft1IJ1RW/yAeH2bCTK3+iT8EqnUEKdhgpTS
         I9V3LWUIFcABeGDkWLJrw7jWpWHwD7NiAuPJA2mtE4rUFEhbmA1pb8Fep3kEyCIdRG+u
         oTTw==
X-Gm-Message-State: APt69E38lOijWcYNdQZKyR2RlsR7vLcqY/UJvEJnN6w1Z549ogkqb1pJ
        aLTpm+5kRTsgdmMv4BL7OLilKw==
X-Google-Smtp-Source: AAOMgpfNOEtqNHU5HcFwUN4y3mWVw4nxejN/fTXPsrCgt6AlkeVFS+qeBhEItgApZJsj3UsFpc5ucg==
X-Received: by 2002:aa7:c396:: with SMTP id k22-v6mr23677102edq.149.1531159071606;
        Mon, 09 Jul 2018 10:57:51 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id p20-v6sm1442371edr.12.2018.07.09.10.57.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 10:57:50 -0700 (PDT)
Message-ID: <1531159069.3205.63.camel@arista.com>
Subject: Re: [RFC 0/3] iommu/iova: Unsafe locking in find_iova()
From:   Dmitry Safonov <dima@arista.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org,
        Dmitry Safonov <0x7f454c46@gmail.com>
Date:   Mon, 09 Jul 2018 18:57:49 +0100
In-Reply-To: <20180706151321.sq25kc7otgjo3xvn@8bytes.org>
References: <20180621180823.805-1-dima@arista.com>
         <20180706131611.h3w2kdinmjguikgo@8bytes.org>
         <1530886247.3205.53.camel@arista.com>
         <20180706151321.sq25kc7otgjo3xvn@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-07-06 at 17:13 +0200, Joerg Roedel wrote:
> On Fri, Jul 06, 2018 at 03:10:47PM +0100, Dmitry Safonov wrote:
> > Yes, as far as I can see, there are code-paths which may try to
> > handle
> > it at the same time:
> > o memory notifiers for hot-unplug (intel-iommu.c)
> > o drivers unloading calls free_iova(), which in the result calls
> >   find_iova()
> > o I see at least one driver that frees iova during it's normal work
> >   too: scif_rma.c:scif_free_window_offset()
> 
> Yeah, but the IOVAs freed in the memory notifiers are just the ones
> for
> the direct-mapped RMRR regions requested by firmware, not the IOVAs
> allocated by any driver, so I think this shouldn't be a problem.

Ok, than drop it, please.
I thought that safer API + nice diffstat can justify the change, but
whatever %)

-- 
Thanks,
             Dmitry
