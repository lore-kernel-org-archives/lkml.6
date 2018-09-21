Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD07AC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8565321547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="idF+oADF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8565321547
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389835AbeIUTlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:41:42 -0400
Received: from com-out001.mailprotect.be ([83.217.72.83]:35411 "EHLO
        com-out001.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728098AbeIUTll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 15:41:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
        reply-to:sender:bcc; bh=lEG/EKVPe05cxxnv5259Cj3BMviayd51BTh33CzCDOc=; b=idF+o
        ADFRzoUoQQgi7xDAciQSh0iDTEAD4Ko939hc16mXKLjP5UGC22WqWd834GEq49mrX1SbAgj4IX1Ch
        7Q52DvQTZnrCHP4o6YaC1m+qEOx86rFl2tJEpkbqTVnCVZQpKSKcFbGRHGkmjwEMTXfQcdPyXk2Uf
        lDsPcnmeQscTLLHKV0Sc0A9uFsVP46ZTQEXGr3VbexIh30l7+esQhYxzpdmr0YKYwqiEY6up8Zd6z
        ay8jSsfq//Sx3+24fpI/Hce7VTUZ0L/+EY3rk2Mzuse9ye0hY2yGsl5O0yftkbSmAe02IS/W4QezN
        siaPH/JMESX+Z1/tDwiOKphoc90LQ==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
        by com-mpt-out001.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1g3LrL-000FDL-HQ; Fri, 21 Sep 2018 15:52:40 +0200
Received: from asus.site (c-174-62-111-89.hsd1.ca.comcast.net [174.62.111.89])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id E9CCFC07B4;
        Fri, 21 Sep 2018 15:52:35 +0200 (CEST)
Subject: Re: [PATCH v2] scsi: sd: don't crash the host on invalid commands
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
References: <20180921070101.9260-1-jthumshirn@suse.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <e082c821-e019-7e41-12b8-5295a207d3fb@acm.org>
Date:   Fri, 21 Sep 2018 06:52:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180921070101.9260-1-jthumshirn@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: 178.208.39.159
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.06)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5qEGrhPEisnh4F+0wsEpUUZ602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1XywBiccbuhCIGOW/vveuLb+TGC5IJPF+H2444cKGrX+6i0qS57F453NlInWGQBsIqL
 unMg6LlUcnts7aziP/hXy3GlHF2D/FMlslOifbVq7GByngMgPuQfljK0Hxea9h2mlP2W9u+agdca
 nH6cUDPvJRqc2RinDVSFZnI5bjd5kS2knUt5ieobtHN54ZBVDBqMcsqWKFCe7rdEeuBGsJa9APKT
 Qb+u95nS7SbkJXMn+2dIiExwgKdlQnaZYUsGeBQ6V51u76v35b1wNe/MvdI2JKDpGk/O3CQQHpe9
 GDh+6RtEyOTlr8s/KA4rPNjQVMztdQUSqk/AeLi65+4s/LrywTM2yEHEhvC9Izsy/NENfx9RXrVr
 49ap5wWXhuSP55YIiHqfCgG4wrA3w4/kQTYKxDHA9JN9J4k4XZq11JQkdOHEEHFZXgEmmqOYHQ1J
 ISwdLe5BVNzi0bqETfj8uSNQef6Ceaw0tyEeHKZjklTreHL+whhAdKuW1jHRpItetrkwRG1Ozag+
 aLypWu8oc+mQORcYm+eIaK9fUWr9RAN1zrBRbmp0eFAiJgYeu3yAkNQmV5Z+1S6WRsLXYNyKI5QB
 DLdZGhaGMngAFGniylMEqwf9bMTvxYH7osomSTjBYDRH07DPc71PJTVXI1+34gG6q1M80y9vWj2i
 mx08laHaVy0ju2SDy/D1idkTLcu3EyqH7Y4POaW28MNCV3Ee0ga1bXEPs08cVWTELlhWdTXpOp0Y
 FgXIlZVUUW3bM2RbLqntKr6+crm+rffkaQ6ZgOiefSpVnKbpam6x/YW5cGxszDg6HYuTCyYgL61S
 IkBTYVRriXXIXx4lO2fz1pI1dgUuPvTh35kpzL5cZItNE1ixHHASJNUmoOHSoqgqxfHmWXt6oCtK
 fTa/tHA9eCvHO2xn30BoBQof3mFDO1NWjHVNqUIsWXIoi6q1Q/z1kn6A3+l+PmxJCFvdxzgiQpci
 HL4orzY0475SioCnWKQvNuLmsXw4MOrC86Zbws/yHKkfE0757KiUYziXyuXG4Z+FT7fctuG6KQ7F
 UJu4bGno4HcWzTM+8NvWuEOaBFVKkIT35Qca9/LxmVk3n6Ce51Hb9nM=
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/18 12:01 AM, Johannes Thumshirn wrote:
> When sd_init_command() get's a with a unknown req_op() it crashes the
> system via BUG().
> 
> This makes debugging the actual reason for the broken request
> cmd_flags pretty hard as the system is down before it's able to write
> out debugging data on the serial console or the trace buffer.
> 
> Change the BUG() to a WARN_ON() and return BLKPREP_KILL to fail
> gracefully and return an I/O error to the producer of the request.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
