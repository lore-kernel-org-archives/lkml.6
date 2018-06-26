Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA6CC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 03:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF03F26484
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 03:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vNAj0z9q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF03F26484
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965315AbeFZDVh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 23:21:37 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:40893 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965262AbeFZDVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 23:21:35 -0400
Received: by mail-pl0-f68.google.com with SMTP id t6-v6so2465254plo.7;
        Mon, 25 Jun 2018 20:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=u6RZ+0kcquAJnVtJsY79u6IIi6jol26oG5vpLiyrB34=;
        b=vNAj0z9qkOTxbl2mwKJaBRoYuoIszmJ/X8TQfHUpI+7gAEFnDwqbsEhpmuJDOkTyDk
         NRgIpvCVG1zKg+8O9vIN8/EuwMNhYqblMeE3qLkgSQRQ84PddQO9+UCTTDSzj78dX0fQ
         AJrkPCHlbccXiC1su0Oe82J4hjWLxMUPp1lTY962LEqrhnjOZQD45ABpeNUg61CawBT6
         EHXQfnbjCFh/3g5PhmKWWBdPusyNojjjaIv+gKn/63dL0ui0iilO2TozjUKdiy4DpSDu
         QzzYZS+5jT46LHXluEEg90NfyLGdazIIT2+rmQPBFcd70vJI2hb4rplZ6p+vnVvLWXT/
         jwtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=u6RZ+0kcquAJnVtJsY79u6IIi6jol26oG5vpLiyrB34=;
        b=QRHtRVRbHBH/c5aKVz5VLtSmxZ5uHJSsmYd+pbeBuhdVm3j5j84BXHKP/kzAbWrP7p
         eHXf3XCffVbo/COaQe4EWYUnpMmNgzLgKsWfwFsMiDmJPdcu0qRXZo+YEysjizQE3wzF
         Yg1L/b8s0QpK31Eth4VD82Q75ac3ZIZ/BUkMcmxNrSvX6wbzuTaKQ01+AE0LCaakFvUx
         gY4meVzuVl+s430VsXHDZ+uMkwCcPiR7KoApxbZrVtCRVdHxX5Wqk9ohtn2wNZSoBws+
         EjfTOeOT+k4iKvejbJs/F/XLTIPGJjTkOGwOLSPj8MOxS7Y+pZ2OlE2fQuL/IAR0NwR6
         eIuA==
X-Gm-Message-State: APt69E39H3I966Ru8gtCu0hr+srILfhS7KWBi584Ve+z5teFnS9GGPyR
        G5/RqzNYSCJhSSnNdnaA3yLI4PXb
X-Google-Smtp-Source: ADUXVKI2jhDt+rcdn2hJOwR8isFtS6Bt2QQIn5lUciaCZlV1UFNBH4NGH1RfNDUe1HjlIGpCy8bxhA==
X-Received: by 2002:a17:902:9f81:: with SMTP id g1-v6mr14795209plq.304.1529983294516;
        Mon, 25 Jun 2018 20:21:34 -0700 (PDT)
Received: from hxeon ([147.46.241.218])
        by smtp.gmail.com with ESMTPSA id v26-v6sm619377pfn.105.2018.06.25.20.21.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 20:21:33 -0700 (PDT)
From:   sjpark <sj38.park@gmail.com>
X-Google-Original-From: sjpark <sjpark@hxeon>
Date:   Tue, 26 Jun 2018 12:21:23 +0900 (KST)
To:     Byungchul Park <byungchul.park@lge.com>
cc:     SeongJae Park <sj38.park@gmail.com>, paulmck@linux.vnet.ibm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@lge.com
Subject: Re: [PATCH] locking/memory-barriers.txt/kokr: Update Korean translation
 to fix broken DMA vs. MMIO ordering example
In-Reply-To: <20180626004738.GA20783@X58A-UD3R>
Message-ID: <alpine.DEB.2.20.1806261218490.1528@hxeon>
References: <20180617051608.2128-1-sj38.park@gmail.com> <20180626004738.GA20783@X58A-UD3R>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="781441777-312507392-1529983293=:1528"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--781441777-312507392-1529983293=:1528
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hello Byungchul,


