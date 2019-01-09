Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A351EC43612
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71C8120859
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfT7BN+6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbfAITkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 14:40:53 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39040 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbfAITkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 14:40:53 -0500
Received: by mail-pg1-f196.google.com with SMTP id w6so3743355pgl.6;
        Wed, 09 Jan 2019 11:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nJ14hBWFoar2exUMI4Uqe+xjT8xBcg3yX/L14mGb20c=;
        b=VfT7BN+6FEeLAr88u/WhuhB2yxzD3zCou5s/ovqjR3vDmT70O3wRD9C0PZdghENGrO
         x506uNNS18oCR+fWdBt5wxdkiTU/Za6V2VXoe0IO+Uu7Q9pQqNPrJ+yxkKI2Ppn70VCE
         /LhhMfcRZWI/cS1OzK/ArNnUtrDrZ9T48cDyyqKKB8BwwsM0YDkzu/OeUX1Rb+9K7tog
         z14SsY57zH5lT53OEt4FRxmiUZasINgZ8GSpiNsV5A4rqJL9heVr1he8W8d8h0wCbaBL
         1AxesTKo7wjIxVsOp6tOYxVJlK2tedBk3XYjNq/yi1J4zDhDULl7MW//W35n7FSoSHwF
         AbcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=nJ14hBWFoar2exUMI4Uqe+xjT8xBcg3yX/L14mGb20c=;
        b=EyoiIwHg6LipuV448sjeC4UQ2AE4pJ9RCcA+zv38IMx8BCkOtPgIqfP3ffk018te3x
         M3ZCGLI09DDHGog/BbXsaoThfFijAgtrCPLJ49mlj38Bw0ElOvJhL5Dlzh9uqxs3BojJ
         dGWs5NjjmQnlWOQ1BWdrHGXvOy/I6dTh7fDYXpbZLJuVh8Vvc6jbaTymnrVqvdwUfzFu
         xxj8Irjdw7JFfFJVP8wfQnOb1FILzdofd9jlazqFWby3/bJLTog6qQDlrPbt8z7o9CCp
         UicKZy2A57d/zeIUZKkeqP80SCIBE+zQ7oeIt05+ti636tYOlWG/kCn4Iy4vsqhnjfiT
         M3PQ==
X-Gm-Message-State: AJcUukd44+Lh9UYAGvRKcGIuHGROFU/CkfmsGk/DNd9uasnQkoeh0BSt
        Y8ajivZZAFl7d3oYj51L2p8=
X-Google-Smtp-Source: ALg8bN52T8rL9ew7hHCVmQ19eycHBCn1TXhTvMD7bcXkhF//7D6Wcx52MtEm1sWTuf0s4doYxmoepQ==
X-Received: by 2002:a62:1c0a:: with SMTP id c10mr7228772pfc.213.1547062851310;
        Wed, 09 Jan 2019 11:40:51 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j9sm94438785pfi.86.2019.01.09.11.40.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 11:40:50 -0800 (PST)
Date:   Wed, 9 Jan 2019 11:40:48 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 000/170] 4.19.14-stable review
Message-ID: <20190109194048.GA11505@roeck-us.net>
References: <20190107104452.953560660@linuxfoundation.org>
 <20190108230731.GC20519@roeck-us.net>
 <20190109143811.GB29274@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109143811.GB29274@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 03:38:11PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Jan 08, 2019 at 03:07:31PM -0800, Guenter Roeck wrote:
> > On Mon, Jan 07, 2019 at 01:30:27PM +0100, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 4.19.14 release.
> > > There are 170 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Wed Jan  9 10:43:54 UTC 2019.
> > > Anything received after that time might be too late.
> > > 
> > 
> > For v4.19.13-171-gc68ce175c3b8:
> > 
> > Build results:
> > 	total: 155 pass: 152 fail: 3
> > Failed builds: 
> > 	powerpc:ppc64e_defconfig 
> > 	powerpc:cell_defconfig 
> > 	powerpc:maple_defconfig 
> > Qemu test results:
> > 	total: 332 pass: 319 fail: 13
> > Failed tests: 
> > 	ppc64:mac99:ppc64_book3s_defconfig:nosmp:initrd 
> > 	ppc64:mac99:ppc64_book3s_defconfig:smp:initrd 
> > 	ppc64:mac99:ppc64_book3s_defconfig:smp:ide:rootfs 
> > 	ppc64:mac99:ppc64_book3s_defconfig:smp:mmc:rootfs 
> > 	ppc64:mac99:ppc64_book3s_defconfig:smp:nvme:rootfs 
> > 	ppc64:mac99:ppc64_book3s_defconfig:smp:scsi[DC395]:rootfs 
> > 	ppc64:mpc8544ds:ppc64_e5500_defconfig:nosmp:initrd 
> > 	ppc64:mpc8544ds:ppc64_e5500_defconfig:smp:initrd 
> > 	ppc64:ppce500:corenet64_smp_defconfig:e5500:initrd 
> > 	ppc64:ppce500:corenet64_smp_defconfig:e5500:nvme:rootfs 
> > 	ppc64:ppce500:corenet64_smp_defconfig:e5500:mmc:rootfs 
> > 	ppc64:ppce500:corenet64_smp_defconfig:e5500:scsi[53C895A]:rootfs
> > 	ppc64:ppce500:corenet64_smp_defconfig:e5500:sata-sii3112:rootfs
> 
> Ugh, I thought this was just the cell build, didn't realize it hit more.
> 
> Ok, I've dropped the patch from all queues.  Odd that it only causes
> problems on 4.19.y :(
> 
I don't know what you dropped, but v4.19.14 fails to build with 
the same error. Did you drop it after the release ?

Guenter
