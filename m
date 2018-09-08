Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD9FC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 04:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFA192075A
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 04:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="VHWV/GrX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFA192075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbeIHIvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 04:51:31 -0400
Received: from out002.mailprotect.be ([83.217.72.86]:38245 "EHLO
        out002.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbeIHIvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 04:51:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:reply-to:
        sender:cc:bcc; bh=YtfjMd+iPuRa7buoCBS/zpjS0vBSmqrun2SNUwg5oRQ=; b=VHWV/GrXDtp
        Q5KOMESxbL4EvIRsexnDRlbazyX44Iom06RBA28qLw7BzluC+nHgeKf/5+FCWev+shQ9RppRv34mc
        iW5P9EdlsUNYiM/bO0JKjlp2CVcWnNZccrwb5Y8kH+ilVEcakzeY4RXwk58r/NIULUR6WcJDUt/r1
        xKaATHJMcsul20yt7lg5jQRuZuL7xXp0+7JpTLWu27jZu+CVuSvAhTK7XXu87OxxvlDKxTX81smJq
        Nv7kOP8PvbyguFkR6qnSxCimHEGX0TPuar3hFp7SaFNnv3hh2L/ugncvDiP16hWlHW1tDzq60gzOE
        8FGe4xvWoE47aTyw416fS2A==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
        by com-mpt-out002.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1fyUWY-0007vg-Ex; Sat, 08 Sep 2018 06:07:07 +0200
Received: from asus.site (c-174-62-111-89.hsd1.ca.comcast.net [174.62.111.89])
        (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id CFD90C1837;
        Sat,  8 Sep 2018 06:06:56 +0200 (CEST)
Subject: Re: [PATCH] scsi: sd: Contribute to randomness when running
 rotational device
To:     Xuewei Zhang <xueweiz@google.com>, Theodore Ts'o <tytso@mit.edu>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        ming.lei@redhat.com, hare@suse.de, hch@lst.de, pbonzini@redhat.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aditya Kali <adityakali@google.com>, groeck@chromium.org,
        =?UTF-8?Q?Maciej_=c5=bbenczykowski?= <maze@google.com>
References: <20180906203719.209399-1-xueweiz@google.com>
 <1536272873.26747.11.camel@acm.org> <20180906224210.GK5098@thunk.org>
 <CAPtwhKoFE-eZcRkvhpJgyutGK91ZouwSjTRb-cwHLQjBkriksw@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <26273801-8dd5-983a-ef09-f8eef21749ac@acm.org>
Date:   Fri, 7 Sep 2018 21:06:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAPtwhKoFE-eZcRkvhpJgyutGK91ZouwSjTRb-cwHLQjBkriksw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: 178.208.39.159
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.06)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5o8cF3p86jO51RKz/iQ3DzJ602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO6vKcmAs6CbufrvwgXALYJ2A5LiDfh3lq6IyugVpruaU7sA8c0G8vPgpF/mOUR3AbCXA
 rInbZ6qIwLyBZyJW/YCT9Ui8ESSPXhfBI/CVeVpLWv7L6YAFQCVyuHTI87HxBfWpAw+3oS8eQJ1j
 rvdLDWC8eVP+pWyk8IQQ1lL3EHX54FFwuzjqg0YMSb5Z0gwwMsQa9E0mv5W8tg6akrbeq2/q3gKP
 YN4pDx6T+Gom7LQv3fOjRDD9OGUKRZmyo9aj/eZNohDx+e40Z/8DK3FY6+L//vWhll9ubWTAaTwX
 JtFJvdePI8pMO8g15dV4F8DQ+QgXAmY3WV/PikYBtj1zgVj/gbuP7hnUK8NQdLwsVWKI5h95nPh9
 a549uEJDlX2zbVNiLZt/QXQnOBRD+jq1HsIsPYYqgCE9VHi2RrGTOb8LVtuU7LV93speZaHn7N0i
 oBjisIUymzDZZZVpKet7jIJvhPVU8VsnjvDKPRgDOuBhGRQP6aoq2j5ibghWGduoTt0e4JZGLi4N
 7z34dRW8He8OS36jJS0vGLHCMBZ8qZbSH5hAeUS9cQyvi5qmSFkUknN5Z0HND1jmKFhIjcMZ2Hzp
 D59QdM/f9KJhSSfjTAUyLIywuTEI0kISK7u1AZUYswhRnz2TBlRANbxfwyKJau9SJCaCv74Yh1P8
 2G5a6FUfCqKyMMr9DC5xv10I1RUEoMex+02z+OLc6JgtScTK+tB+krcu2EUkcwJAT4fgYEF9hqUv
 gugTwCBLPD4olaNxG1Uzhk3emVQ3gGhRNfbGmn/DPdxtH4YeHcdUG7t52t8IQOrYSw1F+nigO8Hc
 zQSiYxqZR3KVQgqF/fPYYAfEfshY5+rKdpQX0JCawTpXLsZHQ6Opvgt3P7LuE20sspzMMtco3f54
 Vr05fWzzciEg6Ru2OdWr+Or9P0IHyk2pZXI5Aop9L1WAXCZ22036WHg8viWNUl/fumlD47sXPQEl
 p1YRFZ4oobg8BBg3Jq+ntzj0/GqJg4E/KNK41fXYWiMK3hUu9uwJu0VOx5JgxLZ/jzH5BeM+PPvo
 BWcDxsFUXzz0RLajaudc+HA3xjQwpRltQnLYM3A6BXfvel8OEFDbU53Bgg0jWhcETmPWhuXbFcbm
 0rFyn10wV+nM7dIy27DE7cdXogrgAlIbNoRIs8zFcDjnShMu2z+YCLdt1O36QJzT4QKoDPA69FJ5
 6j6TBEeRw33i5WSyISiVtdP1UgGt/UpwRJ/eXhAiot4MY812nNgiJt0ptDwHWmhqaO2WHXIzPWeB
 6FPJK/BpIbQy+VVErox5P1XXf9064N+GSqYoBRs3
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/18 16:03, Xuewei Zhang wrote:
> On Thu, Sep 6, 2018 at 3:42 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>> There was a discussion about a number of *years* ago; blk-mq has been
>> baking for a very long time.  In the early days of block_mq, the
>> overwhelming percentage of the users of blk-mq where those who were
>> using PCIe attached flash.  So when, I raised this question, the
>> argument was that SSD users have no entropy.  Which I agree with; but
>> now that blk-mq is the default, and hard drives are using blk-mq, it's
>> time for a patch like Xuewei's.
>
> Besides Ted's point of "SSD users have no entropy", I think there are
> two more reasons:
> 1. setting QUEUE_FLAG_ADD_RANDOM has a more visible performance hit
> on SSD disks than rotational disks.
> 2. SSD disks provide less entropy than rotational disks.
> I actually experimented on Container-Optimized OS, running on Google
> Compute Engine with QUEUE_FLAG_ADD_RANDOM set.
> Turns out the VM will have ~800 bit of entropy provided on boot on
> rotational disk;
> and will only have ~70 bit of entropy if running on SSD (and remember
> there are ~50 bit contributed from other sources).
> (in the above experiment, both disks were virtualized disks)

All of the above makes sense to me and is much less risky than changing
QUEUE_FLAG_MQ_DEFAULT. Hence:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