On Tue, 26 Jun 2018, Byungchul Park wrote:

> On Sun, Jun 17, 2018 at 02:16:08PM +0900, SeongJae Park wrote:
> > Translate this commit to Korean:
> >
> >   5846581e3563 ("locking/memory-barriers.txt: Fix broken DMA vs. MMIO ordering example")
>
> Hi SeongJae,
>
> You keep doing good jobs ;)
>
> I believe it would be better if you consider the little things below
> more. What do you think about it, SeongJae?

Thank you for great comments!

>
> > Signed-off-by: SeongJae Park <sj38.park@gmail.com>
> > ---
> >  Documentation/translations/ko_KR/memory-barriers.txt | 15 +++++++--------
> >  1 file changed, 7 insertions(+), 8 deletions(-)
> >
> > diff --git a/Documentation/translations/ko_KR/memory-barriers.txt b/Documentation/translations/ko_KR/memory-barriers.txt
> > index 921739d00f69..ada0a709cce1 100644
> > --- a/Documentation/translations/ko_KR/memory-barriers.txt
> > +++ b/Documentation/translations/ko_KR/memory-barriers.txt
> > @@ -1891,19 +1891,18 @@ Mandatory 배리어들은 SMP 시스템에서도 UP 시스템에서도 SMP 효
> >  		/* 소유권을 수정 */
> >  		desc->status = DEVICE_OWN;
> >
> > -		/* MMIO 를 통해 디바이스에 공지를 하기 전에 메모리를 동기화 */
> > -		wmb();
> > -
> >  		/* 업데이트된 디스크립터의 디바이스에 공지 */
> >  		writel(DESC_NOTIFY, doorbell);
> >  	}
> >
> >       dma_rmb() 는 디스크립터로부터 데이터를 읽어오기 전에 디바이스가 소유권을
> > -     내놓았음을 보장하게 하고, dma_wmb() 는 디바이스가 자신이 소유권을 다시
> > -     가졌음을 보기 전에 디스크립터에 데이터가 쓰였음을 보장합니다.  wmb() 는
> > -     캐시 일관성이 없는 (cache incoherent) MMIO 영역에 쓰기를 시도하기 전에
> > -     캐시 일관성이 있는 메모리 (cache coherent memory) 쓰기가 완료되었음을
> > -     보장해주기 위해 필요합니다.
> > +     내려놓았을 것을 보장하고, dma_wmb() 는 디바이스가 자신이 소유권을 다시
> > +     가졌음을 보기 전에 디스크립터에 데이터가 쓰였을 것을 보장합니다.  writel()
>                                                                         ^
>                                                                      참고로,

Nice comment.  This will enhance the readability a lot.

>
> > +     을 사용하면 캐시 일관성이 있는 메모리 (cache coherent memory) 쓰기가 MMIO
> > +     영역에의 쓰기 전에 완료되었을 것을 보장하므로 writel() 앞에 wmb() 를
> > +     실행할 필요가 없음을 알아두시기 바랍니다.  writel() 보다 비용이 저렴한
> > +     writel_relaxed() 는 이런 보장을 제공하지 않으므로 여기선 사용되지 않아야
> > +     합니다.
> >
> >       consistent memory 에 대한 자세한 내용을 위해선 Documentation/DMA-API.txt
> >       문서를 참고하세요.
>
>      See the subsection "Kernel I/O barrier effects" for more information on
>      relaxed I/O accessors and the Documentation/DMA-API.txt file for more
>      information on consistent memory.
>
> Don't you think the whole sentence need to be translated? If yes, then
> it would be better to do that as well ;)

Oh, my mistake!  It should be.

I applied your comments to the second version.


Thanks,
SeongJae Park

>
> > --
> > 2.13.0
>
> --
> Thanks,
> Byungchul
>
--781441777-312507392-1529983293=:1528--
