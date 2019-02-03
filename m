Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43702C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 16:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1547F21773
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 16:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbfBCQ4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 11:56:05 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38004 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbfBCQ4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 11:56:04 -0500
Received: by mail-ed1-f67.google.com with SMTP id h50so9334002ede.5
        for <linux-kernel@vger.kernel.org>; Sun, 03 Feb 2019 08:56:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=0BUE2qsMk8B9n6ac/OcDjJ/pUd2Z4OrH8sv5vvG/PaE=;
        b=lMAObkBuXpl7m0YTtXNFQETNw3h3bowUbXcA3m6KFDk/D+dJ9PWRzbNThgc0ixWqqc
         j+ldgf+4BBWu479Ha1D6WR3cN3afwVwH9+nTltacyi32tiw4cqoHPTgivQBdi65gyyfR
         reGcMykiEgMd367OB+kyEjfqG2jNvYqwJPvXuaVgJOl3ggAwFd2Y/wBQLyWPjY98eBH5
         Ky/VzR1ghgK8JtEXDx09w4mZJwMHbGA6+0eR6A1fPS3+ysO37dLlhRYWPQyRNbQaXoSO
         7plt4f0Oy7gF8cR/NQW9Eq3mlC/0QduGuBAmsTz/Q0PQlBzRqbtkkGmu+8PpM6LECtbJ
         pJXw==
X-Gm-Message-State: AJcUukezHTlDIeixGVaV+oGxzL20ZL8WMZWvI9x1TlnHM9TdUitAiHX8
        1rpI2L4QAfVKa/vKOYAlfHo9FFaSGtFT0Q==
X-Google-Smtp-Source: ALg8bN5ZSCtj/BP7hbieC/epfvEHXChGPe0jtKOVYWmwFEzfct643d7AE8i1jQWOLnq9cNo2ZCOPYQ==
X-Received: by 2002:a05:6402:14cd:: with SMTP id f13mr47577405edx.224.1549212962325;
        Sun, 03 Feb 2019 08:56:02 -0800 (PST)
Received: from [10.43.7.208] ([109.236.136.226])
        by smtp.gmail.com with ESMTPSA id l18sm3422958edq.87.2019.02.03.08.56.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Feb 2019 08:56:01 -0800 (PST)
To:     David Disseldorp <ddiss@suse.de>, Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Laura Abbott <labbott@redhat.com>
Subject: Userspace regression with 6baca7601bde ("scsi: target: drop unused
 pi_prot_format attribute storage")
Message-ID: <57120b72-2ab9-bfa5-f69c-31aee78d5936@redhat.com>
Date:   Sun, 3 Feb 2019 17:56:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Fedora got a bug report of a new permission denied error with 5.0-rc2:

>   File "/usr/lib/python3.7/site-packages/rtslib_fb/utils.py", line 100, in fread
>     with open(path, 'r') as file_fd:
> PermissionError: [Errno 13] Permission denied: '/sys/kernel/config/target/core/fileio_28/xxx/attrib/pi_prot_format'

This looks like an intentional behavior change with

commit 6baca7601bdee2e57f20c45d63eb53b89b33e816
Author: David Disseldorp <ddiss@suse.de>
Date:   Fri Nov 23 18:36:11 2018 +0100

     scsi: target: drop unused pi_prot_format attribute storage
     
     On write, the pi_prot_format configfs attribute invokes the device
     format_prot() callback if present. Read dumps the contents of
     se_dev_attrib.pi_prot_format which is always zero.  Make the configfs
     attribute write-only, and drop the always zero se_dev_attrib.pi_prot_format
     storage.
     
     Signed-off-by: David Disseldorp <ddiss@suse.de>
     Reviewed-by: Christoph Hellwig <hch@lst.de>
     Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>


Unfortunately, existing code that's opening with read permissions is now broken.
Can this be reverted? Full bug at https://bugzilla.redhat.com/show_bug.cgi?id=1667505

Thanks,
Laura
