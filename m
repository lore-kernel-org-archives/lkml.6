Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CA7C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3706208B2
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHYvm7eL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3706208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbeH0MaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 08:30:01 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36123 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbeH0MaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 08:30:00 -0400
Received: by mail-lj1-f194.google.com with SMTP id v26-v6so7872194ljj.3;
        Mon, 27 Aug 2018 01:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MVwnb6YB2NxrCktoPgmjFjHVGEIc7ASLkQhna90wuPU=;
        b=NHYvm7eLa/qd0SBmJNi/hWFZ4K7tbxZVAbgFQZzWSSyPR4Rvb+LDVWFLDjSywUj1SE
         G/1Fte7CeT7Se6Bl2bG7swiWKQ5SY/agQ8SubIY8qrduazLixJkNgH7XwiHksI1wJHba
         Yu3e33KpJhGlTOnJsSlEQFrPjeAkIhgNMVlmKdO88bZcgEC99nwe1snu8m0v3JMls0O3
         v3OIlKRxbFmSMFyZSbtraeQCADO9r63IyxqJGfCK9XHNWVRUap6AtuaCQq9QIy0rQYzy
         TqNVkMHI7mkMtrpGQAjIXb0ryhSclRiZMRQUXt2FHH8DLC6YVHSLv2zGR8yOKgpVc8rE
         oyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=MVwnb6YB2NxrCktoPgmjFjHVGEIc7ASLkQhna90wuPU=;
        b=XbKsIcynjCApLYaphxuYdjijgMNu6SP1U8cD+Tubf6UfA2Bw+q9BlGqA8Lnl8K7fmO
         kABPiuzaizYd2CYKV9iJz3qdxXwkGCcmgeQANphwN8MPovArJVu9WTSQsGECtwoE9zc6
         GYrM6r5f5CF8lxkeEdnU+BBgYJVsiuHwUvF/ULEpY0kxxWevWoSMbeBuJuWuhfOEDwLA
         VuEVjLrFQlS/HY/HjSNgKYmWr4h1JM0wT4tam+DbzdYyW1/uWQ8foDXCekaky530rfjg
         PkB1MoOEOQxFKsrqsacONEtjJPFOOmnjw+EE0bbdZkC33GVJTilONmYTbzg5h3hlav7w
         wYDw==
X-Gm-Message-State: APzg51DTBVMeeVrMqGQuZhuiDmXdUs3Ind6kLbda5P+HNwTiRHhUHUv6
        TY0sQgOKLR3iPQGkHF9/xJA=
X-Google-Smtp-Source: ANB0VdYkP19iPlGPjqF4EP0g9GCiVdVJqqwI1LZDrsOpjkvv6PJ3kPvVk3CMVtWS4saxi6Q0TuJncg==
X-Received: by 2002:a2e:3c1a:: with SMTP id j26-v6mr7620867lja.149.1535359456787;
        Mon, 27 Aug 2018 01:44:16 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id q15-v6sm2634151ljh.34.2018.08.27.01.44.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 01:44:15 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1fuD8A-0005z5-Rl; Mon, 27 Aug 2018 10:44:14 +0200
Date:   Mon, 27 Aug 2018 10:44:14 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Johan Hovold <johan@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable <stable@vger.kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Josh Wu <rainyfeeling@outlook.com>
Subject: Re: [PATCH v2 5/9] mtd: nand: atmel: fix OF child-node lookup
Message-ID: <20180827084414.GZ14967@localhost>
References: <20180827082153.22537-1-johan@kernel.org>
 <20180827082153.22537-6-johan@kernel.org>
 <20180827102820.3abf7291@bbrezillon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827102820.3abf7291@bbrezillon>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 10:28:20AM +0200, Boris Brezillon wrote:
> Hi Johan
> 
> On Mon, 27 Aug 2018 10:21:49 +0200
> Johan Hovold <johan@kernel.org> wrote:
> 
> > Use the new of_get_compatible_child() helper to lookup the nfc child
> > node instead of using of_find_compatible_node(), which searches the
> > entire tree from a given start node and thus can return an unrelated
> > (i.e. non-child) node.
> > 
> > This also addresses a potential use-after-free (e.g. after probe
> > deferral) as the tree-wide helper drops a reference to its first
> > argument (i.e. the node of the device being probed).
> > 
> > While at it, also fix a related nfc-node reference leak.
> > 
> > Fixes: f88fc122cc34 ("mtd: nand: Cleanup/rework the atmel_nand driver")
> > Cc: stable <stable@vger.kernel.org>     # 4.11
> > Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> > Cc: Josh Wu <rainyfeeling@outlook.com>
> > Cc: Boris Brezillon <boris.brezillon@bootlin.com>
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> 
> Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>

Thanks for the ack.

> I'll let Miquel queue this patch to the nand/next branch, unless you
> want it to be merged in 4.19, in which case I'll queue it to the
> mtd/fixes branch.

Note that there's a dependency on the first patch of the series which
adds the new helper. Rob can pick up the entire series if the various
maintainers agree, otherwise I'll try to get at the least the helper
into -rc2.

I'd prefer getting the use-after-frees fixed in 4.19, but queuing for
4.20 should be fine too.

Thanks,
Johan
