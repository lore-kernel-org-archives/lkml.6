Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00534C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEE1F2070D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549959993;
	bh=q/MieP8cnsIanHpiUUhtp80wp54Bpb9UtsV3iwbylO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qDH1QQRezxYg7MxdZlr2W/pFEBdGP/5sHJbltEWC9LawDjpudlxmL+5Odt14BtRa8
	 7fHquoM8dRarMiYiaQy4q3TfpSeCPCXw/lgchbvNRiXSA0T8d8wTfefXtY7N7QFfOo
	 swJG3XY1hgOvWFK9cAlzzcsuDkWPo+kjMtMwan0U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbfBLI0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 03:26:31 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36275 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728095AbfBLI0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 03:26:31 -0500
Received: by mail-lf1-f66.google.com with SMTP id q11so1317925lfd.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 00:26:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a+2h7gpQxkc9JQfd9EdYxmd37Yt7ECu246HBXw6YV9o=;
        b=gTIr/qJi0Irk0lBDQnZHxyt+uiXmFXybuOUnIm9vd1e0+MUH/ddBzW/8BwS5nreupV
         0XNboMOjzd9WlwPLaakRS7cS0ogv/mTD5tsAvGIPuJg63kEO44jLaXKrsC2ukBFfnM+9
         QaWNlFVzNThegPSBx62LCMY6EYi9+D+JHYp4hERM19mqi9QSuaDt0NefLk1xdyA079QJ
         vCl13Cp5TryDtzvpZk6QAnym9RtDlL78EXme67vsX5mcMbMqa8ie/oaUTVNY7cEj6tOA
         cnuwW2w24I7g90SBwZevo0TA99/XOEV7e/+LKrA1CPxUqXrZO1xxIzSM91GbmZ0L7x2S
         IQKw==
X-Gm-Message-State: AHQUAuYhFWh5rZCjc7Wm25tYZh4D9in+VpAnx1dyQ0wKbpZjpu+BFMEF
        D5r6oKB1xzuXlSI4erWEwQzYcJRG
X-Google-Smtp-Source: AHgI3IawQsz13vKtdO8RDNQ9qEgjslqcVxaQiK9xKywWZBslPO6oabAHqaE81o6jZOLkVhWXgfZa8Q==
X-Received: by 2002:ac2:5593:: with SMTP id v19mr1594914lfg.60.1549959989317;
        Tue, 12 Feb 2019 00:26:29 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id q1sm2209253lfk.15.2019.02.12.00.26.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 00:26:28 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gtTOX-0007Et-DK; Tue, 12 Feb 2019 09:26:21 +0100
Date:   Tue, 12 Feb 2019 09:26:21 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@suse.de>, linux-kernel@vger.kernel.org,
        Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 5/5] riscv: use for_each_of_cpu_node iterator
Message-ID: <20190212082621.GA26912@localhost>
References: <20190118140308.9599-1-johan@kernel.org>
 <20190118140308.9599-6-johan@kernel.org>
 <20190212071339.GL26747@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212071339.GL26747@infradead.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 11:13:39PM -0800, Christoph Hellwig wrote:
> On Fri, Jan 18, 2019 at 03:03:08PM +0100, Johan Hovold wrote:
> > Use the new for_each_of_cpu_node() helper to iterate over cpu nodes
> > instead of open coding. Note that this will allow matching also on the
> > node name instead of the (for FDT) deprecated device_type property.
> > 
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> 
> I think this is going to conflict with the ELF caps changes from
> Atish.  Maybe the riscv_fill_hwcap hunk should be included in his
> patch?

Since that patch had some issues (e.g. the node reference underflow) it
may be better to rebase it on top of this series. The changes are
otherwise distinct after all.

> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks for reviewing!

Johan
