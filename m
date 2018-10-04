Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA36C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 687B62083F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yq0QH2fB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 687B62083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbeJEBZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 21:25:20 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40202 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbeJEBZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 21:25:20 -0400
Received: by mail-wr1-f65.google.com with SMTP id d2-v6so6550902wro.7;
        Thu, 04 Oct 2018 11:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=T1mOpapRi8jQJ2qCRWXCOELE8hBhRpR4XTT5VOWFWWc=;
        b=Yq0QH2fBRqiDeMPRJGX2nwA+0qwBS8b+yVWy6l52h+Z3P3Y6xDh6BHLnlfaW2/+gW1
         kObC9CzKx/eX0wehuMi2fg3+hAxK2IRWFBuIJegPz3SezAV0O3JPMjNPcEoMQpRTG51d
         +y7gNGZvTnhjnrrLd7TNLDESRQFUrab0QuEQJtoEEwenyOcOIBkVOFwfyCPLDyMN1NUd
         ZenqCJRk/8ZLHXVMzldnzdJR3sfS7BymRUBBwFb9RaLcDp45+bjuxzK6+uA9QI2F9Yz0
         SYRYqlCTF2rECqPK6acXXeGSXRncrq5OP1jGc/Auxmf8iO+dSdKifdfjY4oAoboTE+jV
         YyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=T1mOpapRi8jQJ2qCRWXCOELE8hBhRpR4XTT5VOWFWWc=;
        b=kWTY18M1H184+/8hCLfTQ0WMSV73wthSJuITERwZ7TvRHw0qYrqPU64MlmDyqVO810
         iT7jcZrzz2j45QPLGl24jplzhjepE4s+dqtkWOCChrptdH1/LidXec06sas6iHa78xs5
         H6uOW77NtXrn9+eKjAygdhPb+c39emS2wNlQQyIlMshJGAoOtk+cUzoYDzSbgqt56UC1
         dnWsFJp9EgKle2lfCDsil45BlkpJx6zLZ23Lvi++IZ4+9ziBqTefjMYSYYZHtfjFVXwI
         0Psll0TeDGcLunEvDcGuK6JW3Hx8YvRxGFFeKlliUFcI6I2hYhdsCli7NhA1zRKV2Xpn
         FC0g==
X-Gm-Message-State: ABuFfogikHZbTOjVLAufWvDEztilUOjVXZWc4tJtGAcPofEJ7fw5RJwo
        hYEqfomiDzGh6wwPcknVgvs=
X-Google-Smtp-Source: ACcGV62rd051ATFp2YnMqIozNXITbRqh2fzJhf+hD9EqY+EJj8BnMNQuecGcwVQSQh1tVP6uU9qH2g==
X-Received: by 2002:a5d:6a8d:: with SMTP id s13-v6mr5426096wru.44.1538677849863;
        Thu, 04 Oct 2018 11:30:49 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id e14-v6sm4640182wrt.76.2018.10.04.11.30.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 11:30:49 -0700 (PDT)
Date:   Thu, 4 Oct 2018 11:30:47 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: -Wswitch Clang warnings in drivers/scsi
Message-ID: <20181004183047.GA1885@flashbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi SCSI folks,

In an effort to get the kernel building warning free with Clang, we've
come across an interesting occurrence in a few scsi drivers:

drivers/scsi/hpsa.c:6533:7: warning: overflow converting case value to switch condition type (2148024833 to 18446744071562609153) [-Wswitch]
        case CCISS_GETPCIINFO:
             ^
./include/uapi/linux/cciss_ioctl.h:65:26: note: expanded from macro 'CCISS_GETPCIINFO'
#define CCISS_GETPCIINFO _IOR(CCISS_IOC_MAGIC, 1, cciss_pci_info_struct)
                         ^
./include/uapi/asm-generic/ioctl.h:86:28: note: expanded from macro '_IOR'
#define _IOR(type,nr,size)      _IOC(_IOC_READ,(type),(nr),(_IOC_TYPECHECK(size)))
                                ^
./include/uapi/asm-generic/ioctl.h:70:2: note: expanded from macro '_IOC'
        (((dir)  << _IOC_DIRSHIFT) | \
        ^

I see this warning in drivers/scsi/hpsa.c and drivers/scsi/smartpqi/smartpqi_init.c
on an arm64 allyesconfig build and it has also been reported in a couple of files in
drivers/scsi/cxlflash.

As the warning states, there is an overflow because the switch statement's value is of
type int but the switch value is greater than INT_MAX. I did a brief sweep of the tree
and it seems that all uses of _IOC in switch statement values either are small enough
to fit into size int or the value is of size unsigned int.

I am unsure of the implications of using a smaller _IOC value or converting all ioctls
to expect a cmd of type unsigned int (especially since that has userspace implications)
but I didn't see any negative ioctl commands. Some clarity and insight would be
appreciated.

Thank you for your time,
Nathan
