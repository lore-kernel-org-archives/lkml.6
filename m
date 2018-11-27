Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4A5C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 21:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49E0221104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 21:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3wywJnR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49E0221104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbeK1IWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 03:22:10 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34035 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbeK1IWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 03:22:10 -0500
Received: by mail-pf1-f195.google.com with SMTP id h3so9030531pfg.1;
        Tue, 27 Nov 2018 13:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=drFtW+xdbjqWu8Rc2hIkFzGLk/Fk1q7VOcLCOOYtVNs=;
        b=i3wywJnRuLsf8sn84ps9xtF4gThH9K2aK3KDBmEarNpwia72RkYrzEJNR5y6Y7TwZl
         XZcMwlgasIb1dCibz+hN3TxqQ/wM4OU6jGwzxhjkQ32SbW2xg9nh3zmPt6xwZ9E5ySlW
         S+VPuPtOPNXR1i2Peb9G2swACwkrAbla3EqfkkDSkuCkAV/1QTxfut+36hJjBspnurLT
         7Ijb+Ondzdm9xm8wMOFERna5kQIqt3V7zvePZuUND6chfghrvTkyhv73cq/rdbM/bwdR
         irC8Fvpp6LtwRFfkqxuB0NId5Uj8MD9J/pLBBxbui6LZsTzFwdzoa4CK+1mIoT7wxwPJ
         IE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=drFtW+xdbjqWu8Rc2hIkFzGLk/Fk1q7VOcLCOOYtVNs=;
        b=A/jhNSc2YFPmJeAAeDrdhDFqZa8ds8IFA1PJnMpGeKY9nb4dmvFTbyUnIpOdXlUGAe
         XJ1mI8FPAYJf3onchBqMxPMjh79Noe8x2amHbmdcCEbFaUoP/QWgeKQ0ui9HV09csVNK
         GHXZc0gz7pYOqA1bIWOxFKkUuOQV7nfgIzi8ZFu5bmTrnd7e+aJTg8RIGrlhSERdkrMx
         p97mMupYDRleJD2nK1HXfYdALvuxnjgErnh2CE6vzQ6B5DTtg6s2HYhpboYbKVmsz42L
         cpu8ueBfWZveo3zNVElLf5yQJ5hST9B2dzhHVdqe5KeYp2rcOmGq+v63i84sdhhF2qKi
         3uZg==
X-Gm-Message-State: AA+aEWZyHwRiDSVbSwO4lE6puD+vW+uq54U5xFDfPMOhumEbB/aQvkLP
        pRZXQXVAVhzN/HYRXUZuM2mUxU3s
X-Google-Smtp-Source: AFSGD/WCkoPyHzz+QAZGUbIk9nicuNFxieKP0o12wyGsi7dCdCdBJkN6V4PwnXDOnGHyDffPJxs2lA==
X-Received: by 2002:a63:6bc1:: with SMTP id g184mr31354971pgc.25.1543353777008;
        Tue, 27 Nov 2018 13:22:57 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2-v6sm7415478pfj.106.2018.11.27.13.22.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 13:22:56 -0800 (PST)
Date:   Tue, 27 Nov 2018 13:22:55 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rainer Fiebig <jrf@mailbox.org>
Cc:     linux-kernel@vger.kernel.org, grendel@twistedcode.net,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
Subject: Re: ext4 file system corruption with v4.19.3 / v4.19.4
Message-ID: <20181127212255.GA2987@roeck-us.net>
References: <065643a0-f9aa-a361-715a-03ca978d9228@roeck-us.net>
 <b43fb902-9b64-22d9-25ca-c970b3842a43@roeck-us.net>
 <5d94f857-b31d-a02c-5a20-2796076f447e@twistedcode.net>
 <2157925.3ZPi3Rj3bs@siriux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2157925.3ZPi3Rj3bs@siriux>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 07:55:01PM +0100, Rainer Fiebig wrote:
