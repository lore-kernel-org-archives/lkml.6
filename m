Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDF5C4321E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 22:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80628206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 22:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="KAUGPfMO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80628206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbeIGDGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 23:06:41 -0400
Received: from com-out001.mailprotect.be ([83.217.72.83]:34481 "EHLO
        com-out001.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbeIGDGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 23:06:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:Mime-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:
        reply-to:sender:bcc; bh=w2URl6XFYSrmWtyjBiuKWDlXpzEAnzkGVY9D5gogAYA=; b=KAUGP
        fMOoijh0McbXPVcbXOpdC2Wa+LoEzfJgwtC32MdekPxCXMxL6uWPVa9iFT42LRrVhbDxIBE6dVfyg
        Ol+KQUWhxfCJpiJkQMAENCFc1tfGMS30YZ26V48zbE4NrHyeVffY+cCaEu6TZrM88WhjbvTnzegot
        d0+tVlKPGB6XzFygPjanqE+2hmAqPNlDR7TRyUmHXtC589gu/eyDFQxSOEN+1eaDobOCltNsKHsVy
        ir9/KUPjT7NjHzZcM+xENS87KAilHqsGSOOEUks2JUGY8NdMf/9EtH3l5f+Zj6292b0aXi7R9baNj
        XIX0ibT0fXOR3BowJqRSXJnnK6dCg==;
Received: from smtp-auth.mailprotect.be ([178.208.39.155])
        by com-mpt-out001.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1fy2ld-0002Zy-UB; Fri, 07 Sep 2018 00:28:50 +0200
Received: from [100.110.80.9] (unknown [104.132.0.105])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id F1DADC1A2D;
        Fri,  7 Sep 2018 00:27:51 +0200 (CEST)
Message-ID: <1536272873.26747.11.camel@acm.org>
Subject: Re: [PATCH] scsi: sd: Contribute to randomness when running
 rotational device
From:   Bart Van Assche <bvanassche@acm.org>
To:     Xuewei Zhang <xueweiz@google.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Christoph Hellwig <hch@lst.de>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Aditya Kali <adityakali@google.com>,
        tytso@mit.edu, Guenter Roeck <groeck@chromium.org>, maze@google.com
Date:   Thu, 06 Sep 2018 15:27:53 -0700
In-Reply-To: <20180906203719.209399-1-xueweiz@google.com>
References: <20180906203719.209399-1-xueweiz@google.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Originating-IP: 178.208.39.155
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.06)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5haRi3fSQbdpGJk/+dzZLrV602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO6vKcmAs6CbufrvwgXALYJ2A5LiDfh3lq6IyugVpruaU7sA8c0G8vPgpF/mOUR3AbCXA
 rInbZ6qIwLyBZyJW/YCT9Ui8ESSPXhfBI/CVeVpLWv7L6YAFQCVyuHTI87HxBfWpAw+3oS8eQJ1j
 rvdLDWC8eVP+pWyk8IQQ1lL3EHX54FFwuzjqg0YMSb5Z0gwwMsQa9E0mv5W8tg6akrbeq2/q3gKP
 YN4pDx6T+Gom7LQv3fOjRDD9OGUKRZmyo9aj/eZNohDx+e40Z/8DK3FY6+L//vWhll9ubWTAaTwX
 JtFJvdePI8pMO8g15dV4F8DQ+QgXAmY3WV/PikYBtj1zgVj/gbuP7hnUK8NQdLwsVWKI5h95nPh9
 a549uEJDlX2zbVNiLZt/QXQnOBRD+jq1HsIsPYYqgCE9VHi2RrGTOb8LhakTPTmcFbPlFqk6vwQX
 6xjisIUymzDZZZVpKet7jIJvhPVU8VsnjvDKPRgDOuBhdnrLabUgNzEO/QU0BfnnNN0e4JZGLi4N
 7z34dRW8He8OS36jJS0vGLHCMBZ8qZbSH5hAeUS9cQyvi5qmSFkUknN5Z0HND1jmKFhIjcMZ2Hzp
 D59QdM/f9KJhSSfjTAUyLIywuTEI0kISK7u1AZUYswhRnz2TBlRANbxfwyKJau9SJCaCv74Yh1P8
 2G5a6FUfCqKyMMr9DC5xv10I1RUEoMex+02z+OLc6JgtScTK+tB+krcu2EUkcwJAT4fgYEF9hqUv
 gugTwCBLPD4olaNxG1Uzhk3emVQ3gGhRNfbGmn/DPdxtH4YeHcdUG7t52t8IQOrYSw1F+nigO8Hc
 zQSiYxqZR3KVQgqF/fPYYAfEfshY5+rKdpQX0JCawTpXLsZHDi5vUxN7tsrs2aYakAmICYctZ3oQ
 Q+5COuHUJqi4YtG2OdWr+Or9P0IHyk2pZXI5Aop9L1WAXCZ22036WHg8viWNUl/fumlD47sXPQEl
 p1YRFZ4oobg8BBg3Jq+ntzj0/GqJg4E/KNK41fXYWiMK3hUu9uwJu0VOx5JgxLZ/jzE0W0tXqNpM
 nBA6RYf5L0Fe/whJRtf29za4rlun4XgebHLYM3A6BXfvel8OEFDbU53Bgg0jWhcETmPWhuXbFcbm
 /oZH2lvlQsC8AzMlaaDx/cdXogrgAlIbNoRIs8zFcDjnShMu2z+YCLdt1O36QJzT4QKoDPA69FJ5
 6j6TBEeRw33i5WSyISiVtdP1UgGt/UpwRJ/eXhAiot4MY812nNgiJt0ptDwHWmhqaO2WHXIzPWeB
 6FPJK/BpIbQy+VVErox5P1XXf9064N+GSqYoBRs3
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-09-06 at 13:37 -0700, Xuewei Zhang wrote:
+AD4 Currently a scsi device won't contribute to kernel randomness when it
+AD4 uses blk-mq. Since we commonly use scsi on rotational device with
+AD4 blk-mq, it make sense to keep contributing to kernel randomness in these
+AD4 cases. This is especially important for virtual machines.
+AD4 
+AD4 commit b5b6e8c8d3b4 (+ACI-scsi: virtio+AF8-scsi: fix IO hang caused by automatic
+AD4 irq vector affinity+ACI) made all virtio-scsi device to use blk-mq, which
+AD4 does not contribute to randomness today. So for a virtual machine only
+AD4 having virtio-scsi disk (which is common), it will simple stop getting
+AD4 randomness from its disks in today's implementation.
+AD4 
+AD4 With this patch, if the above VM has rotational virtio-scsi device, then
+AD4 it can still benefit from the entropy generated from the disk.
+AD4 
+AD4 Reported-by: Xuewei Zhang +ADw-xueweiz+AEA-google.com+AD4
+AD4 Signed-off-by: Xuewei Zhang +ADw-xueweiz+AEA-google.com+AD4
+AD4 ---
+AD4  drivers/scsi/sd.c +AHw 3 +-+-+-
+AD4  1 file changed, 3 insertions(+-)
+AD4 
+AD4 diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
+AD4 index b79b366a94f7..5e4f10d28065 100644
+AD4 --- a/drivers/scsi/sd.c
+AD4 +-+-+- b/drivers/scsi/sd.c
+AD4 +AEAAQA -2959,6 +-2959,9 +AEAAQA static void sd+AF8-read+AF8-block+AF8-characteristics(struct
+AD4 scsi+AF8-disk +ACo-sdkp)
+AD4  	if (rot +AD0APQ 1) +AHs
+AD4  		blk+AF8-queue+AF8-flag+AF8-set(QUEUE+AF8-FLAG+AF8-NONROT, q)+ADs
+AD4  		blk+AF8-queue+AF8-flag+AF8-clear(QUEUE+AF8-FLAG+AF8-ADD+AF8-RANDOM, q)+ADs
+AD4 +-	+AH0 else +AHs
+AD4 +-		blk+AF8-queue+AF8-flag+AF8-clear(QUEUE+AF8-FLAG+AF8-NONROT, q)+ADs
+AD4 +-		blk+AF8-queue+AF8-flag+AF8-set(QUEUE+AF8-FLAG+AF8-ADD+AF8-RANDOM, q)+ADs
+AD4  	+AH0
+AD4  
+AD4  	if (sdkp-+AD4-device-+AD4-type +AD0APQ TYPE+AF8-ZBC) +AHs

Although this patch looks fine to me, seeing this patch makes me wonder
whether the default should be changed (QUEUE+AF8-FLAG+AF8-MQ+AF8-DEFAULT) instead of
modifying the sd driver. Can anyone remind me why QUEUE+AF8-FLAG+AF8-MQ+AF8-DEFAULT does
not include QUEUE+AF8-FLAG+AF8-ADD+AF8-RANDOM?

Thanks,

Bart.

