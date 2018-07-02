Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8176CC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A39D25EAB
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdwRWVyv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A39D25EAB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752697AbeGBOsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 10:48:24 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:35091 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751878AbeGBOsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 10:48:19 -0400
Received: by mail-yb0-f195.google.com with SMTP id x15-v6so5188928ybm.2;
        Mon, 02 Jul 2018 07:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=quxoMmfFN2lidKOEcGdap78KNDTcVSPPLlWZjSOOcl4=;
        b=OdwRWVyvDh03EsbuOIq7og0jkJa3D4BphwBEqDmGjI+3Yfd6NfemtNn3qzyMbI85tO
         rk0VkZW7hauxZKMgzPPG7rm6XdOnOJ/2vC76VQ6wkxiJF6smxDrbj/iId9TtJFAh/Kk9
         cVD18qeho8vhjhEN4GGf5f/8GVH9ugopL3NRDNm0yYUhpNl1EY21RXv9MCJ4jqjSAD0t
         qDFwQkPkfv/bL3j/Rm0/ZS8jchbN54G7zv69ef6UcLe7G9RQBq63ob73FESINHruIqY3
         CeLSKjj3EOxIvzBDCHLHcolE22cO/W5t4N/jLpDV9QzUOvwIbWypaFs4W93T4z1QZtKM
         eNNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=quxoMmfFN2lidKOEcGdap78KNDTcVSPPLlWZjSOOcl4=;
        b=MbebsBJ6Zz1UhwsFhyBlMteXVQijVC6u1PqXBqUW9tCGTHEc4uIu05+yYI22DSU+en
         mLafxiqX/qvCPpT6ZmXLqDTtQtGnMOPNRvvHxSqSESjhzDbQNu/aPaP2okJOH7lUL4QH
         AVVuIapZJOC9mWmrh8hPu1ge8vadjjrj42SSmWajz+4ie7OWf/3L2NbqIVFd1yhA4w3X
         /W8biLN+0cb7vSi8vzAOwi02c5SA6MTFg5kDKPS5/eSIE+U3idb2KJnHDg/O4lq5adId
         SsFzm2pj2F7RSuwUB/FUzWzZj+7sDvIHAc4ZooMo7ERiOXFSf4jXSRvz0d0l4pvfiTzB
         B2Qw==
X-Gm-Message-State: APt69E3iM10C2SNiHh/qxILXNy3EDU3jaS9a8LbqaM9ki6hYPF8r3DRd
        vf2k31SPPoULmkLdzapduiU=
X-Google-Smtp-Source: ADUXVKL1WEuPof98PbzTVB+57wsVYDPkkZe8rXBSPkPeIbaa++DSK0gyT1ieSlj8J8AgNtEV9bBeBg==
X-Received: by 2002:a25:4103:: with SMTP id o3-v6mr12933090yba.48.1530542899096;
        Mon, 02 Jul 2018 07:48:19 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2b6f])
        by smtp.gmail.com with ESMTPSA id s6-v6sm916451ywl.37.2018.07.02.07.48.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 07:48:18 -0700 (PDT)
Date:   Mon, 2 Jul 2018 07:48:16 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     linux-ide@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sata_nv: remove redundant pointers sdev0 and sdev1
Message-ID: <20180702144816.GA533219@devbig577.frc2.facebook.com>
References: <20180702073022.10000-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180702073022.10000-1-colin.king@canonical.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 08:30:22AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Pointers sdev0 and sdev1 are being assigned but are never used hence they
> are redundant and can be removed.
> 
> Cleans up clang warnings:
> warning: variable 'sdev0' set but not used [-Wunused-but-set-variable]
> warning: variable 'sdev1' set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied to libata/for-4.18-fixes.

Thanks.

-- 
tejun
