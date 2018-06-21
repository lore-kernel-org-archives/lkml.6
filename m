Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB544C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 19:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 654ED21A6F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 19:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="llpBIIQV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 654ED21A6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754269AbeFUTG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 15:06:28 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38539 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754065AbeFUTG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 15:06:26 -0400
Received: by mail-wm0-f67.google.com with SMTP id 69-v6so8055422wmf.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 12:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1D91HEkEL7ItFtVWmy2vtnB10Y1driE1hTKVMXkjfrE=;
        b=llpBIIQVSfJGrIQ4upSC+Saezilm4QZyYKak+NgZW80TOlcvEV8nDBz2VaIwbkQVoB
         zLSk3hG11Q7GFUUVb4m34W2Jf4XHARgxRhepWKUNlZkxiVXN5z+tpJzt4kLQfj7plDvh
         kvjs36WgmKzij3Ll5lgDKIrAqowZ85y3wn/ulMLrEv7F1VMHGdg7enBr+cCubUDjTMZR
         8gJLzitEVDZijLTEkJhDUikRcknnyV6YUlq40yuZzqkI/i1tzH2zr3fdjGwaDri6RqUl
         DpTyrVpnNlH8gA2AMaYVjQbMAum7dsBdx0S2HIQ8PtqxTGyB7uLaCs0NU9uJaW8exRgs
         f4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1D91HEkEL7ItFtVWmy2vtnB10Y1driE1hTKVMXkjfrE=;
        b=sIXi5VpwahSkI++v/cDp5sNN6oxRK8QkSVciFEkZgdaoAjl3f7BDEhxRAY2e+WIuq2
         8rG6AR4UCw5lJniqfa1tVaH3I9xmaNsEwMeRKS3D4AeFPsBxZJ8J1DyfWh/ftrU3+z0B
         x/ba24qhq3jzlMfPO2v9Gv4JAG4XvKxl69uBfionrLpVaJe0DgaevBZpc9FYKbSaFYXa
         TE27jubvN/liPS0mF5QLcuMQ4q22JFX5H41zaAgyVvDSg6g+otbm0rvIb1OgAM0jDaG3
         t0K0utC5Yeq5+1kxJ59nn7miM2EK31LJIuf1c8SGgrt4h/kw28eo+jNmXBg/JH+Try3K
         lsMg==
X-Gm-Message-State: APt69E1eUxmUCfCphuYbptkmSXkv9WOMi2hnQAEfE5NpCAlPRu7BJbFY
        Rau9p2SxI5aAc16hkSJP60kKTA==
X-Google-Smtp-Source: ADUXVKLdGwBzDPSa1LqxIBOFsiaN+pZ61pW7Ot11AE5gkqb+UtnK3Et1qIc0JEqlMXUjS7kaQpJnyQ==
X-Received: by 2002:a1c:f513:: with SMTP id t19-v6mr6494394wmh.50.1529607984932;
        Thu, 21 Jun 2018 12:06:24 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id r10-v6sm10608884wrm.66.2018.06.21.12.06.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 12:06:24 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@ziepe.ca>)
        id 1fW4uS-0002bn-Iu; Thu, 21 Jun 2018 13:06:20 -0600
Date:   Thu, 21 Jun 2018 13:06:20 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] tpm: Implement tpm_chip_find() and tpm_chip_put()
 for other subsystems
Message-ID: <20180621190620.GE19270@ziepe.ca>
References: <20180620204236.1572523-1-stefanb@linux.vnet.ibm.com>
 <20180620204236.1572523-2-stefanb@linux.vnet.ibm.com>
 <20180621171518.GI11859@linux.intel.com>
 <95b2970f-b71b-4cfc-c188-7ae7e8cb94c5@linux.vnet.ibm.com>
 <20180621175601.GC19270@ziepe.ca>
 <743f606f-b3eb-6917-33bb-5b080f76fe3f@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <743f606f-b3eb-6917-33bb-5b080f76fe3f@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 02:19:44PM -0400, Stefan Berger wrote:
> On 06/21/2018 01:56 PM, Jason Gunthorpe wrote:
> >On Thu, Jun 21, 2018 at 01:45:03PM -0400, Stefan Berger wrote:
> >>On 06/21/2018 01:15 PM, Jarkko Sakkinen wrote:
> >>>On Wed, Jun 20, 2018 at 04:42:33PM -0400, Stefan Berger wrote:
> >>>>Implement tpm_chip_find() for other subsystems to find a TPM chip and
> >>>>get a reference to that chip. Once done with using the chip, the reference
> >>>>is released using tpm_chip_put().
> >>>>
> >>>>Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> >>>You should sort this out in a way that we don't end up with duplicate
> >>>functions.
> >>Do you want me to create a function *like* tpm_chip_find_get() that takes an
> >>additional parameter whether to get the ops semaphore and have that function
> >>called by the existing tpm_chip_find_get() and the new tpm_chip_find(). The
> >>latter would then not get the ops semphore. I didn't want to do this since
> >>one time the function returns with a lock held and the other time not.
> >Another option, and I haven't looked, is to revise the callers of
> >tpm_chip_find_get to not require it to hold the ops semaphore for
> >them.
> 
> We have tpm_chip_unregister calling tpm_del_char_device to set the ops to
> NULL once a chip is unregistered. All existing callers, if they pass in a
> tpm_chip != NULL, currently fail if the ops are NULL. (If they pass in
> tpm_chip = NULL, they shouldn't find a chip once ops are null and it has
> been removed from the IDR). I wouldn't change that since IMA will call in
> with a tpm_chip != NULL and we want to protect the ops. All existing code
> within the tpm subsystem does seem to call tpm_chip_find_get() with a NULL
> pointer, though. Also trusted keys seems to pass in a NULL pointer every
> time.
> 
> >
> >Either by giving them an API to do it, or revising the TPM entry
> >points to do it.
> >
> >I didn't look, but how did the ops semaphore get grabbed in your
> >revised patches? They do grab it, right?
> 
> The revised patches do not touch the existing code much but will call
> tpm_chip_find_get() and get that semaphore every time before the ops are
> used. IMA is the only caller of tpm_chip_find() that now gets an additional
> reference to the tpm_chip and these APIs get called like this from IMA:
> 
> ima init: chip = tpm_chip_find()
> 
> ima::tpm: tpm_chip_find_get(chip) ... tpm_put_ops(chip)
> 
> ima::tpm: tpm_chip_find_get(chip) ... tpm_put_ops(chip)
> 
> [repeat]
> 
> ima shutdown: tpm_chip_put(chip)

Maybe just change tpm_chip_find_get() into tpm_get_ops(chip) and
convert all callers?

Jason