> Am Dienstag, 27. November 2018, 15:48:19 schrieb Marek Habersack:
> > On 27/11/2018 15:32, Guenter Roeck wrote:
> > Hi,
> > 
> > You might try to see if you have CONFIG_SCSI_MQ_DEFAULT=yes in your kernel
> > config. Starting with 4.19.1 it somehow interferes with ext4 and causes
> > problems similar to the ones you list below. Ever since I disabled MQ
> > (either recompile your kernel or add `scsi_mod.use_blk_mq=0` to the kernel
> > command line) none of those errors came back.
> > 
> > hope it helps,
> > 
> > marek
> 
> Unfortunately, this doesn't seem to work in every case: 
> https://bugzilla.kernel.org/show_bug.cgi?id=201685#c54
> 
> And I'm using a defconfig-4.19.3 (meaning: CONFIG_SCSI_MQ_DEFAULT=yes) in a VM 
> and I'm not seeing those errors there. OK, it's a VM - but anyway.
> 

Agreed. I disabled CONFIG_SCSI_MQ_DEFAULT, but the problem is still seen
at least on one of my servers, so disabling it does not help, at least not
in my case.

If the problem is somehow related to CONFIG_SCSI_MQ_DEFAULT, you might
have to explicitly use a scsi drive (virtio-scsi-pci or similar) to
trigger its use in a VM.

Guenter

> The definite cause of this can only be found by bisecting, IMO. And it needs 
> to be pinned down because else some feeling of insecurity will remain.
> 
> So long!
> 
> Rainer Fiebig
> 
> > 
> > > [trying again, this time with correct kernel.org address]
> > > 
> > > Hi,
> > > 
> > > I have seen the following and similar problems several times,
> > > with both v4.19.3 and v4.19.4:
> > > 
> > > Nov 23 04:32:25 mars kernel: [112668.673671] EXT4-fs error (device sdb1):
> > > ext4_iget:4831: inode #12602889: comm git: bad extra_isize 33661 (inode
> > > size 256)
> > > Nov 23 04:32:25 mars kernel: [112668.675217] Aborting journal on device
> > > sdb1-8. Nov 23 04:32:25 mars kernel: [112668.676681] EXT4-fs (sdb1):
> > > Remounting filesystem read-only Nov 23 04:32:25 mars kernel:
> > > [112668.808886] EXT4-fs error (device sdb1): ext4_iget:4831: inode
> > > #12602881: comm rm: bad extra_isize 33685 (inode size 256)
> > > ...
> > > 
> > > Nov 25 00:12:43 saturn kernel: [59377.725984] EXT4-fs error (device sda1):
> > > ext4_lookup:1578: inode #238034131: comm updatedb.mlocat: deleted inode
> > > referenced: 238160407
> > > Nov 25 00:12:43 saturn kernel: [59377.766638] Aborting journal on device
> > > sda1-8. Nov 25 00:12:43 saturn kernel: [59377.779372] EXT4-fs (sda1):
> > > Remounting filesystem read-only ...
> > > 
> > > Nov 24 01:52:31 saturn kernel: [189085.240016] EXT4-fs error (device
> > > sda1): ext4_lookup:1578: inode #52038457: comm nfsd: deleted inode
> > > referenced: 52043796
> > > Nov 24 01:52:31 saturn kernel: [189085.263427] Aborting journal on device
> > > sda1-8. Nov 24 01:52:31 saturn kernel: [189085.275313] EXT4-fs (sda1):
> > > Remounting filesystem read-only
> > > 
> > > 
> > > The same systems running v4.18.6 never experienced a problem.
> > > 
> > > Has anyone else seen similar problems ? Is there anything I can do
> > > to help tracking down the problem ?
> > > 
> > > Thanks,
> > > Guenter
> 
> -- 
> The truth always turns out to be simpler than you thought.
> Richard Feynman


