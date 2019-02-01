Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCA0C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D96D21872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dIZxhKJy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbfBARJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 12:09:04 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46766 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727935AbfBARJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 12:09:04 -0500
Received: by mail-pf1-f194.google.com with SMTP id c73so3485849pfe.13
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 09:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TPdrzSWC4my13nhCOT7Q1xoA/g/ucGHhDI45r4M6KQw=;
        b=dIZxhKJyVaT3stVWrv2lLJugLkhkjvsOBEgzTCbIMR+Ml2CMEPwp8bpQy1DXVkToWT
         jfnXrEl05TZS4hx7/ArHVksbm6UjGhbE1h+ChiVnWEKQ/GWFduk11B6KbJXnCldyPd/K
         E89oFlBNBShGTw6K23bkBLpOd4bRNjQuCbRyTVKHMHdG2t0EFdlPDBeZB+D8tViZi/+N
         b4Yc+AbF2TEB48MsD/PSp1kJqIazrmUGCVN3yNn/8AVQF3fOPXC2AqC2WF/5ojbCwFK1
         cOMETn8J1dVeM1bulwG10oXogCL+aBYB6hu9YzBCFIccK08bdgvdRgcndgDYW/aFr9Sf
         wMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TPdrzSWC4my13nhCOT7Q1xoA/g/ucGHhDI45r4M6KQw=;
        b=tQGvex1Vvjzkfnxw73I+AV+qvxkAQyYeoIsp0URN2ZYOLloeKBNiSHhskZJ63F5nc6
         4tZgn+VyHEyr681YS9o/Bi2CZ4CYAuHoqbfIvjriBHDrtxpO6ikWpz4zXAUvjvVE2PFo
         gUbq+RcaxRnjyhCiqy1Gh24wdPLljA+lZ9UNdsplTdVMrFM6J8XpEvuzcXJN/8VRRBay
         vKh36M89gvb8Hz+e4lv5pcCT1OxrvE2iJT38t8SxqpkdN3jgysgrVqv9UtgU5F3W2UoO
         IpdDe+k5Kio9bEMDhkV6Ww8QWi/h2BLyZxyOhRIZbyoed8rgM/NddhWbf7L7Fp35N/TK
         ba2A==
X-Gm-Message-State: AJcUukffu858Okktkw7fAFUkAabAtCbTcAi21/22tjfw0jIviW7z+c5k
        7vJX+NmKhsES+5jYnqQfngu/JA==
X-Google-Smtp-Source: ALg8bN4vpMKKaSS1rDTHr9jpdYO+5qSrorvDLTURtQvDH7ow2hSlzFFPV2LxeVTROI1R79Ig+e138g==
X-Received: by 2002:a62:8a51:: with SMTP id y78mr39741330pfd.35.1549040943484;
        Fri, 01 Feb 2019 09:09:03 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id g185sm10791193pfc.174.2019.02.01.09.09.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 09:09:02 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gpcJK-0003rp-8w; Fri, 01 Feb 2019 10:09:02 -0700
Date:   Fri, 1 Feb 2019 10:09:02 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Joel Nider <joeln@il.ibm.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] docs-rst: driver-api: Add infiniband interface
 documentation
Message-ID: <20190201170902.GB13002@ziepe.ca>
References: <1548151235-386-1-git-send-email-joeln@il.ibm.com>
 <1548151235-386-3-git-send-email-joeln@il.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548151235-386-3-git-send-email-joeln@il.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 12:00:34PM +0200, Joel Nider wrote:
> A short document regarding the user verbs interface implementation on
> the kernel side. Also, the corresponding index entry in the
> documentation tree.
> 
> Signed-off-by: Joel Nider <joeln@il.ibm.com>
>  Documentation/driver-api/index.rst      |  1 +
>  Documentation/driver-api/infiniband.rst | 73 +++++++++++++++++++++++++++++++++
>  2 files changed, 74 insertions(+)
>  create mode 100644 Documentation/driver-api/infiniband.rst
> 
> diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
> index ab38ced..ecb3f8a5 100644
> +++ b/Documentation/driver-api/index.rst
> @@ -28,6 +28,7 @@ available subsections can be seen below.
>     regulator
>     iio/index
>     input
> +   infiniband
>     usb/index
>     firewire
>     pci/index
> diff --git a/Documentation/driver-api/infiniband.rst b/Documentation/driver-api/infiniband.rst
> new file mode 100644
> index 0000000..2de47ff
> +++ b/Documentation/driver-api/infiniband.rst
> @@ -0,0 +1,73 @@
> +==========================
> +Infiniband Interface Guide
> +==========================
> +
> +This guide is for people who wish to understand the implementation details of
> +handler functions in the Infiniband subsystem. There are currently two system
> +calls for executing Infiniband commands: write() and ioctl(). Older commands
> +are sent to the kernel via write()s on the device files described in
> +:doc:`../userspace-api/rdma_user_verbs`. New commands must use the ioctl()
> +method. For completeness, both mechanisms are described here.
> +
> +The interface between userspace and kernel is kept in sync by checking the
> +version number. In the kernel, it is defined by IB_USER_VERBS_ABI_VERSION
> +(in include/uapi/rdma/ib_user_verbs.h).
> +
> +Write system call
> +-----------------
> +The entry point to the kernel is the ib_uverbs_write() function, which is
> +invoked as a response to the 'write' system call. The requested function is
> +looked up from an array called uverbs_cmd_table which contains function pointers
> +to the various command handlers.

This array was deleted recently

> +Write Command Handlers
> +~~~~~~~~~~~~~~~~~~~~~~
> +These command handler functions are declared
> +with the IB_VERBS_DECLARE_CMD macro in drivers/infiniband/core/uverbs.h. There
> +are also extended commands, which are kept in a similar manner in the
> +uverbs_ex_cmd_table. The extended commands use 64-bit values in the command
> +header, as opposed to the 32-bit values used in the regular command table.

IB_VERBS_DELCARE_CMD is also deleted

> +Objects trees are declared using the DECLARE_UVERBS_OBJECT_TREE macro. This
> +combines all of the objects.

DECLARE_UVERBS_OBJECT_TREE as well

Jason
